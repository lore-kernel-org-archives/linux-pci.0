Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74672DEA98
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143441; cv=none; b=IxMurRY6N8ko8ja5BS/bPMRT2V+1Yy24NgsZ6U1sMqQ4XwU4JVD+Wm/dLp4VaAiFyJrugIWDZ3DB9XAOYFtAxeDp+Snp/qod35ojPg8XfS5xXJGb2gACMuEFZg3sL7aiGc9s2uPiaNrxKycRVQxIRFCcC9KWXtnXnRPoMf2JXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143441; c=relaxed/simple;
	bh=kCVyzCwcZ6ZcbCcDFgtNaMRirAbiQLNUcJ9/50s9HXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BaIWprS/k5DEz+7cQM3JZdxzcCZx3vHOv0IZuLxfBOqfg78W36lMt8CYko5vGMuahzSEC1iFgru2YjTA8T+RxWauwcqpuxdhBy9zi5EBXnaTrlDwLcFkWFQnxy+gKBu9Q+6LEdVKLekbka/688OzSkPIu83YhLaySa/mCIPNHno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HfXvdPcv; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfXvdPcv"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-698557ec1e9so949604a12.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787143438; x=1787748238; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lOZr8zYhx3EDw1Z6Z0FGemAoEG9B6UahqKdYX8gOB9w=;
        b=HfXvdPcv1hvD993PiSfBTFlJcjGhn2XxQ6+183Isa9kx0dgYr5KBteF4cw38MEqglg
         aVFyKJ7r8qUCTbTY8IX2gqTGmF2zX5kDyw1zPcNxBlyGY2zYxZ7BfzF2ek9wrhc0907+
         5vWgYELBfAxauXRWxLW2vYoWN4rs+YpCU4JTCkwQIM0TRZU6UtohVfLiLcsmlTe1mteQ
         cEuA5El44L+Fsm+c9q5i0+dIg22YspErfAJ6lgbDguwj89r18325F99uC6MC5eCsES6G
         h19KEq9HJ0SlWPLLde2MK23MhmUOZBHHdC4VTOyC/FJTDtqkeoRvLms9AnFki2+lUOx/
         FEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143438; x=1787748238;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lOZr8zYhx3EDw1Z6Z0FGemAoEG9B6UahqKdYX8gOB9w=;
        b=tX81ErS9SVV77i8pMjue78e8RSw58QIESV/ZH4KARpjVh0iLckVzq30sbmr8b0i9oQ
         ZteF4pXEeFQmO+a8biuTGaXFXVTlNMGBgjTJEQQ4wbynx3RpJLcJEeN68T58nH2aeHOb
         bdt9MBEpFffUNLkheDc2WZXF+ZXR+rUpx2WOYNVtRKyz6fCLMh3zs6qR3IRUt6aoENpg
         BuavMaPJHa5VhCe+GfHNrLOF2e6w+ecRHJ7wVyVT1hktnTmmjv2K86EN5Uvx5EV/4Utc
         UtVcHzcjM8dLPGvyRzLMeEWvHeYD6vPuhO+pnKW8Bc/u608rFt8kRimZupWQJaJKGH33
         H9rA==
X-Forwarded-Encrypted: i=1; AHgh+RqG1Ofqgf7vE4aJNdt57CymFg+7lJ8TAKNtXXxqBa1G3kdLY41cbcUL7zdSyzc0+FcgjlCBy19AoEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3li/l3YocN3q99MZJ23WwI3GMm+uPrPV8YOIjk3vl6u2JkmH9
	zirF2nWPLJ5qdNwuGaFYX7Uf5wKEZvZxyuA09Knk6bT8jYd3fiy4NBhbDyn6tN7rQte7K9CdmJW
	hIbPtng==
X-Received: from edoy17.prod.google.com ([2002:aa7:c251:0:b0:69a:a4ce:cc7d])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1f4f:b0:6a1:2400:baea
 with SMTP id 4fb4d7f45d1cf-6a4032f8e7dmr2997486a12.10.1787143437426; Wed, 19
 Aug 2026 05:43:57 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:43:36 +0000
