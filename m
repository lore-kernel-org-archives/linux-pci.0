Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1BF51CF43;
	Thu,  1 Oct 2026 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874504; cv=none; b=hqT1kLgj4RsqdBR+y9np2kouagAHOpvpJV+hB5XKWTp5LAsI5BuAjZf9QFUml6sk9tAoTUaqAygMOdXvCOqIaIUdsHLBqMEEekoHWDorOgz1tUc3gJA1uqo9BtbZuztcdQwUUt9RDRrr26jfCvNPshgy0nJ9gy3mfTasJHFOdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874504; c=relaxed/simple;
	bh=vkzHWmtkQnXfDOBM8yyOCwI0qAln+O7/+Tqc74Wvo2M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pQfHk7IVxySliKkqAdw2IZY/eX78z05DUYIJX4HpN7XR4eS0RwuvGJEgB4pRdwXj1HB3t2eyIELQgQ4aQNwloNRawKuasQDs5U8Wn7nWDNO74H6hoc0DBDCWbTONchIkv+X35+9ZeaLRT/qTTAbs9QwMueZAyL5jAIJAxmoLhzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmR8ugfq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmR8ugfq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F481F000FF;
	Thu,  1 Oct 2026 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790874497;
	bh=2EBHTCbQ9dYD3G0cXc8AK50xFhsxNiy6PPwJjkJDECo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=LmR8ugfq7MkFiQbu3TBY25zL60kpjw5V6UjC97NldfxQqfbcMmCEJzuWOw1abTII2
	 JJKDTR2molXFIIzSGv8wfXAdcdQ7sqm/r5saoalX0QsXHI17Ltc6wcT7KA/d/GtXgP
	 aVMQXxPG4BnI7eAaWQI9LjqQVvQqzfi/J7URixhsaFwJRQZsQA6PQopLkTh2ut2V+2
	 Reeb1NpzVuvSqmQzk34TDWxv7/WQYVtD/c+EW4XmOSDIQsGCtJmjlUlsHE8Ih4fvoE
	 KTg+/6ZbiWOwo+cpriVIedmgFDdZNom6Zm+fCHEIKVDHC0w+Wpm7fAT5HM7+qcG7IM
	 99TXfxv72T0hQ==
Date: Thu, 1 Oct 2026 12:08:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rickey Bartlett <subtexel@gmail.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Flush initiator posted writes before demuxing
 interrupts on Meteor Lake
Message-ID: <20261001170816.GA2702295@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825043220.9047-1-subtexel@gmail.com>

On Mon, Aug 24, 2026 at 09:32:20PM -0700, Rickey Bartlett wrote:
> Meteor Lake VMD (8086:7d0b) is affected by erratum MTL016: the VMD can
> signal its MSI before the posted writes carrying a child device's DMA
> data have landed in memory. vmd_irq() then demuxes to the child handler
> while the child's completion queue is not yet coherent, so the handler
> observes no completion and returns without consuming it. The I/O is
> only recovered when the block layer timeout expires and polls the queue:
> 
>   nvme nvme0: I/O tag 253 (50fd) QID 1 timeout, completion polled
> 
> The practical effect is therefore not a lost I/O but a 30 second stall
> of the entire storage stack, repeated under any sustained read load.
> 
> This was originally diagnosed and fixed by Kai-Heng Feng in September
> 2024 [1]. That patch used udelay(4); Keith Busch objected that the delay
> is merely a side effect of the read, and that flushing the pending
> device-to-host writes is what the erratum actually requires. Kai-Heng
> agreed to respin with a dummy register read. The thread then stalled on
> an open question from Manivannan Sadhasivam [2]: whether the read must
> target the child device (the "MSI initiator" named by the erratum)
> rather than the VMD, and whether the workaround belongs in the NVMe
> driver instead. No revision followed, and the erratum has remained
> unmitigated in mainline since.
> 
> This implements the flush read Keith asked for, and answers the open
> question empirically: the read MUST complete at the initiating child
> device. A read of the VMD's own config BAR was tried first and does not
> help - it terminates at the VMD and never traverses the downstream
> link, so it does not order against the child's posted writes (measured:
> timeout rate unchanged). Reading the initiator's config space does
> order correctly: per PCIe ordering rules the read completion cannot
> pass the device's earlier posted writes, so returning from the read
> guarantees the completion queue entry is visible.
> 
> The initiator's config address is captured per-IRQ at MSI allocation
> time from the requesting device, so the hot path adds one config read
> only on affected parts, and only for vectors owned by a child device.
> The read is serialized with cfg_lock like all other VMD config access.
> No NVMe driver change is needed.
> 
> Measured on a Dell Pro Max 14 MC14250 (Meteor Lake, VMD 8086:7d0b,
> KIOXIA BG6 512GB, 7.0.0-30-generic). The drive is healthy (46C, 0 media
> errors, 2% used) and ASPM is disabled on the link with all L1 substates
> off, so neither ASPM nor APST is involved.
> 
> Dropping caches and reading 3000 shared libraries, measuring
> /proc/pressure/io "full" (every task on the system blocked on I/O),
> with nvme_core.io_timeout=5:
> 
>   unpatched:      round 1  wall 37.4s   full I/O stall 32.6s   timeouts 0
>                   round 2  wall 30.6s   full I/O stall 28.7s   timeouts 1
>                   round 3  wall 30.3s   full I/O stall 27.4s   timeouts 1
> 
>   VMD-BAR read:   round 1  wall 44.8s   full I/O stall 38.6s   timeouts 8
>   (insufficient)  round 2  wall 234.8s  full I/O stall 207.9s  timeouts 37
>                   round 3  wall 3.6s    full I/O stall 0.8s    timeouts 0
> 
>   this patch:     round 1  wall 3.6s    full I/O stall 1.3s    timeouts 0
>                   round 2  wall 3.6s    full I/O stall 1.3s    timeouts 0
>                   round 3  wall 3.6s    full I/O stall 1.4s    timeouts 0
> 
> Before any workaround, 208 seconds of total-system I/O stall
> accumulated in the first 13 minutes of uptime, roughly 27% of wall
> clock. Userspace experiences this as GUI applications taking 30-60+
> seconds to start while throughput between stalls looks entirely normal
> (1.9 GB/s QD1) - which is what makes the fault easy to misattribute to
> ASPM or to the drive.
> 
> [1] https://lore.kernel.org/all/20240909082657.19660-1-kai.heng.feng@canonical.com/

