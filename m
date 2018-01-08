Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 8 Jan 2018 16:35:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org,
        adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/9] PCI: cadence: Add host driver for Cadence PCIe
 controller
Message-ID: <20180108223545.GB31640@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
 <4b2b67ad54e14ee5e1f83af65e9932ce408e82ec.1513620412.git.cyrille.pitchen@free-electrons.com>
 <20180108180613.GE2530@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180108180613.GE2530@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 08, 2018 at 06:06:13PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Dec 18, 2017 at 07:16:06PM +0100, Cyrille Pitchen wrote:
> > This patch adds support to the Cadence PCIe controller in host mode.
> > 
> > The "cadence/" entry in drivers/pci/Makefile is placed after the
> > "endpoint/" entry so when the next patch introduces a EPC driver for the
> > Cadence PCIe controller, drivers/pci/cadence/pcie-cadence-ep.o will be
> > linked after drivers/pci/endpoint/*.o objects, otherwise the built-in
> > pci-cadence-ep driver would be probed before the PCI endpoint libraries
> > would have been initialized, which would result in a kernel crash.

I assume this ordering requirement applies to both Cadence and
DesignWare, i.e., drivers/pci/endpoint must be linked before
drivers/pci/cadence and drivers/pci/dwc.

If so, please add a one-line comment in the Makefile, e.g.,

  obj-$(CONFIG_PCI_ENDPOINT) += endpoint/

  # endpoint library must be initialized before its users
  obj-$(CONFIG_PCI_CADENCE)  += cadence/
  obj-y                      += dwc/

I think the "PCI dwc controller drivers" comment adds no real value.

> > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > index 7284a7f6ad1e..a66ddb347798 100644
> > --- a/drivers/pci/Makefile
> > +++ b/drivers/pci/Makefile
> > @@ -54,5 +54,6 @@ obj-y += host/
> >  obj-y += switch/
> >  
> >  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> > +obj-$(CONFIG_PCI_CADENCE)	+= cadence/
> >  # PCI dwc controller drivers
> >  obj-y				+= dwc/
