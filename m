Return-Path: <SRS0=DZ5F=MB=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=DZ5F=MB=intel.com=keith.busch@kernel.org>
Date: Wed, 19 Sep 2018 09:52:28 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sinan Kaya <okaya@kernel.org>, Thomas Tai <thomas.tai@oracle.com>,
	poza@codeaurora.org, Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv3 05/10] PCI/ERR: Handle fatal error recovery
Message-ID: <20180919155227.GB26372@localhost.localdomain>
References: <20180918235702.26573-1-keith.busch@intel.com>
 <20180918235702.26573-6-keith.busch@intel.com>
 <20180919154651.GA243610@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180919154651.GA243610@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 19, 2018 at 10:46:51AM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 18, 2018 at 05:56:57PM -0600, Keith Busch wrote:
> > We don't need to be paranoid about the topology changing while handling an
> > error. If the device has changed in a hotplug capable slot, we can rely
> > on the presence detection handling to react to a changing topology. This
> > patch restores the fatal error handling behavior that existed before
> > merging DPC with AER with 7e9084b3674 ("PCI/AER: Handle ERR_FATAL with
> > removal and re-enumeration of devices").
> 
> 7e9084b3674 updated Documentation/PCI/pci-error-recovery.txt; doesn't
> this require another update to keep it matching the code?

Indeed, I will fix that.
