Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A24C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 18:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF6C205C9
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 18:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF6C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbeK2FCc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:02:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47684 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeK2FCc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Nov 2018 00:02:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E424A80D;
        Wed, 28 Nov 2018 10:00:03 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44BE73F59C;
        Wed, 28 Nov 2018 10:00:02 -0800 (PST)
Date:   Wed, 28 Nov 2018 17:59:51 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCHv2 4/4] PCI: dwc: add prefetchable memory range support
Message-ID: <20181128175943.GA25307@e107981-ln.cambridge.arm.com>
References: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
 <20181107100854.28389-5-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107100854.28389-5-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 10:09:21AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The current code only support non-prefetchable memory range,
> as the non-prefetchable memory range must not be greater than
> 4GiB, one viewport can cover it, which supports upto 4GiB.
> 
> To support prefetchable memory range, which is upto 64-bit
> memory space and can be greater than 4GiB, so we need multiple
> viewports. And added separate vars to store prefetchable memory
> range info to prevent overriding the non-prefetchable memory
> range info.
> 
> And this patch explicitly assigned the last (if there are only
> 2 viewports) or last 2 viewports for CFG and I/O windows and the
> rests for MEM windows.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Reworded the subject and commit description.
>  - Fix the prefetchable memory range overriding non-perfetchable
>    memory range issue by adding vars to store prefetchable memory
>    range info.
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 107 ++++++++++++++----
>  drivers/pci/controller/dwc/pcie-designware.h  |   7 ++
>  2 files changed, 95 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ecacce016489..328aa40a6609 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -346,6 +346,35 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		dev_err(dev, "Missing *config* reg space\n");
>  	}
>  
> +	/*
> +	 * If vendor's platform driver has set the num_viewport and it is
> +	 * not less than 2, skip getting the num_viewport from DT here.

That's not what the device tree bindings specify. If DT does contain
the property you *must* read it.

> +	 */
> +	if (pci->num_viewport < 2) {
> +		ret = of_property_read_u32(np, "num-viewport",
> +					   &pci->num_viewport);
> +		if (ret || pci->num_viewport < 2)
> +			pci->num_viewport = 2;
> +	}
> +
> +	/*
> +	 * if there are only 2 viewports, assign the last viewport for
> +	 * both CFG and IO window, otherwise assign the last 2 viewport

Gah. Can anyone explain to me how this driver works if only two
viewports are available ? What happens if an IO access happens at
the same time of a config access (that fiddles with the outbound
memory windows) ?

> +	 * for CFG and IO window specific. And the rest viewports are
> +	 * assigned to MEM windows.
> +	 */
> +	if (pci->num_viewport == 2) {
> +		pp->cfg_idx = pp->io_idx = PCIE_ATU_REGION_INDEX1;
> +		pp->mem_wins = 1;
> +	} else {
> +		pp->cfg_idx = pci->num_viewport - 1;
> +		pp->io_idx = pci->num_viewport - 2;
> +		pp->mem_wins = pci->num_viewport - 2;
> +	}
> +
> +	dev_dbg(dev, "CFG win id: %d, I/O win id: %d, Total MEM win: %d\n",
> +		pp->cfg_idx, pp->io_idx, pp->mem_wins);
> +
>  	bridge = pci_alloc_host_bridge(0);
>  	if (!bridge)
>  		return -ENOMEM;
> @@ -377,10 +406,20 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			}
>  			break;
>  		case IORESOURCE_MEM:
> -			pp->mem = win->res;
> -			pp->mem->name = "MEM";
> -			pp->mem_size = resource_size(pp->mem);
> -			pp->mem_bus_addr = pp->mem->start - win->offset;
> +			if (win->res->flags & IORESOURCE_PREFETCH) {
> +				pp->mem_perf = win->res;
> +				pp->mem_perf->name = "MEM perf";

Nit: Why "perf" and not "pref" ?

It is confusing but that's the least of this patch problems.

> +				pp->mem_perf_size = resource_size(pp->mem_perf);
> +				pp->mem_perf_bus_addr = pp->mem_perf->start -
> +							win->offset;
> +				pp->mem_perf_base = pp->mem_perf->start;
> +			} else {
> +				pp->mem = win->res;
> +				pp->mem->name = "MEM";
> +				pp->mem_size = resource_size(pp->mem);
> +				pp->mem_bus_addr = pp->mem->start - win->offset;
> +				pp->mem_base = pp->mem->start;
> +			}
>  			break;
>  		case 0:
>  			pp->cfg = win->res;
> @@ -406,8 +445,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
>  
> -	pp->mem_base = pp->mem->start;
> -
>  	if (!pp->va_cfg0_base) {
>  		pp->va_cfg0_base = devm_pci_remap_cfgspace(dev,
>  					pp->cfg0_base, pp->cfg0_size);
> @@ -534,12 +571,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  		va_cfg_base = pp->va_cfg1_base;
>  	}
>  
> -	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
> +	dw_pcie_prog_outbound_atu(pci, pp->cfg_idx,
>  				  type, cpu_addr,
>  				  busdev, cfg_size);
>  	ret = dw_pcie_read(va_cfg_base + where, size, val);
> -	if (pci->num_viewport <= 2)
> -		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
> +	if (pp->cfg_idx == pp->io_idx)
> +		dw_pcie_prog_outbound_atu(pci, pp->io_idx,
>  					  PCIE_ATU_TYPE_IO, pp->io_base,
>  					  pp->io_bus_addr, pp->io_size);

