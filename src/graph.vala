/*-
 * Copyright (c) 2017 elementary llc
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * Authored by: kay van der Zander <kay20@hotmail.com>
 */

namespace graph {

    public class App : Granite.Application {


        public Gvc.Context gvc_context;
        public Gvc.Graph graph;

        construct {
            program_name = _(Constants.APP_NAME);
            exec_name = "graph";

            build_data_dir = Constants.DATADIR;
            build_pkg_data_dir = Constants.PKGDATADIR;
            build_release_name = Constants.RELEASE_NAME;
            build_version = Constants.VERSION;
            build_version_info = Constants.VERSION_INFO;

            Intl.setlocale (LocaleCategory.ALL, "");

            app_years = "2017";
            app_icon = "multimedia-video-player";
            app_launcher = "org.pantheon.audience.desktop";
            application_id = "org.pantheon.audience";

            main_url = "";
            bug_url = "";
            help_url = "";
            translate_url = "";

            about_authors = { "kay van der Zander <kay20@hotmail.com>" };
            about_translators = _("translator-credits");
            about_license_type = Gtk.License.GPL_3_0;
        }

        public App () {
            graph = new Gvc.Graph ("test", Gvc.Agdirected, 0);
            var n1 = graph.create_node ("n1", 1);
            var n2 = graph.create_node ("n2", 1);
            var n3 = graph.create_node ("n3", 1);
            var n4 = graph.create_node ("n4", 1);
            var n5 = graph.create_node ("n5", 1);
            var n6 = graph.create_node ("n6", 1);
            var e1 = graph.create_edge (n1, n2, "", 1);
            e1.safe_set ("color", "red", "");
            graph.create_edge (n1, n3, "", 1);
            graph.create_edge (n1, n4, "", 1);
            graph.create_edge (n1, n5, "", 1);
            graph.create_edge (n1, n6, "", 1);
            graph.create_edge (n3, n6, "", 1);

            graph.write (stdout);

            // layout and render give segmentation fault.
            //gvc_context.layout_jobs (graph);
            //gvc_context.render_jobs (graph);
            //gvc_context.free_layout (graph);
        }

        private static App app; // global App instance
        public static App get_instance () {
            if (app == null)
                app = new App ();
            return app;
        }

        public override void activate () {

        }

        public string get_cache_directory () {
            return "0";
        }

        //the application was requested to open some files
        public override void open (File[] files, string hint) {
            activate ();
        }
    }
}

public static void main (string [] args) {
    
    var app = graph.App.get_instance ();

    app.gvc_context = new Gvc.Context ();
    app.gvc_context.parse_args (args);

    app.run (args);
}
