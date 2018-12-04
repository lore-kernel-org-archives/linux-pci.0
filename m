Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE51C04EBF
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 11:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DDD2087F
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 11:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WJwi76wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DDD2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeLDLHC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:07:02 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:48012 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbeLDLHB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 06:07:01 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 41D4410C119B;
        Tue,  4 Dec 2018 03:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543921620; bh=HVJfMnfsweELdSApUVorIwdIn2JspmBozwHw6TL4EV8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=WJwi76wr37oKBB4a8cE+FGdMWekSVy/LtiW2m5zyafhCdHx8xHkING9fB8ywu3EVX
         PFpCOwtj5Y7SwDlnASepE+1bqXtmArN/lKcbzxMVoTegsXr/5rg7KDHf8Gj68ogjTV
         st9fTO3a3ZavwKhEp2LxGrkNivJ11luE5vEhKQuiDfo2+FLpI//0Wbjiiw3ui2qEME
         S3inZ9804urWTzf/P0ZoUeDafAwjdxVMKt/u5vaSkquwI0l5NCNdzkJjzQ2HMibRSl
         Ct1FvQswmu17jPqarDRE8gQAW6XvJtom0CBPlDWlTHS9KwocZpKLDxiCX93MpwR4Gm
         J+tRNtyCcJPSw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id D76D33981;
        Tue,  4 Dec 2018 03:06:59 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 03:06:59 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 12:06:56 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 12:06:56 +0100
Subject: Re: [PATCH V2] PCI: dwc ep: cache config until DBI regs available
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "Trent Piepho" <tpiepho@impinj.com>,
        "kishon@ti.com" <kishon@ti.com>
References: <20181126230958.8175-1-swarren@wwwdotorg.org>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <5586f6c0-4305-5d7e-d0ff-90f7eb8fd363@synopsys.com>
Date:   Tue, 4 Dec 2018 11:02:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181126230958.8175-1-swarren@wwwdotorg.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[CC Kishon]

