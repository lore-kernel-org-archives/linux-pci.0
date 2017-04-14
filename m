Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 14 Apr 2017 09:46:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] PCI/irq: add pci_request_irq and pci_free_irq helpers
Message-ID: <20170414144649.GC29349@bhelgaas-glaptop.roam.corp.google.com>
References: <20170413070643.32165-1-hch@lst.de>
 <20170413070643.32165-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170413070643.32165-4-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 13, 2017 at 09:06:42AM +0200, Christoph Hellwig wrote:
> These are small wrappers around request_threaded_irq and free_irq,
> which dynamically allocate space for the device name so that drivers
> don't need to keep static buffers for these around.  Additionally it
> works with device-relative vector numbers to make the usage easier,
> and force the IRQF_SHARED flag on given that it has no runtime overhead
> and should be supported by all PCI devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Let me know if you'd like me to take this series (given an appropriate
ack for the genirq parts).

> ---
>  drivers/pci/irq.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/pci.h |  6 ++++++
>  2 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
> index 6684f153ab57..53e7f30d9461 100644
> --- a/drivers/pci/irq.c
> +++ b/drivers/pci/irq.c
> @@ -1,7 +1,8 @@
>  /*
> - * PCI IRQ failure handing code
> + * PCI IRQ handing code
>   *
>   * Copyright (c) 2008 James Bottomley <James.Bottomley@HansenPartnership.com>
> + * Copyright (C) 2017 Christoph Hellwig.
>   */
>  
>  #include <linux/acpi.h>
> @@ -59,3 +60,61 @@ enum pci_lost_interrupt_reason pci_lost_interrupt(struct pci_dev *pdev)
>  	return PCI_LOST_IRQ_NO_INFORMATION;
>  }
>  EXPORT_SYMBOL(pci_lost_interrupt);
> +
> +/**
> + * pci_request_irq - allocate an interrupt line for a PCI device
> + * @dev:	PCI device to operate on
> + * @nr:		device-relative interrupt vector index (0-based).
> + * @handler:	Function to be called when the IRQ occurs.
> + *		Primary handler for threaded interrupts.
> + *		If NULL and thread_fn != NULL the default primary handler is
> + *		installed.
> + * @thread_fn:	Function called from the irq handler thread
> + *		If NULL, no irq thread is created
> + * @dev_id:	Cookie passed back to the handler function
> + * @fmt:	Printf-like format string naming the handler
> + *
> + * This call allocates interrupt resources and enables the interrupt line and
> + * IRQ handling. From the point this call is made @handler and @thread_fn may
> + * be invoked.  All interrupt requsted using this function might be shared.
> + *
> + * @dev_id must not ne NULL and be globally unique.
> + */
> +int pci_request_irq(struct pci_dev *dev, unsigned int nr, irq_handler_t handler,
> +		irq_handler_t thread_fn, void *dev_id, const char *fmt, ...)
> +{
> +	va_list ap;
> +	int ret;
> +	char *devname;
> +
> +	va_start(ap, fmt);
> +	devname = kvasprintf(GFP_KERNEL, fmt, ap);
> +	va_end(ap);
> +
> +	ret = request_threaded_irq(pci_irq_vector(dev, nr), handler, thread_fn,
> +			IRQF_SHARED, devname, dev_id);
> +	if (ret)
> +		kfree(devname);
> +	return ret;
> +}
> +EXPORT_SYMBOL(pci_request_irq);
> +
> +/**
> + * pci_free_irq - free an interrupt allocated with pci_request_irq
> + * @dev:	PCI device to operate on
> + * @nr:		device-relative interrupt vector index (0-based).
> + * @dev_id:	Device identity to free
> + *
> + * Remove an interrupt handler. The handler is removed and if the interrupt
> + * line is no longer in use by any driver it is disabled.  The caller must
> + * ensure the interrupt is disabled on the device before calling this function.
> + * The function does not return until any executing interrupts for this IRQ
> + * have completed.
> + *
> + * This function must not be called from interrupt context.
> + */
> +void pci_free_irq(struct pci_dev *dev, unsigned int nr, void *dev_id)
> +{
> +	kfree(free_irq(pci_irq_vector(dev, nr), dev_id));
> +}
> +EXPORT_SYMBOL(pci_free_irq);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index eb3da1a04e6c..b23f81b583ab 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -28,6 +28,7 @@
>  #include <linux/kobject.h>
>  #include <linux/atomic.h>
>  #include <linux/device.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/resource_ext.h>
>  #include <uapi/linux/pci.h>
> @@ -1072,6 +1073,11 @@ int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>  bool pci_device_is_present(struct pci_dev *pdev);
>  void pci_ignore_hotplug(struct pci_dev *dev);
>  
> +int __printf(6, 7) pci_request_irq(struct pci_dev *dev, unsigned int nr,
> +		irq_handler_t handler, irq_handler_t thread_fn, void *dev_id,
> +		const char *fmt, ...);
> +void pci_free_irq(struct pci_dev *dev, unsigned int nr, void *dev_id);
> +
>  /* ROM control related routines */
>  int pci_enable_rom(struct pci_dev *pdev);
>  void pci_disable_rom(struct pci_dev *pdev);
> -- 
> 2.11.0
> 
