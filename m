Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52AA53C3C7
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930983; cv=none; b=KGHatOhCJb4QZy8bTNZydi8XWsqQmjeCcY+M6TlrqAn6h9pcc0q5gUMLXGR08hmw9U4Z85Z31V6f9Vy4ZNljoEjME06w1FAYwgGP08lKWiYjmGDvSLzsZBYWiy1yo5El63fKgKJz7cLpKi5V7bPn8LLrgmiN1oCOxTrB8052e1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930983; c=relaxed/simple;
	bh=dGrHkmn75O4txPA2TUSvgrf1Az3p2Wc157ZPXrt7ulI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/+AEonRuQi3AaxeHSf5v110hQNQMoDdZeoPNMlEg8t2ns577OihIvTMnJJMg1Fe2UQ6+4I0Qv3rjbOsB4Hi/z+ME5mhNTxjG24cHqjsOalo+c4jfjKATmpH4f/rWdrfJ3Z5wHcndZ7uGk5CX0vDxcnNwKLZteUC7qSeLYhMKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BnAK/aF2; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BnAK/aF2"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DKWlRt1625157
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 15:36:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=29WxjFdkcrrKHHzPghLMhnd38n3Qp1IUXwKe6
	tO1r7g=; b=BnAK/aF2wsV6EEfgrNBxfxx6n3H6ZPvGJP9M7Vvnm2a270Nrdwowr
	dz5erj/F/Rs0P5AFCNCBD/JaB3voU6g/fkO3SKw8CgHE9qbcC3lctay69sbdY2QW
	GYQrj1UqiLM04AbbGs6V7FPkeCkKRBoT/tmhpTM+DXcUry1NrVW1LSc0QQ0MK8OV
	n8jP8j3UDq3GpQcM0OUe5eLxKmY6fnLOTEEPvG1fE26o2KMhBISdFZWmODziAFQv
	jN19S21zmN8TI3FKlFWdo2xBb3GZE1dsGJKfI9fuA6Y5xRQJQykX0otdWPXGlRRc
	VcX4k9XwFjftxNl+bgoihYxEJtnrzEiXA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h9hc46f0v-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 15:36:16 -0700 (PDT)
Received: from twshared134145.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 13 Oct 2026 22:36:12 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 659352D52CB78; Tue, 13 Oct 2026 15:35:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <changfengnan@bytedance.com>, <linux-pci@vger.kernel.org>,
        <tglx@kernel.org>, <namjain@linux.microsoft.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [RFC PATCH 1/3] genirq: Add disable_irq_nowait()
Date: Tue, 13 Oct 2026 15:35:41 -0700
Message-ID: <20261013223543.395054-2-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=L86I0OT8 c=1 sm=1 tr=0 ts=6aceb260 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8 a=6pG0410DK98tSDJBP48A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfX/0tFLWR1Tv2j
 u6ARSadehT8/1WVnIJ8EHbabWa66whBsf5elD1TS3zvcAYN9HpoC8sjCovXuXAU6TPFEUp23OOF
 9k22ZlhtxMvYk1tM+cEC1pZO48DM/JI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfX+IeZbQbsb0Ru
 A5Ya+NVJ5zptuxSmtDTRFat6qTTND9FKMGO+m4BNRYwRiKjfN2BsvvGBAg0I9e7uLnpWoDegRW8
 m67fMA9W0ONTToGGdt18xu/iEhykjlfk1YhUqgojRUnWrgUcY+OCJLMR9QsRKfYPMSMQ86zClwP
 hKNuyQeMXzdOHh3bqeUuugCYVptK8xaEYmZBU4ObOsCpktMYgk5racl1Ii8zxLV7td+7AirWOt7
 aJBR7gbVByTJ/ZOON2hrnMgZzCqT3f2MWoHPW6dCvsZZxX1H8z2qVhGd3EAcYtkSBZ2r0UGeqBf
 632SDx2+cnkfmQScsIZn9GReSBlsa595grqgpOoZhTD0c2semX76z3pis8FdzPe/3c5E/JE1kpf
 fDWiXMJ8SFm0yEmGcducCV9LKsTyBdVGjNt9QpW39YHnS4+QF9W2Isbppcp5BpMW3b1w1pd+KLg
 BvY1CqZ0KSTZ9NRXWFQ==
