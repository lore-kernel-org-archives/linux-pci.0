Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F237367B77
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143445; cv=none; b=RCt4GL+wgeGj44JOJQiV1ygi9wxqGP+aHu9UNTRcc0yP1F/ckN31iYmq1rXv3Gs/p37ddph594pVbjQ77QvGdPHVb9Ok5q9pH0llDxszb8gD5YYdqiu9KWJLFJOfGathbthV2CrCPr5472WQObmHkEnVIwIrKSRvLyFKwRCuWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143445; c=relaxed/simple;
	bh=Ox+d0B8XD1GDbofxCcqR2ba+haJM/n/mDwRsHvJc33c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pg1ng9njAYQ0Cl70mdn0TgpZ/QOq1Q2FqcFwKp4aCrL4J0YqEyNU5y+1NdZ+ONsgtns3zEukMB5L5NscTxcQBVOiXYb0k1GqT9OcxU+sRhj35mUlLnjMTDBkFbxI+1ZKt8XNlmy58PMwoOJqy9AwEk6f46Lm9LWulOoQYkd7faU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XWKhXt95; arc=none smtp.client-ip=209.85.218.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWKhXt95"
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1686e23b9cso73561266b.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 05:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787143440; x=1787748240; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lgslhZs5lHfUM6vsYvygJcRXohyJMB1GN9y8NyUjAaQ=;
        b=XWKhXt95SkQU+XYBRlYMs8s+PNWBwzk7/zYXLP3MouUU5h7mxSyUsczyOEIIDvhDIX
         YhP/U/wJFUjuWXzQrVGEttaf1XzV0JZQErpneHICyvgzmbv2lIFtrCpEtA2WlOnp+upr
         P8oNt2i+tcD7x+eKwyqQh1MJJfDma8N11lhkbbL7BaxJUATicHaUJrQ0nEuPTuCHqCrH
         66yv2eUtuiRjSavb/d5+dWlzPmJBDf3l8TDipEO8+w6mL78hSySTyTl4VrwA2ClMoY9F
         9xcBL5NzJ0FXBQtbhK3u3UsEpJcksJtdPcmjk6RLhoV17UmYmCUxwQXUg497MYWqjdC6
         9DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143440; x=1787748240;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lgslhZs5lHfUM6vsYvygJcRXohyJMB1GN9y8NyUjAaQ=;
        b=g2JkAe8GBbULj5pBU167E+Fm/Aor4GN+B/yT9HH127LtTqcG0HtPJu47lWdyM8U3M0
         McscpXdIxoQYMVGXxDjdlsaCcr5P16bBW9uRL3dH5nNDd0UEZTWdRQ84jKFKxo1VGwZl
         dMHur7+FTvENbpVqCe5zOZD2ZNthPvhzD0o4NbHQ/bmSM1i6PJ1tCQhI/7hEqlw4rPtU
         zxIMhMWyIZ9QCl6XKq3oEFe9jH6Ipc6cGGoAFcd3StZ2vP17JNzyGvFJN6rhVUZiR8vL
         m5sGx7ITgBleZVy5nB6/nIBYiPjv7xFN1fnJtJCErqRUY8TOT/Z5SvR5ZtU/xPu9Exox
         AzsA==
X-Forwarded-Encrypted: i=1; AHgh+Rr92LtgosmfgUVhUNIs5EyKeCEMaZdtNue70D124jD7Va3mTbjIyjKdN/bqnRqZ4wsdc9fpkI9WSPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywQN4PoZVRx4B0GxX/BF0SJQnXY+g21Dz2mg9YeP+BFU+C0G5M
	q6Y+ZxFneZI898YL+dVWH5MyuL2YCeNpt47/qOR0a2x0DdtUZjkQkqC0eOmXjgtIGKpiggRbov9
	fb2uyPw==
X-Received: from ejgi22.prod.google.com ([2002:a17:906:3c56:b0:c16:6d0e:5e64])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:6d08:b0:c20:5213:56f1
 with SMTP id a640c23a62f3a-c240544ed8dmr308638566b.13.1787143439988; Wed, 19
 Aug 2026 05:43:59 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:43:38 +0000
In-Reply-To: <20260819124341.4185621-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260819124341.4185621-1-lrizzo@google.com>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260819124341.4185621-5-lrizzo@google.com>
Subject: [PATCH v5 4/7] genirq: Integrate GSIM into interrupt flow
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Hook GSIM into edge/fasteoi handlers and teardown.

Specifically:
- Hook GSIM into handle_edge_irq() and handle_fasteoi_irq().
- Introduce `irq_moderation_allow(desc, allow)` to validate if an IRQ
  is eligible for GSIM (non-oneshot, edge/fasteoi, single target, no bus lock)
  and set/clear the IRQ_MODERATABLE flag.
- Integrate GSIM setup in __setup_irq() using `irq_moderation_allow()`,
  defaulting to disabled (`use_moderation = false`).
- Clear GSIM state in __free_irq() and __cleanup_nmi().

Note: At this stage, GSIM is disabled by default (use_moderation = false) and
cannot be enabled at runtime yet. Subsequent commits will introduce procfs
configuration and a configurable default mode. For testing this commit,
use_moderation can be manually set to true in the code.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 kernel/irq/chip.c           | 14 +++++++++++++
 kernel/irq/internals.h      |  8 +++++++
 kernel/irq/irq_moderation.c | 42 +++++++++++++++++++++++++++++++++++++
 kernel/irq/manage.c         | 10 +++++++++
 4 files changed, 74 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index de754db414d1d..04a30ba04e78b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -20,6 +20,7 @@
 #include <trace/events/irq.h>
 
 #include "internals.h"
