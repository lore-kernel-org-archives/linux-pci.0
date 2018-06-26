Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 26 Jun 2018 09:01:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>, n0000b.n000b@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume bridges w/o drivers on
 suspend-to-RAM
Message-ID: <20180626140115.GA146680@bhelgaas-glaptop.roam.corp.google.com>
References: <35587465.8Nave9aG7d@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35587465.8Nave9aG7d@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 26, 2018 at 12:06:01PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is reported that commit c62ec4610c40 (PM / core: Fix direct_complete
> handling for devices with no callbacks) introduced a system suspend
> regression on Samsung 305V4A by allowing a PCI bridge (not a PCIe
> port) to stay in D3 over suspend-to-RAM, which is a side effect of
> setting power.direct_complete for the children of that bridge that
> have no PM callbacks.
> 
> On the majority of systems PCI bridges are not allowed to be
> runtime-suspended (the power/control sysfs attribute is set to "on"
> for them by default), but user space can change that setting and if
> it does so and a given bridge has no children with PM callbacks, the
> direct_complete optimization will be applied to it and it will stay
> in suspend over system suspend.  Apparently, that confuses the

"stay in D3 over system suspend"? (just to be explicit about what "in
suspend" means)

> platform firmware on the affected machine and that may very well
> happen elsewhere, so avoid the direct_complete optimization for
> PCI bridges with no drivers (if there is a driver, it should take
> care of the PM handling) on suspend-to-RAM altogether (that should
> not matter for suspend-to-idle as platform firmware is not involved
> in it).
> 
> Fixes: c62ec4610c40 (PM / core: Fix direct_complete handling for devices with no callbacks)
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199941
> Reported-by: n0000b.n000b@gmail.com
> Tested-by: n0000b.n000b@gmail.com
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pci-acpi.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -638,6 +638,14 @@ static bool acpi_pci_need_resume(struct
>  	if (acpi_target_system_state() == ACPI_STATE_S0)
>  		return false;
>  
> +	/*
> +	 * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend
> +	 * confuses the platform firmware, so avoid doing that, unless the
> +	 * bridge has a driver that should take care of PM handling.
> +	 */
> +	if (pci_is_bridge(dev) && !dev->driver)
> +		return true;

It sounds like the question of whether leaving a bridge in D3 confuses
the firmware has a platform-specific answer.  How does the driver PM
handling know how to do the right thing?  Does it need to know whether
it's safe to put the device in D3?  Or maybe a device is never put in
D3 for system suspend if it has a driver?

But I'm just kibbitzing; since you merged c62ec4610c40, I'm happy if
you also merge this:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

>  	return !!adev->power.flags.dsw_present;
>  }
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
