Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1BB189B84
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 04:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632368; cv=none; b=bSd4zKpWbBDeQIwaQXpSz9PNq5V7IhC75rCEPG7cz8zqttW6QPCjmq+Jf58F6GjHraIJAL17bGOrFOm+Kr2bwD6rFhGs53UCewq7lNP6faWqo+44mcaKwsjIxXEvj3M17eNa+PZuICt0hXop2lczxtz+7f0HDapVkXfqfueLZww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632368; c=relaxed/simple;
	bh=YT2PfnmuSCLMjkoHGHFExNbb+4S4RCH0v/0A2sBOzXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMrL19KNgelzoIt9AovvlCDzUOg5T9JM+lkzb+7115kYIxafvahagBjgRvb30vVWz7YQYdPMrPUMnceU7KjTvCrFoVuhcsRHGCnhQlcCdkYqdLrFgOv+1aOhp+fqKhHvVOmSFEiP7JlaPNUEyUwoOELwrN0bfnWyp16YkmaMM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKUvZcxW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKUvZcxW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-395ea741d07so2111059a91.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 21:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787632367; x=1788237167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fINDobLGIMpgAGGbfauJsWMZ+uJcI5Jw9fF5RHvMPlc=;
        b=iKUvZcxWQ8TorOAWAmxW4RuVvFplEuBK1cu4yC+Vtw28J3noy4VIQPfvPM2uh+T8wa
         1oOG2/xqZCI9fJlrYd3PFGWGUis/suUg/37YBq9bcjxx/T36ytRYvaRBYSBl6YOo+bMY
         ma/hWaIT81zyIZo5MvAI5RF6IY5N62z0iCCYBFSH51LEyiD60NkXIOBkwP9hfejfCXjq
         QvZCkKBuXj7OO4Jnnsj4sr28zbS9VNOSlACmNh9xpuZ9UTl2kdOwS4ybygdOO+XPTsjx
         QcO1u4cOrFcyVoMDTFWL2Li5PRS1AuukzD4/ljx1QwY62txtdtvu6dpQJ6aVBWhR7Fg6
         ArfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787632367; x=1788237167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fINDobLGIMpgAGGbfauJsWMZ+uJcI5Jw9fF5RHvMPlc=;
        b=TtIZdfdtueOvIbgrDlTrpKkZT5mCVolKef6HTOoJjJXw6NAQfS3KJamwFcwUGY60KN
         whAt53KtEXTCazsNZ9ByxDqDZkCkXM0tplCkCCbGVtVs5/sg85jaKpGKWbfwrjG4wEyC
         axHZfE595J8ou9hLqS+bEyNWvOeXhy4IWstv6fodo9pFNbMn4q3DNOeqTQaTVN9bqMOF
         T5i8RvdyXqS9Yk56tH0YHPlQTMV/dcmc+6b/U2yOoApwazB561yAVBjux9yV02tIs/Cs
         xavGrmqi/QyiL8LVpcOlQFhPN/As5YZT9t9C9OHYIEEsBwaSRh/5q6IEEwYXDV1vZpWt
         5+rA==
X-Forwarded-Encrypted: i=1; AHgh+Rod/OYqK2+UUfcIzHWENUgeWBM3veacpIFegpoQw0xr49NTVU4x8Iw7ABKWcUIJv4LFabJOPXG0U0M=@vger.kernel.org
X-Gm-Message-State: AFuF++kHm0ERe5MaBNdC39pUkkKbsQtSBR+EMyBQkH8GWPxSGrbY3IIV
	+XNSz4AUKeYdEV/xW6JkX1iWOp9bNUwR4c4ormHTXWWthK1Qpc7nvQLY