This link doesn't work.  Do you have a corrected one?  Maybe it was a
followup to this one:

  https://lore.kernel.org/all/20240903025544.286223-1-kai.heng.feng@canonical.com/

> [2] https://lkml.iu.edu/hypermail/linux/kernel/2409.1/08047.html

And this appears to be the email at
https://lore.kernel.org/all/20240913111142.4cgrmirofhhgrbqm@thinkpad/

Prefer lore.kernel.org over lkml.iu.edu because lore doesn't depend on
non-kernel.org resources.

> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Rickey Bartlett <subtexel@gmail.com>
> ---
> This revives the MTL016 workaround that Kai-Heng Feng posted in September
> 2024 [1]. To be clear about the provenance: the diagnosis and the fix are
> his. Intel confirmed the silicon bug in that thread. What is new here is
> the implementation Keith asked for, and the measurements needed to close
> the question the thread ended on.
> 
> That thread stalled on one unanswered point - whether the flush read has
> to target the NVMe child device, the "MSI initiator" named in the erratum,
> or whether the VMD's own register is enough, and whether the workaround
> belongs in the NVMe driver at all. Nobody had hardware in front of them to
> settle it, and the discussion stopped there. It has been two years, the
> erratum is still unmitigated in mainline, and every affected machine has
> been stalling that whole time.
> 
> I have the hardware, so here is the answer: the read must complete at
> the NVMe child device - the "MSI initiator" named in the erratum -
> exactly as Manivannan suspected. I first tried reading the VMD's own
> config BAR; it does not help (measured, numbers in the commit message:
> timeout rate was unchanged). A read that terminates at the VMD never
> traverses the downstream link, so PCIe ordering gives no guarantee
> about the child's posted writes. Reading the initiator's config space
> closes the race. The workaround still lives in the VMD driver rather
> than the NVMe driver: the VMD is the broken component, the initiator
> address is captured generically per-IRQ at MSI allocation time, and no
> NVMe-specific knowledge is needed.
> 
> Measurements are in the commit message.
> 
>  drivers/pci/controller/vmd.c | 52 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 241023e..e45ef8c 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -92,6 +92,22 @@ enum vmd_features {
>  	 * referred to as MEMBAR2 or MSI-X BAR.
>  	 */
>  	VMD_FEAT_USE_BIOS_INFO		= (1 << 6),
> +
> +	/*
> +	 * Meteor Lake VMD (device ID 0x7d0b) is affected by erratum MTL016:
> +	 * the VMD may signal its MSI before the posted writes that carry the
> +	 * child device's DMA data have landed in memory.  The demuxed handler
> +	 * then runs against a not-yet-coherent completion queue and misses the
> +	 * completion entirely, so the I/O is only recovered when the block
> +	 * layer timeout fires and polls the queue ("timeout, completion
> +	 * polled").  Intel's documented workaround is to issue a dummy read
> +	 * to the MSI initiator (the child device) before handling the
> +	 * interrupt: the read completion cannot pass the device's earlier
> +	 * posted writes, so it pulls them into memory per PCIe ordering
> +	 * rules.  A read that terminates at the VMD itself does not order
> +	 * against the child's writes and is not sufficient (measured).
> +	 */
> +	VMD_FEAT_INTERRUPT_QUIRK	= (1 << 7),
>  };
>  
>  #define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
> @@ -114,6 +130,9 @@ static DEFINE_RAW_SPINLOCK(list_lock);
>   * @irq:	back pointer to parent.
>   * @enabled:	true if driver enabled IRQ
>   * @virq:	the virtual IRQ value provided to the requesting driver.
> + * @flush_addr:	config space address of the initiating device, read before
> + *		demuxing to flush its posted writes (MTL016); NULL if the
> + *		VMD is not affected.
>   *
>   * Every MSI/MSI-X IRQ requested for a device in a VMD domain will be mapped to
>   * a VMD IRQ using this structure.
> @@ -123,8 +142,14 @@ struct vmd_irq {
>  	struct vmd_irq_list	*irq;
>  	bool			enabled;
>  	unsigned int		virq;
> +	void __iomem		*flush_addr;
>  };
>  
> +struct vmd_dev;
> +
> +static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
> +				  unsigned int devfn, int reg, int len);
> +
>  /**
>   * struct vmd_irq_list - list of driver requested IRQs mapping to a VMD vector
>   * @irq_list:	the list of irq's the VMD one demuxes to.
> @@ -132,12 +157,15 @@ struct vmd_irq {
>   * @count:	number of child IRQs assigned to this vector; used to track
>   *		sharing.
>   * @virq:	The underlying VMD Linux interrupt number
> + * @vmd:	back pointer to the owning VMD device; serializes the MTL016
> + *		flush read against other config space access.
>   */
>  struct vmd_irq_list {
>  	struct list_head	irq_list;
>  	struct srcu_struct	srcu;
>  	unsigned int		count;
>  	unsigned int		virq;
> +	struct vmd_dev		*vmd;
>  };
>  
>  struct vmd_dev {
> @@ -295,6 +323,13 @@ static int vmd_msi_alloc(struct irq_domain *domain, unsigned int virq,
>  		INIT_LIST_HEAD(&vmdirq->node);
>  		vmdirq->irq = vmd_next_irq(vmd, desc);
>  		vmdirq->virq = virq + i;
> +		if (vmd->features & VMD_FEAT_INTERRUPT_QUIRK) {
> +			struct pci_dev *pdev = msi_desc_to_pci_dev(desc);
> +
> +			vmdirq->flush_addr = vmd_cfg_addr(vmd, pdev->bus,
> +							  pdev->devfn,
> +							  PCI_VENDOR_ID, 2);
> +		}
>  
>  		irq_domain_set_info(domain, virq + i, vmdirq->irq->virq,
>  				    &vmd_msi_controller, vmdirq,
> @@ -756,8 +791,20 @@ static irqreturn_t vmd_irq(int irq, void *data)
>  	int idx;
>  
>  	idx = srcu_read_lock(&irqs->srcu);
> -	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
> +	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node) {
> +		/*
> +		 * MTL016: the MSI may have outrun the initiating device's
> +		 * posted writes (e.g. its NVMe completion entry).  A read
> +		 * that completes at the initiator flushes them, so the
> +		 * demuxed handler observes a coherent completion queue.
> +		 * The value is discarded; only the ordering matters.
> +		 */
> +		if (vmdirq->flush_addr) {
> +			guard(raw_spinlock)(&irqs->vmd->cfg_lock);
> +			readw(vmdirq->flush_addr);
> +		}
>  		generic_handle_irq(vmdirq->virq);
> +	}
>  	srcu_read_unlock(&irqs->srcu, idx);
>  
>  	return IRQ_HANDLED;
> @@ -788,6 +835,7 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  			return err;
>  
>  		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
> +		vmd->irqs[i].vmd = vmd;
>  		vmd->irqs[i].virq = pci_irq_vector(dev, i);
>  		err = devm_request_irq(&dev->dev, vmd->irqs[i].virq,
>  				       vmd_irq, IRQF_NO_THREAD,
> @@ -1250,7 +1298,7 @@ static const struct pci_device_id vmd_ids[] = {
>  	{PCI_VDEVICE(INTEL, 0xa77f),
>  		.driver_data = VMD_FEATS_CLIENT,},
>  	{PCI_VDEVICE(INTEL, 0x7d0b),
> -		.driver_data = VMD_FEATS_CLIENT,},
> +		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_INTERRUPT_QUIRK,},
>  	{PCI_VDEVICE(INTEL, 0xad0b),
>  		.driver_data = VMD_FEATS_CLIENT,},
>  	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> -- 
> 2.53.0
> 
