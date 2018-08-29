Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46312 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH2U5Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Aug 2018 16:57:24 -0400
Subject: Re: [PATCH] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, Narendra_K@Dell.com,
        Stuart_Hayes@Dell.com, lukas@wunner.de,
        linux-kernel@vger.kernel.org
References: <20180730212146.31909-1-mr.nuke.me@gmail.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <d0b5fa66-e16d-8686-79e2-4d7177cd4806@gmail.com>
Date: Wed, 29 Aug 2018 11:59:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180730212146.31909-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Should I resubmit this rebased on 4.19-rc*, or just leave this patch as is?

Alex

On 07/30/2018 04:21 PM, Alexandru Gagniuc wrote:
> When a PCI device is gone, we don't want to send IO to it if we can
> avoid it. We expose functionality via the irq_chip structure. As
> users of that structure may not know about the underlying PCI device,
> it's our responsibility to guard against removed devices.
> 
> irq_write_msi_msg is already guarded. pci_msi_(un)mask_irq are not.
> Guard them for completeness.
> 
> For example, surprise removal of a PCIe device triggers teardown. This
> touches the irq_chips ops some point to disable the interrupts. I/O
> generated here can crash the system on machines with buggy firmware.
> Not triggering the IO in the first place eliminates the problem.
> 
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
>   drivers/pci/msi.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 4d88afdfc843..5f47b5cb0401 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
>   {
>   	struct msi_desc *desc = irq_data_get_msi_desc(data);
>   
> +	if (pci_dev_is_disconnected(msi_desc_to_pci_dev(desc)))
> +		return;
> +
>   	if (desc->msi_attrib.is_msix) {
>   		msix_mask_irq(desc, flag);
>   		readl(desc->mask_base);		/* Flush write to device */
> 
