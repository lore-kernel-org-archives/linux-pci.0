Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Wed, 22 Jun 2016 13:09:46 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI / DPC: Few improvements
Message-ID: <20160622100946.GC1739@lahna.fi.intel.com>
References: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160621185719.GB7603@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160621185719.GB7603@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 21, 2016 at 01:57:20PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 06, 2016 at 04:06:04PM +0300, Mika Westerberg wrote:
> > Hi,
> > 
> > This series includes few improvements for the PCIe DPC driver. First we
> > introduce module_pci_port_service() which allows reducing of boilerblate
> > code used in the DPC driver. In addition we convert the driver to use
> > managed resource functions (devm) to get rid of even more boilerblate.
> > 
> > I do not have hardware supporting DPC so these are only compile tested.
> > 
> > Mika Westerberg (4):
> >   PCI / PCIe: Introduce module_pci_port_service()
> >   PCI / DPC: Convert to use module_pcie_port_service()
> >   PCI / DPC: Convert the driver to use devm_* functions
> >   PCI / DPC: Fix whitespace in struct dpc_dev
> > 
> >  drivers/pci/pcie/pcie-dpc.c | 30 +++++++-----------------------
> >  include/linux/pcieport_if.h | 13 +++++++++++++
> >  2 files changed, 20 insertions(+), 23 deletions(-)
> 
> I applied the last two, with Keith's acks, to pci/dpc for v4.8.
> 
> I didn't apply the first two because I don't think these port drivers
> should be modules.  I think DPC and thunderbolt are the only candidates
> right now, and I think it's a stretch to think about either one as a
> module.

Understood. Thanks.