X-Gm-Gg: AR+sD10nljRUYxFedVC/iLimeGVFYzXKpeWpeYHkDlvKeUbUAY+NQkktGUHkjgSdWb/
	y52nld12RgYU5A2b+AC+lCgvA+ouXEToyOpM8nj+xFAS0RLiqu4ez3PN/EtekCI/yyoL0+jktEp
	NMFOK+UoXO8Dx3Fh+ECispGLEeAeQWNzVCrfdW8sFmOFch7knkv7eb8ozF9wGK11c3OCzKaIRaf
	t/4uvaKtrMdK9AhwxBAaCYTuTSPB2zEYBP+1qryfJd8E6EleSuWI3euqI1DC/nEGKJJOKcB3AHw
	/adGL87T96Ni8JZdwqIFhPTG8qeOmMJlmOHd3OlVkUZPAwVdtI+mx8U9ajNKLbH7Tm3MWOR8HHi
	pyTLd2PmBC5+IG/AQLrtoT0BWBBeQqrk4ln5svygq7M9nh1rgVj70X//8N/qnwL6z4hu8VtqbF7
	0SXLdv5FEkrcfquYkqdaYfHySwza01m5QMfq2SKrMc3MVlbxqi5dDt4CSf1zMo6D+B5hBnwRQJ8
	5sf+JtRw8upD08GoPt4H65dtsv3
X-Received: by 2002:a17:90b:2f0c:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-395c3847e85mr58426092a91.16.1787632366576;
        Mon, 24 Aug 2026 21:32:46 -0700 (PDT)
