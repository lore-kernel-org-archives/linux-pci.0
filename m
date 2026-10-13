Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE1563288
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930982; cv=none; b=iq4TlDkU4LINYyQYyqzgMcD59sjpcEgttfRP7hwFwyyQDu2I7gQHEmN+iCVypjR1kVZjLszyN3qIvffQElkDGRVjCi43JtF/YCq4tTRUcj7LaJQfiouLBZq2G3PMDJB4L+cwdaOIfxyyUiCkVshVfOrzGTkgUhaoHHQc58+oMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930982; c=relaxed/simple;
	bh=a/a+gGK5rkrdmnhBusgolgwp9//7H0nbeXpoSZ/e0SA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0I9PRWS3tulhIaU9AhVEGjMOkt34nhZ3+yEbCRA41kVQxlYcfNw2lD/XdtZbafIeG5lOmGfOSipGq8SuxONgcGbsWZKoz7g1fkvznYzKfVETB9WdOd3759zWl45mK+V1OYK2+nrrEaiVcUQRGPOp3Ls2MPYsDARgmhJQ8WLOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=f9ub/Xh0; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="f9ub/Xh0"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69DKWqUm4152197
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 15:36:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=Ev023zI5goKdCEEbHJOxhliYaULMGafmrrWjZ
	Rts9tQ=; b=f9ub/Xh0KcafHUAUBa5RA65VvtV7rv0QN8vN89DaL+iayyyBjNRWW
	TRey6sxbIQ0qufBKTGC+3kT8AVKqUqAT59GopaDt6ArSXTW7SyK/Brbg4EmW/9Qr
	0PIDL+T/bGz/iFa7fxhAvsHmA98K0kAedcrlXr5ovHJ4/3MhWMi0bjSFmOFQg6Qz
	0XE/dqt9WxmDM77hr0rBZazoj3a77HNddntS9t0qtrDIod6sjifrll60dKH7xcoN
	1ggGdNvix9Ni7C7lQ8uOk45ce+RAu2av3u0oC9B3ywNap8JQXc3CR7aTSKhWZOoS
	Cq3vmqIsaTn0ZtZWtv0zpFuZllcllu62Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4h9q77m0kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 15:36:12 -0700 (PDT)
Received: from twshared20516.04.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 13 Oct 2026 22:36:10 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 784872D52CB7C; Tue, 13 Oct 2026 15:35:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <changfengnan@bytedance.com>, <linux-pci@vger.kernel.org>,
        <tglx@kernel.org>, <namjain@linux.microsoft.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [RFC PATCH 3/3] nvme-pci: hybrid irq+polling
Date: Tue, 13 Oct 2026 15:35:43 -0700
Message-ID: <20261013223543.395054-4-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261013223543.395054-1-kbusch@meta.com>
References: <20261013223543.395054-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0KKdLbv5h1kF1hHnHkRKMmUGAPM9YX8W
X-Authority-Analysis: v=2.4 cv=OvbaWC/t c=1 sm=1 tr=0 ts=6aceb25c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8 a=hlmgFXTaEyILlQX1T1oA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfXxWc+BPELRBPz
 6zQdCIE20uHkpPTTDr4wnh+9XUsaNTifGTZ+wOhgZGaUlZNfSPFn/VUzUCirT74ZuL0/oqzC/nY
 ORRTWKlYWGJ+KY6E5bs54Si6QqauOXI=
X-Proofpoint-GUID: 0KKdLbv5h1kF1hHnHkRKMmUGAPM9YX8W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfX7g7EQv5nSCum
 kN0z8hXH9Ct986qJnM9HEPk5scd4rcJUOQ5R/XDwz2tAbgcrnmbDwM6UZcQwIrd5p7eNSHsO4ZI
 FRhOP+YG58B8OJiQcrJ1en+AOeNGTy+zWKsBlAHrx++i8S/H+TRWsJwoL36T9UKej0wdSuHjyZG
 i66ZPCfgZkJEkrRSREVbfz932An1Gpop1wVfQqb7Gpob8TBOW/H/9pc0v+elLzCtVRRdeJF3UEI
 QI/FlvttG/a8QGci+vRfRCV6NWqbHSvFdC+pbBBAgLHikYVzb5rqE17B8ZM8rg5mcgAL5DoECv5
 y3RtUB7d9SKWhHV1loy0c30ViZPv6RbQ/J6cyhiaGnj/Zo6aE1uu9pjcEIBLvpSI/Kpq2lXZf6I
 TIDo3fgeW5dGQi7+CDQt9B9A7/YYd/MRMBuqNlBidlMqyKNph85Br6WONbxVk3+ANeG49R4MCjf
 xejM7bycai9ehTJSlhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

High depth workloads can trigger interrupt storms that would be better
off polled. This proposal uses the DIM framework to adjust the
completion method from interrupt driven to polling based on the
workload.=20

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/Kconfig |   2 +
 drivers/nvme/host/pci.c   | 624 ++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/trace.c |   1 +
 drivers/nvme/host/trace.h |  26 ++
 4 files changed, 626 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 31974c7dd20c9..184e9ccfde8b2 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -6,6 +6,8 @@ config BLK_DEV_NVME
 	tristate "NVM Express block device"
 	depends on PCI && BLOCK
 	select NVME_CORE
+	select DIMLIB
+	select IRQ_POLL
 	help
 	  The NVM Express driver is for solid state drives directly
 	  connected to the PCI or PCI Express bus.  If you know you
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 79b3c1092e4d1..1e4dbb9b1435d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -9,10 +9,15 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq-dma.h>
 #include <linux/blk-integrity.h>
