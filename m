Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCB5C43461
	for <linux-pci@archiver.kernel.org>; Thu, 29 Apr 2021 16:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827466145A
	for <linux-pci@archiver.kernel.org>; Thu, 29 Apr 2021 16:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbhD2QlG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Apr 2021 12:41:06 -0400
Received: from foss.arm.com ([217.140.110.172]:55916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232724AbhD2QlF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 12:41:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 885851FB;
        Thu, 29 Apr 2021 09:40:18 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC4793F70D;
        Thu, 29 Apr 2021 09:40:15 -0700 (PDT)
Date:   Thu, 29 Apr 2021 17:40:11 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greentime Hu <greentime.hu@sifive.com>, paul.walmsley@sifive.com,
        hes@sifive.com, erik.danie@sifive.com, zong.li@sifive.com,
        bhelgaas@google.com, robh+dt@kernel.org, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 5/6] PCI: fu740: Add SiFive FU740 PCIe host controller
 driver
Message-ID: <20210429164010.GA31397@lpieralisi>
References: <20210429145954.GA29122@lpieralisi>
 <20210429151522.GA495642@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429151522.GA495642@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 29, 2021 at 10:15:22AM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 29, 2021 at 03:59:54PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Apr 28, 2021 at 02:47:13PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Apr 06, 2021 at 05:26:33PM +0800, Greentime Hu wrote:
> > > > From: Paul Walmsley <paul.walmsley@sifive.com>
> > > > 
> > > > Add driver for the SiFive FU740 PCIe host controller.
> > > > This controller is based on the DesignWare PCIe core.
> > > > 
> > > > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > > > Co-developed-by: Henry Styles <hes@sifive.com>
> > > > Signed-off-by: Henry Styles <hes@sifive.com>
> > > > Co-developed-by: Erik Danie <erik.danie@sifive.com>
> > > > Signed-off-by: Erik Danie <erik.danie@sifive.com>
> > > > Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
> > > > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > > 
> > > Tripped over these errors while build testing with the .config below.
> > 
> > Sorry about that - the kbot did not managed to test it. Is it a
> > randconfig ? I think we should ask the kbuild bot guys to add it,
> > I think it can be done on a per-repo basis.
> 
> I don't know enough about the bot.  The lkp@intel.com reports I get
> include allyesconfig for x86_64; not sure why that wouldn't catch
> this.
> 
> > Waiting for a fix asap - I can move/rebase some commits if the fix
> > takes time.
> 
> If it's feasible you could just move the FU740 stuff to a different
> branch so we can be sure to include the other dwc stuff.  Same for
> brcmstb.
> 
> Oh, and Colin just posted a NULL pointer check that could be squashed
> into the new mediatek-gen3 driver.

All done. Updated pci/dwc, pci/brcmstb and pci/mediatek, parked the
changes requiring a fix-up in separate branches, will push them out
when fixed.

Thanks,
Lorenzo
