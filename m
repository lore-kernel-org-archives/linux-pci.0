Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8414C43441
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCE920671
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCE920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeKTVVz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:21:55 -0500
Received: from foss.arm.com ([217.140.101.70]:46796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbeKTVVz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:21:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E1AF80D;
        Tue, 20 Nov 2018 02:53:24 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC56A3F575;
        Tue, 20 Nov 2018 02:53:22 -0800 (PST)
Date:   Tue, 20 Nov 2018 10:53:17 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Roy Zang <roy.zang@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCHv2] PCI/Layerscape: fix wrongly invoking of outbound
 window disable accessor
Message-ID: <20181120105317.GA19867@e107981-ln.cambridge.arm.com>
References: <20181107051647.12242-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107051647.12242-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 05:16:49AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The order of parameters is not correct when invoking the outbound
> window disable routine.
> 
> Fixes: commit 4a2745d760fac ("PCI: layerscape: Disable outbound
> windows configured by bootloader").
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Tagged this patch for stable.
>  - Reworded the commit description.
> 
>  drivers/pci/controller/dwc/pci-layerscape.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/controller-fixes for one of the upcoming -rc*.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 3724d3ef7008..7aa9a82b7ebd 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -88,7 +88,7 @@ static void ls_pcie_disable_outbound_atus(struct ls_pcie *pcie)
>  	int i;
>  
>  	for (i = 0; i < PCIE_IATU_NUM; i++)
> -		dw_pcie_disable_atu(pcie->pci, DW_PCIE_REGION_OUTBOUND, i);
> +		dw_pcie_disable_atu(pcie->pci, i, DW_PCIE_REGION_OUTBOUND);
>  }
>  
>  static int ls1021_pcie_link_up(struct dw_pcie *pci)
> -- 
> 2.17.1
> 
