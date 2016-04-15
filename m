Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 15 Apr 2016 10:08:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org,
	=?utf-8?B?0J7Qu9C10LPQnNC+0YDQvtC3?= <oleg.moroz@mcc.vniiem.ru>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>,
	Rob Groner <rgroner@rtd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH 0/3] v4.4: Revert "PCI: Implement pcibios_alloc_irq() and
Message-ID: <20160415150821.GA7973@localhost>
References: <20160413055439.6877.68183.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160414155044.GB3886@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160414155044.GB3886@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 14, 2016 at 05:50:44PM +0200, Joerg Roedel wrote:
> Hi Bjorn,
> 
> On Wed, Apr 13, 2016 at 12:56:59AM -0500, Bjorn Helgaas wrote:
> > We reverted the following changes from v4.5 to fix a regression:
> > 
> >   8affb487d4a4 ("x86/PCI: Don't alloc pcibios-irq when MSI is enabled")
> >   811a4e6fce09 ("PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed")
> >   991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()")
> 
> Do you have a link to the thread about these issues? I'd like to have a
> look at what has been tried to solve the regressions before the revert.

The revert was 6c777e8799a9 ("Revert "PCI, x86: Implement
pcibios_alloc_irq() and pcibios_free_irq()"").

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=111211
Email discussion: http://lkml.kernel.org/r/56A27E7E.4080609@mcc.vniiem.ru

> I had a look at commit 991de2e59090 and noted that the main difference
> it introduces is that the pcibios-irq is allocated earlier (probe time,
> before the commit it was pci_enable_device() time). In fact, it is now
> allocated before pci_enable_resources() has been called on the device
> (as far as I can see). I wonder if the regression can be fixed by
> also moving pci_enable_resources() to probe time.

I assume you're thinking about doing pci_enable_resources() before
the core calls the driver's probe method?  One question there is how
we would deal with pci_enable_device_mem().  If the core calls
pci_enable_resources(), it has to assume the driver requires all BARs,
and there are quite a few drivers that don't need the I/O BARs.

I'd be very glad if you poked at this a little more.  Jiang did a lot
of nice work on IOAPIC hotplug, and I feel bad reverting this piece of
it.  It's just that nobody so far has had the time or interest to work
out a better fix.

Bjorn
