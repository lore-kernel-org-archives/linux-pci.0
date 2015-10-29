Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Date: Thu, 29 Oct 2015 16:44:06 +0000
Message-ID: <PS1PR06MB11804B39B09D6FCAA9B3D9DCF5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
 <20151029123755.GC2351@katana>
 <PS1PR06MB118061CA5128E4C1A2C70A18F5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151029163930.GC22218@katana>
In-Reply-To: <20151029163930.GC22218@katana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Wolfram,

On 29 October 2015 16:40, Wolfram wrote:
> > Ouch, my bad. I have been working with our out-of-tree BSP for the Salvator-X
> board on
> > http://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git,  rcar-3.0.2
> tag along
> > with some patches from colleagues. I hadn't noticed this patch:
> 
> Thanks! Any plans for pushing this upstream? We will have the build error
> otherwise...
After some digging, that patch won't be accepted upstream. I'm looking into how the
driver can be modified so it doesn't need to call this, but I don't expect a small or
imminent fix.

> > > Any news if this is really HW related?
> > I found out that the PCIe controller HW only supports 32-bit AXI bus addresses,
> so it
> > works fine if you limit the available memory. The driver will need some work to
> use
> > the IPMMU at some point.
> 
> Ah, okay.
> 
> Can you send the dts patches, too? I checked the BSP this time, but to
> no avail...
I will once I sort out the arm64 IO resources problem and the MSI problem.

Thanks
Phil