+#include <linux/delay.h>
+#include <linux/dim.h>
 #include <linux/dmi.h>
+#include <linux/hrtimer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq_poll.h>
+#include <linux/ktime.h>
 #include <linux/kstrtox.h>
 #include <linux/memremap.h>
 #include <linux/mm.h>
@@ -83,6 +88,26 @@ struct quirk_entry {
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
=20
+static bool use_adaptive_irq_polling;
+module_param(use_adaptive_irq_polling, bool, 0444);
+MODULE_PARM_DESC(use_adaptive_irq_polling,
+		 "use adaptive IRQ polling on dedicated I/O vectors; ignored with thre=
aded interrupts");
+
+static unsigned int irq_poll_timeout_ms =3D 2;
+module_param(irq_poll_timeout_ms, uint, 0644);
+MODULE_PARM_DESC(irq_poll_timeout_ms,
+	"milliseconds the threaded handler may wait for completions before hand=
ing the queue back");
+
+static unsigned int irq_poll_sleep_max_us =3D 100;
+module_param(irq_poll_sleep_max_us, uint, 0644);
+MODULE_PARM_DESC(irq_poll_sleep_max_us,
+	"upper bound on the measured inter-completion poll sleep");
+
+static int irq_poll_profile =3D -1;
+module_param(irq_poll_profile, int, 0644);
+MODULE_PARM_DESC(irq_poll_profile,
+	"pin the moderation profile, or -1 to let it adapt");
+
 static bool use_cmb_sqes =3D true;
 module_param(use_cmb_sqes, bool, 0444);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O S=
Qes");
@@ -284,6 +309,7 @@ struct nvme_queue;
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static void nvme_delete_io_queues(struct nvme_dev *dev);
 static void nvme_update_attrs(struct nvme_dev *dev);
+static bool nvme_pci_ctrl_is_dead(struct nvme_dev *dev);
=20
 struct nvme_descriptor_pools {
 	struct dma_pool *large;
@@ -309,6 +335,7 @@ struct nvme_dev {
 	void __iomem *bar;
 	unsigned long bar_mapped_size;
 	struct mutex shutdown_lock;
+	bool use_int_mask;
 	bool subsystem;
 	u64 cmb_size;
 	bool cmb_use_sqes;
@@ -387,11 +414,32 @@ struct nvme_queue {
 	u16 qid;
 	u8 cq_phase;
 	u8 sqes;
+	/* Adaptive polling knobs, seeded from the irq_poll_* module params. */
+	unsigned int poll_thresh;
+	unsigned int poll_sleep_us;	/* servo'd poll wait */
+	unsigned int poll_idle_rounds;
+	unsigned int poll_budget;
+	/* Serializes IRQ admission and the irq_poll callback tail. */
+	spinlock_t poll_lock;
+	/* Softirq poll episode state. */
+	struct hrtimer poll_timer;
+	int irq;
+	struct irq_poll iopoll;
+	unsigned long poll_deadline;
+	unsigned int poll_idle;
+	/* Adaptive interrupt moderation (DIM) sampling state. */
+	struct dim dim;
+	u16 dim_events;			/* cumulative interrupts (BIT_GAP-safe) */
+	u32 dim_comps;			/* cumulative completions */
 	unsigned long flags;
 #define NVMEQ_ENABLED		0
 #define NVMEQ_SQ_CMB		1
 #define NVMEQ_DELETE_ERROR	2
 #define NVMEQ_POLLED		3
+#define NVMEQ_POLLING		4
+#define NVMEQ_IRQ_MASKED	5
+#define NVMEQ_HYBRID		6
+#define NVMEQ_POLL_PAUSED	7
 	__le32 *dbbuf_sq_db;
 	__le32 *dbbuf_cq_db;
 	__le32 *dbbuf_sq_ei;
@@ -1838,13 +1886,13 @@ static inline void nvme_update_cq_head(struct nvm=
e_queue *nvmeq)
 	}
 }
=20
-static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
-			        struct io_comp_batch *iob)
+static inline int nvme_poll_cq_bounded(struct nvme_queue *nvmeq,
+				       struct io_comp_batch *iob, int budget)
 {
-	bool found =3D false;
+	int found =3D 0;
=20
 	while (nvme_cqe_pending(nvmeq)) {
-		found =3D true;
+		found++;
 		/*
 		 * load-load control dependency between phase and the rest of
 		 * the cqe requires a full read memory barrier
@@ -1852,23 +1900,434 @@ static inline bool nvme_poll_cq(struct nvme_queu=
e *nvmeq,
 		dma_rmb();
 		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
+		if (budget && found =3D=3D budget)
+			break;
 	}
=20
+	return found;
+}
+
+static inline int __nvme_poll_cq(struct nvme_queue *nvmeq,
+				 struct io_comp_batch *iob, int budget)
+{
+	int found =3D nvme_poll_cq_bounded(nvmeq, iob, budget);
+
 	if (found)
 		nvme_ring_cq_doorbell(nvmeq);
 	return found;
 }
=20
+/* budget =3D=3D 0 means reap the whole queue. */
+static int nvme_poll_cq(struct nvme_queue *nvmeq, int budget)
+{
+	DEFINE_IO_COMP_BATCH(iob);
+	int found =3D __nvme_poll_cq(nvmeq, &iob, budget);
+
+	if (found && !rq_list_empty(&iob.req_list))
+		nvme_pci_complete_batch(&iob);
+	nvmeq->dim_comps +=3D found;
+	return found;
+}
+
+static inline unsigned int nvmeq_outstanding(struct nvme_queue *nvmeq)
+{
+	u16 sq_tail =3D READ_ONCE(nvmeq->sq_tail);
+	u16 cq_head =3D nvmeq->cq_head;
+
+	if (sq_tail >=3D cq_head)
+		return sq_tail - cq_head;
+	return nvmeq->q_depth - cq_head + sq_tail;
+}
+
+static inline bool nvmeq_cq_continue(struct nvme_queue *nvmeq)
+{
+	return nvmeq_outstanding(nvmeq) > nvmeq->poll_thresh;
+}
+
+static inline bool nvmeq_cq_idle(struct nvme_queue *nvmeq)
+{
+	return nvmeq->cq_head =3D=3D READ_ONCE(nvmeq->sq_tail);
+}
+
+/*
+ * Interrupt-moderation profiles, ordered from least moderation (index 0=
: enter
+ * polling late, short sleep, brief linger -> lowest latency, most inter=
rupts)
+ * to most moderation (enter early, long sleep, long linger -> fewest
+ * interrupts).  The hill-climb walks this table to keep completions-per=
-
+ * interrupt high, which is what bounds the interrupt rate.
+ */
+static const struct nvme_poll_prof {
+	u16 thresh;
+	u16 batch;
+	u16 idle_rounds;
+	u16 budget;
+} nvme_poll_prof[] =3D {
+	{ 31,  0,  1,  0 },
+	{ 15,  1,  2, 16 },
+	{  7,  2,  4,  8 },
+	{  3,  4,  8,  4 },
+	{  1,  8, 16,  2 },
+};
+
+#define NVME_DIM_START_PROFILE 2
+
+static u8 nvme_fixed_profile(void)
+{
+	int pin =3D READ_ONCE(irq_poll_profile);
+
+	if (pin < 0)
+		return NVME_DIM_START_PROFILE;
+	return min_t(int, pin, ARRAY_SIZE(nvme_poll_prof) - 1);
+}
+
+static void nvme_apply_profile(struct nvme_queue *nvmeq)
+{
+	const struct nvme_poll_prof *p =3D &nvme_poll_prof[nvmeq->dim.profile_i=
x];
+
+	nvmeq->poll_thresh =3D p->thresh;
+	nvmeq->poll_idle_rounds =3D p->idle_rounds;
+	nvmeq->poll_budget =3D p->budget;
+}
+
+static void nvme_poll_calibrate(struct nvme_queue *nvmeq, int found)
+{
+	unsigned int target =3D nvme_poll_prof[nvmeq->dim.profile_ix].batch;
+	unsigned int sleep =3D nvmeq->poll_sleep_us;
+
+	if (!target)
+		return;
+
+	target =3D min(target, found + nvmeq_outstanding(nvmeq) / 2);
+	if (!target)
+		return;
+
+	if (found < target)
+		sleep +=3D max(sleep >> 2, 1U);
+	else
+		sleep -=3D sleep >> 2;
+
+	nvmeq->poll_sleep_us =3D min(sleep, irq_poll_sleep_max_us);
+}
+
+static void nvme_poll_arm(struct nvme_queue *nvmeq)
+{
+	u64 delay =3D (u64)max(nvmeq->poll_sleep_us, 1U) * NSEC_PER_USEC;
+
+	hrtimer_start(&nvmeq->poll_timer, ns_to_ktime(delay),
+		      HRTIMER_MODE_REL_PINNED_HARD);
+}
+
+static bool nvme_poll_accessible(struct nvme_queue *nvmeq)
+{
+	struct pci_dev *pdev =3D to_pci_dev(nvmeq->dev->dev);
+
+	return pci_is_enabled(pdev) &&
+		READ_ONCE(pdev->error_state) =3D=3D pci_channel_io_normal;
+}
+
+static void nvme_poll_mask(struct nvme_queue *nvmeq)
+{
+	struct nvme_dev *dev =3D nvmeq->dev;
+
+	if (test_and_set_bit(NVMEQ_IRQ_MASKED, &nvmeq->flags))
+		return;
+	if (dev->use_int_mask)
+		writel(BIT(nvmeq->cq_vector), dev->bar + NVME_REG_INTMS);
+	else
+		disable_irq_nowait(nvmeq->irq);
+}
+
+static void nvme_poll_unmask(struct nvme_queue *nvmeq)
+{
+	struct nvme_dev *dev =3D nvmeq->dev;
+
+	if (!test_and_clear_bit(NVMEQ_IRQ_MASKED, &nvmeq->flags))
+		return;
+	if (dev->use_int_mask)
+		writel(BIT(nvmeq->cq_vector), dev->bar + NVME_REG_INTMC);
+	else
+		enable_irq(nvmeq->irq);
+}
+
+static void nvme_poll_end(struct nvme_queue *nvmeq)
+{
+	nvme_poll_unmask(nvmeq);
+	clear_bit(NVMEQ_POLLING, &nvmeq->flags);
+
+	if (nvme_cqe_pending(nvmeq) &&
+	    test_bit(NVMEQ_ENABLED, &nvmeq->flags) &&
+	    !test_and_set_bit(NVMEQ_POLLING, &nvmeq->flags)) {
+		nvme_poll_mask(nvmeq);
+		nvmeq->poll_idle =3D 0;
+		nvme_poll_arm(nvmeq);
+	}
+}
+
+static enum hrtimer_restart nvme_poll_timer(struct hrtimer *t)
+{
+	struct nvme_queue *nvmeq =3D container_of(t, struct nvme_queue, poll_ti=
mer);
+
+	if (test_bit(NVMEQ_POLLING, &nvmeq->flags))
+		irq_poll_sched(&nvmeq->iopoll);
+	return HRTIMER_NORESTART;
+}
+
+static int nvme_poll_softirq(struct irq_poll *iop, int budget)
+{
+	struct nvme_queue *nvmeq =3D container_of(iop, struct nvme_queue, iopol=
l);
+	DEFINE_IO_COMP_BATCH(iob);
+	unsigned long flags;
+	int found =3D 0;
+
+	spin_lock_irqsave(&nvmeq->poll_lock, flags);
+	if (unlikely(!test_bit(NVMEQ_POLLING, &nvmeq->flags)))
+		goto complete;
+	if (unlikely(test_bit(NVMEQ_POLL_PAUSED, &nvmeq->flags) ||
+		     !test_bit(NVMEQ_ENABLED, &nvmeq->flags) ||
+		     !nvme_poll_accessible(nvmeq)))
+		goto stopped;
+	spin_unlock_irqrestore(&nvmeq->poll_lock, flags);
+
+	spin_lock(&nvmeq->cq_poll_lock);
+	found =3D nvme_poll_cq_bounded(nvmeq, &iob, budget);
+	/* AER can freeze the channel while the CQ is being drained. */
+	if (found && nvme_poll_accessible(nvmeq))
+		nvme_ring_cq_doorbell(nvmeq);
+	spin_unlock(&nvmeq->cq_poll_lock);
+	if (!rq_list_empty(&iob.req_list))
+		nvme_pci_complete_batch(&iob);
+
+	spin_lock_irqsave(&nvmeq->poll_lock, flags);
+	nvmeq->dim_comps +=3D found;
+	nvme_poll_calibrate(nvmeq, found);
+
+	/* A full-budget return leaves irq_poll ownership with the core. */
+	if (found >=3D budget)
+		goto unlock;
+
+	if (unlikely(test_bit(NVMEQ_POLL_PAUSED, &nvmeq->flags) ||
+		     !test_bit(NVMEQ_ENABLED, &nvmeq->flags) ||
+		     !nvme_poll_accessible(nvmeq)))
+		goto stopped;
+
+	/* poll_lock joins all queue accesses after releasing SCHED. */
+	irq_poll_complete(iop);
+	if (found)
+		nvmeq->poll_idle =3D 0;
+	else
+		nvmeq->poll_idle++;
+
+	if (nvmeq->poll_idle > nvmeq->poll_idle_rounds ||
+	    nvmeq_cq_idle(nvmeq) ||
+	    time_after_eq(jiffies, nvmeq->poll_deadline))
+		nvme_poll_end(nvmeq);
+	else
+		nvme_poll_arm(nvmeq);
+	goto unlock;
+
+stopped:
+	/* Pause or teardown retains ownership of the interrupt mask. */
+	clear_bit(NVMEQ_POLLING, &nvmeq->flags);
+complete:
+	irq_poll_complete(iop);
+unlock:
+	spin_unlock_irqrestore(&nvmeq->poll_lock, flags);
+	return found;
+}
+
+static void nvme_poll_start(struct nvme_queue *nvmeq)
+{
+	nvme_poll_mask(nvmeq);
+	nvmeq->poll_idle =3D 0;
+	nvmeq->poll_deadline =3D jiffies + msecs_to_jiffies(irq_poll_timeout_ms=
);
+	nvme_poll_arm(nvmeq);
+}
+
+/* Caller holds shutdown_lock to serialize pause, resume and IRQ removal=
. */
+static void nvme_poll_pause(struct nvme_queue *nvmeq)
+{
+	unsigned long flags;
+
+	lockdep_assert_held(&nvmeq->dev->shutdown_lock);
+	if (!test_bit(NVMEQ_HYBRID, &nvmeq->flags))
+		return;
+
+	spin_lock_irqsave(&nvmeq->poll_lock, flags);
+	if (test_and_set_bit(NVMEQ_POLL_PAUSED, &nvmeq->flags)) {
+		spin_unlock_irqrestore(&nvmeq->poll_lock, flags);
+		return;
+	}
+	if (nvme_poll_accessible(nvmeq))
+		nvme_poll_mask(nvmeq);
+	spin_unlock_irqrestore(&nvmeq->poll_lock, flags);
+
+	synchronize_irq(nvmeq->irq);
+	irq_poll_disable(&nvmeq->iopoll);
+	/* irq_poll_complete() can release SCHED before its caller returns. */
+	spin_lock_irqsave(&nvmeq->poll_lock, flags);
+	clear_bit(NVMEQ_POLLING, &nvmeq->flags);
+	spin_unlock_irqrestore(&nvmeq->poll_lock, flags);
+	hrtimer_cancel(&nvmeq->poll_timer);
+}
+
+static void nvme_poll_resume(struct nvme_queue *nvmeq)
+{
+	unsigned long flags;
+
+	lockdep_assert_held(&nvmeq->dev->shutdown_lock);
+	if (!test_bit(NVMEQ_HYBRID, &nvmeq->flags) ||
+	    !test_bit(NVMEQ_ENABLED, &nvmeq->flags))
+		return;
+
+	spin_lock_irqsave(&nvmeq->poll_lock, flags);
+	if (test_bit(NVMEQ_POLL_PAUSED, &nvmeq->flags) &&
+	    nvme_poll_accessible(nvmeq)) {
+		irq_poll_enable(&nvmeq->iopoll);
+		clear_bit(NVMEQ_POLL_PAUSED, &nvmeq->flags);
+		nvme_poll_unmask(nvmeq);
+	}
+	spin_unlock_irqrestore(&nvmeq->poll_lock, flags);
+}
+
+static void nvme_pause_io_poll(struct nvme_dev *dev)
+{
+	int i;
+
+	for (i =3D dev->ctrl.queue_count - 1; i > 0; i--)
+		nvme_poll_pause(&dev->queues[i]);
+}
+
+static bool nvme_resume_io_poll(struct nvme_dev *dev)
+{
+	int i;
+
+	lockdep_assert_held(&dev->shutdown_lock);
+	if (!use_adaptive_irq_polling || use_threaded_interrupts)
+		return true;
+	if (nvme_ctrl_state(&dev->ctrl) !=3D NVME_CTRL_LIVE ||
+	    nvme_pci_ctrl_is_dead(dev))
+		return false;
+	for (i =3D 1; i < dev->ctrl.queue_count; i++)
+		nvme_poll_resume(&dev->queues[i]);
+	return true;
+}
+
+static void nvme_poll_quiesce(struct nvme_queue *nvmeq)
+{
+	unsigned long flags;
+
+	nvme_poll_pause(nvmeq);
+	spin_lock_irqsave(&nvmeq->poll_lock, flags);
+	/* PAUSED makes a replay harmless until pci_free_irq() joins it. */
+	if (nvme_poll_accessible(nvmeq))
+		nvme_poll_unmask(nvmeq);
+	spin_unlock_irqrestore(&nvmeq->poll_lock, flags);
+	irq_poll_enable(&nvmeq->iopoll);
+}
+
+/* Mirror of rdma_dim_step() bounded to our profile table. */
+static int nvme_dim_step(struct dim *dim)
+{
+	if (dim->tune_state =3D=3D DIM_GOING_RIGHT) {
+		if (dim->profile_ix =3D=3D ARRAY_SIZE(nvme_poll_prof) - 1)
+			return DIM_ON_EDGE;
+		dim->profile_ix++;
+		dim->steps_right++;
+	}
+	if (dim->tune_state =3D=3D DIM_GOING_LEFT) {
+		if (dim->profile_ix =3D=3D 0)
+			return DIM_ON_EDGE;
+		dim->profile_ix--;
+		dim->steps_left++;
+	}
+	return DIM_STEPPED;
+}
+
+/* Mirror of rdma_dim_stats_compare(): completion rate first, then batch=
ing. */
+static int nvme_dim_stats_compare(struct dim_stats *curr, struct dim_sta=
ts *prev)
+{
+	if (!prev->cpms)
+		return DIM_STATS_SAME;
+
+	if (IS_SIGNIFICANT_DIFF(curr->cpms, prev->cpms))
+		return curr->cpms > prev->cpms ? DIM_STATS_BETTER :
+						 DIM_STATS_WORSE;
+
+	if (IS_SIGNIFICANT_DIFF(curr->cpe_ratio, prev->cpe_ratio))
+		return curr->cpe_ratio > prev->cpe_ratio ? DIM_STATS_BETTER :
+							   DIM_STATS_WORSE;
+
+	return DIM_STATS_SAME;
+}
+
+/* Mirror of rdma_dim_decision(); returns true if the profile changed. *=
/
+static bool nvme_dim_decision(struct dim_stats *curr, struct dim *dim)
+{
+	int prev_ix =3D dim->profile_ix;
+	int stats_res;
+
+	stats_res =3D nvme_dim_stats_compare(curr, &dim->prev_stats);
+	switch (stats_res) {
+	case DIM_STATS_SAME:
+		if (curr->cpe_ratio <=3D 50 * prev_ix)
+			dim->profile_ix =3D 0;
+		break;
+	case DIM_STATS_WORSE:
+		dim_turn(dim);
+		fallthrough;
+	case DIM_STATS_BETTER:
+		if (nvme_dim_step(dim) =3D=3D DIM_ON_EDGE)
+			dim_turn(dim);
+		break;
+	}
+
+	dim->prev_stats =3D *curr;
+	return dim->profile_ix !=3D prev_ix;
+}
+
+static void nvme_dim(struct nvme_queue *nvmeq)
+{
+	struct dim *dim =3D &nvmeq->dim;
+	struct dim_sample end;
+	struct dim_stats stats;
+
+	if (dim->state =3D=3D DIM_START_MEASURE) {
+		dim_update_sample_with_comps(nvmeq->dim_events, 0, 0,
+					     nvmeq->dim_comps, &dim->start_sample);
+		dim->state =3D DIM_MEASURE_IN_PROGRESS;
+		return;
+	}
+
+	/* Cheap gate: only recompute once a full window of events accrues. */
+	if ((u16)(nvmeq->dim_events - dim->start_sample.event_ctr) < DIM_NEVENT=
S)
+		return;
+
+	dim_update_sample_with_comps(nvmeq->dim_events, 0, 0, nvmeq->dim_comps,
+				     &end);
+	if (dim_calc_stats(&dim->start_sample, &end, &stats)) {
+		if (READ_ONCE(irq_poll_profile) >=3D 0) {
+			u8 ix =3D nvme_fixed_profile();
+
+			if (dim->profile_ix !=3D ix) {
+				dim->profile_ix =3D ix;
+				nvme_apply_profile(nvmeq);
+			}
+		} else if (nvme_dim_decision(&stats, dim)) {
+			nvme_apply_profile(nvmeq);
+		}
+		trace_nvme_dim(nvmeq->qid, stats.cpms, stats.epms,
+			       stats.cpe_ratio, dim->profile_ix,
+			       nvmeq->poll_sleep_us);
+	}
+	dim->start_sample =3D end;
+}
+
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	struct nvme_queue *nvmeq =3D data;
-	DEFINE_IO_COMP_BATCH(iob);
=20
-	if (nvme_poll_cq(nvmeq, &iob)) {
-		if (!rq_list_empty(&iob.req_list))
-			nvme_pci_complete_batch(&iob);
+	if (nvme_poll_cq(nvmeq, 0))
 		return IRQ_HANDLED;
-	}
 	return IRQ_NONE;
 }
=20
@@ -1881,6 +2340,56 @@ static irqreturn_t nvme_irq_check(int irq, void *d=
ata)
 	return IRQ_NONE;
 }
=20
+static irqreturn_t nvme_irq_adaptive(int irq, void *data)
+{
+	struct nvme_queue *nvmeq =3D data;
+	DEFINE_IO_COMP_BATCH(iob);
+	unsigned long flags;
+	irqreturn_t ret =3D IRQ_HANDLED;
+	bool enabled;
+	int found;
+
+	spin_lock_irqsave(&nvmeq->poll_lock, flags);
+	if (unlikely(test_bit(NVMEQ_POLL_PAUSED, &nvmeq->flags) ||
+		     !nvme_poll_accessible(nvmeq)))
+		goto unlock;
+	nvmeq->dim_events++;
+	if (test_and_set_bit(NVMEQ_POLLING, &nvmeq->flags))
+		goto unlock;
+	enabled =3D test_bit(NVMEQ_ENABLED, &nvmeq->flags);
+	spin_unlock_irqrestore(&nvmeq->poll_lock, flags);
+
+	found =3D nvme_poll_cq_bounded(nvmeq, &iob,
+				     enabled ? nvmeq->poll_budget : 0);
+	if (found && nvme_poll_accessible(nvmeq))
+		nvme_ring_cq_doorbell(nvmeq);
+	if (!rq_list_empty(&iob.req_list))
+		nvme_pci_complete_batch(&iob);
+
+	spin_lock_irqsave(&nvmeq->poll_lock, flags);
+	nvmeq->dim_comps +=3D found;
+	if (unlikely(test_bit(NVMEQ_POLL_PAUSED, &nvmeq->flags) ||
+		     !nvme_poll_accessible(nvmeq)))
+		goto release;
+	nvme_dim(nvmeq);
+	if (!found) {
+		ret =3D IRQ_NONE;
+		goto release;
+	}
+
+	/* Leftover CQEs have already spent their interrupt. */
+	if (enabled && test_bit(NVMEQ_ENABLED, &nvmeq->flags) &&
+	    (nvme_cqe_pending(nvmeq) || nvmeq_cq_continue(nvmeq))) {
+		nvme_poll_start(nvmeq);
+		goto unlock;
+	}
+release:
+	clear_bit(NVMEQ_POLLING, &nvmeq->flags);
+unlock:
+	spin_unlock_irqrestore(&nvmeq->poll_lock, flags);
+	return ret;
+}
+
 /*
  * Poll for completions for any interrupt driven queue
  * Can be called from any context.
@@ -1894,24 +2403,24 @@ static void nvme_poll_irqdisable(struct nvme_queu=
e *nvmeq)
=20
 	irq =3D pci_irq_vector(pdev, nvmeq->cq_vector);
 	disable_irq(irq);
-	spin_lock(&nvmeq->cq_poll_lock);
-	nvme_poll_cq(nvmeq, NULL);
-	spin_unlock(&nvmeq->cq_poll_lock);
+	spin_lock_bh(&nvmeq->cq_poll_lock);
+	__nvme_poll_cq(nvmeq, NULL, 0);
+	spin_unlock_bh(&nvmeq->cq_poll_lock);
 	enable_irq(irq);
 }
=20
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *i=
ob)
 {
 	struct nvme_queue *nvmeq =3D hctx->driver_data;
-	bool found;
+	int found;
=20
 	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags) ||
 	    !nvme_cqe_pending(nvmeq))
 		return 0;
=20
-	spin_lock(&nvmeq->cq_poll_lock);
-	found =3D nvme_poll_cq(nvmeq, iob);
-	spin_unlock(&nvmeq->cq_poll_lock);
+	spin_lock_bh(&nvmeq->cq_poll_lock);
+	found =3D __nvme_poll_cq(nvmeq, iob, 0);
+	spin_unlock_bh(&nvmeq->cq_poll_lock);
=20
 	return found;
 }
@@ -1953,6 +2462,7 @@ static int nvme_pci_subsystem_reset(struct nvme_ctr=
l *ctrl)
 		goto unlock;
 	}
=20
+	nvme_pause_io_poll(dev);
 	writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
=20
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
@@ -1964,6 +2474,8 @@ static int nvme_pci_subsystem_reset(struct nvme_ctr=
l *ctrl)
 	 * pcie read error.
 	 */
 	readl(dev->bar + NVME_REG_CSTS);
+	/* Leave polling paused if recovery has made the controller unusable. *=
/
+	nvme_resume_io_poll(dev);
 unlock:
 	mutex_unlock(&dev->shutdown_lock);
 	return ret;
@@ -2284,8 +2796,12 @@ static void nvme_suspend_queue(struct nvme_dev *de=
v, unsigned int qid)
 	nvmeq->dev->online_queues--;
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		nvme_quiesce_admin_queue(&nvmeq->dev->ctrl);
-	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags))
+	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags)) {
+		if (test_bit(NVMEQ_HYBRID, &nvmeq->flags))
+			nvme_poll_quiesce(nvmeq);
 		pci_free_irq(to_pci_dev(dev->dev), nvmeq->cq_vector, nvmeq);
+		clear_bit(NVMEQ_HYBRID, &nvmeq->flags);
+	}
 }
=20
 static void nvme_suspend_io_queues(struct nvme_dev *dev)
@@ -2307,9 +2823,10 @@ static void nvme_reap_pending_cqes(struct nvme_dev=
 *dev)
 	int i;
=20
 	for (i =3D dev->ctrl.queue_count - 1; i > 0; i--) {
-		spin_lock(&dev->queues[i].cq_poll_lock);
-		nvme_poll_cq(&dev->queues[i], NULL);
-		spin_unlock(&dev->queues[i].cq_poll_lock);
+		spin_lock_bh(&dev->queues[i].cq_poll_lock);
+		/* The controller is disabled; only reap CQ memory. */
+		nvme_poll_cq_bounded(&dev->queues[i], NULL, 0);
+		spin_unlock_bh(&dev->queues[i].cq_poll_lock);
 	}
 }
