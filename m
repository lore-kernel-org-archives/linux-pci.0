Return-Path: <SRS0=5FVt=AA=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=5FVt=AA=intel.com=keith.busch@kernel.org>
Date: Wed, 30 Aug 2017 17:50:02 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Derrick, Jonathan" <jonathan.derrick@intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] vmd: Remove IRQ affinity
Message-ID: <20170830215002.GB17331@localhost.localdomain>
References: <1504109704-17033-1-git-send-email-keith.busch@intel.com>
 <20170830164020.GC18250@bhelgaas-glaptop.roam.corp.google.com>
 <20170830202340.GA17331@localhost.localdomain>
 <20170830214139.GY8154@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170830214139.GY8154@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 30, 2017 at 04:41:39PM -0500, Bjorn Helgaas wrote:
> I added some breadcrumbs to the changelog about this connection
> between affinity and limiting the number of IRQs.  Did I get this
> right?
> 
> This is on pci/host-vmd for v4.14.

Awesome, sounds good to me! 
 
> commit be85af02e1b00d49cd678d8f2ea6f391bdbaca19
> Author: Keith Busch <keith.busch@intel.com>
> Date:   Wed Aug 30 12:15:04 2017 -0400
> 
>     PCI: vmd: Remove IRQ affinity so we can allocate more IRQs
>     
>     VMD hardware has to share its vectors among child devices in its PCI
>     domain so we should allocate as many as possible rather than just ones
>     that can be affinitized.
>     
>     pci_alloc_irq_vectors_affinity() limits the number of affinitized IRQs to
>     the number of present CPUs (see irq_calc_affinity_vectors()).  But we'd
>     prefer to have more vectors, even if they aren't distributed across the
>     CPUs, so use pci_alloc_irq_vectors() instead.
>     
>     Reported-by: Brad Goodman <Bradley.Goodman@dell.com>
>     Signed-off-by: Keith Busch <keith.busch@intel.com>
>     [bhelgaas: add irq_calc_affinity_vectors() reference to changelog]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
