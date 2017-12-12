Return-Path: <SRS0=hqxK=DI=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=hqxK=DI=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 12 Dec 2017 18:10:05 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: rcar: Misc error path fixes
Message-ID: <20171212181005.GB22805@red-moon>
References: <1512641720-4715-1-git-send-email-geert+renesas@glider.be>
 <20171212171658.GA53955@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171212171658.GA53955@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 12, 2017 at 11:16:58AM -0600, Bjorn Helgaas wrote:
> On Thu, Dec 07, 2017 at 11:15:18AM +0100, Geert Uytterhoeven wrote:
> > 	Hi Simon, Lorenzo, Bjorn,
> > 
> > This patch series fixes two issues in the error path for the R-Car PCIe
> > host bridge driver.
> > 
> > The first issue is triggered easily by not having a PCIe card inserted,
> > and may cause a crash.
> > 
> > Thanks!
> > 
> > Geert Uytterhoeven (2):
> >   PCI: rcar: Fix use-after-free in probe error path
> >   PCI: rcar: Handle rcar_pcie_parse_request_of_pci_ranges() failures
> > 
> >  drivers/pci/host/pcie-rcar.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> The first fixes ddd535f1ea3eb27e, which appeared in v4.14-rc1.  The
> second fixes 5d2917d469faab72, which appeared in v4.5-rc1.
> 
> After the merge window I normally just pull in critical fixes and
> fixes to things we merged during the window.
> 
> I think the first makes sense for v4.15 because it can cause a crash
> with no obvious way to debug it.  The second one feels like v4.16
> material to me.
> 
> Thoughts?  We're trying to sort out how to handle this sort of thing
> between Lorenzo and myself, so I apologize for the confusion here.

This sounds absolutely reasonable for me.

Thanks !
Lorenzo
