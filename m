Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DBBC10F12
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 12:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7782077C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 12:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfDOMZQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:25:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33706 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfDOMZQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 08:25:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4569680D;
        Mon, 15 Apr 2019 05:25:15 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE2CC3F706;
        Mon, 15 Apr 2019 05:25:12 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:25:13 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
Subject: Re: [PATCH v2 06/26] PCI: keystone: Move initializations to
 appropriate places
Message-ID: <20190415122513.GB12127@red-moon>
References: <20190325083501.8088-1-kishon@ti.com>
 <20190325083501.8088-7-kishon@ti.com>
 <20190413143001.GE126710@google.com>
 <9ab596e8-b012-7f4e-aa93-c5661827af95@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ab596e8-b012-7f4e-aa93-c5661827af95@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 15, 2019 at 11:04:10AM +0530, Kishon Vijay Abraham I wrote:
> Hi Bjorn,
> 
> On 13/04/19 8:00 PM, Bjorn Helgaas wrote:
> > On Mon, Mar 25, 2019 at 02:04:41PM +0530, Kishon Vijay Abraham I wrote:
> >> No functional change. Move host specific platform_get_resource to
> >> ks_add_pcie_port and the common platform_get_resource (applicable
> >> to both host and endpoint) to probe. This is in preparation for
> >> adding endpoint support to pci-keystone driver.
> > 
> > This seems to move platform_get_resource() *from* (not *to*)
> > ks_add_pcie_port().
> 
> Maybe I should have mentioned "Keep host specific platform_get_resource() in
> ks_add_pcie_port() and move the common platform_get_resource() (applicable
> to both host and endpoint) to probe()"

Commit log updated, pushed out pci/keystone again.

Thanks,
Lorenzo

> > You seem to be making a distinction in the commit log between (1) a
> > resource that's only used for host mode, and (2) a common resource
> > that's used for both host and endpoint mode.  But I don't see that
> > distinction in the patch, so it's a little confusing to mention it in
> > the commit log.
> > 
> > It must make endpoint support easier, but I can't quite connect the
> > dots yet.  Maybe endpoint will also use ks_pcie_add_pcie_port(), but
> > will have a separate .probe() function that doesn't look up the
> > resource that's specific to host mode?
> 
> No ks_pcie_add_pcie_port() is specific to host mode, so "config" resource is
> kept there whereas "dbics" and "app" resources are common to both host mode and
> device mode, so they are moved to probe().
> 
> Thanks
> Kishon
> 
> > 
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/pci/controller/dwc/pci-keystone.c | 27 +++++++++++++----------
> >>  1 file changed, 15 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> >> index 5eebef9b9ada..95997885a05c 100644
> >> --- a/drivers/pci/controller/dwc/pci-keystone.c
> >> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> >> @@ -806,11 +806,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
> >>  	struct resource *res;
> >>  	int ret;
> >>  
> >> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
> >> -	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
> >> -	if (IS_ERR(pci->dbi_base))
> >> -		return PTR_ERR(pci->dbi_base);
> >> -
> >>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> >>  	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> >>  	if (IS_ERR(pp->va_cfg0_base))
> >> @@ -818,13 +813,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
> >>  
> >>  	pp->va_cfg1_base = pp->va_cfg0_base;
> >>  
> >> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> >> -	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
> >> -	if (IS_ERR(ks_pcie->va_app_base))
> >> -		return PTR_ERR(ks_pcie->va_app_base);
> >> -
> >> -	ks_pcie->app = *res;
> >> -
> >>  	pp->ops = &ks_pcie_host_ops;
> >>  	ret = dw_pcie_host_init(pp);
> >>  	if (ret) {
> >> @@ -895,6 +883,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
> >>  	struct dw_pcie *pci;
> >>  	struct keystone_pcie *ks_pcie;
> >>  	struct device_link **link;
> >> +	struct resource *res;
> >> +	void __iomem *base;
> >>  	u32 num_viewport;
> >>  	struct phy **phy;
> >>  	u32 num_lanes;
> >> @@ -911,6 +901,19 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
> >>  	if (!pci)
> >>  		return -ENOMEM;
> >>  
> >> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> >> +	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
> >> +	if (IS_ERR(ks_pcie->va_app_base))
> >> +		return PTR_ERR(ks_pcie->va_app_base);
> >> +
> >> +	ks_pcie->app = *res;
> >> +
> >> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
> >> +	base = devm_pci_remap_cfg_resource(dev, res);
> >> +	if (IS_ERR(base))
> >> +		return PTR_ERR(base);
> >> +
> >> +	pci->dbi_base = base;
> >>  	pci->dev = dev;
> >>  	pci->ops = &ks_pcie_dw_pcie_ops;
> >>  
> >> -- 
> >> 2.17.1
> >>
