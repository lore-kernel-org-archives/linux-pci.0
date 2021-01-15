Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B606C433E9
	for <linux-pci@archiver.kernel.org>; Fri, 15 Jan 2021 11:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3A22371F
	for <linux-pci@archiver.kernel.org>; Fri, 15 Jan 2021 11:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbhAOLhr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Jan 2021 06:37:47 -0500
Received: from foss.arm.com ([217.140.110.172]:36404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbhAOLhr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Jan 2021 06:37:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52ABFD6E;
        Fri, 15 Jan 2021 03:37:01 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02E983F719;
        Fri, 15 Jan 2021 03:36:59 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:36:54 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, robh@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] pci/controller/dwc: convert comma to semicolon
Message-ID: <20210115113654.GA22508@e121166-lin.cambridge.arm.com>
References: <20201216131944.14990-1-zhengyongjun3@huawei.com>
 <20210106190722.GA1327553@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106190722.GA1327553@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 06, 2021 at 01:07:22PM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 16, 2020 at 09:19:44PM +0800, Zheng Yongjun wrote:
> > Replace a comma between expression statements by a semicolon.
> 
> Looks like a good fix, but read this about the changelog title:
> 
> https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

I would request NXP maintainers to take this patch, rewrite it as
Bjorn requested and resend it as fast as possible, this is a very
relevant fix.

Thanks,
Lorenzo

> > Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> > ---
> >  drivers/pci/controller/dwc/pci-layerscape-ep.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > index 84206f265e54..917ba8d254fc 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > @@ -178,7 +178,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
> >  	pci->dev = dev;
> >  	pci->ops = pcie->drvdata->dw_pcie_ops;
> >  
> > -	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
> > +	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4);
> >  
> >  	pcie->pci = pci;
> >  	pcie->ls_epc = ls_epc;
> > -- 
> > 2.22.0
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
