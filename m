Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 3 Aug 2017 15:12:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: [PATCH 0/2] PCI: dwc: convert remaining dbi read/writes to
 dw_pcie_readX_dbi/dw_pcie_writeX_dbi
Message-ID: <20170803201215.GX20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170714120735.11993-1-niklas.cassel@axis.com>
 <20170802213255.GB7667@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170802213255.GB7667@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adding Kishon & Pratyush for real this time.

On Wed, Aug 02, 2017 at 04:32:56PM -0500, Bjorn Helgaas wrote:
> [+cc Kishon, Pratyush]
> 
> On Fri, Jul 14, 2017 at 02:07:33PM +0200, Niklas Cassel wrote:
> > Since the introduction of the dw_pcie_readX_dbi/dw_pcie_writeX_dbi macros,
> > most dw_pcie_read(pci->dbi_base, ..)/dw_pcie_write(pci->dbi_base, ..) calls
> > have been converted to dw_pcie_readX_dbi/dw_pcie_writeX_dbi calls.
> > Convert the remaining calls.
> > 
> > Niklas Cassel (2):
> >   PCI: dwc: dra7xx: utilize dw_pcie_readX_dbi/dw_pcie_writeX_dbi macros
> >   PCI: dwc: spear13xx: utilize dw_pcie_readX_dbi/dw_pcie_writeX_dbi
> >     macros
> > 
> >  drivers/pci/dwc/pci-dra7xx.c     | 14 ++++++--------
> >  drivers/pci/dwc/pcie-spear13xx.c | 22 ++++++++++------------
> >  2 files changed, 16 insertions(+), 20 deletions(-)
> 
> Waiting for ack from maintainers (cc'd).
