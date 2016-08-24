Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:51759 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754572AbcHXOQh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2016 10:16:37 -0400
Date: Wed, 24 Aug 2016 16:17:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][RFC v3] PCI: Workaround to enable poweroff on Mac Pro 11
Message-ID: <20160824141731.GA23108@wunner.de>
References: <1471595425-1752-1-git-send-email-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471595425-1752-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 19, 2016 at 04:30:25PM +0800, Chen Yu wrote:
> People reported that they can not do a poweroff nor a
> suspend to ram on their Mac Pro 11. After some investigations
> it was found that, once the PCI bridge 0000:00:1c.0 reassigns its
> mm windows to ([mem 0x7fa00000-0x7fbfffff] and
> [mem 0x7fc00000-0x7fdfffff 64bit pref]), the region of ACPI
> io resource 0x1804 becomes unaccessible immediately, where the
> ACPI Sleep register is located, as a result neither poweroff(S5)
> nor suspend to ram(S3) works.

To provide a bit more context:

The root port in question (0000:00:1c.0) is not listed in the DSDT.
On macOS, only devices present in the ACPI namespace are incorporated
into the I/O Kit registry. Consequently macOS pretends that this root
port doesn't exist. It's not listed in the "ioreg -l" output and thus
no driver is attached to this device.

So what we're dealing with is sloppiness on the part of Apple:
Some engineer probably forgot to disable this unused root port
and they didn't notice it during testing because their OS ignores
such devices.

We could in principle achieve the same behaviour by adding a PCI
device only if it has an ACPI companion, perhaps quirk this only
to Macs. I'm not sure if that's the right thing to do though.
What if they hide devices from macOS but we want to access them
on Linux?

What's really odd is that changing *memory* windows affects
accessibility of *I/O ports*.

One theory would be that I/O ports are somehow mapped into memory.
The GPIO pins of Intel chipsets are usually accessible through
I/O ports, but I've recently looked at the DSDT of the newest
MacBook9,1 (2016) and it looks like they're now accessed through
SystemMemory instead of SystemIO. Perhaps someone at Intel knows
about these intricacies of their chipsets.

If I/O ports are indeed mapped into memory, we need to find a way
to identify and reserve that region. So while this patch seems
like a workable and sufficiently small fix, it might mask a larger
underlying issue. It's certainly a problem though that these
machines currently cannot power off or suspend.

FWIW, we have a somewhat similar issue with the Apple gmux
(a microcontroller built into dual GPU MacBook Pros). That chip
is attached to the LPC bus and accessed through I/O ports.
It turns out that once VGA IO is locked to the discrete GPU
using vgaarb, gmux' I/O ports suddenly become inaccessible.
Apparently its I/O ports are routed to the secondary PCI bus
to which the discrete GPU is connected, and no longer to the
root bus on which the LPC bridge resides. However gmux' I/O ports
are in the 0x700-0x7ff range, whereas the VGA registers are in
the 0x3b0-0x3bb and 0x3c0-0x3df range. So that's another oddity
of Intel chipsets with regards to I/O accessibility.

Best regards,

Lukas

> 
> As suggested by Bjorn, further testing shows that, there is an
> unreported device may be (using) conflict with above aperture,
> which brings unpredictable result such as the failure of accessing
> the io port, which blocks the poweroff(S5). Besides if we reassign
> the memory aperture to the other place, the poweroff works again.
> 
> As we do not find any resource declared in _CRS which contain above
> memory aperture, and Mac OS does not use this pci bridge neither, we
> choose a simple workaround to clear the hotplug flag(suggested by
> Yinghai Lu), thus do not allocate any resource for this pci bridge,
> and thereby no conflict anymore.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=103211
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/pci/quirks.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 37ff015..04bbdba 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2776,6 +2776,26 @@ static void quirk_hotplug_bridge(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
>  
>  /*
> + * Apple: Avoid programming the memory/io aperture of 00:1c.0
> + *
> + * BIOS does not declare any resource for 00:1c.0, but with
> + * hotplug flag set, thus the OS allocates:
> + * [mem 0x7fa00000 - 0x7fbfffff]
> + * [mem 0x7fc00000-0x7fdfffff 64bit pref]
> + * which is conflict with an unreported device, which
> + * causes unpredictable result such as accessing io port.
> + * So clear the hotplug flag to work around it.
> + */
> +static void quirk_apple_mbp_poweroff(struct pci_dev *dev)
> +{
> +	if (dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,4") ||
> +	    dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,5"))
> +		dev->is_hotplug_bridge = 0;
> +}
> +
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);
> +
> +/*
>   * This is a quirk for the Ricoh MMC controller found as a part of
>   * some mulifunction chips.
>  
> -- 
> 2.7.4
> 
