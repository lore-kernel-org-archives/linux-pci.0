Return-Path: <SRS0=38Fo=6B=mediatek.com=ryder.lee@kernel.org>
Return-Path: <SRS0=38Fo=6B=mediatek.com=ryder.lee@kernel.org>
Message-ID: <1498612886.20242.12.camel@mtkswgap22>
Subject: Re: [PATCH] PCI: mediatek: change to use the new host bridge
 interface
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell
	<sfr@canb.auug.org.au>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Wed, 28 Jun 2017 09:21:26 +0800
In-Reply-To: <20170627232057.GK17844@bhelgaas-glaptop.roam.corp.google.com>
References: <1498555451-55073-1-git-send-email-ryder.lee@mediatek.com>
	 <1498555451-55073-2-git-send-email-ryder.lee@mediatek.com>
	 <20170627223039.GE17844@bhelgaas-glaptop.roam.corp.google.com>
	 <20170627232057.GK17844@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-06-27 at 18:20 -0500, Bjorn Helgaas wrote:
> On Tue, Jun 27, 2017 at 05:30:40PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jun 27, 2017 at 05:24:11PM +0800, Ryder Lee wrote:
> > > With the introduction of pci_scan_root_bus_bridge() there is no need to
> > > export pci_register_host_bridge() to other kernel subsystems other than the
> > > PCI compilation unit that needs it.
> > > 
> > > Make pci_register_host_bridge() static to its compilation unit and convert
> > > the existing drivers usage over to pci_scan_root_bus_bridge().
> > > 
> > > Also, when probing the PCI host controller driver, if an error occurs, the probe
> > > function code does not free memory allocated for the struct pci_host_bridge
> > > resulting in memory leakage.
> > > 
> > > This patch fixes them by using the methods that introduces by Lorenzo.
> > > 
> > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > 
> > I rebased my pci/host-mediatek branch on top of pci/enumeration (which
> > contains the series from Lorenzo), and folded this into the initial
> > MediaTek driver commit.
> > 
> > This branch:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-mediatek&id=b6ca15d18881b784dc9efc5d81989be26ecd9fc8
> > 
> > should have all the MediaTek bits I know about.  Can you double-check
> > it, please?
> 
> Sorry, that's wrong; I see your controller powerup stuff in patchwork, and
> that's *not* included yet.

Yes, that should be folded into the initial commit if possible.
Thanks for your help!

Ryder
