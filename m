Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jake Oshins <jakeo@microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: RE: [PATCH 4/4] drivers:pci:hv: New paravirtual PCI front-end for
 Hyper-V VMs
Date: Mon, 3 Aug 2015 19:19:56 +0000
Message-ID: <DM2PR0301MB1232A1E50FA39BEAB5707FEDAB770@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1438476889-19220-1-git-send-email-jakeo@microsoft.com>
 <1438476889-19220-5-git-send-email-jakeo@microsoft.com>
 <alpine.DEB.2.11.1508020948470.3825@nanos>
In-Reply-To: <alpine.DEB.2.11.1508020948470.3825@nanos>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx@linutronix.de]
> Sent: Sunday, August 2, 2015 1:47 AM
> To: Jake Oshins <jakeo@microsoft.com>
> Cc: gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>; LKML
> <linux-kernel@vger.kernel.org>; devel@linuxdriverproject.org;
> olaf@aepfle.de; apw@canonical.com; vkuznets@redhat.com; linux-
> pci@vger.kernel.org; bhelgaas@google.com; x86@kernel.org; Jiang Liu
> <jiang.liu@linux.intel.com>
> Subject: Re: [PATCH 4/4] drivers:pci:hv: New paravirtual PCI front-end for
> Hyper-V VMs
> 

<snip>

> > +static int hv_msi_domain_ops_prepare(struct irq_domain *domain,
> > +				     struct device *dev, int nvec,
> > +				     msi_alloc_info_t *arg)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct msi_desc *desc = first_pci_msi_entry(pdev);
> > +
> > +	memset(arg, 0, sizeof(*arg));
> > +	arg->msi_dev = pdev;
> > +	if (desc->msi_attrib.is_msix) {
> > +		arg->type = X86_IRQ_ALLOC_TYPE_MSIX;
> > +	} else {
> > +		arg->type = X86_IRQ_ALLOC_TYPE_MSI;
> > +		arg->flags |= X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Pretty much a copy of the x86 code, right?
> 
> I wonder whether this MSI infrastructure code would be better
> seperated out and moved to arch/x86/hyperv/msi.c or
> arch/x86/kernel/apic/hvmsi.c. It's small enough to be built in. So all
> you'd need to export is hv_pcie_init_irq_domain and
> hv_pcie_free_irq_domain.
> 
> Thanks,
> 
> 	tglx

Thanks for your review.  I'll respond to all of your feedback and resend.

I do have a question about your last point, though.  If I build this into the kernel, it will need to depend on sending and receiving messages through the hv_vmbus driver, which isn't built in.  It seemed like the indirection and glue code necessary to make that work would be almost as big as this entire implementation (which admittedly isn't very big.)  If you prefer that, I'll do it.  But it would make more sense to me to refactor this a bit more so that functions like the one above are exported rather than putting hv_pcie_init_irq_domain and hv_pcie_free_irq_domain into the kernel itself.  Would that work?

Thanks,
Jake Oshins

