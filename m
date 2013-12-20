Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:58877 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870Ab3LTQfa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Dec 2013 11:35:30 -0500
Received: by mail-ig0-f182.google.com with SMTP id c10so7514568igq.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2013 08:35:30 -0800 (PST)
Date: Fri, 20 Dec 2013 09:35:26 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Mohit Kumar <mohit.kumar@st.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Pratyush Anand <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>, spear-devel@list.st.com
Subject: Re: [PATCH 07/12] pcie: designware: add dw_pcie prefix before
 cfg_read/write
Message-ID: <20131220163526.GA30026@google.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <11157a3462fcad1067bddd27dcd580bbeb2c289e.1386752447.git.mohit.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11157a3462fcad1067bddd27dcd580bbeb2c289e.1386752447.git.mohit.kumar@st.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 11, 2013 at 03:08:32PM +0530, Mohit Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> cfg_read/write function are designware pcie specific. Add dw_pcie prefix
> to avoid collision in global name space.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Cc: Mohit Kumar <mohit.kumar@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: spear-devel@list.st.com
> Cc: linux-pci@vger.kernel.org

Applied to pci/host-designware for v3.14, with these acks:

    Tested-by: Jingoo Han <jg1.han@samsung.com>
    Reviewed-by: Jagannadha Sutradharudu Teki <jagannadh.teki@gmail.com>
    Acked-by: Jingoo Han <jg1.han@samsung.com>

Thanks!

> ---
>  drivers/pci/host/pci-exynos.c      |    5 +++--
>  drivers/pci/host/pcie-designware.c |   23 ++++++++++++++---------
>  drivers/pci/host/pcie-designware.h |    4 ++--
>  3 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index 24beed3..3de6bfb 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -468,7 +468,7 @@ static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>  	int ret;
>  
>  	exynos_pcie_sideband_dbi_r_mode(pp, true);
> -	ret = cfg_read(pp->dbi_base + (where & ~0x3), where, size, val);
> +	ret = dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, size, val);
>  	exynos_pcie_sideband_dbi_r_mode(pp, false);
>  	return ret;
>  }
> @@ -479,7 +479,8 @@ static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
>  	int ret;
>  
>  	exynos_pcie_sideband_dbi_w_mode(pp, true);
> -	ret = cfg_write(pp->dbi_base + (where & ~0x3), where, size, val);
> +	ret = dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3),
> +			where, size, val);
>  	exynos_pcie_sideband_dbi_w_mode(pp, false);
>  	return ret;
>  }
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 73aa13c..be6ce30 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -32,7 +32,7 @@ static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
>  	return sys->private_data;
>  }
>  
> -int cfg_read(void __iomem *addr, int where, int size, u32 *val)
> +int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>  {
>  	*val = readl(addr);
>  
> @@ -46,7 +46,7 @@ int cfg_read(void __iomem *addr, int where, int size, u32 *val)
>  	return PCIBIOS_SUCCESSFUL;
>  }
>  
> -int cfg_write(void __iomem *addr, int where, int size, u32 val)
> +int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val)
>  {
>  	if (size == 4)
>  		writel(val, addr);
> @@ -84,7 +84,8 @@ static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>  	if (pp->ops->rd_own_conf)
>  		ret = pp->ops->rd_own_conf(pp, where, size, val);
>  	else
> -		ret = cfg_read(pp->dbi_base + (where & ~0x3), where, size, val);
> +		ret = dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where,
> +				size, val);
>  
>  	return ret;
>  }
> @@ -97,8 +98,8 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
>  	if (pp->ops->wr_own_conf)
>  		ret = pp->ops->wr_own_conf(pp, where, size, val);
>  	else
> -		ret = cfg_write(pp->dbi_base + (where & ~0x3), where, size,
> -				val);
> +		ret = dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3), where,
> +				size, val);
>  
>  	return ret;
>  }
> @@ -534,11 +535,13 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  
>  	if (bus->parent->number == pp->root_bus_nr) {
>  		dw_pcie_prog_viewport_cfg0(pp, busdev);
> -		ret = cfg_read(pp->va_cfg0_base + address, where, size, val);
> +		ret = dw_pcie_cfg_read(pp->va_cfg0_base + address, where, size,
> +				val);
>  		dw_pcie_prog_viewport_mem_outbound(pp);
>  	} else {
>  		dw_pcie_prog_viewport_cfg1(pp, busdev);
> -		ret = cfg_read(pp->va_cfg1_base + address, where, size, val);
> +		ret = dw_pcie_cfg_read(pp->va_cfg1_base + address, where, size,
> +				val);
>  		dw_pcie_prog_viewport_io_outbound(pp);
>  	}
>  
> @@ -557,11 +560,13 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  
>  	if (bus->parent->number == pp->root_bus_nr) {
>  		dw_pcie_prog_viewport_cfg0(pp, busdev);
> -		ret = cfg_write(pp->va_cfg0_base + address, where, size, val);
> +		ret = dw_pcie_cfg_write(pp->va_cfg0_base + address, where, size,
> +				val);
>  		dw_pcie_prog_viewport_mem_outbound(pp);
>  	} else {
>  		dw_pcie_prog_viewport_cfg1(pp, busdev);
> -		ret = cfg_write(pp->va_cfg1_base + address, where, size, val);
> +		ret = dw_pcie_cfg_write(pp->va_cfg1_base + address, where, size,
> +				val);
>  		dw_pcie_prog_viewport_io_outbound(pp);
>  	}
>  
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index da1ed35..afb1734 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -66,8 +66,8 @@ struct pcie_host_ops {
>  	void (*host_init)(struct pcie_port *pp);
>  };
>  
> -int cfg_read(void __iomem *addr, int where, int size, u32 *val);
> -int cfg_write(void __iomem *addr, int where, int size, u32 val);
> +int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val);
> +int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val);
>  void dw_handle_msi_irq(struct pcie_port *pp);
>  void dw_pcie_msi_init(struct pcie_port *pp);
>  int dw_pcie_link_up(struct pcie_port *pp);
> -- 
> 1.7.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
