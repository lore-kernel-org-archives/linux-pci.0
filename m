Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbdF3Cjg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jun 2017 22:39:36 -0400
Date: Thu, 29 Jun 2017 21:39:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH][RFC v3] PCI: Workaround to enable poweroff on Mac Pro 11
Message-ID: <20170630023931.GW17844@bhelgaas-glaptop.roam.corp.google.com>
References: <1471595425-1752-1-git-send-email-yu.c.chen@intel.com>
 <20170629191926.GV17844@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629191926.GV17844@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 29, 2017 at 02:19:26PM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 19, 2016 at 04:30:25PM +0800, Chen Yu wrote:
> > People reported that they can not do a poweroff nor a
> > suspend to ram on their Mac Pro 11. After some investigations
> > it was found that, once the PCI bridge 0000:00:1c.0 reassigns its
> > mm windows to ([mem 0x7fa00000-0x7fbfffff] and
> > [mem 0x7fc00000-0x7fdfffff 64bit pref]), the region of ACPI
> > io resource 0x1804 becomes unaccessible immediately, where the
> > ACPI Sleep register is located, as a result neither poweroff(S5)
> > nor suspend to ram(S3) works.
> > 
> > As suggested by Bjorn, further testing shows that, there is an
> > unreported device may be (using) conflict with above aperture,
> > which brings unpredictable result such as the failure of accessing
> > the io port, which blocks the poweroff(S5). Besides if we reassign
> > the memory aperture to the other place, the poweroff works again.
> > 
> > As we do not find any resource declared in _CRS which contain above
> > memory aperture, and Mac OS does not use this pci bridge neither, we
> > choose a simple workaround to clear the hotplug flag(suggested by
> > Yinghai Lu), thus do not allocate any resource for this pci bridge,
> > and thereby no conflict anymore.
> > 
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=103211
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/pci/quirks.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 37ff015..04bbdba 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2776,6 +2776,26 @@ static void quirk_hotplug_bridge(struct pci_dev *dev)
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
> >  
> >  /*
> > + * Apple: Avoid programming the memory/io aperture of 00:1c.0
> > + *
> > + * BIOS does not declare any resource for 00:1c.0, but with
> > + * hotplug flag set, thus the OS allocates:
> > + * [mem 0x7fa00000 - 0x7fbfffff]
> > + * [mem 0x7fc00000-0x7fdfffff 64bit pref]
> > + * which is conflict with an unreported device, which
> > + * causes unpredictable result such as accessing io port.
> > + * So clear the hotplug flag to work around it.
> > + */
> > +static void quirk_apple_mbp_poweroff(struct pci_dev *dev)
> > +{
> > +	if (dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,4") ||
> > +	    dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,5"))
> > +		dev->is_hotplug_bridge = 0;
> > +}
> > +
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);
> > +
> > +/*
> >   * This is a quirk for the Ricoh MMC controller found as a part of
> 
> I give up.  We're not making any progress on this.  I propose the
> following patch for v4.13.  This is slightly modified to:
> 
>   - move to arch/x86/pci/fixups.c, since I think this is specific to
>     x86
> 
>   - only clear dev->is_hotplug_bridge for the 00:1c.0 bridge, since
>     these systems contain other bridges where I think we *do* want to
>     support hotplug, e.g., the Thunderbolt bridge at 09:00.0 (from
>     https://bugzilla.kernel.org/attachment.cgi?id=210611)
> 
>   - log a note in dmesg about what we're doing
> 
> commit f7bf6baa11b84534d0b7f5ceee06e3349948c853
> Author: Chen Yu <yu.c.chen@intel.com>
> Date:   Fri Aug 19 16:30:25 2016 +0800
> 
>     PCI: Work around poweroff & suspend-to-RAM issue on Macbook Pro 11
>     
>     Neither soft poweroff (transition to ACPI power state S5) nor
>     suspend-to-RAM (transition to state S3) works on the Macbook Pro 11,4 and
>     11,5.
>     
>     The problem is related to assigning the [mem 0x7fa00000-0x7fbfffff] space
>     to the 00:1c.0 Root Port.  This port isn't connected to anything, but it
>     advertises hotplug support in its PCIe Capability.  Initially it has no
>     windows assigned, and if Linux leaves it that way, poweroff and
>     suspend-to-RAM work fine.
>     
>     Since the port supports hotplug, Linux assigns windows for future hot-added
>     devices.  We currently assign [mem 0x7fa00000-0x7fbfffff] for the memory
>     window, and poweroff and suspend-to-RAM don't work after this assignment.
>     
>     Linux does a soft poweroff (transition to S5) by writing to PM1_CNT at
>     [io 0x1804].  The theory about why this doesn't work is:
>     
>       - The write to PM1_CNT causes an SMI.
>       - The BIOS SMI handler depends on something in [mem 0x7fa00000-0x7fbfffff].
>       - When Linux assigns [mem 0x7fa00000-0x7fbfffff] to the 00:1c.0 Port, it
>         covers up whatever the SMI handler uses, so the SMI handler no longer
>         works correctly.
>     
>     Mark the 00:1c.0 bridge as not supporting hotplug, so we don't assign the
>     [mem 0x7fa00000-0x7fbfffff] space to it.
>     
>     Note that we don't know what the real conflict is, so other use of this
>     memory range by another device may cause similar problems.
>     
>     Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=103211
>     Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>     [bhelgaas: limit to device 00:1c.0, add printk, changelog, comment]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Cc: Rafael J. Wysocki <rafael@kernel.org>
>     Cc: Lukas Wunner <lukas@wunner.de>
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 6d52b94f4bb9..e6b3bf9ecf81 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -571,3 +571,29 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
> +
> +/*
> + * Apple: Avoid programming the memory/io apertures of 00:1c.0
> + *
> + * The BIOS does not assign any windows to the 00:1c.0 Root Port, but the
> + * port advertises hotplug support in the PCIe Capability, so Linux assigns
> + *
> + *   [mem 0x7fa00000 - 0x7fbfffff]
> + *
> + * This assignment somehow causes a conflict with I/O port 0x1804, which is
> + * used for soft poweroff and suspend-to-RAM.  Clear the hotplug flag to
> + * keep Linux from assigning the window above.
> + *
> + * N.B. We don't know what the conflict is, so other use of this memory
> + * range by another device may cause similar problems.
> + */
> +static void quirk_apple_mbp_poweroff(struct pci_dev *dev)
> +{
> +	if ((dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,4") ||
> +	     dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,5")) &&
> +	    dev->bus->number == 0 && dev->devfn == PCI_DEVFN(0x1c, 0)) {
> +		dev_info(&dev->dev, "treating as non-hotplug bridge to work around poweroff issue\n");
> +		dev->is_hotplug_bridge = 0;
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);

This patch stinks, sorry.  I'll try again tomorrow.  The problem is
the address space, not the device, so we should be able to do better
than this.
