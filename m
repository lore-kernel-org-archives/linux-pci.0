Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbdH1SOt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Aug 2017 14:14:49 -0400
Date: Mon, 28 Aug 2017 13:14:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Honghui Zhang <honghui.zhang@mediatek.com>
Cc: "Li, Philip" <philip.li@intel.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "youlin.pei@mediatek.com" <youlin.pei@mediatek.com>,
        "xinping.qian@mediatek.com" <xinping.qian@mediatek.com>
Subject: Re: [pci:pci/host-mediatek 11/11]
 drivers/pci/host/pcie-mediatek.c:541:43: error: 'node' undeclared
Message-ID: <20170828181446.GF8154@bhelgaas-glaptop.roam.corp.google.com>
References: <201708232205.SymULNVt%fengguang.wu@intel.com>
 <20170823225211.GI8498@bhelgaas-glaptop.roam.corp.google.com>
 <1503544447.19072.7.camel@mhfsdcap03>
 <20170824134451.GA31858@bhelgaas-glaptop.roam.corp.google.com>
 <1503622427.19072.11.camel@mhfsdcap03>
 <1503708987.2081.5.camel@mtkswgap22>
 <20170826115508.GE8154@bhelgaas-glaptop.roam.corp.google.com>
 <20170826122823.v6eprqvee4dcgah4@wfg-t540p.sh.intel.com>
 <831EE4E5E37DCC428EB295A351E662494C80B571@shsmsx102.ccr.corp.intel.com>
 <1503891233.10964.2.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503891233.10964.2.camel@mhfsdcap03>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 28, 2017 at 11:33:53AM +0800, Honghui Zhang wrote:
> On Sat, 2017-08-26 at 14:20 +0000, Li, Philip wrote:
> > > On Sat, Aug 26, 2017 at 06:55:08AM -0500, Bjorn Helgaas wrote:
> > > >On Sat, Aug 26, 2017 at 08:56:27AM +0800, Ryder Lee wrote:
> > > >> Hi,
> > > >>
> > > >> On Fri, 2017-08-25 at 08:53 +0800, Honghui Zhang wrote:
> > > >> > On Thu, 2017-08-24 at 08:44 -0500, Bjorn Helgaas wrote:
> > > >> > > On Thu, Aug 24, 2017 at 11:14:07AM +0800, mtk11102 wrote:
> > > >> > > > On Wed, 2017-08-23 at 17:52 -0500, Bjorn Helgaas wrote:
> > > >> > > > > On Wed, Aug 23, 2017 at 10:53:07PM +0800, kbuild test robot wrote:
> > > >>
> > > >> ....
> > > >> > > > I pull the your host-mediatek branch and seems the build error is still
> > > >> > > > there.
> > > >> > > > Should I send a new patch base on your pci/host-mediatek to fix the
> > > >> > > > build warnings, or should I wait for your push for build error and then
> > > >> > > > send the patch?
> > > >> > >
> > > >> > > Sorry, I must have forgotten to push it.  Should be there now:
> > > >> > > 9f3ec1e47377 ("PCI: mediatek: Add MSI support for MT2712 and MT7622")
> > > >> > >
> > > >> > > Hopefully that has everything we need (I included your fix above).
> > > >> > >
> > > >> >
> > > >> > Thanks very much for your help.
> > > >> >
> > > >> > > Bjorn
> > > >> >
> > > >> >
> > > >>
> > > >> I just noticed that 9f3ec1e47377 could not be built pass.
> > > >>
> > > >> In function 'mtk_pcie_enable_msi':
> > > >>  error: 'return' with a value, in function returning void [-Werror]
> > > >>   return 0;
> > > >>
> > > >> In function 'mtk_pcie_init_irq_domain': error: unused variable
> > > >> 'err' [-Werror=unused-variable]
> > > >>   int err;
> > > >
> > > >Fixed in 0eb463c096c4 ("PCI: mediatek: Add MSI support for MT2712 and
> > > >MT7622").
> > > >
> 
> Hi, Bjorn,
>    Seems you forget to remove the following define in 0eb463c096c4 :
> 
> > >> In function 'mtk_pcie_init_irq_domain': error: unused variable
> > > >> 'err' [-Werror=unused-variable]
> > > >>   int err;

Removed, thanks.
