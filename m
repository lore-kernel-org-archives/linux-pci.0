Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Mon, 30 May 2016 17:44:45 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	Peter Wu <peter@lekensteyn.nl>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH] PCI: Wait for 50ms after bridge is powered up
Message-ID: <20160530144445.GC1743@lahna.fi.intel.com>
References: <20160524162833.GA30762@localhost>
 <20160526104557.GA6816@wunner.de>
 <20160526110308.GX1789@lahna.fi.intel.com>
 <1576190.gfFb6HhZV6@vostro.rjw.lan>
 <20160530093326.GH1789@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160530093326.GH1789@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 12:33:26PM +0300, Mika Westerberg wrote:
> I also learned that both of these can be shortened with following
> mechanisms:
> 
>  - PCIe readines notifications (6.23 in PCIe spec 3.1a)
>  - ACPI _DSM method returning readines durations from  (4.6.9 in PCI
>    firmware spec 3.2).

BTW, looks like the latter is already implemented in
pci_acpi_optimize_delay().
