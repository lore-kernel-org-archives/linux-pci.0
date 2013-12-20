Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36196 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab3LTQgc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Dec 2013 11:36:32 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl1so15489217igb.5
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2013 08:36:31 -0800 (PST)
Date: Fri, 20 Dec 2013 09:36:29 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Mohit Kumar <mohit.kumar@st.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Pratyush Anand <pratyush.anand@st.com>,
	Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marex@denx.de>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	spear-devel@list.st.com
Subject: Re: [PATCH 08/12] pcie: designware: Fix IO transfers
Message-ID: <20131220163629.GB30026@google.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <6b4282b9e793ec89ba0c20f3362d41f6133a8132.1386752447.git.mohit.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6b4282b9e793ec89ba0c20f3362d41f6133a8132.1386752447.git.mohit.kumar@st.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 11, 2013 at 03:08:33PM +0530, Mohit Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> pp->io_base which is the input of the outbound IO address translation
> unit should be the cpu address, it was programmed wrongly to realio
> address.
> 
> We should pass global_io_offset rather than sys->io_offset to
> pci_ioremap_io, so we map the new window into the first available spot
> in the Linux view of the I/O space.
> 
> We must also pass cpu address instead  of realio address to
> pci_ioremap_io.
> 
> This patch fixes above issue. It has been tested with Lecroy PTC in AIC
> mode and Pericom PI7C9X2G303EL PCIe switch, which does not work
> otherwise.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Tested-by: Mohit Kumar <mohit.kumar@st.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> Cc: linux-pci@vger.kernel.org
> Cc: spear-devel@list.st.com

Applied to pci/host-designware for v3.14, with these acks:

    Reviewed-by: Marek Vasut <marex@denx.de
    Reviewed-by: Jagannadha Sutradharudu Teki <jagannadh.teki@gmail.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Jingoo Han <jg1.han@samsung.com>

Thanks!

> ---
>  drivers/pci/host/pcie-designware.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index be6ce30..071ebc0 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -378,6 +378,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  					   + global_io_offset);
>  			pp->config.io_size = resource_size(&pp->io);
>  			pp->config.io_bus_addr = range.pci_addr;
> +			pp->io_base = range.cpu_addr;
>  		}
>  		if (restype == IORESOURCE_MEM) {
>  			of_pci_range_to_resource(&range, np, &pp->mem);
> @@ -403,7 +404,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  
>  	pp->cfg0_base = pp->cfg.start;
>  	pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
> -	pp->io_base = pp->io.start;
>  	pp->mem_base = pp->mem.start;
>  
>  	pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
> @@ -573,7 +573,6 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  	return ret;
>  }
>  
> -
>  static int dw_pcie_valid_config(struct pcie_port *pp,
>  				struct pci_bus *bus, int dev)
>  {
> @@ -667,7 +666,7 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
>  
>  	if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
>  		sys->io_offset = global_io_offset - pp->config.io_bus_addr;
> -		pci_ioremap_io(sys->io_offset, pp->io.start);
> +		pci_ioremap_io(global_io_offset, pp->io_base);
>  		global_io_offset += SZ_64K;
>  		pci_add_resource_offset(&sys->resources, &pp->io,
>  					sys->io_offset);
> -- 
> 1.7.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
