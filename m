Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58148 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964917AbeBMOEW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Feb 2018 09:04:22 -0500
Date: Tue, 13 Feb 2018 14:04:09 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
        "thomas.petazzoni@free-electrons.com"
        <thomas.petazzoni@free-electrons.com>,
        "minghuan.Lian@freescale.com" <minghuan.Lian@freescale.com>,
        "mingkai.hu@freescale.com" <mingkai.hu@freescale.com>,
        "tie-fei.zang@freescale.com" <tie-fei.zang@freescale.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        "svarbanov@mm-sol.com" <svarbanov@mm-sol.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: Re: [PATCH v6 0/9] PCI: dwc: MSI-X feature
Message-ID: <20180213140359.GA12971@e107981-ln.cambridge.arm.com>
References: <cover.1516984229.git.gustavo.pimentel@synopsys.com>
 <20180212122334.GA25396@e107981-ln.cambridge.arm.com>
 <47720ab7-1eb5-0605-5711-80595b358f7d@synopsys.com>
 <20180213122920.GB8981@e107981-ln.cambridge.arm.com>
 <1518525395.2744.14.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518525395.2744.14.camel@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 13, 2018 at 01:36:35PM +0100, Lucas Stach wrote:
> Am Dienstag, den 13.02.2018, 12:29 +0000 schrieb Lorenzo Pieralisi:
> > On Mon, Feb 12, 2018 at 06:14:29PM +0000, Gustavo Pimentel wrote:
> > > Hi Lorenzo,
> > > 
> > > On 12/02/2018 12:23, Lorenzo Pieralisi wrote:
> > > > On Fri, Jan 26, 2018 at 04:35:35PM +0000, Gustavo Pimentel wrote:
> > > > > Replaces the use of IRQ domain hierarchy by the IRQ chained
> > > > > used by
> > > > > pcie-designware and each SoC specific driver in order to allow
> > > > > new and
> > > > > complex features like MSI-X.
> > > > > 
> > > > > Adds Synopsys Root Complex support for MSI-X feature.
> > > > 
> > > > Hi Gustavo,
> > > > 
> > > > please CC me for future patch versions. I have a question for
> > > > you,
> > > > the series definitely looks like it is going in the right
> > > > direction
> > > > but I do not understand the cover letter.
> > > > 
> > > > - You are not replacing the IRQ domain hierarchy, you are
> > > > actually
> > > > ?? introducing it properly. It may be just nomenclature but I
> > > > though
> > > > ?? I would mention that.
> > > > - I really do not understand why this series is advertised as
> > > > ?? "implementing MSI-X". I want to understand why MSI-X it is not
> > > > ?? currently supported and why this series would enable it, I
> > > > ?? honestly do not understand the reasoning behind this, it looks
> > > > ?? a bit fuzzy.
> > > > 
> > > > Please note I am just asking clarifications on the $SUBJECT for
> > > > my own
> > > > understanding, the series is definitely the right thing to do and
> > > > I am
> > > > happy to target v4.17 for it.
> > > 
> > > Marc Zyngier also pointed out like you that the description is
> > > confusing and
> > > does not correspond to what is done in the code and now I also see
> > > it now.
> > > 
> > > Please fell free to review and point out something wrong, only in
> > > this way can I
> > > evolve. :)
> > 
> > Sure. Let's start by discussing this:
> > 
> > https://patchwork.kernel.org/patch/5708521/
> > 
> > If it is a HW issue your patches can't solve it. If it is a SW issue
> > patch above (and current mainline code - commit 19c5392eb1c1) is
> > wrong.
> > 
> > Before updating the code I want to understand what the problem is
> > with
> > MSI-X in current mainline.
> > 
> > To be as clear as I can: this series is doing the *right* thing, I
> > want
> > to understand what the current driver is doing with MSIs and why, so
> > that we can help you update the code correctly.
> 
> It's partly a software issue and partly a wrong understanding of MSI-X
> on my side at the time. The DW hardware doesn't support different MSI
> target addresses for individual MSIs, but that's just a optional
> feature of MSI-X and not required to implement them correctly. Enabling
> of MSI-X on the DW hardware via a proper software implementation is
> fine.

Ok, thanks for clarifying, that matches my understanding, I completely
agree that to enable MSI-X we must move to a hierarchical IRQ domain
implementation (where core IRQ code deals with IRQ allocation and
mapping on behalf of drivers) instead of abusing the IRQ layer even
further, so this series is definitely the way to go, I just wanted to
understand why DW does not support MSI-X.

Thanks,
Lorenzo
