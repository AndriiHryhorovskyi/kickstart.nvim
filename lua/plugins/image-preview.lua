return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { 'magick' },
    },
  },
  {
    '3rd/image.nvim',
    dependencies = { 'luarocks.nvim', 'MunifTanjim/nui.nvim', 'nvim-treesitter' },
    opts = {},
    config = function()
      local function isUrl(word)
        local url_pattern = '(https?://[%w-_%.%?%.:/%+=&#]+)'
        return word:match(url_pattern) ~= nil
      end

      local function isImageFile(word)
        local patterns = { '%.png', '%.jpg', '%.jpeg', '%.gif', '%.bmp', '%.svg' }
        for _, pattern in pairs(patterns) do
          if string.match(word, pattern) ~= nil then
            return true
          end
        end
        return false
      end

      local function getTextUnderCursor()
        local ts_utils = require 'nvim-treesitter.ts_utils'
        local node = ts_utils.get_node_at_cursor()
        if node == nil then
          return nil
        end
        return vim.treesitter.get_node_text(node, 0)
      end

      local function displayImage(location)
        local imageAPI = require 'image'
        local Popup = require 'nui.popup'
        imageAPI.setup {
          backend = 'kitty',
          integrations = {
            markdown = {
              enabled = false,
              clear_in_insert_mode = false,
              download_remote_images = true,
              only_render_image_at_cursor = false,
              filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
            },
            neorg = {
              enabled = false,
              clear_in_insert_mode = false,
              download_remote_images = true,
              only_render_image_at_cursor = false,
              filetypes = { 'norg' },
            },
            html = {
              enabled = false,
            },
            css = {
              enabled = false,
            },
          },
          max_width = nil,
          max_height = nil,
          max_width_window_percentage = 100,
          max_height_window_percentage = 100,
          window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
          window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
          editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
          tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
          hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' }, -- render image files as images when opened
        }

        local popup = Popup {
          enter = false,
          focusable = false,
          border = {
            style = 'none',
            padding = {
              top = 0,
              bottom = 0,
              left = 0,
              right = 0,
            },
          },
          relative = 'editor',
          position = '50%',
          size = '50%',
          buf_options = {
            modifiable = true,
            readonly = true,
          },
          win_options = {
            winblend = 0,
          },
        }

        popup:mount()
        vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { 'Loading...' })

        if isUrl(location) then
          imageAPI.from_url(location, {
            window = popup.winid,
          }, function(img)
            image = img
            vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { '' })
            img:render()
          end)
        elseif isImageFile(location) then
          local absolutePath = vim.fn.resolve(vim.fn.fnamemodify(location, ':p'))
          if vim.fn.filereadable(absolutePath) == 0 then
            vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { 'THE FILE NOT FOUND' })
          else
            image = imageAPI.from_file(absolutePath, {
              window = popup.winid,
            })
            vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { '' })
            image:render {}
          end
        else
          popup:unmount()
          return
        end

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'ModeChanged' }, {
          buffer = 0,
          once = true,
          group = vim.api.nvim_create_augroup('preview_image', { clear = true }),
          callback = function()
            image:clear()
            popup:unmount()
          end,
        })
      end

      vim.keymap.set('n', '<leader>K', function()
        -- TODO: integrate with oil.nvim, telescope, neotree
        local node_text = getTextUnderCursor()
        if isUrl(node_text) or isImageFile(node_text) then
          displayImage(node_text)
        end
      end)
    end,
  },
}
