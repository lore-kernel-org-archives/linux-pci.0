Return-Path: <SRS0=0+Fi=A4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63679C433E3
	for <linux-pci@archiver.kernel.org>; Fri, 17 Jul 2020 16:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395372067D
	for <linux-pci@archiver.kernel.org>; Fri, 17 Jul 2020 16:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbvO53EM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgGQQno (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgGQQno (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2020 12:43:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D5BC0619D2;
        Fri, 17 Jul 2020 09:43:44 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j20so5669168pfe.5;
        Fri, 17 Jul 2020 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k/TgVIFyUxKNr8J07jj05sARsA4UK4pzzx0YGsMsVEc=;
        b=MbvO53EMPvZS8gI0VkrTP4QW3ZmT8gqVCBABpqrLowbXi1Dqgpc4XBrUWLXZQMXoTS
         F6t/M3grck9Z5f5/CN3jVGTxHiOlDb0nsNDXjULkIFUotrxxtZWDscnWnS3HXI/8qlp7
         no8XALY+iQDiq8iLbzI5LXBT8TeYBNaEyUrJ4aenb6cqxVWB9/66mnkFVZuQmeYAqOlB
         kDMq+GZQNbCLdItzi/vGdp7PVikVcAxfkgnGDblhkkddx94tste6w/Z0dhBE4qhikWfc
         ALv2ncTEI6Wd1TxxZsRWSBco5YoH3gdrSKrUxgMNnjCMXqT5zdl3yNQd6n7P/53Mog9f
         C0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k/TgVIFyUxKNr8J07jj05sARsA4UK4pzzx0YGsMsVEc=;
        b=eYFEDyi/AW/ycpa1oMVuWfNYNzwO6ffU6oCkmLHkwvxZZL7iatHiGekTAQdsLAR2lu
         0/P7IB/7TwqUDbfINBzWssUKJ5KNoe1UWLxCQlZbiwSC3Xi1OF/PpB/aQHh1lMKB32rA
         fSfsj4HlepUNw4sjRxR8xj8YZGQlWvlPGVVbgp4osBoQfl6hHzP5Hi/YgDUlWd/f9ZkY
         al2o7Ya+2aaSlJ00B6NcQggIxEBkHGtU5TueGo16ejRImMCzOjZrw9h/Ebi+GHUaj2BT
         hXuMa4qcE61NQ2rHyeCKCeE3l+JQplZv60XNjP74gnbDQZlt8CBaBQx7y8B3YK8tmbRY
         oEig==
X-Gm-Message-State: AOAM533raWEotvMXHPhK58Vp6eq3Q3C12xI5zZNQK2TTsUdWkPxAjH2e
        58okfxV1CnqrlIXyRH2WdNA=
X-Google-Smtp-Source: ABdhPJx/wPQQq/JLfNyG9lXei7OzOF2j7nUC7jFwgN6Y8SNjBiOv6Ngn8BbCwa1b34AdEJ6fuaUaqg==
X-Received: by 2002:a63:ea02:: with SMTP id c2mr9429492pgi.66.1595004223785;
        Fri, 17 Jul 2020 09:43:43 -0700 (PDT)
Received: from localhost ([89.208.244.139])
        by smtp.gmail.com with ESMTPSA id o8sm2344939pjf.37.2020.07.17.09.43.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jul 2020 09:43:43 -0700 (PDT)
Date:   Sat, 18 Jul 2020 00:43:38 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     m-karicheri2@ti.com, robh@kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1] PCI: dwc: fix a warning about variable 'res' is
 uninitialized
Message-ID: <20200717164338.GA11755@nuc8i5>
References: <20200717133007.23858-1-zhengdejin5@gmail.com>
 <20200717163111.GA8421@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717163111.GA8421@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 17, 2020 at 05:31:11PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Jul 17, 2020 at 09:30:07PM +0800, Dejin Zheng wrote:
> > The kernel test robot reported a compile warning,
> > 
> > drivers/pci/controller/dwc/pci-keystone.c:1236:18: warning: variable 'res'
> > is uninitialized when used here [-Wuninitialized]
> > 
> > The commit c59a7d771134b5 ("PCI: dwc: Convert to
> > devm_platform_ioremap_resource_byname()") did a wrong conversion for
> > keystone driver. the commit use devm_platform_ioremap_resource_byname()
> > to replace platform_get_resource_byname() and devm_ioremap_resource().
> > but the subsequent code needs to use the variable 'res', which is got by
> > platform_get_resource_byname() for resource "app". so revert it.
> > 
> > Fixes: c59a7d771134b5 ("PCI: dwc: Convert to devm_platform_ioremap_resource_byname()")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Squashed in the commit it is fixing, thanks.
>
Lorenzo, Thanks a lot for your help.

BR,
Dejin

> Lorenzo
> 
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index 5ffc3b40c4f6..00279002102e 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > @@ -1228,8 +1228,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
> >  	if (!pci)
> >  		return -ENOMEM;
> >  
> > -	ks_pcie->va_app_base =
> > -		devm_platform_ioremap_resource_byname(pdev, "app");
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> > +	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
> >  	if (IS_ERR(ks_pcie->va_app_base))
> >  		return PTR_ERR(ks_pcie->va_app_base);
> >  
> > -- 
> > 2.25.0
> > 
