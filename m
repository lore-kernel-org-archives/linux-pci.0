Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7527C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 11:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D40F20878
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 11:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D40F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394642AbeKVVzs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:55:48 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45810 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388022AbeKVVzr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 16:55:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01F973617;
        Thu, 22 Nov 2018 03:16:52 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5935E3F5A0;
        Thu, 22 Nov 2018 03:16:50 -0800 (PST)
Date:   Thu, 22 Nov 2018 11:16:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCHv2 3/4] PCI: layerscape: initialize the number of viewport
Message-ID: <20181122111645.GA11447@e107981-ln.cambridge.arm.com>
References: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
 <20181107100854.28389-4-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107100854.28389-4-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 10:09:16AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> FSL implements 6 viewports on Layerscape series SoCs PCIe
> controllers.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Reworded the subject and commit description.
> 
>  drivers/pci/controller/dwc/pci-layerscape.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 3724d3ef7008..69f3f1a5a782 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -280,6 +280,9 @@ static int __init ls_add_pcie_port(struct ls_pcie *pcie)
>  
>  	pp->ops = pcie->drvdata->ops;
>  
> +	/* FSL implements 6 windows */
> +	pci->num_viewport = 6;

There is a DT property to configure this value, I am not sure it was the
right thing to do to add it but since it is there use it.

I will not consider this patch for merging.

Lorenzo

>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize host\n");
> -- 
> 2.17.1
> 
