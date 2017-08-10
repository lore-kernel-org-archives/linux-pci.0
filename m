Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Zheng, Lv" <lv.zheng@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 1/3] ACPICA: Dispatch active GPEs at init time
Date: Thu, 10 Aug 2017 01:48:58 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF066E6@SHSMSX101.ccr.corp.intel.com>
References: <12346760.yAFCnkEgf6@aspire.rjw.lan>
 <46980112.WLPtxWZQ3y@aspire.rjw.lan>
In-Reply-To: <46980112.WLPtxWZQ3y@aspire.rjw.lan>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Rafael

> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Subject: [PATCH 1/3] ACPICA: Dispatch active GPEs at init time
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In some cases GPEs are already active when they are enabled by
> acpi_ev_initialize_gpe_block() and whatever happens next may depend
> on the result of handling the events signaled by them, so the
> events should not be discarded (which is what happens currently) and
> they should be handled as soon as reasonably possible.
> 
> For this reason, modify acpi_ev_initialize_gpe_block() to
> dispatch GPEs with the status flag set in-band right after
> enabling them.

In fact, what we need seems to be invoking acpi_ev_gpe_dispatch()
right after enabling an GPE. So there are 2 conditions related:
1. GPE is enabled for the first time.
2. GPE is initialized.

And we need to make sure that before acpi_update_all_gpes() is invoked,
all GPE EN bits are actually disabled.
What if we do this in this way:

Index: linux-acpica/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-acpica.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-acpica/drivers/acpi/acpica/evxfgpe.c
@@ -97,6 +97,14 @@ acpi_status acpi_update_all_gpes(void)
 unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 
+	/*
+	 * Poll GPEs to handle already triggered events.
+	 * It is not sufficient to trigger edge-triggered GPE with specific
+	 * GPE chips, software need to poll once after enabling.
+	 */
+	if (acpi_gbl_all_gpes_initialized) {
+		acpi_ev_gpe_detect(acpi_gbl_gpe_xrupt_list_head);
+	}
 	return_ACPI_STATUS(status);
 }
 
@@ -120,6 +128,7 @@ acpi_status acpi_enable_gpe(acpi_handle
 	acpi_status status = AE_BAD_PARAMETER;
 	struct acpi_gpe_event_info *gpe_event_info;
 	acpi_cpu_flags flags;
+	u8 poll_gpes = FALSE;
 
 	ACPI_FUNCTION_TRACE(acpi_enable_gpe);
 
@@ -135,12 +144,25 @@ acpi_status acpi_enable_gpe(acpi_handle
 		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
 		    ACPI_GPE_DISPATCH_NONE) {
 			status = acpi_ev_add_gpe_reference(gpe_event_info);
+			if (ACPI_SUCCESS(status) &&
+			    gpe_event_info->runtime_count == 1) {
+				poll_gpes = TRUE;
+			}
 		} else {
 			status = AE_NO_HANDLER;
 		}
 	}
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+
+	/*
+	 * Poll GPEs to handle already triggered events.
+	 * It is not sufficient to trigger edge-triggered GPE with specific
+	 * GPE chips, software need to poll once after enabling.
+	 */
+	if (poll_gpes && acpi_gbl_all_gpes_initialized) {
+		acpi_ev_gpe_detect(acpi_gbl_gpe_xrupt_list_head);
+	}
 	return_ACPI_STATUS(status);
 }
 ACPI_EXPORT_SYMBOL(acpi_enable_gpe)
Index: linux-acpica/drivers/acpi/acpica/utxfinit.c
===================================================================
--- linux-acpica.orig/drivers/acpi/acpica/utxfinit.c
+++ linux-acpica/drivers/acpi/acpica/utxfinit.c
@@ -284,6 +284,13 @@ acpi_status ACPI_INIT_FUNCTION acpi_init
 	}
 
 	/*
+	 * Cleanup GPE enabling status to make sure that the GPE settings are
+	 * as what the OSPMs expect. This should be done before enumerating
+	 * ACPI devices and operation region drivers.
+	 */
+	(void)acpi_hw_disable_all_gpes();
+
+	/*
 	 * Initialize all device/region objects in the namespace. This runs
 	 * the device _STA and _INI methods and region _REG methods.
 	 */

Thanks and best regards
Lv

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpica/evgpeblk.c |   28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpica/evgpeblk.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/evgpeblk.c
> +++ linux-pm/drivers/acpi/acpica/evgpeblk.c
> @@ -440,9 +440,11 @@ acpi_ev_initialize_gpe_block(struct acpi
>  			     void *ignored)
>  {
>  	acpi_status status;
> +	acpi_event_status event_status;
>  	struct acpi_gpe_event_info *gpe_event_info;
>  	u32 gpe_enabled_count;
>  	u32 gpe_index;
> +	u32 gpe_number;
>  	u32 i;
>  	u32 j;
> 
> @@ -470,30 +472,38 @@ acpi_ev_initialize_gpe_block(struct acpi
> 
>  			gpe_index = (i * ACPI_GPE_REGISTER_WIDTH) + j;
>  			gpe_event_info = &gpe_block->event_info[gpe_index];
> +			gpe_number = gpe_block->block_base_number + gpe_index;
> 
>  			/*
>  			 * Ignore GPEs that have no corresponding _Lxx/_Exx method
> -			 * and GPEs that are used to wake the system
> +			 * and GPEs that are used for wakeup
>  			 */
> -			if ((ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
> -			     ACPI_GPE_DISPATCH_NONE)
> -			    || (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
> -				ACPI_GPE_DISPATCH_HANDLER)
> -			    || (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
> -				ACPI_GPE_DISPATCH_RAW_HANDLER)
> +			if ((ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
> +			     ACPI_GPE_DISPATCH_METHOD)
>  			    || (gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
>  				continue;
>  			}
> 
> +			event_status = 0;
> +			(void)acpi_hw_get_gpe_status(gpe_event_info,
> +						     &event_status);
> +
>  			status = acpi_ev_add_gpe_reference(gpe_event_info);
>  			if (ACPI_FAILURE(status)) {
>  				ACPI_EXCEPTION((AE_INFO, status,
>  					"Could not enable GPE 0x%02X",
> -					gpe_index +
> -					gpe_block->block_base_number));
> +					gpe_number));
>  				continue;
>  			}
> 
> +			if (event_status & ACPI_EVENT_FLAG_STATUS_SET) {
> +				ACPI_INFO(("GPE 0x%02X active on init",
> +					   gpe_number));
> +				(void)acpi_ev_gpe_dispatch(gpe_block->node,
> +							   gpe_event_info,
> +							   gpe_number);
> +			}
> +
>  			gpe_enabled_count++;
>  		}
>  	}

