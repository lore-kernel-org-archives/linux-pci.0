Return-Path: <SRS0=DZ5F=MB=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=DZ5F=MB=intel.com=keith.busch@kernel.org>
Date: Wed, 19 Sep 2018 14:17:35 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sinan Kaya <okaya@kernel.org>, Thomas Tai <thomas.tai@oracle.com>,
	poza@codeaurora.org, Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv3 01/10] PCI/portdrv: Use subsys_init for service drivers
Message-ID: <20180919201735.GD28310@localhost.localdomain>
References: <20180918235702.26573-1-keith.busch@intel.com>
 <20180918235702.26573-2-keith.busch@intel.com>
 <20180919162846.GB243610@bhelgaas-glaptop.roam.corp.google.com>
 <20180919180003.GC28310@localhost.localdomain>
 <20180919194029.GA261184@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180919194029.GA261184@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 19, 2018 at 02:40:29PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 19, 2018 at 12:00:03PM -0600, Keith Busch wrote:
> > On Wed, Sep 19, 2018 at 11:28:46AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Sep 18, 2018 at 05:56:53PM -0600, Keith Busch wrote:
> > > Since none of the service drivers can be modules, I don't think it
> > > buys us much to make their init functions initcalls.  Can we
> > > explicitly call them from the pcie_portdrv_probe() path?
> > 
> > It's actually during pcie_portdrv_init that the services need to be
> > initialized if we're going this way. Do you think the following is
> > better? The initialization order should be more clear to the reader at
> > the cost of more code than init call magic, but I'm okay having this
> > done either way.
> 
> Yes.  More code, less magic seems like the right tradeoff to me.

Sounds good. Will send a new version of the set using this method, plus
merging up to the current pci/hotplug and the documentation updates.
