Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965243AbeAJLOn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jan 2018 06:14:43 -0500
Date: Wed, 10 Jan 2018 11:15:43 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Koen Vandeputte <koen.vandeputte@ncentric.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com,
        niklas.cassel@axis.com
Subject: Re: [PATCH] PCI: dwc: fix enumeration end when reaching root
 subordinate
Message-ID: <20180110111543.GB27463@red-moon>
References: <1515508941-20055-1-git-send-email-koen.vandeputte@ncentric.com>
 <20180109152550.GA16285@red-moon>
 <20180109200025.GU27654@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180109200025.GU27654@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 09, 2018 at 10:00:25PM +0200, Mika Westerberg wrote:
> On Tue, Jan 09, 2018 at 03:25:58PM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Jan 09, 2018 at 03:42:21PM +0100, Koen Vandeputte wrote:
> > > The subordinate value indicates the highest bus number which can be
> > > reached downstream though a certain device.
> > > 
> > > Commit a20c7f36bd3d ("PCI: Do not allocate more buses than available in
> > > parent")
> > > ensures that downstream devices cannot assign busnumbers higher than the
> > > upstream device subordinate number, which was indeed illogical.
> > > 
> > > By default, dw_pcie_setup_rc() inits the Root Complex subordinate to a
> > > value of 0x01.
> > > 
> > > Due to this combined with above commit, enumeration stops digging deeper
> > > downstream as soon as bus num 0x01 has been assigned, which is always
> > > the case for a bridge device.
> > > 
> > > This results in all devices behind a bridge bus to remain undetected, as
> > > these would be connected to bus 0x02 or higher.
> > > 
> > > Fix this by initializing the RC to a subordinate value of 0xff, meaning
> > > that all busses [0x00-0xff] are reachable through this RC.
> > 
> > This is not a correct description of the problem. AFAICS all busses
> > are reachable through this RC _regardless_ of whatever subordinate
> > bus number value you programme into it.
> 
> Type 1 (the ones directed to the other side of the bridge) configuration
> transactions are not forwarded if the bus number in the transaction is
> not included in secondary and subordinate numbers of the root bridge. I
> think the description here is pretty accurate as the bridges (anything
> higher than bus number 1) below are effectively hidden.

That's correct - but that's not what this patch is fixing which is
what the commit log should describe.

See:

https://marc.info/?l=linux-arm-kernel&m=151540153522730&w=2
