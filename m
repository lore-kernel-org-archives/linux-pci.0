Return-Path: <SRS0=DXIZ=FH=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=DXIZ=FH=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 13 Feb 2018 10:28:53 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Niklas Cassel <niklas.cassel@axis.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Sekhar Nori <nsekhar@ti.com>,
	Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
	Niklas Cassel <niklass@axis.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	John Keeping <john@metanate.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: endpoint: Handle 64-bit BARs properly
Message-ID: <20180213102853.GA8981@e107981-ln.cambridge.arm.com>
References: <20180208123346.20784-1-niklas.cassel@axis.com>
 <20180208123346.20784-2-niklas.cassel@axis.com>
 <da5004d3-c3e8-d9fd-6698-3b12c3ab624a@ti.com>
 <20180208215735.GD98765@bhelgaas-glaptop.roam.corp.google.com>
 <5e54c525-1b78-bef3-7f83-82eb872837da@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5e54c525-1b78-bef3-7f83-82eb872837da@ti.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 09, 2018 at 06:14:49PM +0530, Kishon Vijay Abraham I wrote:
> Hi Bjorn,
> 
> On Friday 09 February 2018 03:27 AM, Bjorn Helgaas wrote:
> > On Thu, Feb 08, 2018 at 06:17:32PM +0530, Kishon Vijay Abraham I wrote:
> >> Hi,
> >>
> >> On Thursday 08 February 2018 06:03 PM, Niklas Cassel wrote:
> >>> A 64-bit BAR uses the succeeding BAR for the upper bits, therefore
> >>> we cannot call pci_epc_set_bar() on a BAR that follows a 64-bit BAR.
> >>>
> >>> If pci_epc_set_bar() is called with flag PCI_BASE_ADDRESS_MEM_TYPE_64,
> >>
> >> Not related to $patch. But I have a query on when
> >> PCI_BASE_ADDRESS_MEM_TYPE_64 should be set. Whether if the size is >
> >> 4G or if the address can be mapped anywhere in the 64-bit PCIe
> >> address space or both?
> > 
> > In general, PCI_BASE_ADDRESS_MEM_TYPE_64 should be set if the BAR is
> > 64 bits wide.  IORESOURCE_MEM_64 is similar.
> 
> okay, if the HW support 64bit BAR, 64 bit flag should be set and not based on
> size or anything else?

Yes, I completely agree with Bjorn. Actually it would be a good idea to
make the struct pci_epf->bar member array an array of struct resources
to simplify its handling.

Thanks,
Lorenzo