On 26/11/2018 23:09, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Some implementations of the DWC PCIe endpoint controller do not allow
> access to DBI registers until the attached host has started REFCLK,
> released PERST, and the endpoint driver has initialized clocking of the
> DBI registers based on that. One such system is NVIDIA's T194 SoC. The
> PCIe endpoint subsystem and DWC driver currently don't work on such
> hardware, since they assume that all endpoint configuration can happen
> at any arbitrary time.
> 
> Enhance the DWC endpoint driver to support such systems by caching all
> endpoint configuration in software, and only writing the configuration
> to hardware once it's been initialized. This is implemented by splitting
> all endpoint controller ops into two functions; the first which simply
> records/caches the desired configuration whenever called by the
> associated function driver and optionally calls the second, and the
> second which actually programs the configuration into hardware, which
> may be called either by the first function, or later when it's known
> that the DBI registers are available.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v2:
> Replace hw_regs_available with hw_regs_not_available. A 0 value in this
> field is now equivalent to the existing behaviour, so that drivers that
> allocate struct dw_pcie_ep with kzalloc or equivalent do not need to
> explicitly set this new field in order to maintain existing behaviour.
> 
> Note: I have only compiled-tested this patch in the context of the
> mainline kernel since NVIDIA Tegra PCIe EP support is not yet present.
> However, I've built and tested an equivalent patch in our downstream
> kernel. I did have to manually port it to mainline due to conflicts
> though.
> 
> This patch was developed on top of "PCI: designware: don't hard-code
> DBI/ATU offset" which I sent a little while back, so may rely on that
> for patch context.
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 197 ++++++++++++++----
>  drivers/pci/controller/dwc/pcie-designware.h  |  26 ++-
>  2 files changed, 179 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 880210366e71..e69b6ef504ed 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -73,11 +73,10 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
>  	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>  }
>  
> -static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
> -				   struct pci_epf_header *hdr)
> +static void dw_pcie_ep_write_header_regs(struct dw_pcie_ep *ep)
>  {
> -	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct pci_epf_header *hdr = &(ep->cached_hdr);
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, hdr->vendorid);
> @@ -94,6 +93,19 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
>  	dw_pcie_writeb_dbi(pci, PCI_INTERRUPT_PIN,
>  			   hdr->interrupt_pin);
>  	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
> +static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
> +				   struct pci_epf_header *hdr)
> +{
> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> +
> +	ep->cached_hdr = *hdr;
> +
> +	if (ep->hw_regs_not_available)
> +		return 0;
> +
> +	dw_pcie_ep_write_header_regs(ep);
>  
>  	return 0;
>  }
> @@ -112,6 +124,15 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, enum pci_barno bar,
>  		return -EINVAL;
>  	}
>  
> +	ep->cached_inbound_atus[free_win].bar = bar;
> +	ep->cached_inbound_atus[free_win].cpu_addr = cpu_addr;
> +	ep->cached_inbound_atus[free_win].as_type = as_type;
> +	ep->cached_bars[bar].atu_index = free_win;
> +	set_bit(free_win, ep->ib_window_map);
> +
> +	if (ep->hw_regs_not_available)
> +		return 0;
> +
>  	ret = dw_pcie_prog_inbound_atu(pci, free_win, bar, cpu_addr,
>  				       as_type);
>  	if (ret < 0) {
> @@ -119,9 +140,6 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, enum pci_barno bar,
>  		return ret;
>  	}
>  
> -	ep->bar_to_atu[bar] = free_win;
> -	set_bit(free_win, ep->ib_window_map);
> -
>  	return 0;
>  }
>  
> @@ -137,27 +155,66 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t phys_addr,
>  		return -EINVAL;
>  	}
>  
> +	ep->cached_outbound_atus[free_win].addr = phys_addr;
> +	ep->cached_outbound_atus[free_win].pci_addr = pci_addr;
> +	ep->cached_outbound_atus[free_win].size = size;
> +	set_bit(free_win, ep->ob_window_map);
> +
> +	if (ep->hw_regs_not_available)
> +		return 0;
> +
>  	dw_pcie_prog_outbound_atu(pci, free_win, PCIE_ATU_TYPE_MEM,
>  				  phys_addr, pci_addr, size);
>  
> -	set_bit(free_win, ep->ob_window_map);
> -	ep->outbound_addr[free_win] = phys_addr;
> -
>  	return 0;
>  }
>  
> +static void dw_pcie_ep_clear_bar_regs(struct dw_pcie_ep *ep, u8 func_no,
> +				      enum pci_barno bar)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	int flags = ep->cached_bars[bar].flags;
> +	u32 atu_index = ep->cached_bars[bar].atu_index;
> +
> +	__dw_pcie_ep_reset_bar(pci, bar, flags);
> +
> +	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND);
> +}
> +
>  static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
>  				 struct pci_epf_bar *epf_bar)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> -	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
> -	u32 atu_index = ep->bar_to_atu[bar];
> +	u32 atu_index = ep->cached_bars[bar].atu_index;
>  
> -	__dw_pcie_ep_reset_bar(pci, bar, epf_bar->flags);
> -
> -	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND);
>  	clear_bit(atu_index, ep->ib_window_map);
> +
> +	if (ep->hw_regs_not_available)
> +		return;
> +
> +	dw_pcie_ep_clear_bar_regs(ep, func_no, bar);
> +}
> +
> +static void dw_pcie_ep_set_bar_regs(struct dw_pcie_ep *ep, u8 func_no,
> +				    enum pci_barno bar)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	size_t size = ep->cached_bars[bar].size;
> +	int flags = ep->cached_bars[bar].flags;
> +	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> +	dw_pcie_writel_dbi(pci, reg, flags);
> +
> +	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
> +		dw_pcie_writel_dbi(pci, reg + 4, 0);
> +	}
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  
>  static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
> @@ -165,12 +222,10 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
>  {
>  	int ret;
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> -	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
>  	size_t size = epf_bar->size;
>  	int flags = epf_bar->flags;
>  	enum dw_pcie_as_type as_type;
> -	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>  
>  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
>  		as_type = DW_PCIE_AS_MEM;
> @@ -181,17 +236,13 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
>  	if (ret)
>  		return ret;
>  
> -	dw_pcie_dbi_ro_wr_en(pci);
> +	ep->cached_bars[bar].size = size;
> +	ep->cached_bars[bar].flags = flags;
>  
> -	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> -	dw_pcie_writel_dbi(pci, reg, flags);
> -
> -	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> -		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
> -		dw_pcie_writel_dbi(pci, reg + 4, 0);
> -	}
> +	if (ep->hw_regs_not_available)
> +		return 0;
>  
> -	dw_pcie_dbi_ro_wr_dis(pci);
> +	dw_pcie_ep_set_bar_regs(ep, func_no, bar);
>  
>  	return 0;
>  }
> @@ -202,7 +253,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
>  	u32 index;
>  
>  	for (index = 0; index < ep->num_ob_windows; index++) {
> -		if (ep->outbound_addr[index] != addr)
> +		if (ep->cached_outbound_atus[index].addr != addr)
>  			continue;
>  		*atu_index = index;
>  		return 0;
> @@ -223,8 +274,12 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
>  	if (ret < 0)
>  		return;
>  
> -	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_OUTBOUND);
>  	clear_bit(atu_index, ep->ob_window_map);
> +
> +	if (ep->hw_regs_not_available)
> +		return;
> +
> +	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_OUTBOUND);
>  }
>  
>  static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
> @@ -254,7 +309,10 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no)
>  		return -EINVAL;
>  
>  	reg = ep->msi_cap + PCI_MSI_FLAGS;
> -	val = dw_pcie_readw_dbi(pci, reg);
> +	if (ep->hw_regs_not_available)
> +		val = ep->cached_msi_flags;
> +	else
> +		val = dw_pcie_readw_dbi(pci, reg);
>  	if (!(val & PCI_MSI_FLAGS_ENABLE))
>  		return -EINVAL;
>  
> @@ -273,12 +331,18 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
>  		return -EINVAL;
>  
>  	reg = ep->msi_cap + PCI_MSI_FLAGS;
> -	val = dw_pcie_readw_dbi(pci, reg);
> +	if (ep->hw_regs_not_available)
> +		val = ep->cached_msi_flags;
> +	else
> +		val = dw_pcie_readw_dbi(pci, reg);
>  	val &= ~PCI_MSI_FLAGS_QMASK;
>  	val |= (interrupts << 1) & PCI_MSI_FLAGS_QMASK;
> -	dw_pcie_dbi_ro_wr_en(pci);
> -	dw_pcie_writew_dbi(pci, reg, val);
> -	dw_pcie_dbi_ro_wr_dis(pci);
> +	ep->cached_msi_flags = val;
> +	if (!ep->hw_regs_not_available) {
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		dw_pcie_writew_dbi(pci, reg, val);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
>  
>  	return 0;
>  }
> @@ -293,7 +357,10 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
>  		return -EINVAL;
>  
>  	reg = ep->msix_cap + PCI_MSIX_FLAGS;
> -	val = dw_pcie_readw_dbi(pci, reg);
> +	if (ep->hw_regs_not_available)
> +		val = ep->cached_msix_flags;
> +	else
> +		val = dw_pcie_readw_dbi(pci, reg);
>  	if (!(val & PCI_MSIX_FLAGS_ENABLE))
>  		return -EINVAL;
>  
> @@ -312,16 +379,48 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
>  		return -EINVAL;
>  
>  	reg = ep->msix_cap + PCI_MSIX_FLAGS;
> -	val = dw_pcie_readw_dbi(pci, reg);
> +	if (ep->hw_regs_not_available)
> +		val = ep->cached_msix_flags;
> +	else
> +		val = dw_pcie_readw_dbi(pci, reg);
>  	val &= ~PCI_MSIX_FLAGS_QSIZE;
>  	val |= interrupts;
> -	dw_pcie_dbi_ro_wr_en(pci);
> -	dw_pcie_writew_dbi(pci, reg, val);
> -	dw_pcie_dbi_ro_wr_dis(pci);
> +	ep->cached_msix_flags = val;
> +	if (!ep->hw_regs_not_available) {
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		dw_pcie_writew_dbi(pci, reg, val);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
>  
>  	return 0;
>  }
>  
> +void dw_pcie_set_regs_available(struct dw_pcie *pci)
> +{
> +	struct dw_pcie_ep *ep = &(pci->ep);
> +	int i;
> +
> +	ep->hw_regs_not_available = false;
> +
> +	dw_pcie_ep_write_header_regs(ep);
> +	for_each_set_bit(i, ep->ib_window_map, ep->num_ib_windows) {
> +		dw_pcie_prog_inbound_atu(pci, i,
> +			ep->cached_inbound_atus[i].bar,
> +			ep->cached_inbound_atus[i].cpu_addr,
> +			ep->cached_inbound_atus[i].as_type);
> +		dw_pcie_ep_set_bar_regs(ep, 0, ep->cached_inbound_atus[i].bar);
> +	}
> +	for_each_set_bit(i, ep->ob_window_map, ep->num_ob_windows)
> +		dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
> +			ep->cached_outbound_atus[i].addr,
> +			ep->cached_outbound_atus[i].pci_addr,
> +			ep->cached_outbound_atus[i].size);
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	dw_pcie_writew_dbi(pci, PCI_MSI_FLAGS, ep->cached_msi_flags);
> +	dw_pcie_writew_dbi(pci, PCI_MSIX_FLAGS, ep->cached_msix_flags);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
>  static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
>  				enum pci_epc_irq_type type, u16 interrupt_num)
>  {
> @@ -330,6 +429,9 @@ static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
>  	if (!ep->ops->raise_irq)
>  		return -EINVAL;
>  
> +	if (ep->hw_regs_not_available)
> +		return -EAGAIN;
> +
>  	return ep->ops->raise_irq(ep, func_no, type, interrupt_num);
>  }
>  
> @@ -391,6 +493,9 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	bool has_upper;
>  	int ret;
>  
> +	if (ep->hw_regs_not_available)
> +		return -EAGAIN;
> +
>  	if (!ep->msi_cap)
>  		return -EINVAL;
>  
> @@ -436,6 +541,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	void __iomem *msix_tbl;
>  	int ret;
>  
> +	if (ep->hw_regs_not_available)
> +		return -EAGAIN;
> +
>  	reg = ep->msix_cap + PCI_MSIX_TABLE;
>  	tbl_offset = dw_pcie_readl_dbi(pci, reg);
>  	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
> @@ -494,7 +602,6 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	int ret;
> -	void *addr;
>  	struct pci_epc *epc;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct device *dev = pci->dev;
> @@ -543,11 +650,17 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	if (!ep->ob_window_map)
>  		return -ENOMEM;
>  
> -	addr = devm_kcalloc(dev, ep->num_ob_windows, sizeof(phys_addr_t),
> -			    GFP_KERNEL);
> -	if (!addr)
> +	ep->cached_inbound_atus = devm_kzalloc(dev,
> +		sizeof(ep->cached_inbound_atus[0]) * ep->num_ib_windows,
> +		GFP_KERNEL);
> +	if (!ep->cached_inbound_atus)
> +		return -ENOMEM;
> +
> +	ep->cached_outbound_atus = devm_kzalloc(dev,
> +		sizeof(ep->cached_outbound_atus[0]) * ep->num_ob_windows,
> +		GFP_KERNEL);
> +	if (!ep->cached_outbound_atus)
>  		return -ENOMEM;
> -	ep->outbound_addr = addr;
>  
>  	epc = devm_pci_epc_create(dev, &epc_ops);
>  	if (IS_ERR(epc)) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e895f37b1dee..c5fa5aecda0e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -192,8 +192,6 @@ struct dw_pcie_ep {
>  	phys_addr_t		phys_base;
>  	size_t			addr_size;
>  	size_t			page_size;
> -	u8			bar_to_atu[6];
> -	phys_addr_t		*outbound_addr;
>  	unsigned long		*ib_window_map;
>  	unsigned long		*ob_window_map;
>  	u32			num_ib_windows;
> @@ -202,6 +200,25 @@ struct dw_pcie_ep {
>  	phys_addr_t		msi_mem_phys;
>  	u8			msi_cap;	/* MSI capability offset */
>  	u8			msix_cap;	/* MSI-X capability offset */
> +	bool			hw_regs_not_available;
> +	struct pci_epf_header	cached_hdr;
> +	struct {
> +		size_t			size;
> +		int			flags;
> +		u8			atu_index;
> +	}			cached_bars[6];
> +	struct {
> +		enum pci_barno		bar;
> +		dma_addr_t		cpu_addr;
> +		enum dw_pcie_as_type	as_type;
> +	}			*cached_inbound_atus;
> +	struct {
> +		phys_addr_t		addr;
> +		u64			pci_addr;
> +		size_t			size;
> +	}			*cached_outbound_atus;
> +	u32			cached_msi_flags;
> +	u32			cached_msix_flags;
>  };
>  
>  struct dw_pcie_ops {
> @@ -363,6 +380,7 @@ static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
>  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep);
>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
> +void dw_pcie_ep_set_regs_available(struct dw_pcie *pci);
>  int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
>  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u8 interrupt_num);
> @@ -383,6 +401,10 @@ static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  {
>  }
>  
> +static inline void dw_pcie_ep_set_regs_available(struct dw_pcie *pci)
> +{
> +}
> +
>  static inline int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
>  {
>  	return 0;
> 

The best person to give any kind of input about this is Kishon, since he
implemented the EP from the beginning.

Kishon, can you comment this patch?

Regards,
Gustavo

