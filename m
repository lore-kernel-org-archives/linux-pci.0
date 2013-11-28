Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53027 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab3K1Eia (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2013 23:38:30 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY0020VI7NSOA0@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 28 Nov 2013 13:38:11 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <002801ceebe7$a0293170$e07b9450$%han@samsung.com>
In-reply-to: <002801ceebe7$a0293170$e07b9450$%han@samsung.com>
Subject: Re: [PATCH] PCI: PCIe portdrv: use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 13:38:10 +0900
Message-id: <005501ceebf3$a4692ea0$ed3b8be0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, November 28, 2013 12:12 PM, Jingoo Han wrote:
> 
> This macro is used to create a struct pci_device_id array.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Please, ignore this patch.
According to the Greg Kroah-Hartman, 

"Yeah, and it's a horrid macro that deserves to be removed, please don't
use it in more places.

Actually, if you could just remove it, that would be best, sorry, I'm
not going to take these patches."

So, I will send the patch to remove 'DEFINE_PCI_DEVICE_TABLE' instead.
Sorry for annoying. :-)

Best regards,
Jingoo Han

> ---
>  drivers/pci/pcie/portdrv_pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 0d8fdc4..5356902 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -368,7 +368,7 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
>  /*
>   * LINUX Device Driver Model
>   */
> -static const struct pci_device_id port_pci_ids[] = { {
> +static DEFINE_PCI_DEVICE_TABLE(port_pci_ids) = { {
>  	/* handle any PCI-Express port */
>  	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
>  	}, { /* end: all zeroes */ }
> --
> 1.7.10.4


