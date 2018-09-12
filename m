Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbeIMCe5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Sep 2018 22:34:57 -0400
Date: Wed, 12 Sep 2018 16:28:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, Narendra_K@Dell.com,
        Stuart_Hayes@Dell.com, lukas@wunner.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20180912212831.GM118330@bhelgaas-glaptop.roam.corp.google.com>
References: <20180730212146.31909-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730212146.31909-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 30, 2018 at 04:21:44PM -0500, Alexandru Gagniuc wrote:
> When a PCI device is gone, we don't want to send IO to it if we can
> avoid it. We expose functionality via the irq_chip structure. As
> users of that structure may not know about the underlying PCI device,
> it's our responsibility to guard against removed devices.

I'm pretty ambivalent about pci_dev_is_disconnected() in general, but
I think I'll take this, given a couple minor changelog clarifications:

> irq_write_msi_msg is already guarded. pci_msi_(un)mask_irq are not.
> Guard them for completeness.

By the irq_write_msi_msg() guard, I guess you mean this path:

  pci_msi_domain_write_msg       # irq_chip.irq_write_msi_msg
    __pci_write_msi_msg
      if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev))
        /* don't touch */

pci_msi_(un)mask_irq() may be irq_chip.irq_mask, .irq_unmask, etc
pointers.  So these are parallel because they're all irq_chip function
pointers, but the changelog isn't (yet) parallel because it uses the
irq_chip pointer name for .irq_write_msi_msg but not for mask/unmask.

> For example, surprise removal of a PCIe device triggers teardown. This
> touches the irq_chips ops some point to disable the interrupts. I/O
> generated here can crash the system on machines with buggy firmware.
> Not triggering the IO in the first place eliminates the problem.

It doesn't eliminate the problem completely because .irq_mask() and
.irq_unmask() may be called for reasons other than surprise removal,
and if a surprise removal happens after the pci_dev_is_disconnected()
check but before the readl(), we will still generate I/O to a device
that's gone.  I'd be OK if you said it "reduces" the problem.

One reason I'm ambivalent about pci_dev_is_disconnected() is that in
cases like this, it turns a reproducible problem into a very
hard-to-reproduce problem, which reduces the likelihood that the buggy
firmware will be fixed.

Do you have information about known platforms with this buggy firmware
and the signature of the crash?  If you do, it's always nice to be
able to connect a patch with the user-visible problem it fixes.

> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
> 
> There's another patch by Lukas Wunner that is needed (not yet published)
> in order to fully block IO on SURPRISE!!! removal. The existing code only
> sets the PCI_DEV_DISCONNECTED bit in an unreasonably narrow set of
> circumstances. Lukas' patch fixes that.
> 
> However, this change is otherwise fully independent, and enjoy!
> 
>  drivers/pci/msi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 4d88afdfc843..5f47b5cb0401 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
>  {
>  	struct msi_desc *desc = irq_data_get_msi_desc(data);
>  
> +	if (pci_dev_is_disconnected(msi_desc_to_pci_dev(desc)))
> +		return;
> +
>  	if (desc->msi_attrib.is_msix) {
>  		msix_mask_irq(desc, flag);
>  		readl(desc->mask_base);		/* Flush write to device */
> -- 
> 2.17.1
> 
