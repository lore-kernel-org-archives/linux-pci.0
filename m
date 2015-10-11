Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 11 Oct 2015 11:49:01 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Romain Bezut <rbezut@gmail.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] PCI/MSI: Export all remapped MSIs to sysfs attributes
In-Reply-To: <20151009223315.GC16112@localhost>
Message-ID: <alpine.DEB.2.11.1510111148340.6097@nanos>
References: <1443051076-27716-1-git-send-email-rbezut@gmail.com> <20151009223315.GC16112@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 9 Oct 2015, Bjorn Helgaas wrote:
> On Thu, Sep 24, 2015 at 01:31:16AM +0200, Romain Bezut wrote:
> > irqbalance uses these attributes to populate its internal database, which is
> > then used to bind the irq on the appropriate NUMA node.
> > 
> > On a device accepting multiple MSIs and with interrupt remapping enabled,
> > only the first irq entry is exported to msi_irqs directory.
> > This results in irqbalance having no clue of the NUMA affinity for the extra
> > irqs and starting to bind them on random nodes.
> > 
> > This patch exports all MSI interrupts as sysfs attributes when relevant.
> > 
> > Signed-off-by: Romain Bezut <rbezut@gmail.com>
> 
> This seems like it makes sense to me.  Do you have any bug reports
> related to this problem?  If so, I'll mention them in the changelog.
> 
> Added Neil, Thomas, and linux-kernel since this is of interest to folks
> beyond the usual linux-pci audience.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
