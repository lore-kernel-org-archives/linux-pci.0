Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:15327 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1030749AbbJ3Lvw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 30 Oct 2015 07:51:52 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Date: Fri, 30 Oct 2015 11:51:47 +0000
Message-ID: <PS1PR06MB11805309BF760C14F4894EAEF52F0@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
 <20151029123755.GC2351@katana>
 <PS1PR06MB118061CA5128E4C1A2C70A18F5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151029163930.GC22218@katana>
 <PS1PR06MB11804B39B09D6FCAA9B3D9DCF5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151029184800.GB8992@katana>
In-Reply-To: <20151029184800.GB8992@katana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Wolfram,

On 29 October 2015 18:48, Wolfram wrote:
> On Thu, Oct 29, 2015 at 04:44:06PM +0000, Phil Edworthy wrote:
> > Hi Wolfram,
> >
> > On 29 October 2015 16:40, Wolfram wrote:
> > > > Ouch, my bad. I have been working with our out-of-tree BSP for the
> Salvator-X
> > > board on
> > > > http://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git,  rcar-
> 3.0.2
> > > tag along
> > > > with some patches from colleagues. I hadn't noticed this patch:
> > >
> > > Thanks! Any plans for pushing this upstream? We will have the build error
> > > otherwise...
> > After some digging, that patch won't be accepted upstream. I'm looking into
> how the
> > driver can be modified so it doesn't need to call this, but I don't expect a small
> or
> > imminent fix.
> 
> Yes, I'd think so, too. However, a fix for 4.4 would be needed to
> prevent having a final release with a build error.
Hopefully, Geert's patch will be applied to avoid build errors in both the
rcar-pcie and rcar-pci-gen2 (internal USB bridge) drivers. Meanwhile I'll fix
the rcar-pcie driver properly for arm64.


> > > > > Any news if this is really HW related?
> > > > I found out that the PCIe controller HW only supports 32-bit AXI bus
> addresses,
> > > so it
> > > > works fine if you limit the available memory. The driver will need some work
> to
> > > use
> > > > the IPMMU at some point.
> > >
> > > Ah, okay.
> > >
> > > Can you send the dts patches, too? I checked the BSP this time, but to
> > > no avail...
> > I will once I sort out the arm64 IO resources problem and the MSI problem.
> 
> What MSI problem?
I was told that rcar pcie on v4.3-rc5 had an issue with MSI. I've since checked
That both v4.3-rc7 and next work ok out of the box on the Koelsch board.
There are some problems with next (mstp related), but it doesn't stop the
board booting and being able to test pcie. Since shmobile arm64 is not in
next yet, I have not checked this.
 
> And can't you send the DTS patches as RFC so I can add some testing?
Sure, though what tree? As I mentioned above, next doesn't have
shmobile arm64 yet.

Thanks
Phil
