Return-Path: <SRS0=PSQI=FU=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=PSQI=FU=h08.hostsharing.net=foo00@kernel.org>
Date: Mon, 26 Feb 2018 13:22:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Linux PM <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Peter Wu <peter@lekensteyn.nl>, Qipeng Zha <qipeng.zha@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Subject: Re: [PATCH v1 2/2] PCI: Allow user to request power management of
 conventional and hotplug bridges
Message-ID: <20180226122243.GA25450@wunner.de>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com>
 <20180220181554.GA32228@bhelgaas-glaptop.roam.corp.google.com>
 <20180222131834.GA5527@wunner.de>
 <20180226120534.GO27191@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180226120534.GO27191@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 26, 2018 at 02:05:34PM +0200, Mika Westerberg wrote:
> On Thu, Feb 22, 2018 at 02:18:34PM +0100, Lukas Wunner wrote:
> > We do need runtime PM on hotplug ports to power off Thunderbolt
> > controllers when nothing is plugged in.  That saves 1.5 W, so a
> > noticeable amount of power.  I was going to respin the series one
> > of these days, I think the best I can do is continue to forbid
> > runtime PM on hotplug ports by default, but whitelist it for
> > Thunderbolt and allow manually enabling it on other platforms via
> > the command line.  That way, vendors are put in a position to
> > validate their platforms for runtime PM of hotplug ports, and
> > perhaps someday we can enable it for all platforms by default,
> > but with a BIOS cut-off date.
> 
> AFAIK Windows started to enable runtime PM (RTD3) for native PCIe
> hotplug ports with the latest release (I guess it's the RS3 release) but
> only when there is a special ACPI _DSD property ("HotPlugSupportInD3")
> associated with the root port. I think we can take advantage of that in
> Linux as well and I already have a patch series to enable runtime PM for
> such ports but I haven't been able to test it properly yet.

Okay.  Well it would be trivial to whitelist those ports with
device_property_present("HotPlugSupportInD3").  In how far are
your patches identical with the patches I submitted last May?
I've started reworking them for v2 but that would be a waste of
time if you're working on this issue in parallel.

Thanks,

Lukas
