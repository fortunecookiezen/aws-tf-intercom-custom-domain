module "intercom" {
    source = "../"
    custom_domain = "support.fortunecookiezen.net"
    zone_id = "JADZZZJADOAMDALD8H"
    origin_id = "fortunecookiezen-origin"
    tags = {
        owner = "support@fortunecookiezen.net"
    }
}