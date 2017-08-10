Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Zheng, Lv" <lv.zheng@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 3/3] ACPI / scan: Enable GPEs before scanning the
 namespace
Date: Thu, 10 Aug 2017 01:54:11 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF06715@SHSMSX101.ccr.corp.intel.com>
References: <12346760.yAFCnkEgf6@aspire.rjw.lan>
 <6344941.kJ2o2XerZ0@aspire.rjw.lan>
In-Reply-To: <6344941.kJ2o2XerZ0@aspire.rjw.lan>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Rafael

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J.
> Wysocki
> Subject: [PATCH 3/3] ACPI / scan: Enable GPEs before scanning the namespace
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> On some systems the platform firmware expects GPEs to be enabled
> before the enumeration of devices and if that expectation is not
> met, the systems in question may not boot in some situations.
> 
> For this reason, change the initialization ordering of the ACPI
> subsystem to make it enable GPEs before scanning the namespace
> for the first time in order to enumerate devices.

This indeed is worthy of a try.
Acked-by: Lv Zheng <lv.zheng@intel.com>

Thanks and best regards
Lv

> 
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/scan.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -2139,6 +2139,10 @@ int __init acpi_scan_init(void)
>  			acpi_get_spcr_uart_addr();
>  	}
> 
> +	acpi_gpe_apply_masked_gpes();
> +	acpi_update_all_gpes();
> +	acpi_ec_ecdt_start();
> +
>  	mutex_lock(&acpi_scan_lock);
>  	/*
>  	 * Enumerate devices in the ACPI namespace.
> @@ -2163,10 +2167,6 @@ int __init acpi_scan_init(void)
>  		}
>  	}
> 
> -	acpi_gpe_apply_masked_gpes();
> -	acpi_update_all_gpes();
> -	acpi_ec_ecdt_start();
> -
>  	acpi_scan_initialized = true;
> 
>   out:
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
