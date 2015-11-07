Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35176 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbbKGL4k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Nov 2015 06:56:40 -0500
Date: Sat, 7 Nov 2015 12:55:54 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Keith Busch <keith.busch@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv4 5/6] x86/pci: Initial commit for new VMD device
 driver
In-Reply-To: <1446849346-8242-6-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.DEB.2.11.1511071243530.4032@nanos>
References: <1446849346-8242-1-git-send-email-keith.busch@intel.com> <1446849346-8242-6-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Keith,

On Fri, 6 Nov 2015, Keith Busch wrote:
> +
> +static DEFINE_SPINLOCK(list_lock);

Can you please make that DEFINE_RAW_SPINLOCK as it nests into the irq
descriptor lock.

> +
> +struct vmd_irq {
> +	struct list_head	node;
> +	struct rcu_head		rcu;	/* rcu callback list */
> +	struct vmd_irq_list	*irq;	/* back pointer */

Please use KernelDoc style documentation if you want to document your
data structures.

> +/**
> + * XXX: Stubbed until a good way to not create conflicts with other devices
> + * sharing the same vector is developed.
> + */
> +static int vmd_irq_set_affinity(struct irq_data *data, const struct cpumask *dest,
> +								bool force)
> +{
> +	return -EINVAL;
> +}

Well, this is a hard problem for shared vectors. The question is
whether we really want to expose that at the per device level or
rather at the demultiplexing level.

> +static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd)
> +{
> +	int i, best = 0;
> +
> +	spin_lock(&list_lock);
> +	for (i = 1; i < vmd->msix_count; i++)
> +		if (vmd->irqs[i].count < vmd->irqs[best].count)
> +			best = i;
> +	vmd->irqs[best].count++;
> +	spin_unlock(&list_lock);
> +
> +	return &vmd->irqs[best];

That looks smarter. Though we might need some more complex way to do
that when interrupt affinity comes into play.

> +static irqreturn_t vmd_irq(int irq, void *data)
> +{
> +	struct vmd_irq_list *irqs = data;
> +	struct vmd_irq *vmdirq;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
> +		generic_handle_irq(vmdirq->virq);
> +	rcu_read_unlock();
> +
> +	return IRQ_HANDLED;

Please remind me, that I still need to fix that life time problem in
the core.

> +	for (i = 0; i < vmd->msix_count; i++) {
> +		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
> +		vmd->irqs[i].vmd_vector = vmd->msix_entries[i].vector;
> +		vmd->irqs[i].index = i;
> +
> +		err = devm_request_irq(&dev->dev, vmd->irqs[i].vmd_vector,
> +				vmd_irq, IRQF_SHARED, "vmd", &vmd->irqs[i]);

This is a MSI interrupt which is never shared.

Aside of the few nitpicks above I'm really happy with the interrupt
side of that driver. Thanks for following up on all the comments!

Thanks,

	tglx


