Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 8 Jul 2015 09:40:53 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [Patch v3 0/4] Introduce a mechanism to allocate PCI IRQ on
 demand
In-Reply-To: <559CD1CF.3030601@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1507080939430.3916@nanos>
References: <1433926501-22956-1-git-send-email-jiang.liu@linux.intel.com> <20150619161001.GJ7710@google.com> <559CD1CF.3030601@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 8 Jul 2015, Jiang Liu wrote:
> On 2015/6/20 0:10, Bjorn Helgaas wrote:
> > On Wed, Jun 10, 2015 at 04:54:57PM +0800, Jiang Liu wrote:
> >> Hi Bjorn,
> >> 	I have verified that this patch set could be applied to the
> >> mainstream kernel without dependency on other patches, so could you
> >> please help to merge it?
> > 
> > I already acked these and said I was willing to merge them and that I was
> > hoping for an ack from Thomas.
> > 
> > Any thoughts, Thomas?
> 
> Hi Thomas,
> 	Any comments about this bugfix series?

How is these a bugfix series? It looks like preparation for ioapic
hotplug.

But other than that, Acked-by-me.

