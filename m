Return-Path: <SRS0=9AXQ=DL=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=9AXQ=DL=arm.com=lorenzo.pieralisi@kernel.org>
Date: Fri, 15 Dec 2017 09:42:55 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <niklas.cassel@axis.com>, linux-pci@vger.kernel.org,
	kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Fix find_first_zero_bit() usage
Message-ID: <20171215094255.GA27435@red-moon>
References: <20171212141634.5985-1-niklas.cassel@axis.com>
 <20171213215925.GJ30595@bhelgaas-glaptop.roam.corp.google.com>
 <20171214133230.GA25307@axis.com>
 <20171214134707.GE27348@e107981-ln.cambridge.arm.com>
 <20171214232138.GO30595@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214232138.GO30595@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 14, 2017 at 05:21:38PM -0600, Bjorn Helgaas wrote:
> On Thu, Dec 14, 2017 at 01:47:07PM +0000, Lorenzo Pieralisi wrote:
> > On Thu, Dec 14, 2017 at 02:32:30PM +0100, Niklas Cassel wrote:
> > > On Wed, Dec 13, 2017 at 03:59:25PM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Dec 12, 2017 at 03:16:31PM +0100, Niklas Cassel wrote:
> > > > > find_first_zero_bit()'s parameter 'size' is defined in bits,
> > > > > not in bytes.
> > > > > 
> > > > > Calling find_first_zero_bit() with the wrong size unit
> > > > > will lead to insidious bugs.
> > > > > 
> > > > > Fix all uses of find_first_zero_bit() called with
> > > > > sizeof() as size argument in drivers/pci.
> > > > > 
> > > > > Also had to fix broken error handling in pci_epc_epf_link()
> > > > > in order to do proper error handling for find_first_zero_bit().
> > > > > 
> > > > > Niklas Cassel (3):
> > > > >   PCI: designware-ep: Fix find_first_zero_bit() usage
> > > > >   PCI: endpoint: Fix error handling in pci_epc_epf_link()
> > > > >   PCI: endpoint: Fix find_first_zero_bit() usage
> > > > > 
> > > > >  drivers/pci/dwc/pcie-designware-ep.c | 34 ++++++++++++++++++++++++++--------
> > > > >  drivers/pci/dwc/pcie-designware.h    |  8 ++++++--
> > > > >  drivers/pci/endpoint/pci-ep-cfs.c    | 13 ++++++++-----
> > > > >  3 files changed, 40 insertions(+), 15 deletions(-)
> > > > 
> > > > In the interest of making forward progress, I applied these to
> > > > for-linus for v4.15.
> > > > 
> > > > The issues apparently have been there since v4.12-rc1, but I guess
> > > > this is proposed for for-linus because (a) it fixes insidious bugs
> > > > and (b) the endpoint framework is relatively little-used yet so
> > > > low-risk.  Right?
> > > > 
> > > 
> > > Hello Bjorn,
> > > 
> > > As far as I know, dra7xx is the only in-tree user of the endpoint
> > > framework. Therefore, I see no real need to rush these patches.
> > > 
> > > One benefit of sending them to v4.15 would be if anyone starts
> > > developing endpoint support for their driver (with v4.15 as a base),
> > > we eliminate the risk that they might get hit by these bugs, and
> > > potentially waste time finding bugs that have already been found.
> > > 
> > > Please note that Kishon had some last minute review comments,
> > > so I had to submit a V5 of the patch series.
> > 
> > I missed this message (please CC me on the cover letter too next time) I
> > hope Bjorn can drop v4 and replace it with v5 - or I can just queue v5
> > for v4.16 - just let me know please how you want to handle it.
> 
> I dropped them from my for-linus tree.  Lorenzo, can you take care of
> v5 for v4.16?

Yes sure, I will queue it straight away.

Thanks,
Lorenzo
