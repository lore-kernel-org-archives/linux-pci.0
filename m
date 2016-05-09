Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54314 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061AbcEITUf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 May 2016 15:20:35 -0400
Date: Mon, 9 May 2016 14:20:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Myron Stowe <mstowe@redhat.com>,
	x86@kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/PCI: Fix Broadwell-EP Home Agent & PCU non-compliant
 BARs
Message-ID: <20160509192030.GA18166@localhost>
References: <1462818195-6533-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462818195-6533-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Andi]

Hi Prarit,

On Mon, May 09, 2016 at 02:23:15PM -0400, Prarit Bhargava wrote:
> commit b894157 ("x86/PCI: Mark Broadwell-EP Home Agent & PCU as having
> non-compliant BARs") marks Home Agent 0 & PCU has having non-compliant
> BARs.

By convention, I use 12-char SHA1 ("[core] abbrev=12" in .git/config)
when citing commits.

> Before commit b894157,
> 
> pci 0000:ff:12.0: BAR 2: failed to assign [mem size 0x00000040]
> pci 0000:ff:12.0: BAR 4: failed to assign [mem size 0x00000040]
> pci 0000:ff:12.4: BAR 2: failed to assign [mem size 0x00000040]
> pci 0000:ff:12.4: BAR 4: failed to assign [mem size 0x00000040]
> pci 0000:ff:12.0: BAR 1: failed to assign [mem size 0x00000010]
> pci 0000:ff:12.0: BAR 3: failed to assign [mem size 0x00000010]
> pci 0000:ff:12.0: BAR 5: failed to assign [mem size 0x00000010]
> pci 0000:ff:12.4: BAR 1: failed to assign [mem size 0x00000010]
> pci 0000:ff:12.4: BAR 3: failed to assign [mem size 0x00000010]
> pci 0000:ff:12.4: BAR 5: failed to assign [mem size 0x00000010]
> pci 0000:7f:12.0: BAR 2: failed to assign [mem size 0x00000040]
> pci 0000:7f:12.0: BAR 4: failed to assign [mem size 0x00000040]
> pci 0000:7f:12.4: BAR 2: failed to assign [mem size 0x00000040]
> pci 0000:7f:12.4: BAR 4: failed to assign [mem size 0x00000040]
> pci 0000:7f:12.0: BAR 1: failed to assign [mem size 0x00000010]
> pci 0000:7f:12.0: BAR 3: failed to assign [mem size 0x00000010]
> pci 0000:7f:12.0: BAR 5: failed to assign [mem size 0x00000010]
> pci 0000:7f:12.4: BAR 1: failed to assign [mem size 0x00000010]
> pci 0000:7f:12.4: BAR 3: failed to assign [mem size 0x00000010]
> pci 0000:7f:12.4: BAR 5: failed to assign [mem size 0x00000010]
> 
> After commit b894157, there are still "failed to assign" messages,
> as well as new "failed to assign" messages for ff:12.0, ff:1e.3,
> 7f:12.0, and 7f:1e.3.
> 
>  pci 0000:ff:12.4: BAR 2: failed to assign [mem size 0x00000040]
>  pci 0000:ff:12.4: BAR 4: failed to assign [mem size 0x00000040]
>  pci 0000:ff:12.4: BAR 1: failed to assign [mem size 0x00000010]
>  pci 0000:ff:12.4: BAR 3: failed to assign [mem size 0x00000010]
>  pci 0000:ff:12.4: BAR 5: failed to assign [mem size 0x00000010]
>  pci 0000:ff:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
>  pci 0000:ff:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
>  pci 0000:7f:12.4: BAR 2: failed to assign [mem size 0x00000040]
>  pci 0000:7f:12.4: BAR 4: failed to assign [mem size 0x00000040]
>  pci 0000:7f:12.4: BAR 1: failed to assign [mem size 0x00000010]
>  pci 0000:7f:12.4: BAR 3: failed to assign [mem size 0x00000010]
>  pci 0000:7f:12.4: BAR 5: failed to assign [mem size 0x00000010]
>  pci 0000:7f:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
>  pci 0000:7f:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
> 
> There are two issues with commit b894157.
> 
> The first is that there is another device, Home Agent 1 & PCU, that must
> also be quirked in the same way.
> 
> \# lspci -n -s 7f:12.4
> 7f:12.4 0880: 8086:6f60 (rev 01)

I think we should split this into two patches: one to add quirks for
the Home Agent 1 & PCU, and a second for the resource assignment
issue.

Can you dig up a spec for these devices?  I should have asked Andi for
that the first time around, but I didn't.  Maybe there's something
we're not interpreting correctly.  I still have a hard time believing
that Intel would produce a PCI device with non-BAR registers where the
BARs are supposed to be.  Maybe there's supposed to be an EA
capability or something that tells us to ignore these registers.

Can you collect "lspci -vvxxx" output for one of these devices?

> After applying the quirk patch, we end up with:
> 
> pci 0000:ff:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
> pci 0000:ff:12.4: BAR 6: failed to assign [mem size 0x00000001 pref]
> pci 0000:ff:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
> pci 0000:7f:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
> pci 0000:7f:12.4: BAR 6: failed to assign [mem size 0x00000001 pref]
> pci 0000:7f:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
> 
> which drives us to the second issue.  Since the PCI devices now
> have unnassigned resources (BARs), pcibios_assign_resources()
> call pci_assign_unassigned_root_bus_resources().  This results in the
> messages above.  I have added a non_compliant_bars check in
> pbus_assign_resources_sorted() to avoid the unassigned device's resources
> from being added to the failed resources list for the bus.

I don't understand this part yet.  If we mark a device with
non_compliant_bars, __pci_read_base() will return without doing
anything, so we should not fill in the struct resource at all.  It
wouldn't have the "mem" or "pref" bits shown above, and it shouldn't
participate in pcibios_assign_resources() at all.  All of these are
for BAR 6 (the ROM BAR), so maybe there's something wrong with the way
to handle that in particular.

Can you collect "lspci -vvxxx" output for one of these devices also?

> Successfully tested by me on a three vendor's Broadwell-EP systems which
> no longer show the above false errors messages.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Myron Stowe <mstowe@redhat.com>
> Cc: x86@kernel.org
> Fixes: b894157 ("x86/PCI: Mark Broadwell-EP Home Agent & PCU as having non-compliant BARs")
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  arch/x86/pci/fixup.c    |    1 +
>  drivers/pci/setup-bus.c |    6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b7de192..59a79e6 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -556,5 +556,6 @@ static void pci_bdwep_bar(struct pci_dev *dev)
>  {
>  	dev->non_compliant_bars = 1;
>  }
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_bdwep_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_bdwep_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_bdwep_bar);
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 55641a3..78b6b69 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -515,8 +515,10 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
>  	struct pci_dev *dev;
>  	LIST_HEAD(head);
>  
> -	list_for_each_entry(dev, &bus->devices, bus_list)
> -		__dev_sort_resources(dev, &head);
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		if (!dev->non_compliant_bars)
> +			__dev_sort_resources(dev, &head);
> +	}
>  
>  	__assign_resources_sorted(&head, realloc_head, fail_head);
>  }
> -- 
> 1.7.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
