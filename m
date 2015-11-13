Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:17949 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbbKMDHS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2015 22:07:18 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>
CC: Jisheng Zhang <jszhang@marvell.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hisi: fix deferred probing
Date: Fri, 13 Nov 2015 03:06:27 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E162AA609@lhreml503-mbs>
References: <1447329728-1589-1-git-send-email-jszhang@marvell.com>
 <4417267.EzK5DAjM5p@wuerfel>
In-Reply-To: <4417267.EzK5DAjM5p@wuerfel>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks Arnd, this looks ok to me

Zhou Wang can you please Ack?

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Arnd Bergmann
> Sent: 12 November 2015 12:22
> To: linux-arm-kernel@lists.infradead.org
> Cc: Jisheng Zhang; Wangzhou (B); bhelgaas@google.com; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] PCI: hisi: fix deferred probing
> 
> The hisi_pcie_probe function is incorrectly marked as __init, as Kconfig
> tells us:
> 
> WARNING: drivers/pci/host/built-in.o(.data+0x7780): Section mismatch in
> reference from the variable hisi_pcie_driver to the
> function .init.text:hisi_pcie_probe()
> 
> If the probe for this device gets deferred past the point where __init
> functions are removed, or the device is unbound and then reattached to
> the driver, we branch into uninitialized memory, which is bad.
> 
> This removes the __init annotation.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> index 35457ecd8e70..163671a4f798 100644
> --- a/drivers/pci/host/pcie-hisi.c
> +++ b/drivers/pci/host/pcie-hisi.c
> @@ -111,7 +111,7 @@ static struct pcie_host_ops hisi_pcie_host_ops = {
>  	.link_up = hisi_pcie_link_up,
>  };
> 
> -static int __init hisi_add_pcie_port(struct pcie_port *pp,
> +static int hisi_add_pcie_port(struct pcie_port *pp,
>  				     struct platform_device *pdev)
>  {
>  	int ret;
> @@ -139,7 +139,7 @@ static int __init hisi_add_pcie_port(struct pcie_port *pp,
>  	return 0;
>  }
> 
> -static int __init hisi_pcie_probe(struct platform_device *pdev)
> +static int hisi_pcie_probe(struct platform_device *pdev)
>  {
>  	struct hisi_pcie *hisi_pcie;
>  	struct pcie_port *pp;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