=20
@@ -2385,6 +2902,10 @@ static int nvme_alloc_queue(struct nvme_dev *dev, =
int qid, int depth)
 	nvmeq->dev =3D dev;
 	spin_lock_init(&nvmeq->sq_lock);
 	spin_lock_init(&nvmeq->cq_poll_lock);
+	spin_lock_init(&nvmeq->poll_lock);
+	hrtimer_setup(&nvmeq->poll_timer, nvme_poll_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_PINNED_HARD);
+	irq_poll_init(&nvmeq->iopoll, 64, nvme_poll_softirq);
 	nvmeq->cq_head =3D 0;
 	nvmeq->cq_phase =3D 1;
 	nvmeq->q_db =3D &dev->dbs[qid * 2 * dev->db_stride];
@@ -2404,14 +2925,24 @@ static int queue_request_irq(struct nvme_queue *n=
vmeq)
 {
 	struct pci_dev *pdev =3D to_pci_dev(nvmeq->dev->dev);
 	int nr =3D nvmeq->dev->ctrl.instance;
+	int ret;
=20
-	if (use_threaded_interrupts) {
+	if (use_threaded_interrupts)
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
 				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
-	} else {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
-				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+
+	/* Masking requires a vector this I/O queue does not share. */
+	if (use_adaptive_irq_polling && nvmeq->qid &&
+	    nvmeq->dev->num_vecs > 1) {
+		nvmeq->irq =3D pci_irq_vector(pdev, nvmeq->cq_vector);
+		ret =3D pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_adaptive,
+				      NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+		if (!ret)
+			set_bit(NVMEQ_HYBRID, &nvmeq->flags);
+		return ret;
 	}
+	return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
+			NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
 }
=20
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
@@ -2423,6 +2954,19 @@ static void nvme_init_queue(struct nvme_queue *nvm=
eq, u16 qid)
 	nvmeq->last_sq_tail =3D 0;
 	nvmeq->cq_head =3D 0;
 	nvmeq->cq_phase =3D 1;
+	memset(&nvmeq->dim, 0, sizeof(nvmeq->dim));
+	nvmeq->dim.priv =3D nvmeq;
+	nvmeq->dim.profile_ix =3D nvme_fixed_profile();
+	nvme_apply_profile(nvmeq);
+	/* No completion rate measured yet: poll without sleeping until one is.=
 */
+	nvmeq->poll_sleep_us =3D 0;
+	nvmeq->dim.tune_state =3D DIM_GOING_RIGHT;
+	nvmeq->dim_events =3D 0;
+	nvmeq->dim_comps =3D 0;
+	clear_bit(NVMEQ_POLLING, &nvmeq->flags);
+	clear_bit(NVMEQ_IRQ_MASKED, &nvmeq->flags);
+	clear_bit(NVMEQ_HYBRID, &nvmeq->flags);
+	clear_bit(NVMEQ_POLL_PAUSED, &nvmeq->flags);
 	nvmeq->q_db =3D &dev->dbs[qid * 2 * dev->db_stride];
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq));
 	nvme_dbbuf_init(dev, nvmeq, qid);
