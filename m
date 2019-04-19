Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BA3C282DA
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CB420652
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698280;
	bh=GpYFjL0iQTmYNM0ELrSlCQ8xNNxSLfGtMu5NsbQf9Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZdDJG756L7jedGxwNx0pyIW9JAbNrwZiKUCCY1/5GQ7J7t7k9/cYV82usakDk6Mf9
	 2k/QqWoxZ9zx6g7Rxgva8m1w53dnNGFXvjOJKK/xDf0z7XNzxInzWA6GKQ0PrFj0fG
	 g5DNDFXFeiCZfxSRT63A1pP/QM+MteqSqEwrmiSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfDSSYP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfDSSYP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 14:24:15 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE87C222DF;
        Fri, 19 Apr 2019 17:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555696059;
        bh=GpYFjL0iQTmYNM0ELrSlCQ8xNNxSLfGtMu5NsbQf9Qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYmJuTH76ZLta78Fu45xrIMMj69Dib9byBtg1Pld0pJR4i0Afghb1v6f0BNItxw5O
         v7FJXhM8pwPPqFvxxVglrpxTDXeQG+RIWnnTF7Hmqst2bFcLvqcPop/BHeAX+U2x+U
         yf4iA9FC0vOa8g30+lvmG27It9QvnzRGroeIvsVQ=
Date:   Fri, 19 Apr 2019 12:47:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     lorenzo.pieralisi@arm.com, kishon@ti.com, robh@kernel.org,
        l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: keystone: Fix build error while only
 CONFIG_PCI_KEYSTONE is set
Message-ID: <20190419174735.GE173520@google.com>
References: <20190419025855.40760-1-yuehaibing@huawei.com>
 <20190419133137.GA173520@google.com>
 <35486240-8c29-410d-e0f4-c87dc42fb668@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35486240-8c29-410d-e0f4-c87dc42fb668@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 19, 2019 at 09:46:39PM +0800, YueHaibing wrote:
> On 2019/4/19 21:31, Bjorn Helgaas wrote:
> > On Fri, Apr 19, 2019 at 10:58:55AM +0800, Yue Haibing wrote:
> >> From: YueHaibing <yuehaibing@huawei.com>
> >>
> >> During randconfig builds, I occasionally run into an invalid configuration
> >>
> >> drivers/pci/controller/dwc/pci-keystone.o: In function `ks_pcie_link_up':
> >> pci-keystone.c:(.text+0x90): undefined reference to `__dw_pcie_read_dbi'
> >> pci-keystone.c:(.text+0x90): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__dw_pcie_read_dbi'
> >> drivers/pci/controller/dwc/pci-keystone.o: In function `ks_pcie_v3_65_scan_bus':
> >> pci-keystone.c:(.text+0x4f0): undefined reference to `__dw_pcie_write_dbi'
> >> pci-keystone.c:(.text+0x4f0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__dw_pcie_write_dbi'
> >>
> >> while CONFIG_PCI_KEYSTONE is selected but CONFIG_PCIE_DW
> >> is not set, the building failed like this. This patch
> >> selects PCIE_DW to fix it.
> >>
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Fixes: 5709114f0a97 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> ---
> >>  drivers/pci/controller/dwc/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> >> index b450ad2..641fa0f 100644
> >> --- a/drivers/pci/controller/dwc/Kconfig
> >> +++ b/drivers/pci/controller/dwc/Kconfig
> >> @@ -105,6 +105,7 @@ config PCIE_SPEAR13XX
> >>  config PCI_KEYSTONE
> >>  	bool "TI Keystone PCIe controller"
> >>  	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
> >> +	select PCIE_DW
> > 
> > What version are you building?  In v5.0, PCI_KEYSTONE already selects
> > PCIE_DW_HOST:
> > 
> > $ git grep -A4 PCI_KEYSTONE v5.0:drivers/pci/controller/dwc/Kconfig | cat
> > v5.0:drivers/pci/controller/dwc/Kconfig:config PCI_KEYSTONE
> > v5.0:drivers/pci/controller/dwc/Kconfig-	bool "TI Keystone PCIe controller"
> > v5.0:drivers/pci/controller/dwc/Kconfig-	depends on ARCH_KEYSTONE || (ARM && COMPILE_TEST)
> > v5.0:drivers/pci/controller/dwc/Kconfig-	depends on PCI_MSI_IRQ_DOMAIN
> > v5.0:drivers/pci/controller/dwc/Kconfig-	select PCIE_DW_HOST
> > 08:30:42 ~/history (master)$
> 
> This patch based on linux-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=5709114f0a97

Oh, yep, looks like this was broken by ad5ca801bd7e ("PCI: keystone:
Add support for PCIe EP in AM654x Platforms"), which added
PCI_KEYSTONE_HOST and PCI_KEYSTONE_EP.  Those select PCIE_DW_HOST and
PCIE_DW_EP, respectively, which in turn select PCIE_DW.

But I guess it's possible to enable PCI_KEYSTONE by itself without
either PCI_KEYSTONE_HOST or PCI_KEYSTONE_EP.  I'm not sure what that
would mean, but we would still try to build pci-keystone.o

I'm hoping we can amend that commit before the merge window.

Bjorn
