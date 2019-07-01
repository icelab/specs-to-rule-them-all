module Test
  module ViewHelpers
    # TODO: build these dynamically for each slice

    # def render(view, opts = {})
    #   view.(opts.merge(context: view_context))
    # end

    # def render_main(view, opts = {})
    #   view.(opts.merge(context: main_view_context))
    # end

    # def current_user
    #   double(:current_user, email: "jane@doe.org", can?: true, superuser?: true, programs: [])
    # end

    # def view_context
    #   Admin::Container["view.context"].with(
    #     assets: Admin::Container["core.assets"],
    #     current_user: current_user,
    #     csrf_metatag: -> { '<meta name="_csrf" content="XX-rRrdVKmmPkVC7QaAdEG-Sj1bvEpsW4EwJPzCGuiw">' },
    #     csrf_tag: -> { '<input type="hidden" name="_csrf" value="XX-rRrdVKmmPkVC7QaAdEG-Sj1bvEpsW4EwJPzCGuiw">' },
    #     csrf_token: -> { "XX-rRrdVKmmPkVC7QaAdEG-Sj1bvEpsW4EwJPzCGuiw" },
    #     fullpath: "",
    #     flash: {}
    #   )
    # end

    # def main_view_context
    #   Main::Container["view.context"].with(
    #     assets: Main::Container["core.assets"],
    #     topics: [],
    #     cache_buster_script_src: "//localhost:3000/_check/~root~/_check.js?",
    #     fullpath: "/"
    #   )
    # end
  end
end