See above, even though this is not related to this patch.

>  
> @@ -573,12 +610,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  		va_cfg_base = pp->va_cfg1_base;
>  	}
>  
> -	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
> +	dw_pcie_prog_outbound_atu(pci, pp->cfg_idx,
>  				  type, cpu_addr,
>  				  busdev, cfg_size);
>  	ret = dw_pcie_write(va_cfg_base + where, size, val);
> -	if (pci->num_viewport <= 2)
> -		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
> +	if (pp->cfg_idx == pp->io_idx)
> +		dw_pcie_prog_outbound_atu(pci, pp->io_idx,
>  					  PCIE_ATU_TYPE_IO, pp->io_base,
>  					  pp->io_bus_addr, pp->io_size);
>  
> @@ -652,6 +689,9 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
>  void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>  	u32 val, ctrl, num_ctrls;
> +	u64 remain_size, base, win_size;
> +	phys_addr_t bus_addr;
> +	int i;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  
>  	dw_pcie_setup(pci);
> @@ -700,13 +740,42 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  		dev_dbg(pci->dev, "iATU unroll: %s\n",
>  			pci->iatu_unroll_enabled ? "enabled" : "disabled");
>  
> -		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
> -					  PCIE_ATU_TYPE_MEM, pp->mem_base,
> -					  pp->mem_bus_addr, pp->mem_size);
> -		if (pci->num_viewport > 2)
> -			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
> -						  PCIE_ATU_TYPE_IO, pp->io_base,
> -						  pp->io_bus_addr, pp->io_size);
> +		/*
> +		 * The maximum region size is 4 GB, and a region
> +		 * must not cross a 4 GB boundary.
> +		 */
> +		win_size = SZ_4G - (pp->mem_base & (SZ_4G - 1));
> +		win_size = min(win_size, pp->mem_size);
> +		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_MEM,
> +					  pp->mem_base, pp->mem_bus_addr,
> +					  win_size);
> +		dev_dbg(pci->dev,
> +			"iATU: non-pref MEM: win = %d: base = %llx, bus_addr = %pa, size = %llx\n",
> +			0, pp->mem_base, &pp->mem_bus_addr, win_size);
> +
> +		/* Prefetchable range can be 64bit space */
> +		remain_size = pp->mem_perf_size;

unallocated/free_size ?

> +		base = pp->mem_perf_base;
> +		bus_addr = pp->mem_perf_bus_addr;
> +		for (i = 1; remain_size > 0 && i < pp->mem_wins; i++) {
> +			win_size = SZ_4G - (base & (SZ_4G - 1));
> +			win_size = min(win_size, remain_size);
> +			dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
> +						  base, bus_addr, win_size);
> +			dev_dbg(pci->dev, "iATU: pref MEM: win = %d: base = %llx, bus_addr = %pa, size = %llx\n",
> +				i, base, &bus_addr, win_size);
> +
> +			base += win_size;
> +			bus_addr += win_size;
> +			remain_size -= win_size;
> +		}
> +
> +		if (remain_size > 0)
> +			dev_info(pci->dev, "iATU: MEM window isn't enough\n");
> +
> +		dw_pcie_prog_outbound_atu(pci, pp->io_idx, PCIE_ATU_TYPE_IO,
> +					  pp->io_base, pp->io_bus_addr,
> +					  pp->io_size);
>  	}
>  
>  	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index a438c3879aa9..0197f67f82b7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -148,15 +148,22 @@ struct pcie_port {
>  	u64			cfg1_base;
>  	void __iomem		*va_cfg1_base;
>  	u32			cfg1_size;
> +	u32			cfg_idx;
>  	resource_size_t		io_base;
>  	phys_addr_t		io_bus_addr;
>  	u32			io_size;
> +	u32			io_idx;
>  	u64			mem_base;
>  	phys_addr_t		mem_bus_addr;
>  	u64			mem_size;
> +	u64			mem_perf_base;

This is a phys_addr_t

> +	phys_addr_t		mem_perf_bus_addr;

pci_bus_addr_t ?

Lorenzo

> +	u64			mem_perf_size;
> +	u32			mem_wins;
>  	struct resource		*cfg;
>  	struct resource		*io;
>  	struct resource		*mem;
> +	struct resource		*mem_perf;
>  	struct resource		*busn;
>  	int			irq;
>  	const struct dw_pcie_host_ops *ops;
> -- 
> 2.17.1
> 
