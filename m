Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5E8C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D94206BA
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfDWJnd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:43:33 -0400
Received: from foss.arm.com ([217.140.101.70]:52730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfDWJnd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 05:43:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5D25374;
        Tue, 23 Apr 2019 02:43:32 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2934D3F557;
        Tue, 23 Apr 2019 02:43:31 -0700 (PDT)
Date:   Tue, 23 Apr 2019 10:43:37 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        YueHaibing <yuehaibing@huawei.com>, robh@kernel.org,
        l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: keystone: Fix build error while only
 CONFIG_PCI_KEYSTONE is set
Message-ID: <20190423094337.GC25738@red-moon>
References: <20190419025855.40760-1-yuehaibing@huawei.com>
 <20190419133137.GA173520@google.com>
 <35486240-8c29-410d-e0f4-c87dc42fb668@huawei.com>
 <20190419174735.GE173520@google.com>
 <9e674a96-5d19-47f6-41a4-9a4313652b5b@ti.com>
 <20190422132617.GL173520@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422132617.GL173520@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 22, 2019 at 08:26:17AM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 22, 2019 at 01:19:53PM +0530, Kishon Vijay Abraham I wrote:
> > Hi Bjorn,
> > ...
> 
> > Sometime back Niklas had fixed this for DRA7xx in
> > 
> > commit b052835c63857e13d9ada3ebc57a8f9e1d124f3a
> > Author: Niklas Cassel <niklas.cassel@axis.com>
> > Date:   Wed Dec 20 00:29:28 2017 +0100
> > 
> >     PCI: dwc: dra7xx: Refactor Kconfig and Makefile handling for host/ep mode
> > 
> >     Refactor the Kconfig and Makefile handling for host/ep mode, since
> >     the previous handling was a bit unorthodox and would have been a bit
> >     bloated once more DWC based controllers added support for ep mode.
> > 
> >     Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> >     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >     Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > 
> > Something similar is applicable for Keystone too as you mentioned without
> > selecting PCI_KEYSTONE_HOST or PCI_KEYSTONE_EP, compiling pci-keystone.c
> > doesn't make sense.
> > 
> > Please see if below looks okay to you. This can be merged with "PCI:
> > keystone:Add support for PCIe EP in AM654x Platforms"). Let me know if I have
> > to send it separately with Fixes tag.
> 
> Lorenzo merged that commit, so I assume he'll take care of this.

I will squash it in and rebuild the branch, thanks.

Lorenzo

> > 8<---------------------------------------------------------
> > From 8fba36048112cf72c49996fc47fd808534bf9689 Mon Sep 17 00:00:00 2001
> > From: Kishon Vijay Abraham I <kishon@ti.com>
> > Date: Mon, 22 Apr 2019 11:42:32 +0530
> > Subject: [PATCH] PCI: keystone: Refactor Kconfig for RC/EP mode
> > 
> > Do not allow PCI_KEYSTONE to be visible to user and let user visible
> > CONFIG symbols PCI_KEYSTONE_HOST and PCI_KEYSTONE_EP select
> > PCI_KEYSTONE. This will let pci-keystone.c to be compiled only when
> > either PCI_KEYSTONE_HOST or PCI_KEYSTONE_EP is selected.
> > 
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig | 24 +++++++++++-------------
> >  1 file changed, 11 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig
> > b/drivers/pci/controller/dwc/Kconfig
> > index b450ad2823a5..90618233d15b 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -103,34 +103,32 @@ config PCIE_SPEAR13XX
> >  	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
> > 
> >  config PCI_KEYSTONE
> > -	bool "TI Keystone PCIe controller"
> > -	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
> > -	help
> > -	  Say Y here if you want to enable PCI controller support on Keystone
> > -	  SoCs. The PCI controller on Keystone is based on DesignWare hardware
> > -	  and therefore the driver re-uses the DesignWare core functions to
> > -	  implement the driver.
> > -
> > -if PCI_KEYSTONE
> > +	bool
> > 
> >  config PCI_KEYSTONE_HOST
> >  	bool "PCI Keystone Host Mode"
> > +	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
> >  	depends on PCI_MSI_IRQ_DOMAIN
> >  	select PCIE_DW_HOST
> > +	select PCI_KEYSTONE
> >  	default y
> >  	help
> >  	 Enables support for the PCIe controller in the Keystone SoC to work in
> > -	 host mode.
> > +	 host mode. The PCI controller on Keystone is based on DesignWare hardware
> > +	 and therefore the driver re-uses the DesignWare core functions to
> > +	 implement the driver.
> > 
> >  config PCI_KEYSTONE_EP
> >  	bool "PCI Keystone Endpoint Mode"
> > +	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
> >  	depends on PCI_ENDPOINT
> >  	select PCIE_DW_EP
> > +	select PCI_KEYSTONE
> >  	help
> >  	 Enables support for the PCIe controller in the Keystone SoC to work in
> > -	 endpoint mode.
> > -
> > -endif
> > +	 endpoint mode. The PCI controller on Keystone is based on DesignWare hardware
> > +	 and therefore the driver re-uses the DesignWare core functions to
> > +	 implement the driver.
> > 
> >  config PCI_LAYERSCAPE
> >  	bool "Freescale Layerscape PCIe controller"
> > -- 
> > 2.17.1
