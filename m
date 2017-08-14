Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752536AbdHNU7v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Aug 2017 16:59:51 -0400
Date: Mon, 14 Aug 2017 15:59:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mayurkumar Patel <mayurkumar.patel@intel.com>
Subject: Re: [PATCH] pciehp: Fix infinite interupt handler loop
Message-ID: <20170814205948.GF32525@bhelgaas-glaptop.roam.corp.google.com>
References: <1501571512-8362-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501571512-8362-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 01, 2017 at 03:11:52AM -0400, Keith Busch wrote:
> We've encountered a particular platform that under some circumstances
> always has the power fault detected status raised. The pciehp irq handler
> would loop forever because it thinks it is handling new events when in
> fact the power fault is not new. This patch fixes that by masking off
> the power fault status from new events if the driver hasn't seen the
> power fault clear from the previous handling attempt.

Can you say which platform this is?  If this is a hardware defect,
it'd be interesting to know where it happens.

But I'm not sure we handle PCI_EXP_SLTSTA correctly.  We basically
have this:

  pciehp_isr()
  {
    pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
    events = status & (<events we care about>);
    pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
    <queue event handling>
  }

The write to PCI_EXP_SLTSTA clears PCI_EXP_SLTSTA_PFD because it's
RW1C.  But we haven't done anything that would actually change the
situation that caused a power fault, so I don't think it would be
surprising if the hardware immediately reasserted it.

So maybe this continual assertion of power fault is really a software
bug, not a hardware problem?

> Fixes: fad214b0aa72 ("PCI: pciehp: Process all hotplug events before looking for new ones")
> 
> Cc: <stable@vger.kernel.org> # 4.9+
> Cc: Mayurkumar Patel <mayurkumar.patel@intel.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
> Resending due to send-email setup error; this patch may appear twice
> for some.
> 
>  drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 026830a..8ecbc13 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -583,7 +583,9 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	 * Slot Status contains plain status bits as well as event
>  	 * notification bits; right now we only want the event bits.
>  	 */
> -	events = status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> +	events = status & (PCI_EXP_SLTSTA_ABP |
> +			  (ctrl->power_fault_detected ?
> +				0 : PCI_EXP_SLTSTA_PFD) |
>  			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
>  			   PCI_EXP_SLTSTA_DLLSC);
>  	if (!events)
> -- 
> 2.5.5
> 
