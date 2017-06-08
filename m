Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54072 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751827AbdFHPY5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2017 11:24:57 -0400
Date: Thu, 8 Jun 2017 11:24:55 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mario Limonciello <mario_limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans De Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/6] USB / PCI / PM: Allow the PCI core to do the resume
 cleanup
In-Reply-To: <1565826.hIbT8kZpDn@aspire.rjw.lan>
Message-ID: <Pine.LNX.4.44L0.1706081124310.1949-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 8 Jun 2017, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> hcd_pci_resume_noirq() used as a universal _resume_noirq handler for
> PCI USB controllers calls pci_back_from_sleep() which is unnecessary
> and may become problematic.
> 
> It is unnecessary, because the PCI bus type carries out post-suspend
> cleanup of all PCI devices during resume and that covers all things
> done by the pci_back_from_sleep().  There is no reason why USB cannot
> follow all of the other PCI devices in that respect.
> 
> It will become problematic after subsequent changes that make it
> possible to go back to sleep again after executing dpm_resume_noirq()
> if no valid system wakeup events have been detected at that point.
> Namely, calling pci_back_from_sleep() at the _resume_noirq stage
> will cause the wakeup status of the devices in question to be cleared
> and if any of them has triggered system wakeup, that event may be
> missed then.
> 
> For the above reasons, drop the pci_back_from_sleep() invocation
> from hcd_pci_resume_noirq().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/usb/core/hcd-pci.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/usb/core/hcd-pci.c
> ===================================================================
> --- linux-pm.orig/drivers/usb/core/hcd-pci.c
> +++ linux-pm/drivers/usb/core/hcd-pci.c
> @@ -584,12 +584,7 @@ static int hcd_pci_suspend_noirq(struct
>  
>  static int hcd_pci_resume_noirq(struct device *dev)
>  {
> -	struct pci_dev		*pci_dev = to_pci_dev(dev);
> -
> -	powermac_set_asic(pci_dev, 1);
> -
> -	/* Go back to D0 and disable remote wakeup */
> -	pci_back_from_sleep(pci_dev);
> +	powermac_set_asic(to_pci_dev(dev), 1);
>  	return 0;
>  }

Acked-by: Alan Stern <stern@rowland.harvard.edu>
