Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:44122 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750973Ab3JWGls (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Oct 2013 02:41:48 -0400
Date: Wed, 23 Oct 2013 12:10:52 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Tim Harvey <tharvey@gateworks.com>,
	Kishon Vijay Abraham I <kishon@ti.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Marek Vasut <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
Message-ID: <20131023064051.GA7646@pratyush-vbox>
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1382504143-27915-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Wed, Oct 23, 2013 at 12:55:43PM +0800, Tim Harvey wrote:
> The IMX6 iATU is used for address translation between the AXI bus
> address space and PCI address space.  This is used for type0 and type1
> config cycles but is not necessary for outbound io/mem regions.
> 
> This patch removes the calls that inappropriately re-configures the ATU
> viewport for outbound memory and IO after config cycles and removes them
> altogether as they are not necessary.
> 
> This resolves issues with PCI devices behind switches and has been tested with
> a Gige device behind a PLX PEX860x switch.  More testing is needed for other
> configurations.

It seems to me that in your controller you have only one view port.
Also mem_base and mem_bus_addr is same. Thats why it works in your
case. 

I would suggest to wait for Kishon's work who would be trying to optimize
viewport allocations.

Regards
Pratyush

> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/pci/host/pcie-designware.c |   41 +++---------------------------------
>  1 file changed, 3 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 5d1f268..6cce779 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -46,7 +46,6 @@
>  #define PCIE_ATU_VIEWPORT		0x900
>  #define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
>  #define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
> -#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
>  #define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
>  #define PCIE_ATU_CR1			0x904
>  #define PCIE_ATU_TYPE_MEM		(0x0 << 0)
> @@ -502,8 +501,8 @@ static void dw_pcie_prog_viewport_cfg0(struct pcie_port *pp, u32 busdev)
>  
>  static void dw_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
>  {
> -	/* Program viewport 1 : OUTBOUND : CFG1 */
> -	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
> +	/* Program viewport 0 : OUTBOUND : CFG1 */
> +	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0,
>  			  PCIE_ATU_VIEWPORT);
>  	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG1, PCIE_ATU_CR1);
>  	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> @@ -513,38 +512,8 @@ static void dw_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
>  			  PCIE_ATU_LIMIT);
>  	dw_pcie_writel_rc(pp, busdev, PCIE_ATU_LOWER_TARGET);
>  	dw_pcie_writel_rc(pp, 0, PCIE_ATU_UPPER_TARGET);
> -}
> -
> -static void dw_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
> -{
> -	/* Program viewport 0 : OUTBOUND : MEM */
> -	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0,
> -			  PCIE_ATU_VIEWPORT);
> -	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_MEM, PCIE_ATU_CR1);
> -	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> -	dw_pcie_writel_rc(pp, pp->mem_base, PCIE_ATU_LOWER_BASE);
> -	dw_pcie_writel_rc(pp, (pp->mem_base >> 32), PCIE_ATU_UPPER_BASE);
> -	dw_pcie_writel_rc(pp, pp->mem_base + pp->config.mem_size - 1,
> -			  PCIE_ATU_LIMIT);
> -	dw_pcie_writel_rc(pp, pp->config.mem_bus_addr, PCIE_ATU_LOWER_TARGET);
> -	dw_pcie_writel_rc(pp, upper_32_bits(pp->config.mem_bus_addr),
> -			  PCIE_ATU_UPPER_TARGET);
> -}
> -
> -static void dw_pcie_prog_viewport_io_outbound(struct pcie_port *pp)
> -{
> -	/* Program viewport 1 : OUTBOUND : IO */
> -	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
> -			  PCIE_ATU_VIEWPORT);
> -	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_IO, PCIE_ATU_CR1);
> +	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG1, PCIE_ATU_CR1);
>  	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> -	dw_pcie_writel_rc(pp, pp->io_base, PCIE_ATU_LOWER_BASE);
> -	dw_pcie_writel_rc(pp, (pp->io_base >> 32), PCIE_ATU_UPPER_BASE);
> -	dw_pcie_writel_rc(pp, pp->io_base + pp->config.io_size - 1,
> -			  PCIE_ATU_LIMIT);
> -	dw_pcie_writel_rc(pp, pp->config.io_bus_addr, PCIE_ATU_LOWER_TARGET);
> -	dw_pcie_writel_rc(pp, upper_32_bits(pp->config.io_bus_addr),
> -			  PCIE_ATU_UPPER_TARGET);
>  }
>  
>  static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> @@ -560,11 +529,9 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  	if (bus->parent->number == pp->root_bus_nr) {
>  		dw_pcie_prog_viewport_cfg0(pp, busdev);
>  		ret = cfg_read(pp->va_cfg0_base + address, where, size, val);
> -		dw_pcie_prog_viewport_mem_outbound(pp);
>  	} else {
>  		dw_pcie_prog_viewport_cfg1(pp, busdev);
>  		ret = cfg_read(pp->va_cfg1_base + address, where, size, val);
> -		dw_pcie_prog_viewport_io_outbound(pp);
>  	}
>  
>  	return ret;
> @@ -583,11 +550,9 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  	if (bus->parent->number == pp->root_bus_nr) {
>  		dw_pcie_prog_viewport_cfg0(pp, busdev);
>  		ret = cfg_write(pp->va_cfg0_base + address, where, size, val);
> -		dw_pcie_prog_viewport_mem_outbound(pp);
>  	} else {
>  		dw_pcie_prog_viewport_cfg1(pp, busdev);
>  		ret = cfg_write(pp->va_cfg1_base + address, where, size, val);
> -		dw_pcie_prog_viewport_io_outbound(pp);
>  	}
>  
>  	return ret;
> -- 
> 1.7.9.5
