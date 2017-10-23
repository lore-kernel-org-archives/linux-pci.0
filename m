Return-Path: <SRS0=gpAo=BW=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=gpAo=BW=linux.intel.com=mika.westerberg@kernel.org>
Date: Mon, 23 Oct 2017 14:04:45 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mario.Limonciello@dell.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] PCI: pciehp: Check that the device is really
 present before touching it
Message-ID: <20171023110445.GA29656@lahna.fi.intel.com>
References: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
 <20171013183548.68283-9-mika.westerberg@linux.intel.com>
 <20171020211502.GR6332@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171020211502.GR6332@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 20, 2017 at 04:15:02PM -0500, Bjorn Helgaas wrote:
> > +
> > +		/* Check if the device is really there anymore */
> > +		present = presence ? pci_device_is_present(dev) : false;
> > +
> > +		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE && present) {
> >  			pci_read_config_byte(dev, PCI_BRIDGE_CONTROL, &bctl);
> 
> I don't like this fix because it's still racy.  We always have to be deal
> with a config read that returns 0xffffffff, even if we previously checked
> pci_device_is_present().  The device might have disappeared in the interim.

That's a fair point. I guess it is better just to check if bctl holds
0xffff before we decide it is a display device.

I'll rework this patch and send an updated version separately.
