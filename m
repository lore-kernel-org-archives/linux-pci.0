Return-Path: <SRS0=5FVt=AA=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=5FVt=AA=intel.com=keith.busch@kernel.org>
Date: Wed, 30 Aug 2017 16:23:40 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Derrick, Jonathan" <jonathan.derrick@intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] vmd: Remove IRQ affinity
Message-ID: <20170830202340.GA17331@localhost.localdomain>
References: <1504109704-17033-1-git-send-email-keith.busch@intel.com>
 <20170830164020.GC18250@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170830164020.GC18250@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 30, 2017 at 09:40:20AM -0700, Bjorn Helgaas wrote:
> [+cc Christoph]
> 
> On Wed, Aug 30, 2017 at 12:15:04PM -0400, Keith Busch wrote:
> > VMD hardware has to share its vectors among child devices in its PCI
> > domain so we should allocate as many as possible rather than just ones
> > that can be affinitized.
> 
> I don't understand this changelog.  It suggests that
> pci_alloc_irq_vectors() will allocate more vectors than
> pci_alloc_irq_vectors_affinity() would.
> 
> But my understanding was that pci_alloc_irq_vectors_affinity() does have
> anything to do with the number of vectors allocated, but that it only
> provided more fine-grained control of affinity.
> 
>   commit 402723ad5c62
>   Author: Christoph Hellwig <hch@lst.de>
>   Date:   Tue Nov 8 17:15:05 2016 -0800
> 
>     PCI/MSI: Provide pci_alloc_irq_vectors_affinity()
>     
>     This is a variant of pci_alloc_irq_vectors() that allows passing a struct
>     irq_affinity to provide fine-grained IRQ affinity control.
>     
>     For now this means being able to exclude vectors at the beginning or end of
>     the MSI vector space, but it could also be used for any other quirks needed
>     in the future (e.g. more vectors than CPUs, or excluding CPUs from the
>     spreading).
> 
> So IIUC, this patch does not change the number of vectors allocated.  It
> does remove PCI_IRQ_AFFINITY, which I suppose means all the vectors target
> the same CPU instead of being spread across CPUs.

VMD has to divvy interrupt vectors up among potentially many devices,
so we want to always get the maximum vectors possible.

By default, PCI_IRQ_AFFINITY flag will have 'nvecs' capped by
irq_calc_affinity_vectors, which is the number of present CPUs and
potentially lower than the available vectors.

We could use the struct irq_affinity to define pre/post vectors to be
excluded from affinity consideration so that we can get more vectors
than CPUs, but it would be weird to have some of these general purpose
vectors affinity set by the kernel and others set by the user.
