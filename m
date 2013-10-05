Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:32549 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab3JEAZv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2013 20:25:51 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MU600D7O6J2FR60@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Sat, 05 Oct 2013 09:25:50 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Seungwon Jeon' <tgih.jun@samsung.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <001d01cea3e5$3a07c8b0$ae175a10$%jun@samsung.com>
 <000f01cea48e$f5fc3160$e1f49420$%han@samsung.com>
 <002001cec0de$f4cd48d0$de67da70$%jun@samsung.com>
In-reply-to: <002001cec0de$f4cd48d0$de67da70$%jun@samsung.com>
Subject: Re: [PATCH] PCI: designware: add missing header guards
Date: Sat, 05 Oct 2013 09:25:50 +0900
Message-id: <001701cec161$71b5a040$5520e0c0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, October 04, 2013 5:52 PM, Seungwon Jeon wrote:
> 
> Added missing header guards against the redundant inclusion.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/pci/host/pcie-designware.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index faccbbf..0b685b5 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -11,6 +11,9 @@
>   * published by the Free Software Foundation.
>   */
> 
> +#ifndef _PCIE_DESIGNWARE_H_
> +#define _PCIE_DESIGNWARE_H_

It looks good.
But, I prefer '_PCIE_DESIGNWARE_H'.
I will fix and send v2 patch, soon.

Best regards,
Jingoo Han

> +
>  struct pcie_port_info {
>  	u32		cfg0_size;
>  	u32		cfg1_size;
> @@ -77,3 +80,5 @@ int dw_pcie_host_init(struct pcie_port *pp);
>  int dw_pcie_setup(int nr, struct pci_sys_data *sys);
>  struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys);
>  int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
> +
> +#endif /* _PCIE_DESIGNWARE_H_ */
> --
> 1.7.0.4