+#include "irq_moderation.h"
 
 static irqreturn_t bad_chained_irq(int irq, void *dev_id)
 {
@@ -500,6 +501,10 @@ static bool irq_can_handle_pm(struct irq_desc *desc)
 		return false;
 	}
 
+	/* Moderated interrupts have IRQD_IRQ_INPROGRESS and need early return. */
+	if (irqd_is_moderated(irqd))
+		return false;
+
 	/* Check whether the interrupt is polled on another CPU */
 	if (unlikely(desc->istate & IRQS_POLL_INPROGRESS)) {
 		if (WARN_ONCE(irq_poll_cpu == smp_processor_id(),
@@ -749,6 +754,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 	 * handling the previous one - it may need to be resent.
 	 */
 	if (!irq_can_handle_pm(desc)) {
+		if (irqd_is_moderated(&desc->irq_data)) {
+			desc->istate |= IRQS_PENDING;
+			mask_irq(desc);
+		}
 		if (irqd_needs_resend_when_in_progress(&desc->irq_data))
 			desc->istate |= IRQS_PENDING;
 		cond_eoi_irq(chip, &desc->irq_data);
@@ -769,6 +778,9 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 
 	cond_unmask_eoi_irq(desc, chip);
 
+	if (irq_start_moderation(desc))
+		return;
+
 	/*
 	 * When the race described above happens this will resend the interrupt.
 	 */
@@ -858,6 +870,8 @@ void handle_edge_irq(struct irq_desc *desc)
 
 		handle_irq_event(desc);
 
+		if (irq_start_moderation(desc))
+			break;
 	} while ((desc->istate & IRQS_PENDING) && !irqd_irq_disabled(&desc->irq_data));
 }
 EXPORT_SYMBOL(handle_edge_irq);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 716a7c2e3633a..705c3bfe28e12 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -400,6 +400,14 @@ static inline void irq_moderation_init_fields(struct irq_desc *desc)
 {
 	INIT_LIST_HEAD(&desc->swmod_state.swmod_node);
 }
+
+int irq_moderation_allow(struct irq_desc *desc, bool allow);
+bool irq_moderation_supported(struct irq_desc *desc);
 #else
 static inline void irq_moderation_init_fields(struct irq_desc *desc) {}
+static inline int irq_moderation_allow(struct irq_desc *desc, bool allow)
+{
+	return allow ? -EOPNOTSUPP : 0;
+}
+static inline bool irq_moderation_supported(struct irq_desc *desc) { return false; }
 #endif
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
index 8f8893d952de0..2c75feb6634f3 100644
--- a/kernel/irq/irq_moderation.c
+++ b/kernel/irq/irq_moderation.c
@@ -294,3 +294,45 @@ static int __init init_irq_moderation(void)
 	return ret;
 }
 device_initcall(init_irq_moderation);
+
+bool irq_moderation_supported(struct irq_desc *desc)
+{
+	struct irq_data *irqd = &desc->irq_data;
+	struct irq_chip *chip = irqd->chip;
+
+	/* GSIM does not support shared interrupts */
+	if (desc->action && desc->action->next)
+		return false;
+
+	if (desc->istate & IRQS_ONESHOT)
+		return false;
+	if (irqd_is_level_type(irqd))
+		return false;
+	if (!irqd_is_single_target(irqd))
+		return false;
+	if (chip->irq_bus_lock || chip->irq_bus_sync_unlock)
+		return false;
+	if (!chip->irq_mask || !chip->irq_unmask)
+		return false;
+	if (desc->handle_irq != handle_edge_irq && desc->handle_irq != handle_fasteoi_irq)
+		return false;
+	return true;
+}
+
+int irq_moderation_allow(struct irq_desc *desc, bool allow)
+{
+	lockdep_assert_held(&desc->lock);
+
+	if (!allow) {
+		irq_settings_clr_moderatable(desc);
+		return 0;
+	}
+
+	if (!irq_moderation_supported(desc)) {
+		irq_settings_clr_moderatable(desc);
+		return -EOPNOTSUPP;
+	}
+
+	irq_settings_set_moderatable(desc);
+	return 0;
+}
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7eb07e3bdb4c2..ce92885e71323 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1470,6 +1470,12 @@ static bool valid_percpu_irqaction(struct irqaction *old, struct irqaction *new)
 static int
 __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 {
+	/*
+	 * Choose the default moderation mode.
+	 * Hardcoded to false for now; configurable defaults are added later.
+	 * Set to true here to force-enable GSIM for testing this commit.
+	 */
+	bool use_moderation = false;
 	struct irqaction *old, **old_ptr;
 	unsigned long flags, thread_mask = 0;
 	int ret, nested, shared = 0;
@@ -1789,6 +1795,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 
 	irq_pm_install_action(desc, new);
 
+	irq_moderation_allow(desc, use_moderation);
+
 	/* Reset broken irq detection when installing new handler */
 	desc->irq_count = 0;
 	desc->irqs_unhandled = 0;
@@ -1897,6 +1905,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	/* If this was the last handler, shut down the IRQ line: */
 	if (!desc->action) {
 		irq_settings_clr_disable_unlazy(desc);
+		irq_settings_clr_moderatable(desc);
 		/* Only shutdown. Deactivate after synchronize_hardirq() */
 		irq_shutdown(desc);
 	}
@@ -2046,6 +2055,7 @@ static const void *__cleanup_nmi(unsigned int irq, struct irq_desc *desc)
 		desc->action = NULL;
 
 		irq_settings_clr_disable_unlazy(desc);
+		irq_settings_clr_moderatable(desc);
 		irq_shutdown_and_deactivate(desc);
 	}
 
-- 
2.55.0.737.g08866a6d13-goog

