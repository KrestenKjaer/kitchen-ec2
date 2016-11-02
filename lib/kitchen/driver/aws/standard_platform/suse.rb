require "kitchen/driver/aws/standard_platform"

module Kitchen
  module Driver
    class Aws
      class StandardPlatform
        class SLES < StandardPlatform
          StandardPlatform.platforms["suse"] = self

          def initialize(driver, _name, version, architecture)
            super(driver, "suse", version, architecture)
          end

          def username
            "ec2-user"
          end

          def image_search
            search = {
              "owner-id" => "013907871322",
              "name" => "suse-sles-#{version}*"
            }
            search["architecture"] = architecture if architecture
            search
          end

          def self.from_image(driver, image)
            if image.name =~ /suse/i
              image.name =~ /\b(\d+(\.\d+)?)/i
              new(driver, "suse", (Regexp.last_match || [])[1], image.architecture)
            end
          end
        end
      end
    end
  end
end