X-Proofpoint-ORIG-GUID: kMlSvpab58yHJxk0VVPdLMdXtJMJMK0P
X-Proofpoint-GUID: kMlSvpab58yHJxk0VVPdLMdXtJMJMK0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Drivers that switch between interrupt and polled completions don't need
to wait for the mask to reach the device; the disabled state already
keeps their handler from running and a late interrupt is replayed on
enable. Add an optional irq_chip irq_mask_nowait() callback, falling
back to irq_mask(), and disable_irq_nowait() to mask through it right
away rather than lazily.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/interrupt.h |  1 +
 include/linux/irq.h       |  4 ++++
 kernel/irq/chip.c         | 31 +++++++++++++++++++++++++++++++
 kernel/irq/internals.h    |  1 +
 kernel/irq/manage.c       | 21 +++++++++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3bf969ad8fe07..d40c992ddb8a1 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -231,6 +231,7 @@ extern void devm_free_irq(struct device *dev, unsigne=
d int irq, void *dev_id);
=20
 bool irq_has_action(unsigned int irq);
 extern void disable_irq_nosync(unsigned int irq);
+extern void disable_irq_nowait(unsigned int irq);
 extern bool disable_hardirq(unsigned int irq);
 extern void disable_irq(unsigned int irq);
 extern void disable_percpu_irq(unsigned int irq);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index f485369b1b4f7..de095299f20ed 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -455,6 +455,9 @@ static inline irq_hw_number_t irqd_to_hwirq(struct ir=
q_data *d)
  * @irq_disable:	disable the interrupt
  * @irq_ack:		start of a new interrupt
  * @irq_mask:		mask an interrupt source
+ * @irq_mask_nowait:	mask an interrupt source without waiting for the
+ *			hardware to acknowledge it (optional, falls back to
+ *			@irq_mask)
  * @irq_mask_ack:	ack and mask an interrupt source
  * @irq_unmask:		unmask an interrupt source
  * @irq_eoi:		end of interrupt
@@ -505,6 +508,7 @@ struct irq_chip {
=20
 	void		(*irq_ack)(struct irq_data *data);
 	void		(*irq_mask)(struct irq_data *data);
+	void		(*irq_mask_nowait)(struct irq_data *data);
 	void		(*irq_mask_ack)(struct irq_data *data);
 	void		(*irq_unmask)(struct irq_data *data);
 	void		(*irq_eoi)(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index de754db414d1d..4e76f025b5f68 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -399,6 +399,37 @@ void irq_disable(struct irq_desc *desc)
 	__irq_disable(desc, irq_settings_disable_unlazy(desc));
 }
=20
+static void mask_irq_nowait(struct irq_desc *desc)
+{
+	if (irqd_irq_masked(&desc->irq_data))
+		return;
+
+	if (desc->irq_data.chip->irq_mask_nowait) {
+		desc->irq_data.chip->irq_mask_nowait(&desc->irq_data);
+		irq_state_set_masked(desc);
+	} else {
+		mask_irq(desc);
+	}
+}
+
+/**
+ * irq_disable_nowait - Mark interrupt disabled and mask it without wait=
ing
+ * @desc:	irq descriptor which should be disabled
+ *
+ * Like irq_disable() with lazy disable turned off, but the hardware may
+ * still deliver an interrupt after this returns. The flow handler deals
+ * with that the same way it does for a lazily disabled interrupt.
+ */
+void irq_disable_nowait(struct irq_desc *desc)
+{
+	if (desc->irq_data.chip->irq_disable) {
+		__irq_disable(desc, true);
+		return;
+	}
+	irq_state_set_disabled(desc);
+	mask_irq_nowait(desc);
+}
+
 void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu)
 {
 	if (desc->irq_data.chip->irq_enable)
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 0ce21dd454047..3ba13932ba831 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -98,6 +98,7 @@ extern void irq_startup_managed(struct irq_desc *desc);
 extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
+extern void irq_disable_nowait(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
 extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
 extern void mask_irq(struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 57eff26fa646a..7a4d7f1024133 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -705,6 +705,27 @@ void disable_irq_nosync(unsigned int irq)
 }
 EXPORT_SYMBOL(disable_irq_nosync);
=20
+/**
+ * disable_irq_nowait - mask an irq without waiting for the hardware
+ * @irq: Interrupt to disable
+ *
+ * Like disable_irq_nosync(), but masks the interrupt at the chip right =
away
+ * instead of lazily, and does not wait for the hardware to acknowledge =
the
+ * mask. An interrupt that still arrives is held pending and replayed by
+ * enable_irq(). Use this when an extra interrupt is cheaper than flushi=
ng
+ * the mask, e.g. switching from interrupts to polling.
+ *
+ * This function may be called from IRQ context.
+ */
+void disable_irq_nowait(unsigned int irq)
+{
+	scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		if (!scoped_irqdesc->depth++)
+			irq_disable_nowait(scoped_irqdesc);
+	}
+}
+EXPORT_SYMBOL_GPL(disable_irq_nowait);
+
 /**
  * disable_irq - disable an irq and wait for completion
  * @irq: Interrupt to disable
--=20
2.52.0

