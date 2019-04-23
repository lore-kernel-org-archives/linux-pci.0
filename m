Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EB9C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5617218B0
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556051715;
	bh=duiLVSTGWAlDxELIUIHgMJeJDOPQakp/dato38su+Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qqtQ8+3LtG0zL4YF9AGHoVA7f25QEo2Lt2/WjEzvdeQjuWmxZbXCwlqk/yZB8fImZ
	 D5jtTFgGz0W19f2G6m6oY5Thw/ysxWPMYjtoZAIZpS/rOX4w6R74CG4NyIZr09Atqz
	 t9v4zDnzH6qdO725ds8BOqeoCa6PMLkJ5G2KKUeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfDWUfF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfDWUfE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 16:35:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 828BC218B0;
        Tue, 23 Apr 2019 20:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556051703;
        bh=duiLVSTGWAlDxELIUIHgMJeJDOPQakp/dato38su+Rg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2U50io9ilBvZjbi1VVSr+4dui9nqxZPJcyQCcX/kQUSFze3/SHRZpFIjUXNB/n3h
         n0dJEzEljhdO+fzJioafhKjHGZnc8MFHtRL0YfSXYtipAns/yhvQTma4w0Ea5ZntQH
         ZpZikyK+TR20efByfGynONh4J+TR6JTVQAzfq3BI=
Date:   Tue, 23 Apr 2019 15:35:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 06/16] PCI: dwc: Add ext config space capability
 search API
Message-ID: <20190423203502.GE14616@google.com>
References: <20190423082730.370-1-vidyas@nvidia.com>
 <20190423082730.370-7-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423082730.370-7-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 01:57:20PM +0530, Vidya Sagar wrote:
> Add extended configuration space capability search API using struct dw_pcie *
> pointer
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Changes from [v3]:
> * None
> 
> Changes from [v2]:
> * None
> 
> Changes from [v1]:
> * This is a new patch in v2 series
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 41 ++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 6a98135244d6..ecf5fe8842f6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -53,6 +53,47 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>  	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
>  }
>  

Please make sure there's a comment here about why
pci_find_ext_capability() can't be used (a comment covering both this
and pci_find_capability() is fine, if the reason is the same).

> +static int dw_pcie_find_next_ext_capability(struct dw_pcie *pci, int start,
> +					    int cap)
> +{
> +	u32 header;
> +	int ttl;
> +	int pos = PCI_CFG_SPACE_SIZE;
> +
> +	/* minimum 8 bytes per capability */
> +	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> +
> +	if (start)
> +		pos = start;
> +
> +	header = dw_pcie_readl_dbi(pci, pos);
> +	/*
> +	 * If we have no capabilities, this is indicated by cap ID,
> +	 * cap version and next pointer all being 0.
> +	 */
> +	if (header == 0)
> +		return 0;
> +
> +	while (ttl-- > 0) {
> +		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
> +			return pos;
> +
> +		pos = PCI_EXT_CAP_NEXT(header);
> +		if (pos < PCI_CFG_SPACE_SIZE)
> +			break;
> +
> +		header = dw_pcie_readl_dbi(pci, pos);
> +	}
> +
> +	return 0;
> +}
> +
> +int dw_pcie_find_ext_capability(struct dw_pcie *pci, int cap)
> +{
> +	return dw_pcie_find_next_ext_capability(pci, 0, cap);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
> +
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>  {
>  	if (!IS_ALIGNED((uintptr_t)addr, size)) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 35160b4ce929..67307842e003 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -249,6 +249,7 @@ struct dw_pcie {
>  		container_of((endpoint), struct dw_pcie, ep)
>  
>  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> +int dw_pcie_find_ext_capability(struct dw_pcie *pci, int cap);
>  
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_write(void __iomem *addr, int size, u32 val);
> -- 
> 2.17.1
> 
