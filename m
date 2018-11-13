Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC14AC43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 05:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3F722507
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 05:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jVfu2rG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3F722507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeKMPUL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:20:11 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:49794 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMPUL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Nov 2018 10:20:11 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B12B624E0822;
        Mon, 12 Nov 2018 21:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542086627; bh=zlgCoupdLnRnlMcfH47awF1PVTB2CHiJxA7ttVsBpkY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=jVfu2rG/UuKG0eGgFWU2nDabS9bNbGyPMOidDfixTIdHBdNwuqZ72qNLidczIEnvM
         1gQ82jQeNYeQ+kLtbjYNUMDpdumBK++hKtCx1e2jmx9mds7pNTZIQhZ+MKx5TylUSN
         ydu5IQkUx2OILze0QcjffjgYkLXqBbeoglWM0N35xqMAabNTC/fG7emFPo4y9fwqu5
         QskEEEz6But24yhRVIL0wdCsGO5m03ZtWLcOizspl7rrk1ra+uK52gSJ/hXPRhLwNS
         gFR4iKo00Wg+SRlhwWxe/y0ojOgTxj7mpE7z9VAHzjYSe/TV3Rx8yfCvQWX2xZKSSH
         Tv16oxy7JnksQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 40A6E3231;
        Mon, 12 Nov 2018 21:23:47 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 12 Nov 2018 21:23:47 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 06:23:45 +0100
Received: from [10.4.120.44] (10.4.120.44) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 06:23:44 +0100
Subject: Re: [PATCH] PCI: designware: don't hard-code DBI/ATU offset
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "Stephen Warren" <swarren@nvidia.com>
References: <20181112225710.29557-1-swarren@wwwdotorg.org>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <ce3ac825-c05b-c782-81ba-dad0acc8d3c8@synopsys.com>
Date:   Tue, 13 Nov 2018 05:19:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181112225710.29557-1-swarren@wwwdotorg.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.4.120.44]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stephen,

I'd suggest to change the designware on the patch name by dwc and use another
description for the patch instead of don't hard-code DBI/ATU offset.

On 12/11/2018 22:57, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The DWC PCIe core contains various separate register spaces: DBI, DBI2,
> ATU, DMA, etc. The relationship between the addresses of these register
> spaces is entirely determined by the implementation of the IP block, not
> by the IP block design itself. Hence, the DWC driver must not make
> assumptions that one register space can be accessed at a fixed offset from
> any other register space. To avoid such assumptions, introduce an
> explicit/separate register pointer for the ATU register space. In
> particular, the current assumption is not valid for NVIDIA's T194 SoC.
> 

If I understood this patch correctly, you basically replace the dbi_base offset
by atu_base offset that still depends of dbi_base offset. I agree the code is
now more readable, but I'm not seeing it by applying this patch what is the
benefit since you are not allowing to change the current atu_base. I though that
was the propose of this patch.

> The ATU register space is only used on systems that require unrolled ATU
> access. This property is detected at run-time for host controllers, and
> when this is detected, this patch provides a default value for atu_base
> that matches the previous assumption re: register layout. An alternative
> would be to update all drivers for HW that requires unrolled access to
> explicitly set atu_base. However, it's hard to tell which drivers would
> require atu_base to be set. The unrolled property is not detected for
> endpoint systems, and so any endpoint driver that requires unrolled access
> must explicitly set the iatu_unroll_enabled flag (none do at present), and
> so a check is added to require the driver to also set atu_base while at
> it.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |  4 ++++
>  .../pci/controller/dwc/pcie-designware-host.c |  3 +++
>  drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h  | 20 +++++++++++++++----
>  4 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1e7b02221eac..880210366e71 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -504,6 +504,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		dev_err(dev, "dbi_base/dbi_base2 is not populated\n");
>  		return -EINVAL;
>  	}
> +	if (pci->iatu_unroll_enabled && !pci->atu_base) {
> +		dev_err(dev, "atu_base is not populated\n");
> +		return -EINVAL;
> +	}
>  
>  	ret = of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows);
>  	if (ret < 0) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 29a05759a294..2ebb7f4768cf 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -699,6 +699,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  		dev_dbg(pci->dev, "iATU unroll: %s\n",
>  			pci->iatu_unroll_enabled ? "enabled" : "disabled");
>  
> +		if (pci->iatu_unroll_enabled && !pci->atu_base)
> +			pci->atu_base = pci->dbi_base + (0x3 << 20);
> +
>  		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
>  					  PCIE_ATU_TYPE_MEM, pp->mem_base,
>  					  pp->mem_bus_addr, pp->mem_size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 2153956a0b20..93ef8c31fb39 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -93,7 +93,7 @@ static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg)
>  {
>  	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
>  
> -	return dw_pcie_readl_dbi(pci, offset + reg);
> +	return dw_pcie_readl_atu(pci, offset + reg);
>  }
>  
>  static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
> @@ -101,7 +101,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
>  {
>  	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
>  
> -	dw_pcie_writel_dbi(pci, offset + reg, val);
> +	dw_pcie_writel_atu(pci, offset + reg, val);
>  }
>  
>  static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
> @@ -187,7 +187,7 @@ static u32 dw_pcie_readl_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg)
>  {
>  	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
>  
> -	return dw_pcie_readl_dbi(pci, offset + reg);
> +	return dw_pcie_readl_atu(pci, offset + reg);
>  }
>  
>  static void dw_pcie_writel_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg,
> @@ -195,7 +195,7 @@ static void dw_pcie_writel_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg,
>  {
>  	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
>  
> -	dw_pcie_writel_dbi(pci, offset + reg, val);
> +	dw_pcie_writel_atu(pci, offset + reg, val);
>  }
>  
>  static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 0989d880ac46..02fb532c5db9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -93,11 +93,11 @@
>  #define PCIE_ATU_UNR_UPPER_TARGET	0x18
>  
>  /* Register address builder */
> -#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)	\
> -			((0x3 << 20) | ((region) << 9))
> +#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region) \
> +		((region) << 9)

I'd suggest to remove the parenthesis around the region variable, like this:
(region << 9)

>  
> -#define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region)				\
> -			((0x3 << 20) | ((region) << 9) | (0x1 << 8))
> +#define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region) \
> +		((region) << 9) | (0x1 << 8)

I'd suggest to remove the parenthesis around the region variable and to put a
parenthesis in the whole macro computation, like this:
((region << 9) | (0x1 << 8))

Regards,
Gustavo

>  
>  #define MAX_MSI_IRQS			256
>  #define MAX_MSI_IRQS_PER_CTRL		32
> @@ -219,6 +219,8 @@ struct dw_pcie {
>  	struct device		*dev;
>  	void __iomem		*dbi_base;
>  	void __iomem		*dbi_base2;
> +	/* Used when iatu_unroll_enabled is true */
> +	void __iomem		*atu_base;
>  	u32			num_viewport;
>  	u8			iatu_unroll_enabled;
>  	struct pcie_port	pp;
> @@ -289,6 +291,16 @@ static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
>  	return __dw_pcie_read_dbi(pci, pci->dbi_base2, reg, 0x4);
>  }
>  
> +static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
> +{
> +	__dw_pcie_write_dbi(pci, pci->atu_base, reg, 0x4, val);
> +}
> +
> +static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
> +{
> +	return __dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
> +}
> +
>  static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
>  {
>  	u32 reg;
> 
