Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:44130 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab3H2IIh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2013 04:08:37 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSA00JLO99EK300@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 29 Aug 2013 17:08:36 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Seungwon Jeon' <tgih.jun@samsung.com>, linux-pci@vger.kernel.org
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <001d01cea3e5$3a07c8b0$ae175a10$%jun@samsung.com>
In-reply-to: <001d01cea3e5$3a07c8b0$ae175a10$%jun@samsung.com>
Subject: Re: [PATCH 2/3] PCI: exynos: add wrapped I/O access functions
Date: Thu, 29 Aug 2013 17:08:35 +0900
Message-id: <000f01cea48e$f5fc3160$e1f49420$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 28, 2013 8:54 PM, Seungwon Jeon wrote:
> 
> read/write operation for I/O mem is wrapped with hiding
> base address inside in order to simplify the usage.
> [elbi_base, phy_base, block_base]
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Thank you for sending the patch.
It looks good except one minor thing below mentioned.
Also, I tested this patch on Exynos5440.

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pci-exynos.c |  161 +++++++++++++++++++++++------------------
>  1 files changed, 91 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index 012ca8a..da6ad6f 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -61,7 +61,6 @@ struct exynos_pcie {
>  #define PCIE_ELBI_SLV_AWMISC		0x11c
>  #define PCIE_ELBI_SLV_ARMISC		0x120
>  #define PCIE_ELBI_SLV_DBI_ENABLE	(0x1 << 21)
> -

But, this removing one line is not necessary.

>  /* PCIe Purple registers */
>  #define PCIE_PHY_GLOBAL_RESET		0x000
>  #define PCIE_PHY_COMMON_RESET		0x004
> @@ -91,19 +90,49 @@ struct exynos_pcie {
>  #define PCIE_PHY_TRSV3_RXCDR		0x2ec
>  #define PCIE_PHY_TRSV3_LVCC		0x31c


