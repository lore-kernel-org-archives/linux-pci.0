Return-Path: <SRS0=m3Xz=GZ=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=m3Xz=GZ=linutronix.de=tglx@kernel.org>
Date: Wed, 4 Apr 2018 10:13:32 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Keith Busch <keith.busch@intel.com>, Linux PCI <linux-pci@vger.kernel.org>,
    Bjorn Helgaas <bhelgaas@google.com>, Oza Pawandeep <poza@codeaurora.org>,
    Sinan Kaya <okaya@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCHv2 2/7] PCI/DPC: Fix PCI legacy interrupt
 acknowledgement
In-Reply-To: <20180403230405.GP9322@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.21.1804041002550.2056@nanos.tec.linutronix.de>
References: <20180402162203.3370-1-keith.busch@intel.com> <20180402162203.3370-3-keith.busch@intel.com> <20180403203847.GO9322@bhelgaas-glaptop.roam.corp.google.com> <20180403230405.GP9322@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Tue, 3 Apr 2018, Bjorn Helgaas wrote:

> [+cc Thomas, Rafael for real]
> On Tue, Apr 03, 2018 at 03:38:47PM -0500, Bjorn Helgaas wrote:
> > [+cc Thomas, Rafael]
> > 
> > On Mon, Apr 02, 2018 at 10:21:58AM -0600, Keith Busch wrote:
> > > From: Oza Pawandeep <poza@codeaurora.org>
> > > 
> > > The DPC driver was acknowledging the DPC interrupt status in deferred
> > > work. That works for edge triggered interrupts, but causes an interrupt
> > > storm with level triggered legacy interrupts.

The problem is homebrewn in the driver. So, yes it needs to mask the
interrupt before returning from the irq handler if the rest of the magic is
done in a worker.

Though this could have been avoided if the driver simply would have used a
threaded interrupt. The core handles that correctly for any type of
interrupts, edge/level. The logic there is:

      low_level_handler()
	   if (level)
	   	irq_mask();
	   primary_handler();
	   wake_thread();
	   if (level && !thread_pending)
	   	irq_unmask();

and the thread handler does

      thread_handler()
      	   thread_handler_function();
	   if (!thread_pending && masked && !disabled)
	   	irq_unmask();

There is a reason why threaded interrupt handlers exist....

Thanks,

	tglx
