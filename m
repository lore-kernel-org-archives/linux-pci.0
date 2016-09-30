Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbcI3WN2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Sep 2016 18:13:28 -0400
Date: Fri, 30 Sep 2016 15:13:24 -0700
From: Shawn Guo <shawnguo@kernel.org>
To: Po Liu <po.liu@nxp.com>
Cc: Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuart.yoder@nxp.com>,
        "M.H. Lian" <minghuan.lian@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 3/3] pci:aer: add support aer interrupt with none
 MSI/MSI-X/INTx mode
Message-ID: <20160930221323.GC2373@x250>
References: <1472625442-23309-2-git-send-email-po.liu@nxp.com>
 <1473741659-17618-1-git-send-email-po.liu@nxp.com>
 <1473741659-17618-3-git-send-email-po.liu@nxp.com>
 <20160918005212.GF15478@tiger>
 <VI1PR0401MB1709F91B0C1EB6C80D741E4492F50@VI1PR0401MB1709.eurprd04.prod.outlook.com>
 <20160920123926.GA3744@tiger>
 <VI1PR0401MB17090ED60A826FDCBFB8B33D92F60@VI1PR0401MB1709.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <VI1PR0401MB17090ED60A826FDCBFB8B33D92F60@VI1PR0401MB1709.eurprd04.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 21, 2016 at 06:54:59AM +0000, Po Liu wrote:
> >  > >  Will the new kernel work with existing/old DTB?  I'm trying to
> >  > > understand the dependency between driver and DTS changes.
> >  >
> >  > Yes, We've never use name 'intr' before. So we remove it is ok.
> >  > 'aer' is a dts name for researching it's true interrupt number by
> >  kernel. This patch is first time to use name 'aer'. So it must be
> >  compatible with existing/old DTB.
> >  
> >  Does that mean driver and DTS changes can go through separate trees, i.e.
> >  PCI and arm-soc, without introducing regressions on either tree?
> >  Or does the patch series needs to go in as a whole?
> 
> Should be as a whole. The driver base on the dts. Or else, the driver would not found the 'aer' point.

Let me try to understand this one more time.  So if the new kernel boots
with an existing DTB, the driver will fail to find 'aer' interrupt,
right?  My question is that in this case, the driver will just stop
working or keep working in the same way as old kernel.  The former case
is a regression which breaks old DTB support, and the latter is pretty
much like that we are adding a new support, and the DTS change can go
independently with driver part through different subsystem tree.

Hope I make my question clear this time.

Shawn
