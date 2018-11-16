Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C705C43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 11:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBA92087A
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 11:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBA92087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389587AbeKPWDi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:03:38 -0500
Received: from foss.arm.com ([217.140.101.70]:50216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbeKPWDi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 17:03:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44D5B80D;
        Fri, 16 Nov 2018 03:51:36 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF3743F718;
        Fri, 16 Nov 2018 03:51:34 -0800 (PST)
Date:   Fri, 16 Nov 2018 11:51:29 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ladislav Michl <ladis@linux-mips.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI: dra7xx: Fix potential NULL dereference
Message-ID: <20181116115129.GA3228@e107981-ln.cambridge.arm.com>
References: <1516284037-81537-1-git-send-email-weiyongjun1@huawei.com>
 <20180118145420.GA21163@lenoch>
 <20180118183525.GG53542@bhelgaas-glaptop.roam.corp.google.com>
 <20180119095857.GA26765@lenoch>
 <20180119170657.GA27882@lenoch>
 <20180120001645.GA21343@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180120001645.GA21343@lenoch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 20, 2018 at 01:16:45AM +0100, Ladislav Michl wrote:
> On Fri, Jan 19, 2018 at 06:06:57PM +0100, Ladislav Michl wrote:
> > On Fri, Jan 19, 2018 at 10:58:57AM +0100, Ladislav Michl wrote:
> > > On Thu, Jan 18, 2018 at 12:35:25PM -0600, Bjorn Helgaas wrote:
> > > > That's probably a better idea.  Maybe we should add a comment like this
> > > > to help avoid this in the future:
> > > 
> > > That seems to spot another a bit more serious problem (given how late
> > > release cycle is now).
> > > 
> > > Both devm_ioremap() and devm_ioremap_resource() shares the same release
> > > function: devm_ioremap_release(). However this function is not aware of
> > > memory region previously requested by devm_request_mem_region() called
> > > from devm_ioremap_resource().
> > > 
> > > Bellow is just a quick hack, even untested as looking at devm_ioremap,
> > > devm_ioremap_wc and devm_ioremap_wc, there is some room for optimization.
> > 
> > Okay, forget it, above analysis is not correct, however there is a bug (and
> > also in PCI version). To show it, let's make following modification:
> 
> I will never ever work in single tree for two different boards without full
> recompile (which should save time and caused opposite) as it makes debugging
> pointless - there is no bug.
> 
> As a request forgiveness, please accept following draft as proposed solution
> for $subj

Wei, Ladislav,

getting back to this old thread, I would mark it as "changes requested"
and expect someone to post a follow-up patch, I do not think this is
a solved problem.

Lorenzo

> Subject: [PATCH] PCI: dra7xx: Use devm_ioremap_resource()
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 8bf7c2714db6..7f422ae258ac 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -409,14 +409,14 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
>  	ep->ops = &pcie_ep_ops;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics");
> -	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
> -	if (!pci->dbi_base)
> -		return -ENOMEM;
> +	pci->dbi_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics2");
> -	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
> -	if (!pci->dbi_base2)
> -		return -ENOMEM;
> +	pci->dbi_base2 = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pci->dbi_base2))
> +		return PTR_ERR(pci->dbi_base2);
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>  	if (!res)
