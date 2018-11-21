Return-Path: <SRS0=MCOJ=OA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DB2C43441
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 17:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AAC214F1
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 17:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="agH6kY6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AAC214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeKVEP6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:15:58 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:57092 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeKVEP6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2018 23:15:58 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AE21024E1527;
        Wed, 21 Nov 2018 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542822038; bh=dpLA2lJ28MFGNPb8NSvGrVLvOmA4I1aXfSg3goaEEJU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=agH6kY6X+Gc13nibiEeAk5ylJJZExCPlosU193WUebYF/v9e4JYDoUR1jmXVcUga1
         MHRWV/HmiTiBEVtklpOz50PcpnL7HfrsEjHYMtU4p9ynM3Ehr3Shl266eX/1/1uYbs
         8I6ylGgofhcfZhn9W8Njg2CiObDePBPDC4iVnV4SSkVDYEoERGnDyuM80LSjwHG9ts
         Aztg1tdOZT/rsFfZB7Dnxj+WLUhvVKzZ9qgho76LFYrXfSOtuyubC7Y69MfUG3FYIm
         uzBuwUWH+ToCTnfRrblkcUxgSP6C1zLIgAWBgsWkqRqVOe3MKiQ2oERd6Wcn5WGk4D
         xCo3PEK2TC37g==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 655E93B32;
        Wed, 21 Nov 2018 09:40:38 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 21 Nov 2018 09:40:38 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 21 Nov 2018 18:40:36 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 21 Nov 2018 18:40:35 +0100
Subject: Re: [PATCHv2 4/4] PCI: dwc: add prefetchable memory range support
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
References: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
 <20181107100854.28389-5-Zhiqiang.Hou@nxp.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <b878c46f-4f1f-2ece-6c91-a62d05b6ba8d@synopsys.com>
Date:   Wed, 21 Nov 2018 17:36:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181107100854.28389-5-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/11/2018 10:09, Z.q. Hou wrote:
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
> +	phys_addr_t		mem_perf_bus_addr;
> +	u64			mem_perf_size;
> +	u32			mem_wins;
>  	struct resource		*cfg;
>  	struct resource		*io;
>  	struct resource		*mem;
> +	struct resource		*mem_perf;
>  	struct resource		*busn;
>  	int			irq;
>  	const struct dw_pcie_host_ops *ops;
> 

Hi,

It worked perfectly in my setup, however my current configuration have
non-prefetchable memory less than 4Gb. In overall the code seems good.

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Regards,
Gustavo
