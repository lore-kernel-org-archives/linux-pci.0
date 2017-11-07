Return-Path: <SRS0=RQ+y=CF=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=RQ+y=CF=linux.intel.com=mika.westerberg@kernel.org>
Date: Tue, 7 Nov 2017 12:33:46 +0200
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
Subject: Re: [PATCH v4] PCI: pciehp: Drop checking of PCI_BRIDGE_CONTROL in
 pciehp_unconfigure_device()
Message-ID: <20171107103346.GR18997@lahna.fi.intel.com>
References: <20171025112940.77890-1-mika.westerberg@linux.intel.com>
 <20171106231409.GI31930@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171106231409.GI31930@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 06, 2017 at 05:14:09PM -0600, Bjorn Helgaas wrote:
> As you mention, shpchp_unconfigure_device() contains the same code; is
> there any reason not to remove it from there as well?

I don't see why we cannot remove that as well. But I have to admit that
I don't know much about conventional PCI hotplug.

> I know you probably can't test shpchp, and neither can I, but it looks
> like it has the same issue, and I don't want to avoid fixing it there
> just for want of testing.

Yeah, I can't test it but no problem removing that code from shpchp as
well. I think it should be a separate patch, though.

> I wish we knew more about why that PCI_BRIDGE_CTL_VGA check was there
> in the first place.  I think it was added by Dely Sy in 2004 [1].
> LinkedIn thinks he's still at Intel; any chance you could ping him and
> see if he has any insight?

I checked from our internal "phone book" and could not find him there,
unfortunately.

> My guess is that it was originally in a
> path that didn't have to worry about surprise unplug.  But I still
> don't know why it would be a problem.

One reason might be that if you do unplug through sysfs and you are
running some graphics console (X) or so, you will suddenly lose access
to the system. However, even in that case you can just ssh to the box
and re-enable the card...
