Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40153 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbbFGFiF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 7 Jun 2015 01:38:05 -0400
Message-ID: <5573D8A5.8030309@ti.com>
Date: Sun, 7 Jun 2015 11:07:41 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Pratyush Anand <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/5] PCI: dra7xx: Use dw_pcie_link_up() consistently
References: <20150604220144.4377.40573.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150604220151.4377.38040.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604220151.4377.38040.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Friday 05 June 2015 03:31 AM, Bjorn Helgaas wrote:
> We already use dw_pcie_link_up() once in dra7xx_pcie_establish_link(), but
> we duplicate its code later.  Use dw_pcie_link_up() for consistency.  No
> functional change.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/pci/host/pci-dra7xx.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 2d57e19..e3d15d7 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -107,8 +107,7 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
>   	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
>
>   	while (retries--) {
> -		reg = dra7xx_pcie_readl(dra7xx,	PCIECTRL_DRA7XX_CONF_PHY_CS);
> -		if (reg & LINK_UP)
> +		if (dw_pcie_link_up(pp))
>   			break;
>   		usleep_range(10, 20);
>   	}
>
