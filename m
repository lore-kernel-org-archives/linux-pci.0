Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:35736 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbdKWALe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 19:11:34 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20171122221337.3877.23362.stgit@bhelgaas-glaptop.roam.corp.google.com>
Date: Wed, 22 Nov 2017 18:11:16 -0600
In-Reply-To: <20171122221337.3877.23362.stgit@bhelgaas-glaptop.roam.corp.google.com>
        (Bjorn Helgaas's message of "Wed, 22 Nov 2017 16:13:37 -0600")
Message-ID: <871skponvf.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v1] PCI: Remove unused HyperTransport interrupt support
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

> From: Bjorn Helgaas <bhelgaas@google.com>
>
> There are no in-tree callers of ht_create_irq(), the driver interface for
> HyperTransport interrupts.  Remove the unused entry point and all the
> supporting code.
>
> See 8b955b0dddb3 ("[PATCH] Initial generic hypertransport interrupt
> support").


This support has been in use until comparatively recently.  But now
that the ipath driver has been removed from the kernel, and apparently
no other native hypertransport cards it does seem reasonable to remove
this support.

6f9b38903c06 ("IB/ipath: Deprecate ipath driver and move to staging.")
b85d9905a7ca ("staging/rdma: remove deprecated ipath driver")

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>


> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/include/asm/hw_irq.h         |    8 -
>  arch/x86/include/asm/hypertransport.h |   46 --------
>  arch/x86/include/asm/irqdomain.h      |    6 -
>  arch/x86/kernel/apic/Makefile         |    1 
>  arch/x86/kernel/apic/htirq.c          |  198 ---------------------------------
>  arch/x86/kernel/apic/vector.c         |    5 -
>  drivers/pci/Kconfig                   |    9 --
>  drivers/pci/Makefile                  |    3 -
>  drivers/pci/htirq.c                   |  135 -----------------------
>  include/linux/htirq.h                 |   39 -------
>  include/linux/pci.h                   |    6 -
>  11 files changed, 2 insertions(+), 454 deletions(-)
>  delete mode 100644 arch/x86/include/asm/hypertransport.h
>  delete mode 100644 arch/x86/kernel/apic/htirq.c
>  delete mode 100644 drivers/pci/htirq.c
>  delete mode 100644 include/linux/htirq.h
>
> diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
> index b80e46733909..2851077b6051 100644
> --- a/arch/x86/include/asm/hw_irq.h
> +++ b/arch/x86/include/asm/hw_irq.h
> @@ -99,14 +99,6 @@ struct irq_alloc_info {
>  			void		*dmar_data;
>  		};
>  #endif
> -#ifdef	CONFIG_HT_IRQ
> -		struct {
> -			int		ht_pos;
> -			int		ht_idx;
> -			struct pci_dev	*ht_dev;
> -			void		*ht_update;
> -		};
> -#endif
>  #ifdef	CONFIG_X86_UV
>  		struct {
>  			int		uv_limit;
> diff --git a/arch/x86/include/asm/hypertransport.h b/arch/x86/include/asm/hypertransport.h
> deleted file mode 100644
> index 5d55df352879..000000000000
> --- a/arch/x86/include/asm/hypertransport.h
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_X86_HYPERTRANSPORT_H
> -#define _ASM_X86_HYPERTRANSPORT_H
> -
> -/*
> - * Constants for x86 Hypertransport Interrupts.
> - */
> -
> -#define HT_IRQ_LOW_BASE			0xf8000000
> -
> -#define HT_IRQ_LOW_VECTOR_SHIFT		16
> -#define HT_IRQ_LOW_VECTOR_MASK		0x00ff0000
> -#define HT_IRQ_LOW_VECTOR(v)						\
> -	(((v) << HT_IRQ_LOW_VECTOR_SHIFT) & HT_IRQ_LOW_VECTOR_MASK)
> -
> -#define HT_IRQ_LOW_DEST_ID_SHIFT	8
> -#define HT_IRQ_LOW_DEST_ID_MASK		0x0000ff00
> -#define HT_IRQ_LOW_DEST_ID(v)						\
> -	(((v) << HT_IRQ_LOW_DEST_ID_SHIFT) & HT_IRQ_LOW_DEST_ID_MASK)
> -
> -#define HT_IRQ_LOW_DM_PHYSICAL		0x0000000
> -#define HT_IRQ_LOW_DM_LOGICAL		0x0000040
> -
> -#define HT_IRQ_LOW_RQEOI_EDGE		0x0000000
> -#define HT_IRQ_LOW_RQEOI_LEVEL		0x0000020
> -
> -
> -#define HT_IRQ_LOW_MT_FIXED		0x0000000
> -#define HT_IRQ_LOW_MT_ARBITRATED	0x0000004
> -#define HT_IRQ_LOW_MT_SMI		0x0000008
> -#define HT_IRQ_LOW_MT_NMI		0x000000c
> -#define HT_IRQ_LOW_MT_INIT		0x0000010
> -#define HT_IRQ_LOW_MT_STARTUP		0x0000014
> -#define HT_IRQ_LOW_MT_EXTINT		0x0000018
> -#define HT_IRQ_LOW_MT_LINT1		0x000008c
> -#define HT_IRQ_LOW_MT_LINT0		0x0000098
> -
> -#define HT_IRQ_LOW_IRQ_MASKED		0x0000001
> -
> -
> -#define HT_IRQ_HIGH_DEST_ID_SHIFT	0
> -#define HT_IRQ_HIGH_DEST_ID_MASK	0x00ffffff
> -#define HT_IRQ_HIGH_DEST_ID(v)						\
> -	((((v) >> 8) << HT_IRQ_HIGH_DEST_ID_SHIFT) & HT_IRQ_HIGH_DEST_ID_MASK)
> -
> -#endif /* _ASM_X86_HYPERTRANSPORT_H */
> diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqdomain.h
> index f695cc6b8e1f..139feef467f7 100644
> --- a/arch/x86/include/asm/irqdomain.h
> +++ b/arch/x86/include/asm/irqdomain.h
> @@ -56,10 +56,4 @@ extern void arch_init_msi_domain(struct irq_domain *domain);
>  static inline void arch_init_msi_domain(struct irq_domain *domain) { }
>  #endif
>  
> -#ifdef CONFIG_HT_IRQ
> -extern void arch_init_htirq_domain(struct irq_domain *domain);
> -#else
> -static inline void arch_init_htirq_domain(struct irq_domain *domain) { }
> -#endif
> -
>  #endif
> diff --git a/arch/x86/kernel/apic/Makefile b/arch/x86/kernel/apic/Makefile
> index a9e08924927e..a6fcaf16cdbf 100644
> --- a/arch/x86/kernel/apic/Makefile
> +++ b/arch/x86/kernel/apic/Makefile
> @@ -12,7 +12,6 @@ obj-y				+= hw_nmi.o
>  
>  obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
>  obj-$(CONFIG_PCI_MSI)		+= msi.o
> -obj-$(CONFIG_HT_IRQ)		+= htirq.o
>  obj-$(CONFIG_SMP)		+= ipi.o
>  
>  ifeq ($(CONFIG_X86_64),y)
> diff --git a/arch/x86/kernel/apic/htirq.c b/arch/x86/kernel/apic/htirq.c
> deleted file mode 100644
> index b07075dce8b7..000000000000
> --- a/arch/x86/kernel/apic/htirq.c
> +++ /dev/null
> @@ -1,198 +0,0 @@
> -/*
> - * Support Hypertransport IRQ
> - *
> - * Copyright (C) 1997, 1998, 1999, 2000, 2009 Ingo Molnar, Hajnalka Szabo
> - *	Moved from arch/x86/kernel/apic/io_apic.c.
> - * Jiang Liu <jiang.liu@linux.intel.com>
> - *	Add support of hierarchical irqdomain
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <linux/mm.h>
> -#include <linux/interrupt.h>
> -#include <linux/init.h>
> -#include <linux/device.h>
> -#include <linux/pci.h>
> -#include <linux/htirq.h>
> -#include <asm/irqdomain.h>
> -#include <asm/hw_irq.h>
> -#include <asm/apic.h>
> -#include <asm/hypertransport.h>
> -
> -static struct irq_domain *htirq_domain;
> -
> -/*
> - * Hypertransport interrupt support
> - */
> -static int
> -ht_set_affinity(struct irq_data *data, const struct cpumask *mask, bool force)
> -{
> -	struct irq_data *parent = data->parent_data;
> -	int ret;
> -
> -	ret = parent->chip->irq_set_affinity(parent, mask, force);
> -	if (ret >= 0) {
> -		struct ht_irq_msg msg;
> -		struct irq_cfg *cfg = irqd_cfg(data);
> -
> -		fetch_ht_irq_msg(data->irq, &msg);
> -		msg.address_lo &= ~(HT_IRQ_LOW_VECTOR_MASK |
> -				    HT_IRQ_LOW_DEST_ID_MASK);
> -		msg.address_lo |= HT_IRQ_LOW_VECTOR(cfg->vector) |
> -				  HT_IRQ_LOW_DEST_ID(cfg->dest_apicid);
> -		msg.address_hi &= ~(HT_IRQ_HIGH_DEST_ID_MASK);
> -		msg.address_hi |= HT_IRQ_HIGH_DEST_ID(cfg->dest_apicid);
> -		write_ht_irq_msg(data->irq, &msg);
> -	}
> -
> -	return ret;
> -}
> -
> -static struct irq_chip ht_irq_chip = {
> -	.name			= "PCI-HT",
> -	.irq_mask		= mask_ht_irq,
> -	.irq_unmask		= unmask_ht_irq,
> -	.irq_ack		= irq_chip_ack_parent,
> -	.irq_set_affinity	= ht_set_affinity,
> -	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> -	.flags			= IRQCHIP_SKIP_SET_WAKE,
> -};
> -
> -static int htirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> -			      unsigned int nr_irqs, void *arg)
> -{
> -	struct ht_irq_cfg *ht_cfg;
> -	struct irq_alloc_info *info = arg;
> -	struct pci_dev *dev;
> -	irq_hw_number_t hwirq;
> -	int ret;
> -
> -	if (nr_irqs > 1 || !info)
> -		return -EINVAL;
> -
> -	dev = info->ht_dev;
> -	hwirq = (info->ht_idx & 0xFF) |
> -		PCI_DEVID(dev->bus->number, dev->devfn) << 8 |
> -		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 24;
> -	if (irq_find_mapping(domain, hwirq) > 0)
> -		return -EEXIST;
> -
> -	ht_cfg = kmalloc(sizeof(*ht_cfg), GFP_KERNEL);
> -	if (!ht_cfg)
> -		return -ENOMEM;
> -
> -	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, info);
> -	if (ret < 0) {
> -		kfree(ht_cfg);
> -		return ret;
> -	}
> -
> -	/* Initialize msg to a value that will never match the first write. */
> -	ht_cfg->msg.address_lo = 0xffffffff;
> -	ht_cfg->msg.address_hi = 0xffffffff;
> -	ht_cfg->dev = info->ht_dev;
> -	ht_cfg->update = info->ht_update;
> -	ht_cfg->pos = info->ht_pos;
> -	ht_cfg->idx = 0x10 + (info->ht_idx * 2);
> -	irq_domain_set_info(domain, virq, hwirq, &ht_irq_chip, ht_cfg,
> -			    handle_edge_irq, ht_cfg, "edge");
> -
> -	return 0;
> -}
> -
> -static void htirq_domain_free(struct irq_domain *domain, unsigned int virq,
> -			      unsigned int nr_irqs)
> -{
> -	struct irq_data *irq_data = irq_domain_get_irq_data(domain, virq);
> -
> -	BUG_ON(nr_irqs != 1);
> -	kfree(irq_data->chip_data);
> -	irq_domain_free_irqs_top(domain, virq, nr_irqs);
> -}
> -
> -static int htirq_domain_activate(struct irq_domain *domain,
> -				 struct irq_data *irq_data, bool early)
> -{
> -	struct ht_irq_msg msg;
> -	struct irq_cfg *cfg = irqd_cfg(irq_data);
> -
> -	msg.address_hi = HT_IRQ_HIGH_DEST_ID(cfg->dest_apicid);
> -	msg.address_lo =
> -		HT_IRQ_LOW_BASE |
> -		HT_IRQ_LOW_DEST_ID(cfg->dest_apicid) |
> -		HT_IRQ_LOW_VECTOR(cfg->vector) |
> -		((apic->irq_dest_mode == 0) ?
> -			HT_IRQ_LOW_DM_PHYSICAL :
> -			HT_IRQ_LOW_DM_LOGICAL) |
> -		HT_IRQ_LOW_RQEOI_EDGE |
> -		((apic->irq_delivery_mode != dest_LowestPrio) ?
> -			HT_IRQ_LOW_MT_FIXED :
> -			HT_IRQ_LOW_MT_ARBITRATED) |
> -		HT_IRQ_LOW_IRQ_MASKED;
> -	write_ht_irq_msg(irq_data->irq, &msg);
> -	return 0;
> -}
> -
> -static void htirq_domain_deactivate(struct irq_domain *domain,
> -				    struct irq_data *irq_data)
> -{
> -	struct ht_irq_msg msg;
> -
> -	memset(&msg, 0, sizeof(msg));
> -	write_ht_irq_msg(irq_data->irq, &msg);
> -}
> -
> -static const struct irq_domain_ops htirq_domain_ops = {
> -	.alloc		= htirq_domain_alloc,
> -	.free		= htirq_domain_free,
> -	.activate	= htirq_domain_activate,
> -	.deactivate	= htirq_domain_deactivate,
> -};
> -
> -void __init arch_init_htirq_domain(struct irq_domain *parent)
> -{
> -	struct fwnode_handle *fn;
> -
> -	if (disable_apic)
> -		return;
> -
> -	fn = irq_domain_alloc_named_fwnode("PCI-HT");
> -	if (!fn)
> -		goto warn;
> -
> -	htirq_domain = irq_domain_create_tree(fn, &htirq_domain_ops, NULL);
> -	irq_domain_free_fwnode(fn);
> -	if (!htirq_domain)
> -		goto warn;
> -
> -	htirq_domain->parent = parent;
> -	return;
> -
> -warn:
> -	pr_warn("Failed to initialize irqdomain for HTIRQ.\n");
> -}
> -
> -int arch_setup_ht_irq(int idx, int pos, struct pci_dev *dev,
> -		      ht_irq_update_t *update)
> -{
> -	struct irq_alloc_info info;
> -
> -	if (!htirq_domain)
> -		return -ENOSYS;
> -
> -	init_irq_alloc_info(&info, NULL);
> -	info.ht_idx = idx;
> -	info.ht_pos = pos;
> -	info.ht_dev = dev;
> -	info.ht_update = update;
> -
> -	return irq_domain_alloc_irqs(htirq_domain, 1, dev_to_node(&dev->dev),
> -				     &info);
> -}
> -
> -void arch_teardown_ht_irq(unsigned int irq)
> -{
> -	irq_domain_free_irqs(irq, 1);
> -}
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index 05c85e693a5d..6a823a25eaff 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -1,5 +1,5 @@
>  /*
> - * Local APIC related interfaces to support IOAPIC, MSI, HT_IRQ etc.
> + * Local APIC related interfaces to support IOAPIC, MSI, etc.
>   *
>   * Copyright (C) 1997, 1998, 1999, 2000, 2009 Ingo Molnar, Hajnalka Szabo
>   *	Moved from arch/x86/kernel/apic/io_apic.c.
> @@ -601,7 +601,7 @@ int __init arch_probe_nr_irqs(void)
>  		nr_irqs = NR_VECTORS * nr_cpu_ids;
>  
>  	nr = (gsi_top + nr_legacy_irqs()) + 8 * nr_cpu_ids;
> -#if defined(CONFIG_PCI_MSI) || defined(CONFIG_HT_IRQ)
> +#if defined(CONFIG_PCI_MSI)
>  	/*
>  	 * for MSI and HT dyn irq
>  	 */
> @@ -663,7 +663,6 @@ int __init arch_early_irq_init(void)
>  	irq_set_default_host(x86_vector_domain);
>  
>  	arch_init_msi_domain(x86_vector_domain);
> -	arch_init_htirq_domain(x86_vector_domain);
>  
>  	BUG_ON(!alloc_cpumask_var(&vector_searchmask, GFP_KERNEL));
>  
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 90944667ccea..bda151788f3f 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -80,15 +80,6 @@ config XEN_PCIDEV_FRONTEND
>            The PCI device frontend driver allows the kernel to import arbitrary
>            PCI devices from a PCI backend to support PCI driver domains.
>  
> -config HT_IRQ
> -	bool "Interrupts on hypertransport devices"
> -	default y
> -	depends on PCI && X86_LOCAL_APIC
> -	help
> -	   This allows native hypertransport devices to use interrupts.
> -
> -	   If unsure say Y.
> -
>  config PCI_ATS
>  	bool
>  
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 3d5e047f0a32..c7819b973df7 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -21,9 +21,6 @@ obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
>  # Build the PCI MSI interrupt support
>  obj-$(CONFIG_PCI_MSI) += msi.o
>  
> -# Build the Hypertransport interrupt support
> -obj-$(CONFIG_HT_IRQ) += htirq.o
> -
>  obj-$(CONFIG_PCI_ATS) += ats.o
>  obj-$(CONFIG_PCI_IOV) += iov.o
>  
> diff --git a/drivers/pci/htirq.c b/drivers/pci/htirq.c
> deleted file mode 100644
> index bb88c26f5144..000000000000
> --- a/drivers/pci/htirq.c
> +++ /dev/null
> @@ -1,135 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * File:	htirq.c
> - * Purpose:	Hypertransport Interrupt Capability
> - *
> - * Copyright (C) 2006 Linux Networx
> - * Copyright (C) Eric Biederman <ebiederman@lnxi.com>
> - */
> -
> -#include <linux/irq.h>
> -#include <linux/pci.h>
> -#include <linux/spinlock.h>
> -#include <linux/export.h>
> -#include <linux/slab.h>
> -#include <linux/htirq.h>
> -
> -/* Global ht irq lock.
> - *
> - * This is needed to serialize access to the data port in hypertransport
> - * irq capability.
> - *
> - * With multiple simultaneous hypertransport irq devices it might pay
> - * to make this more fine grained.  But start with simple, stupid, and correct.
> - */
> -static DEFINE_SPINLOCK(ht_irq_lock);
> -
> -void write_ht_irq_msg(unsigned int irq, struct ht_irq_msg *msg)
> -{
> -	struct ht_irq_cfg *cfg = irq_get_handler_data(irq);
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&ht_irq_lock, flags);
> -	if (cfg->msg.address_lo != msg->address_lo) {
> -		pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx);
> -		pci_write_config_dword(cfg->dev, cfg->pos + 4, msg->address_lo);
> -	}
> -	if (cfg->msg.address_hi != msg->address_hi) {
> -		pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx + 1);
> -		pci_write_config_dword(cfg->dev, cfg->pos + 4, msg->address_hi);
> -	}
> -	if (cfg->update)
> -		cfg->update(cfg->dev, irq, msg);
> -	spin_unlock_irqrestore(&ht_irq_lock, flags);
> -	cfg->msg = *msg;
> -}
> -
> -void fetch_ht_irq_msg(unsigned int irq, struct ht_irq_msg *msg)
> -{
> -	struct ht_irq_cfg *cfg = irq_get_handler_data(irq);
> -
> -	*msg = cfg->msg;
> -}
> -
> -void mask_ht_irq(struct irq_data *data)
> -{
> -	struct ht_irq_cfg *cfg = irq_data_get_irq_handler_data(data);
> -	struct ht_irq_msg msg = cfg->msg;
> -
> -	msg.address_lo |= 1;
> -	write_ht_irq_msg(data->irq, &msg);
> -}
> -
> -void unmask_ht_irq(struct irq_data *data)
> -{
> -	struct ht_irq_cfg *cfg = irq_data_get_irq_handler_data(data);
> -	struct ht_irq_msg msg = cfg->msg;
> -
> -	msg.address_lo &= ~1;
> -	write_ht_irq_msg(data->irq, &msg);
> -}
> -
> -/**
> - * __ht_create_irq - create an irq and attach it to a device.
> - * @dev: The hypertransport device to find the irq capability on.
> - * @idx: Which of the possible irqs to attach to.
> - * @update: Function to be called when changing the htirq message
> - *
> - * The irq number of the new irq or a negative error value is returned.
> - */
> -int __ht_create_irq(struct pci_dev *dev, int idx, ht_irq_update_t *update)
> -{
> -	int max_irq, pos, irq;
> -	unsigned long flags;
> -	u32 data;
> -
> -	pos = pci_find_ht_capability(dev, HT_CAPTYPE_IRQ);
> -	if (!pos)
> -		return -EINVAL;
> -
> -	/* Verify the idx I want to use is in range */
> -	spin_lock_irqsave(&ht_irq_lock, flags);
> -	pci_write_config_byte(dev, pos + 2, 1);
> -	pci_read_config_dword(dev, pos + 4, &data);
> -	spin_unlock_irqrestore(&ht_irq_lock, flags);
> -
> -	max_irq = (data >> 16) & 0xff;
> -	if (idx > max_irq)
> -		return -EINVAL;
> -
> -	irq = arch_setup_ht_irq(idx, pos, dev, update);
> -	if (irq > 0)
> -		dev_dbg(&dev->dev, "irq %d for HT\n", irq);
> -
> -	return irq;
> -}
> -EXPORT_SYMBOL(__ht_create_irq);
> -
> -/**
> - * ht_create_irq - create an irq and attach it to a device.
> - * @dev: The hypertransport device to find the irq capability on.
> - * @idx: Which of the possible irqs to attach to.
> - *
> - * ht_create_irq needs to be called for all hypertransport devices
> - * that generate irqs.
> - *
> - * The irq number of the new irq or a negative error value is returned.
> - */
> -int ht_create_irq(struct pci_dev *dev, int idx)
> -{
> -	return __ht_create_irq(dev, idx, NULL);
> -}
> -EXPORT_SYMBOL(ht_create_irq);
> -
> -/**
> - * ht_destroy_irq - destroy an irq created with ht_create_irq
> - * @irq: irq to be destroyed
> - *
> - * This reverses ht_create_irq removing the specified irq from
> - * existence.  The irq should be free before this happens.
> - */
> -void ht_destroy_irq(unsigned int irq)
> -{
> -	arch_teardown_ht_irq(irq);
> -}
> -EXPORT_SYMBOL(ht_destroy_irq);
> diff --git a/include/linux/htirq.h b/include/linux/htirq.h
> deleted file mode 100644
> index 127c39d815ba..000000000000
> --- a/include/linux/htirq.h
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef LINUX_HTIRQ_H
> -#define LINUX_HTIRQ_H
> -
> -struct pci_dev;
> -struct irq_data;
> -
> -struct ht_irq_msg {
> -	u32	address_lo;	/* low 32 bits of the ht irq message */
> -	u32	address_hi;	/* high 32 bits of the it irq message */
> -};
> -
> -typedef void (ht_irq_update_t)(struct pci_dev *dev, int irq,
> -			       struct ht_irq_msg *msg);
> -
> -struct ht_irq_cfg {
> -	struct pci_dev *dev;
> -	 /* Update callback used to cope with buggy hardware */
> -	ht_irq_update_t *update;
> -	unsigned pos;
> -	unsigned idx;
> -	struct ht_irq_msg msg;
> -};
> -
> -/* Helper functions.. */
> -void fetch_ht_irq_msg(unsigned int irq, struct ht_irq_msg *msg);
> -void write_ht_irq_msg(unsigned int irq, struct ht_irq_msg *msg);
> -void mask_ht_irq(struct irq_data *data);
> -void unmask_ht_irq(struct irq_data *data);
> -
> -/* The arch hook for getting things started */
> -int arch_setup_ht_irq(int idx, int pos, struct pci_dev *dev,
> -		      ht_irq_update_t *update);
> -void arch_teardown_ht_irq(unsigned int irq);
> -
> -/* For drivers of buggy hardware */
> -int __ht_create_irq(struct pci_dev *dev, int idx, ht_irq_update_t *update);
> -
> -#endif /* LINUX_HTIRQ_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c40702be1687..0fd50aee59a9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1472,12 +1472,6 @@ static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
>  static inline void pcie_ecrc_get_policy(char *str) { }
>  #endif
>  
> -#ifdef CONFIG_HT_IRQ
> -/* The functions a driver should call */
> -int ht_create_irq(struct pci_dev *dev, int idx);
> -void ht_destroy_irq(unsigned int irq);
> -#endif /* CONFIG_HT_IRQ */
> -
>  #ifdef CONFIG_PCI_ATS
>  /* Address Translation Service */
>  void pci_ats_init(struct pci_dev *dev);
