Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753580AbcHSCgO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 22:36:14 -0400
Date: Thu, 18 Aug 2016 15:39:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Maik Broemme <mbroemme@libmpq.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Chris Blake <chrisrblake93@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Mark Atheros AR9580 to avoid bus reset
Message-ID: <20160818203958.GL27353@localhost>
References: <20160809144131.GI1034@libmpq.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160809144131.GI1034@libmpq.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Chris, Alex]

On Tue, Aug 09, 2016 at 04:41:31PM +0200, Maik Broemme wrote:
> Similar to the AR93xx and the AR94xx series, the AR95xx also have the
> same quirk for the Bus Reset. It will lead to instant system reset if
> the device is assigned via VFIO to a KVM VM. I've been able reproduce
> this behavior with a MikroTik R11e-2HnD.
> 
> Fixes: c3e59ee4e766 ("PCI: Mark Atheros AR93xx to avoid bus reset")
> Signed-off-by: Maik Broemme <mbroemme@libmpq.org>
> CC: stable@vger.kernel.org

Applied to pci/virtualization for v4.9, thanks!

> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 37ff015..7d82189 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3198,6 +3198,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
>  
>  static void quirk_no_pm_reset(struct pci_dev *dev)
>  {
> -- 
> 2.9.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