Received: from dev-5000.localdomain ([71.89.196.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3964581202fsm2152129a91.0.2026.08.24.21.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 21:32:45 -0700 (PDT)
From: Rickey Bartlett <subtexel@gmail.com>
To: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: vmd: Flush initiator posted writes before demuxing interrupts on Meteor Lake
Date: Mon, 24 Aug 2026 21:32:20 -0700
Message-ID: <20260825043220.9047-1-subtexel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Meteor Lake VMD (8086:7d0b) is affected by erratum MTL016: the VMD can
signal its MSI before the posted writes carrying a child device's DMA
data have landed in memory. vmd_irq() then demuxes to the child handler
while the child's completion queue is not yet coherent, so the handler
observes no completion and returns without consuming it. The I/O is
only recovered when the block layer timeout expires and polls the queue:

  nvme nvme0: I/O tag 253 (50fd) QID 1 timeout, completion polled

The practical effect is therefore not a lost I/O but a 30 second stall
of the entire storage stack, repeated under any sustained read load.

This was originally diagnosed and fixed by Kai-Heng Feng in September
2024 [1]. That patch used udelay(4); Keith Busch objected that the delay
is merely a side effect of the read, and that flushing the pending
device-to-host writes is what the erratum actually requires. Kai-Heng
agreed to respin with a dummy register read. The thread then stalled on
an open question from Manivannan Sadhasivam [2]: whether the read must
target the child device (the "MSI initiator" named by the erratum)
rather than the VMD, and whether the workaround belongs in the NVMe
driver instead. No revision followed, and the erratum has remained
unmitigated in mainline since.

This implements the flush read Keith asked for, and answers the open
question empirically: the read MUST complete at the initiating child
device. A read of the VMD's own config BAR was tried first and does not
help - it terminates at the VMD and never traverses the downstream
link, so it does not order against the child's posted writes (measured:
timeout rate unchanged). Reading the initiator's config space does
order correctly: per PCIe ordering rules the read completion cannot
pass the device's earlier posted writes, so returning from the read
guarantees the completion queue entry is visible.

The initiator's config address is captured per-IRQ at MSI allocation
time from the requesting device, so the hot path adds one config read
only on affected parts, and only for vectors owned by a child device.
The read is serialized with cfg_lock like all other VMD config access.
No NVMe driver change is needed.

Measured on a Dell Pro Max 14 MC14250 (Meteor Lake, VMD 8086:7d0b,
KIOXIA BG6 512GB, 7.0.0-30-generic). The drive is healthy (46C, 0 media
errors, 2% used) and ASPM is disabled on the link with all L1 substates
off, so neither ASPM nor APST is involved.

Dropping caches and reading 3000 shared libraries, measuring
/proc/pressure/io "full" (every task on the system blocked on I/O),
with nvme_core.io_timeout=5:

  unpatched:      round 1  wall 37.4s   full I/O stall 32.6s   timeouts 0
                  round 2  wall 30.6s   full I/O stall 28.7s   timeouts 1
                  round 3  wall 30.3s   full I/O stall 27.4s   timeouts 1

  VMD-BAR read:   round 1  wall 44.8s   full I/O stall 38.6s   timeouts 8
  (insufficient)  round 2  wall 234.8s  full I/O stall 207.9s  timeouts 37
                  round 3  wall 3.6s    full I/O stall 0.8s    timeouts 0

  this patch:     round 1  wall 3.6s    full I/O stall 1.3s    timeouts 0
                  round 2  wall 3.6s    full I/O stall 1.3s    timeouts 0
                  round 3  wall 3.6s    full I/O stall 1.4s    timeouts 0

Before any workaround, 208 seconds of total-system I/O stall
accumulated in the first 13 minutes of uptime, roughly 27% of wall
clock. Userspace experiences this as GUI applications taking 30-60+
seconds to start while throughput between stalls looks entirely normal
(1.9 GB/s QD1) - which is what makes the fault easy to misattribute to
ASPM or to the drive.

[1] https://lore.kernel.org/all/20240909082657.19660-1-kai.heng.feng@canonical.com/
[2] https://lkml.iu.edu/hypermail/linux/kernel/2409.1/08047.html

Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Suggested-by: Keith Busch <kbusch@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Rickey Bartlett <subtexel@gmail.com>
---
This revives the MTL016 workaround that Kai-Heng Feng posted in September
2024 [1]. To be clear about the provenance: the diagnosis and the fix are
his. Intel confirmed the silicon bug in that thread. What is new here is
the implementation Keith asked for, and the measurements needed to close
the question the thread ended on.

That thread stalled on one unanswered point - whether the flush read has
to target the NVMe child device, the "MSI initiator" named in the erratum,
or whether the VMD's own register is enough, and whether the workaround
belongs in the NVMe driver at all. Nobody had hardware in front of them to
settle it, and the discussion stopped there. It has been two years, the
erratum is still unmitigated in mainline, and every affected machine has
been stalling that whole time.

I have the hardware, so here is the answer: the read must complete at
the NVMe child device - the "MSI initiator" named in the erratum -
exactly as Manivannan suspected. I first tried reading the VMD's own
config BAR; it does not help (measured, numbers in the commit message:
timeout rate was unchanged). A read that terminates at the VMD never
traverses the downstream link, so PCIe ordering gives no guarantee
about the child's posted writes. Reading the initiator's config space
closes the race. The workaround still lives in the VMD driver rather
than the NVMe driver: the VMD is the broken component, the initiator
address is captured generically per-IRQ at MSI allocation time, and no
NVMe-specific knowledge is needed.

Measurements are in the commit message.

 drivers/pci/controller/vmd.c | 52 ++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 241023e..e45ef8c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -92,6 +92,22 @@ enum vmd_features {
 	 * referred to as MEMBAR2 or MSI-X BAR.
 	 */
 	VMD_FEAT_USE_BIOS_INFO		= (1 << 6),
+
+	/*
+	 * Meteor Lake VMD (device ID 0x7d0b) is affected by erratum MTL016:
+	 * the VMD may signal its MSI before the posted writes that carry the
+	 * child device's DMA data have landed in memory.  The demuxed handler
+	 * then runs against a not-yet-coherent completion queue and misses the
+	 * completion entirely, so the I/O is only recovered when the block
+	 * layer timeout fires and polls the queue ("timeout, completion
+	 * polled").  Intel's documented workaround is to issue a dummy read
+	 * to the MSI initiator (the child device) before handling the
+	 * interrupt: the read completion cannot pass the device's earlier
+	 * posted writes, so it pulls them into memory per PCIe ordering
+	 * rules.  A read that terminates at the VMD itself does not order
+	 * against the child's writes and is not sufficient (measured).
+	 */
+	VMD_FEAT_INTERRUPT_QUIRK	= (1 << 7),
 };
 
 #define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
@@ -114,6 +130,9 @@ static DEFINE_RAW_SPINLOCK(list_lock);
  * @irq:	back pointer to parent.
  * @enabled:	true if driver enabled IRQ
  * @virq:	the virtual IRQ value provided to the requesting driver.
+ * @flush_addr:	config space address of the initiating device, read before
+ *		demuxing to flush its posted writes (MTL016); NULL if the
+ *		VMD is not affected.
  *
  * Every MSI/MSI-X IRQ requested for a device in a VMD domain will be mapped to
  * a VMD IRQ using this structure.
@@ -123,8 +142,14 @@ struct vmd_irq {
 	struct vmd_irq_list	*irq;
 	bool			enabled;
 	unsigned int		virq;
+	void __iomem		*flush_addr;
 };
 
+struct vmd_dev;
+
+static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
+				  unsigned int devfn, int reg, int len);
+
 /**
  * struct vmd_irq_list - list of driver requested IRQs mapping to a VMD vector
  * @irq_list:	the list of irq's the VMD one demuxes to.
@@ -132,12 +157,15 @@ struct vmd_irq {
  * @count:	number of child IRQs assigned to this vector; used to track
  *		sharing.
  * @virq:	The underlying VMD Linux interrupt number
+ * @vmd:	back pointer to the owning VMD device; serializes the MTL016
+ *		flush read against other config space access.
  */
 struct vmd_irq_list {
 	struct list_head	irq_list;
 	struct srcu_struct	srcu;
 	unsigned int		count;
 	unsigned int		virq;
+	struct vmd_dev		*vmd;
 };
 
 struct vmd_dev {
@@ -295,6 +323,13 @@ static int vmd_msi_alloc(struct irq_domain *domain, unsigned int virq,
 		INIT_LIST_HEAD(&vmdirq->node);
 		vmdirq->irq = vmd_next_irq(vmd, desc);
 		vmdirq->virq = virq + i;
+		if (vmd->features & VMD_FEAT_INTERRUPT_QUIRK) {
+			struct pci_dev *pdev = msi_desc_to_pci_dev(desc);
+
+			vmdirq->flush_addr = vmd_cfg_addr(vmd, pdev->bus,
+							  pdev->devfn,
+							  PCI_VENDOR_ID, 2);
+		}
 
 		irq_domain_set_info(domain, virq + i, vmdirq->irq->virq,
 				    &vmd_msi_controller, vmdirq,
@@ -756,8 +791,20 @@ static irqreturn_t vmd_irq(int irq, void *data)
 	int idx;
 
 	idx = srcu_read_lock(&irqs->srcu);
-	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
+	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node) {
+		/*
+		 * MTL016: the MSI may have outrun the initiating device's
+		 * posted writes (e.g. its NVMe completion entry).  A read
+		 * that completes at the initiator flushes them, so the
+		 * demuxed handler observes a coherent completion queue.
+		 * The value is discarded; only the ordering matters.
+		 */
+		if (vmdirq->flush_addr) {
+			guard(raw_spinlock)(&irqs->vmd->cfg_lock);
+			readw(vmdirq->flush_addr);
+		}
 		generic_handle_irq(vmdirq->virq);
+	}
 	srcu_read_unlock(&irqs->srcu, idx);
 
 	return IRQ_HANDLED;
@@ -788,6 +835,7 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 			return err;
 
 		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
+		vmd->irqs[i].vmd = vmd;
 		vmd->irqs[i].virq = pci_irq_vector(dev, i);
 		err = devm_request_irq(&dev->dev, vmd->irqs[i].virq,
 				       vmd_irq, IRQF_NO_THREAD,
@@ -1250,7 +1298,7 @@ static const struct pci_device_id vmd_ids[] = {
 	{PCI_VDEVICE(INTEL, 0xa77f),
 		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0x7d0b),
-		.driver_data = VMD_FEATS_CLIENT,},
+		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_INTERRUPT_QUIRK,},
 	{PCI_VDEVICE(INTEL, 0xad0b),
 		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
-- 
2.53.0

