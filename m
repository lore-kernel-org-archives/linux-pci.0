Return-Path: <SRS0=DDPm=ZH=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=DDPm=ZH=linux.intel.com=mika.westerberg@kernel.org>
Date: Wed, 25 Jan 2017 18:31:59 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kilian Singer <kilian.singer@quantumtechnology.info>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170125163159.GZ17297@lahna.fi.intel.com>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <20170117145628.GD22776@bhelgaas-glaptop.roam.corp.google.com>
 <20170123203335.GA4707@bhelgaas-glaptop.roam.corp.google.com>
 <20170123211247.GB17297@lahna.fi.intel.com>
 <20170124200103.GA14743@bhelgaas-glaptop.roam.corp.google.com>
 <20170125094831.GP17297@lahna.fi.intel.com>
 <1006923122.16.1485360329865.JavaMail.zimbra@quantumtechnology.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1006923122.16.1485360329865.JavaMail.zimbra@quantumtechnology.info>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 25, 2017 at 05:05:29PM +0100, Kilian Singer wrote:
> Dear Mika,
> just came back from my lecture. Booted into the new kernel runtime suspend works!
> Thanks for all the support. I really enjoyed working with you all.
> It was very interesting to see how bugs are fixed :)

OK, thanks a lot for your patience :)

So it was 3846fd9b8600 ("drm/probe-helpers: Drop locking from
poll_enable") that actually fixed the issue for Kilian. I hope we do not
need to revert the runtime PM patch anymore ;-)

Thanks for everyone who participated in this.
