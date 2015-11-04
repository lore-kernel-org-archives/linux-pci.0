Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50173 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932365AbbKDPPh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 10:15:37 -0500
Date: Wed, 4 Nov 2015 16:14:50 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Keith Busch <keith.busch@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCHv3 3/4] x86/pci: Initial commit for new VMD device
 driver
In-Reply-To: <20151104144905.GI13904@localhost.localdomain>
Message-ID: <alpine.DEB.2.11.1511041614070.4032@nanos>
References: <1445967247-24310-1-git-send-email-keith.busch@intel.com> <1445967247-24310-4-git-send-email-keith.busch@intel.com> <alpine.DEB.2.11.1511021426020.4032@nanos> <20151103001552.GE13904@localhost.localdomain> <alpine.DEB.2.11.1511031001130.4032@nanos>
 <20151104144905.GI13904@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 4 Nov 2015, Keith Busch wrote:

> On Tue, Nov 03, 2015 at 12:42:02PM +0100, Thomas Gleixner wrote:
> > On Tue, 3 Nov 2015, Keith Busch wrote:
> > > > > +	msi_irqdomain = pci_msi_create_irq_domain(NULL, &pci_chained_msi_domain_info,
> > > > > +						  vmd_irqdomain);
> > 
> > But that parent limitation does not matter simply because your
> > msi_irqdomain does not follow down the hierarchy in the allocation
> > path.
> > 
> > So we can avoid the vmd_irqdomain creation completely. It's just
> > wasting memory and has no value at all. Creating the msi domain with a
> > NULL parent is possible.
> 
> I'm having trouble following the hierarchy and didn't understand the
> connection between the parent and msi comain. It's still new to me,
> but I don't think a NULL parent is allowable with msi domains:
> 
>  pci_msi_setup_msi_irqs()
>   pci_msi_domain_alloc_irqs()
>    msi_domain_alloc_irqs()
>     __irq_domain_alloc_irqs()
>      irq_domain_alloc_irqs_recursive()
>       msi_domain_alloc()
>        irq_domain_alloc_irqs_parent()
> 
> The last call returns -ENOSYS since there parent is NULL. Was the
> intension to allow no parent, or do I still need to allocate one to
> achieve the desired chaining?

Hmm, seems I missed that part. But that's a fixable problem. Jiang?

Thanks,

	tglx
 
