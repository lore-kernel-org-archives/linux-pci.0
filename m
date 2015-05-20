Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 May 2015 09:47:33 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [RFC 2/4] PCI, MSI: Optionally free legacy PCI IRQ when enabling
 MSI/MSI-X
In-Reply-To: <555BFA31.5040206@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505200947140.4225@nanos>
References: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com> <1430968374-29286-3-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505152259480.4225@nanos> <555BFA31.5040206@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 20 May 2015, Jiang Liu wrote:
> On 2015/5/16 5:02, Thomas Gleixner wrote:
> > This is a bit odd. With your proposed change we'll have:
> > 
> >      alloc_legacy_irq()
> > 
> >      msi[x]_enable()
> > 	free_legacy_irq()
> > 
> >      msi[x]_disable()
> > 	alloc_legacy_irq()
> Hi Thomas,
> 	It's for safety. I'm not sure whether the device driver will
> make use of legacy IRQ after calling msi[x]_disable(). I have concerns
> about following pattern in PCI device drivers:
> ---------------------------------------------------
> if (enable_msi() == SUCCESS) {
> 	if (allocate_resource_for_msi() == SUCCESS)
> 		return;
> 	disable_msi();
> }
> use_legacy_irq()

Fair enough.

     tglx