In-Reply-To: <20260819124341.4185621-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260819124341.4185621-1-lrizzo@google.com>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260819124341.4185621-3-lrizzo@google.com>
Subject: [PATCH v5 2/7] genirq: Add GSIM infrastructure
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce the Kconfig option CONFIG_IRQ_SW_MODERATION and GSIM fields in
struct irq_desc to support Global Software Interrupt Moderation (GSIM).

Note: This commit only introduces the configuration option and basic
data structures. The core moderation logic, procfs interface, and
integration into the interrupt flow are implemented in subsequent
commits. Enabling this option at this stage is a build-safe no-op.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/irqdesc.h | 12 ++++++++++++
 kernel/irq/Kconfig      | 11 +++++++++++
 kernel/irq/internals.h  |  8 ++++++++
 kernel/irq/irqdesc.c    |  1 +
 4 files changed, 32 insertions(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 8080db17c1b1b..5ba130e224167 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -18,6 +18,16 @@ struct irq_desc;
 struct irq_domain;
 struct pt_regs;
 
+/**
+ * struct irq_desc_swmod - software interrupt moderation state
+ * @swmod_node:		list head for per-CPU list of moderated irq_desc
+ */
+struct irq_desc_swmod {
+#ifdef CONFIG_IRQ_SW_MODERATION
+	struct list_head	swmod_node;
+#endif
+};
+
 /**
  * struct irqstat - interrupt statistics
  * @cnt:	real-time interrupt count
@@ -59,6 +69,7 @@ struct irq_redirect {
  * @threads_handled_last: comparator field for deferred spurious detection of threaded handlers
  * @lock:		locking for SMP
  * @redirect:		Facility for redirecting interrupts via irq_work
+ * @swmod_state:	software interrupt moderation state
  * @affinity_hint:	hint to user space for preferred irq affinity
  * @affinity_notify:	context for notification of affinity changes
  * @pending_mask:	pending rebalanced interrupts
@@ -95,6 +106,7 @@ struct irq_desc {
 	atomic_t		threads_handled;
 	int			threads_handled_last;
 	raw_spinlock_t		lock;
+	struct irq_desc_swmod	swmod_state;
 	struct cpumask		*percpu_enabled;
 #ifdef CONFIG_SMP
 	struct irq_redirect	redirect;
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 05cba4e16dad1..d8d556b4a279d 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -150,6 +150,17 @@ config IRQ_KUNIT_TEST
 
 	  If unsure, say N.
 
+config IRQ_SW_MODERATION
+	bool "Enable Global Software Interrupt Moderation"
+	depends on PROC_FS
+	help
+	  Enable Global Software Interrupt Moderation.
+	  Uses a local timer to delay interrupts in configurable ways
+	  and depending on various global system load indicators
+	  and targets.
+
+	  If you don't know what to do here, say N.
+
 endmenu
 
 config GENERIC_IRQ_MULTI_HANDLER
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 0ce21dd454047..716a7c2e3633a 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -395,3 +395,11 @@ static inline struct irq_data *irqd_get_parent_data(struct irq_data *irqd)
 	return NULL;
 #endif
 }
+#ifdef CONFIG_IRQ_SW_MODERATION
+static inline void irq_moderation_init_fields(struct irq_desc *desc)
+{
+	INIT_LIST_HEAD(&desc->swmod_state.swmod_node);
+}
+#else
+static inline void irq_moderation_init_fields(struct irq_desc *desc) {}
+#endif
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 80ef4e27dcf47..e8488c9352d0c 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -120,6 +120,7 @@ static inline void free_masks(struct irq_desc *desc) { }
 static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 			      const struct cpumask *affinity, struct module *owner)
 {
+	irq_moderation_init_fields(desc);
 	desc->irq_common_data.handler_data = NULL;
 	desc->irq_common_data.msi_desc = NULL;
 
-- 
2.55.0.737.g08866a6d13-goog

