Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42353 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbaBTLie (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 06:38:34 -0500
Message-ID: <5305E928.5070505@ti.com>
Date: Thu, 20 Feb 2014 17:08:16 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Mohit Kumar <mohit.kumar@st.com>, <jg1.han@samsung.com>
CC: Ajay Khandelwal <ajay.khandelwal@st.com>,
	Bjorn Helgaas <bhelgass@google.com>, <spear-devel@list.st.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI:designware:Fix iATU programming for cfg1, io
 and mem viewport
References: <1392873774-22249-1-git-send-email-mohit.kumar@st.com> <1392873774-22249-2-git-send-email-mohit.kumar@st.com>
In-Reply-To: <1392873774-22249-2-git-send-email-mohit.kumar@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thursday 20 February 2014 10:52 AM, Mohit Kumar wrote:
> This patch correct iATU programming for cfg1, io and mem viewport.
> Enable ATU only after configuring it.

Does this patch actually fixes device enumeration behind a PCIe-pci bridge or
this is more of cleaning up the sequence?

Thanks
Kishon

> 
> Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
> Signed-off-by: Ajay Khandelwal <ajay.khandelwal@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Bjorn Helgaas <bhelgass@google.com>
> Cc: spear-devel@list.st.com
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/host/pcie-designware.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 391966f..46f4a19 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -522,13 +522,13 @@ static void dw_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
>  	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
>  			  PCIE_ATU_VIEWPORT);
>  	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG1, PCIE_ATU_CR1);
> -	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>  	dw_pcie_writel_rc(pp, pp->cfg1_base, PCIE_ATU_LOWER_BASE);
>  	dw_pcie_writel_rc(pp, (pp->cfg1_base >> 32), PCIE_ATU_UPPER_BASE);
>  	dw_pcie_writel_rc(pp, pp->cfg1_base + pp->config.cfg1_size - 1,
>  			  PCIE_ATU_LIMIT);
>  	dw_pcie_writel_rc(pp, busdev, PCIE_ATU_LOWER_TARGET);
>  	dw_pcie_writel_rc(pp, 0, PCIE_ATU_UPPER_TARGET);
> +	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>  }
>  
>  static void dw_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
> @@ -537,7 +537,6 @@ static void dw_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
>  	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0,
>  			  PCIE_ATU_VIEWPORT);
>  	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_MEM, PCIE_ATU_CR1);
> -	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>  	dw_pcie_writel_rc(pp, pp->mem_base, PCIE_ATU_LOWER_BASE);
>  	dw_pcie_writel_rc(pp, (pp->mem_base >> 32), PCIE_ATU_UPPER_BASE);
>  	dw_pcie_writel_rc(pp, pp->mem_base + pp->config.mem_size - 1,
> @@ -545,6 +544,7 @@ static void dw_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
>  	dw_pcie_writel_rc(pp, pp->config.mem_bus_addr, PCIE_ATU_LOWER_TARGET);
>  	dw_pcie_writel_rc(pp, upper_32_bits(pp->config.mem_bus_addr),
>  			  PCIE_ATU_UPPER_TARGET);
> +	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>  }
>  
>  static void dw_pcie_prog_viewport_io_outbound(struct pcie_port *pp)
> @@ -553,7 +553,6 @@ static void dw_pcie_prog_viewport_io_outbound(struct pcie_port *pp)
>  	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
>  			  PCIE_ATU_VIEWPORT);
>  	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_IO, PCIE_ATU_CR1);
> -	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>  	dw_pcie_writel_rc(pp, pp->io_base, PCIE_ATU_LOWER_BASE);
>  	dw_pcie_writel_rc(pp, (pp->io_base >> 32), PCIE_ATU_UPPER_BASE);
>  	dw_pcie_writel_rc(pp, pp->io_base + pp->config.io_size - 1,
> @@ -561,6 +560,7 @@ static void dw_pcie_prog_viewport_io_outbound(struct pcie_port *pp)
>  	dw_pcie_writel_rc(pp, pp->config.io_bus_addr, PCIE_ATU_LOWER_TARGET);
>  	dw_pcie_writel_rc(pp, upper_32_bits(pp->config.io_bus_addr),
>  			  PCIE_ATU_UPPER_TARGET);
> +	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>  }
>  
>  static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> 

