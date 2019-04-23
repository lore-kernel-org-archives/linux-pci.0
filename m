Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3671AC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052DE218B0
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556051568;
	bh=G3R7Jcs6ZuiGzozrOAb61sZwt50AkO6rewDf3naz+N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NGJ2RVY2YGI/76B2N2XGPL3PK/Boz8rjb+8SQSdDSpOBnB53CNy2c4jak+kLO9nNB
	 vCpu8HOpqN18ytYLIh3kK26zCXgP6b+AjSzh9c+XRrIbu5ySQP1rKJ1o+dtePRKqG8
	 SOgnDrNIwTyusexMQ++H0tZwxdOdQV/ZPc49dkw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfDWUcr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDWUcr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 16:32:47 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F3A621773;
        Tue, 23 Apr 2019 20:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556051565;
        bh=G3R7Jcs6ZuiGzozrOAb61sZwt50AkO6rewDf3naz+N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=auKN2dMYOt4HYVenbs2hrxeiPiqRVUqHL1ZAq61cvLSax8J24pc8ZnPGy68tSyDdL
         aOICYOeZSKlWC3gJEVE96BtJ3ONCYSSmFXaHzyKpKphL2q3O6Vk3BBFxvlsWUSnkCW
         i3QGGii05Fj213qxfq/BaQIDrwArYX+L3g27YaVk=
Date:   Tue, 23 Apr 2019 15:32:44 -0500
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
Subject: Re: [PATCH V4 05/16] PCI: dwc: Move config space capability search
 API
Message-ID: <20190423203244.GD14616@google.com>
References: <20190423082730.370-1-vidyas@nvidia.com>
 <20190423082730.370-6-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423082730.370-6-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 01:57:19PM +0530, Vidya Sagar wrote:
> Move PCIe config space capability search API to common DesignWare file
> as this can be used by both host and ep mode codes.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Changes from [v3]:
> * Rebased to linux-next top of the tree
> 
> Changes from [v2]:
> * None
> 
> Changes from [v1]:
> * Removed dw_pcie_find_next_ext_capability() API from here and made a
>   separate patch for that
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 33 ++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  2 ++

You claim this is a "move", but I only see adds.  Where did it move
*from*?

While you're at it, can you add a comment in the code about why we
can't use the regular pci_find_capability() interface?  It's really a
shame to have to reimplement that.

>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 8e0081ccf83b..6a98135244d6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -20,6 +20,39 @@
>  #define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
>  #define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
>  
> +static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
> +				  u8 cap)
> +{
> +	u8 cap_id, next_cap_ptr;
> +	u16 reg;
> +
> +	reg = dw_pcie_readw_dbi(pci, cap_ptr);
> +	next_cap_ptr = (reg & 0xff00) >> 8;
> +	cap_id = (reg & 0x00ff);
> +
> +	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
> +		return 0;
> +
> +	if (cap_id == cap)
> +		return cap_ptr;
> +
> +	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
> +}
> +
> +u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
> +{
> +	u8 next_cap_ptr;
> +	u16 reg;
> +
> +	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
> +	next_cap_ptr = (reg & 0x00ff);
> +
> +	if (!next_cap_ptr)
> +		return 0;
> +
> +	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
> +}
> +
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>  {
>  	if (!IS_ALIGNED((uintptr_t)addr, size)) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9ee98ced1ef6..35160b4ce929 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -248,6 +248,8 @@ struct dw_pcie {
>  #define to_dw_pcie_from_ep(endpoint)   \
>  		container_of((endpoint), struct dw_pcie, ep)
>  
> +u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> +
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_write(void __iomem *addr, int size, u32 val);
>  
> -- 
> 2.17.1
> 
