Return-Path: <SRS0=8/kT=ZT=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=8/kT=ZT=wunner.de=lukas@kernel.org>
Date: Mon, 6 Feb 2017 07:09:53 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/8] PCI: Recognize Thunderbolt devices
Message-ID: <20170206060953.GB557@wunner.de>
References: <cover.1484486499.git.lukas@wunner.de>
 <bfabf33fc63abbeb84e11e544456098dff0e4604.1484486499.git.lukas@wunner.de>
 <20170128215208.GM20550@bhelgaas-glaptop.roam.corp.google.com>
 <20170129002616.GA28225@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170129002616.GA28225@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 29, 2017 at 01:26:16AM +0100, Lukas Wunner wrote:
> On Sat, Jan 28, 2017 at 03:52:08PM -0600, Bjorn Helgaas wrote:
> > On Sun, Jan 15, 2017 at 09:03:45PM +0100, Lukas Wunner wrote:
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -1206,6 +1206,37 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
> > >  		pdev->is_hotplug_bridge = 1;
> > >  }
> > >  
> > > +static void set_pcie_vendor_specific(struct pci_dev *dev)
> > 
> > This is very specific to Thunderbolt, so let's name it something that
> > conveys that information.  The fact that we use a vendor-specific
> > capability to figure it out isn't really relevant in the caller.
> 
> I thought that we may have the necessity in the future to parse other
> VSECs on device probe, so I gave the function this generic name.
> 
> Think about it, every VSEC that needs to be parsed needs the while loop
> below.  It's more efficient to have only a single while loop that handles
> *all* VSECs at once.
> 
> If someone needs to parse another VSEC, they just add it to this function.
> So IMO the way I've solved it is preferable to just adding a Thunderbolt-
> specific function.
> 
> Are you sure you want this renamed? (y/n)

Bjorn, I'm taking the liberty to send a gentle ping already after a week:
Could you give me a quick yes or no for the above question so that I get
a chance to submit a rectified version of this patch before the merge
window opens?

Thanks!

Lukas
