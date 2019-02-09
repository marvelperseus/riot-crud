<!-- feathers-example-upload https://github.com/CianCoders/feathers-example-fileupload -->
<crud-upload>

    <link rel="stylesheet" href="/bower_components/dropzone/dist/dropzone.css">

    <div class="card">
        <div class="header">
            <h2>{opts.title}<small>{opts.description}</small></h2>
            <span if={selection.length > 0} class="label-count bg-pink font-6">{selection.length}</span>
            <crud-header-dropdown if={opts.actionMenu !== false} selection="{selection.length}" service="{opts.service}" name="{opts.name}" views="{opts.views}" view="{opts.view}" query="{opts.query}" buttons="{opts.buttons}"></crud-header-dropdown>
        </div>
        <div class="body">
            <form action="http://localhost:3030/datauploads" class="dropzone"
              id="my-awesome-dropzone">
                    <label for="model-selection">Models</label>
                    <select id="model-selection">
                        <option>Products</option>
                        <option>Categories</option>
                        <option>Orders</option>
                    </select>
            </form>
        </div>
    </div>
    <script>
        var self = this;

        self.mixin(FeatherClientMixin);

        self.dependencies = [
                '//cdnjs.cloudflare.com/ajax/libs/core-js/2.1.4/core.min.js',
                '/bower_components/dropzone/dist/dropzone.js'
        ];

        this.on('*', function(event) {
            console.info('opts.showHeader', event, opts.showHeader || 'df')
        });

        this.on('before-mount', function() {
            RiotCrudController.loadDependencies(self.dependencies,'crud-upload', function (argument) {
                self.initPlugins();
            });
        });

        self.initPlugins = function() {
            console.info(opts.showHeader)
            // Now with Real-Time Support!
            self.client.service('datauploads').on('created', function(file){
                console.log('Received file created event!', file);
                // RiotControl.trigger(
                //             'notification',
                //             'uploaded',
                //             'success',
                //             'File'
                //         );
            });

            self.client.service('datauploads').on('error', function(file){
                console.log('Received file created event!', file);
            });

            // Let's use DropZone!
            Dropzone.options.myAwesomeDropzone = {
                paramName: "uri",
                uploadMultiple: false,
                maxFilesize: 2000,
                params: { foo: "bar" },
                init: function(){
                    this.on('uploadprogress', function(file, progress){
                        console.log('progresss', progress);
                        // NProgress.set(progress)
                    });
                    this.on('sending', function(file, xhr, formData) {
                        formData.append("dyndata", 'dude');
                    });
                    this.on('complete', function(file) {
                        console.log('complete', file);
                        RiotControl.trigger(
                            'notification',
                            'File Upload Success',
                            'success',
                            'File ' + file.name + ' cerated'
                        );
                    });
                }
            };
        }




    </script>

</crud-upload>

