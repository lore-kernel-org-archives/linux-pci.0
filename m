Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49207 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932573AbcBPROW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 16 Feb 2016 12:14:22 -0500
Date: Tue, 16 Feb 2016 11:14:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
Cc: Jayachandran C <jchandra@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] PCI: Handle Broadcom Vulcan quirks
Message-ID: <20160216171418.GA702@localhost>
References: <1455487501-28630-2-git-send-email-jchandra@broadcom.com>
 <1455528398-29311-1-git-send-email-jchandra@broadcom.com>
 <20160215183015.GC12641@localhost>
 <CAKc_7PVVn2ookpbOUuT-jyUq6e6hJYKLpM+d9=6CqYtLO45tWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKc_7PVVn2ookpbOUuT-jyUq6e6hJYKLpM+d9=6CqYtLO45tWw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 16, 2016 at 09:47:34PM +0530, Jayachandran Chandrashekaran Nair wrote:
> On Tue, Feb 16, 2016 at 12:00 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Feb 15, 2016 at 02:56:38PM +0530, Jayachandran C wrote:
> >> Handle two quirks of the PCI controller on Broadcom's Vulcan processor.
> >>  - Mark internal bridges so that they are skipped during DMA alias
> >>    search.
> >>  - Skip BAR0 resource assignment for internal bridges. The BARs
> >>    of internal bridges should not be assigned from the mem resource
> >>    range.
> >>
> >> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> >> ---
> >>
> >> Resending, last patch was missing the Signed-off-by, also fixed the
> >> comment a bit.
> >
> > If you resend a patch, please increment the version number and resend
> > the entire series, no matter how minor the change was.  Version
> > numbers are free, and it's a hassle for me to sort out multiple
> > versions labeled with the same number.
> 
> Since it was an RFC, I thought setting the in-reply-to would be sufficient.
> Looks like I was mistaken, sorry for the trouble.
> 
> >>
> >>  drivers/pci/quirks.c | 21 +++++++++++++++++++++
> >>  1 file changed, 21 insertions(+)
> >>
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index 0575a1e..afc186a 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -3705,6 +3705,27 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
> >>  DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
> >>
> >>  /*
> >> + * Two levels of bridges in Broadcom Vulcan are not real PCI or PCIe bridges.
> >> + * These are internal bridges and should not be used for dma alias
> >> + * calculations. Additionally, the BAR0 of thes bridges should not be
> >> + * assigned with a mem resource from linux
> >> + */
> >> +static void quirk_bridge_brcm_vulcan_internal(struct pci_dev *pdev)
> >> +{
> >> +     struct resource *r = &pdev->resource[0];
> >> +
> >> +     /* skip from alias search */
> >> +     pdev->dev_flags |= PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS;
> >> +
> >> +     /* clear BAR0, should not be used from Linux */
> >> +     memset(r, 0, sizeof(*r));
> >
> > This definitely needs some explanation.  The whole point of the
> > architected PCI config space header is so that generic OS code can
> > manage the device without having to add device-specific code.
> >
> > Are you saying the register at 0x10 in config space is not actually a
> > BAR at all?  Or it is a BAR, but you don't think anybody should need
> > to use it?
> 
> These is a proper BAR (64 bit pref) in the bridge's Type 1 header, but:
> 1. Assigning a memory resource from the pci memory window to this
>    BAR causes the PCIe system to fail (this is a bug). So we cannot
>    expose this BAR to standard Linux code without even more quirks
>    and hacks.

Are you saying assigning space for this BAR exposes a Linux PCI bug?
If so, I'd like to know more about that because we should fix it.

Or does it expose a hardware bug in the Broadcom device?

> 2. This BAR is used for accessing debugging and private registers
>    of the PCI controller, which is not useful in Linux.
> 
> So I thought it is better to handle it with a quirk to hide the BAR. The
> device still works as a bridge and standard linux bridge configuration
> happens correctly.

Unfortunately, there's no way in PCI for a device to communicate that
some of the resources it requests are more valuable than others.
There's no way for it to say "I'm asking for these resources (via the
BAR), but I didn't really mean it."

> > BARs do not have enable bits, so no matter what value is
> > in the BAR, that value defines address space to which the device will
> > respond.  Linux needs to know about that, even if no driver actually
> > uses it.
> 
> This is a good point. We might need to read the firmware setting of this
> BAR and mark the physical address range reserved - but this may be
> to document the value.
> 
> >> +}
> >> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9000,
> >> +                             quirk_bridge_brcm_vulcan_internal);
> >> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9039,
> >> +                             quirk_bridge_brcm_vulcan_internal);
> >> +
> >> +/*
> >>   * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
> >>   * class code.  Fix it.
> >>   */
> 
> Thanks,
> JC.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
