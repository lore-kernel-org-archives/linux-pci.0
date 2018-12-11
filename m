Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2689C07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 04:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C65920811
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 04:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xTaGhNFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C65920811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbeLKEg2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 23:36:28 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54840 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbeLKEg2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Dec 2018 23:36:28 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBB4aIPd075895;
        Mon, 10 Dec 2018 22:36:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544502978;
        bh=zWTGvCHEozkV63RZPhJcBmNtpVENMPZuxw6t72jEbtw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xTaGhNFCW06JQbXTORNO6ntvxb8yea/i1TdyjZ9yXQsUbuKPnjC46cKelXQTsS2kc
         WY56U3HPsD21POKv4MJ8dO4roqoT4DLTrCX6AMSoeXU0WkvpWa2SLhZoEklpJwxUeN
         I7ovPq3ipI+DjtepflOlkQWOHiKT19JALdr4GgHM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBB4aIN1057400
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 22:36:18 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 22:36:18 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 22:36:18 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBB4aFlo005324;
        Mon, 10 Dec 2018 22:36:15 -0600
Subject: Re: [PATCH V2] PCI: dwc ep: cache config until DBI regs available
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Stephen Warren <swarren@nvidia.com>
References: <20181126230958.8175-1-swarren@wwwdotorg.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <340ed2c5-cb11-0aea-5430-5da5b509d805@ti.com>
Date:   Tue, 11 Dec 2018 10:06:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126230958.8175-1-swarren@wwwdotorg.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 27/11/18 4:39 AM, Stephen Warren wrote:
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

When will this function be invoked? Does the wrapper get an interrupt when
refclk is enabled where this function will be invoked?
> +	struct dw_pcie_ep *ep = &(pci->ep);
> +	int i;
> +
> +	ep->hw_regs_not_available = false;

This can race with epc_ops.

> +
> +	dw_pcie_ep_write_header_regs(ep);
> +	for_each_set_bit(i, ep->ib_window_map, ep->num_ib_windows) {
> +		dw_pcie_prog_inbound_atu(pci, i,
> +			ep->cached_inbound_atus[i].bar,
> +			ep->cached_inbound_atus[i].cpu_addr,
> +			ep->cached_inbound_atus[i].as_type);

Depending on the context in which this function is invoked, programming
inbound/outbound ATU can also race with EPC ops.
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

IMHO we should add a new epc ops ->epc_init() which indicates if the EPC is
ready to be initialized or not. Only if the epc_init indicates it's ready to be
initialized, the endpoint function driver should go ahead with further
initialization. Or else it should wait for a notification from EPC to indicate
when it's ready to be initialized.

Thanks
Kishon