@@ -3272,6 +3816,7 @@ static int nvme_setup_io_queues(struct nvme_dev *de=
v)
 		goto out_unlock;
 	}
=20
+	dev->use_int_mask =3D !pdev->msix_enabled;
 	dev->num_vecs =3D result;
 	result =3D max(result - 1, 1);
 	dev->max_qid =3D result + dev->io_queues[HCTX_TYPE_POLL];
@@ -3294,10 +3839,11 @@ static int nvme_setup_io_queues(struct nvme_dev *=
dev)
=20
 	if (dev->online_queues - 1 < dev->max_qid) {
 		nr_io_queues =3D dev->online_queues - 1;
-		nvme_delete_io_queues(dev);
 		result =3D nvme_setup_io_queues_trylock(dev);
 		if (result)
 			return result;
+		nvme_pause_io_poll(dev);
+		nvme_delete_io_queues(dev);
 		nvme_suspend_io_queues(dev);
 		goto retry;
 	}
@@ -3551,6 +4097,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, =
bool shutdown)
 	}
=20
 	nvme_quiesce_io_queues(&dev->ctrl);
+	nvme_pause_io_poll(dev);
=20
 	if (!dead && dev->ctrl.queue_count > 0) {
 		nvme_delete_io_queues(dev);
@@ -4175,6 +4722,7 @@ static int nvme_resume(struct device *dev)
 {
 	struct nvme_dev *ndev =3D pci_get_drvdata(to_pci_dev(dev));
 	struct nvme_ctrl *ctrl =3D &ndev->ctrl;
+	bool resumed;
=20
 	if (ndev->last_ps =3D=3D U32_MAX ||
 	    nvme_set_power_state(ctrl, ndev->last_ps) !=3D 0)
@@ -4182,9 +4730,16 @@ static int nvme_resume(struct device *dev)
 	if (ctrl->hmpre && nvme_setup_host_mem(ndev))
 		goto reset;
=20
+	mutex_lock(&ndev->shutdown_lock);
+	resumed =3D nvme_resume_io_poll(ndev);
+	mutex_unlock(&ndev->shutdown_lock);
+	if (!resumed)
+		goto reset;
 	return 0;
 reset:
-	return nvme_try_sched_reset(ctrl);
+	if (nvme_ctrl_state(ctrl) =3D=3D NVME_CTRL_RESETTING)
+		return nvme_try_sched_reset(ctrl);
+	return nvme_reset_ctrl(ctrl);
 }
=20
 static int nvme_suspend(struct device *dev)
@@ -4192,6 +4747,7 @@ static int nvme_suspend(struct device *dev)
 	struct pci_dev *pdev =3D to_pci_dev(dev);
 	struct nvme_dev *ndev =3D pci_get_drvdata(pdev);
 	struct nvme_ctrl *ctrl =3D &ndev->ctrl;
+	bool poll_paused =3D false;
 	int ret =3D -EBUSY;
=20
 	ndev->last_ps =3D U32_MAX;
@@ -4219,8 +4775,14 @@ static int nvme_suspend(struct device *dev)
 	nvme_wait_freeze(ctrl);
 	nvme_sync_queues(ctrl);
=20
-	if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE)
+	mutex_lock(&ndev->shutdown_lock);
+	if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE) {
+		mutex_unlock(&ndev->shutdown_lock);
 		goto unfreeze;
+	}
+	nvme_pause_io_poll(ndev);
+	poll_paused =3D true;
+	mutex_unlock(&ndev->shutdown_lock);
=20
 	/*
 	 * Host memory access may not be successful in a system suspend state,
@@ -4260,6 +4822,11 @@ static int nvme_suspend(struct device *dev)
 		ctrl->npss =3D 0;
 	}
 unfreeze:
+	if (ret && poll_paused) {
+		mutex_lock(&ndev->shutdown_lock);
+		nvme_resume_io_poll(ndev);
+		mutex_unlock(&ndev->shutdown_lock);
+	}
 	nvme_unfreeze(ctrl);
 	return ret;
 }
@@ -4314,6 +4881,9 @@ static pci_ers_result_t nvme_error_detected(struct =
pci_dev *pdev,
 	case pci_channel_io_perm_failure:
 		dev_warn(dev->ctrl.device,
 			"failure state error detected, request disconnect\n");
+		mutex_lock(&dev->shutdown_lock);
+		nvme_pause_io_poll(dev);
+		mutex_unlock(&dev->shutdown_lock);
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 	return PCI_ERS_RESULT_NEED_RESET;
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index ad25ad1e40412..4bdd5abc60880 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -498,3 +498,4 @@ const char *nvme_trace_disk_name(struct trace_seq *p,=
 char *name)
 }
=20
 EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_sq);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_dim);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 4fb5922ffdac5..c7020388f9688 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -161,6 +161,32 @@ TRACE_EVENT(nvme_sq,
 	)
 );
=20
+TRACE_EVENT(nvme_dim,
+	TP_PROTO(u16 qid, int cpms, int epms, int cpe_ratio, u8 profile,
+		 unsigned int sleep_us),
+	TP_ARGS(qid, cpms, epms, cpe_ratio, profile, sleep_us),
+	TP_STRUCT__entry(
+		__field(u16, qid)
+		__field(int, cpms)
+		__field(int, epms)
+		__field(int, cpe_ratio)
+		__field(u8, profile)
+		__field(unsigned int, sleep_us)
+	),
+	TP_fast_assign(
+		__entry->qid =3D qid;
+		__entry->cpms =3D cpms;
+		__entry->epms =3D epms;
+		__entry->cpe_ratio =3D cpe_ratio;
+		__entry->profile =3D profile;
+		__entry->sleep_us =3D sleep_us;
+	),
+	TP_printk("qid=3D%u cpms=3D%d epms=3D%d cpe_ratio=3D%d profile=3D%u sle=
ep_us=3D%u",
+		__entry->qid, __entry->cpms, __entry->epms,
+		__entry->cpe_ratio, __entry->profile, __entry->sleep_us
+	)
+);
+
 #endif /* _TRACE_NVME_H */
=20
 #undef TRACE_INCLUDE_PATH
--=20
2.52.0

