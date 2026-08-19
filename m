Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C82F5A2D
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143443; cv=none; b=kNqyiIvN7+VcFdFRF8Hbirp8doM76F74ifviesZopvZiEmVxNvz/guRVf90KB9+2EGE17IO7tarD1ysfzlXN0PlKzB8hnscKfckFHn9iVz/L7VW6Zc3NsmLRzbjosEcl+ZgrGBqYSXGuVgECMZrRYcrQdTQGNnl+xlafxF0RsXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143443; c=relaxed/simple;
	bh=IjTJqwhFGVDI4FVEfIUW6Az24jC7ENWkPSA/4XTgYZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gAzUwEr3R/QsNu3ErDBSUkZoE6joqI0uxbdCBSpUqbQSu7NKb/+ac9o8xEb0gRXoy3LP5jrpzOo+ngPBPc1Rcj2irbzpHaBGiK38yQOfqvohSkXpEtbmOJK+Q8fj29XgWrfGgEbz3aoi828vmhmBofUJsTxEsl+of2n/6MMGvuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEspwffA; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEspwffA"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15c32294e1so80119966b.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787143439; x=1787748239; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFxkMDZOQBabx4zg7nJClUru9l/HhQ40JvBa/Y+K1tQ=;
        b=OEspwffAypz5bcTCUi7q5twV0W+6CgUBaRbP8RzarOVFPw6IHDmMH6y0GOdU/fuC6D
         2GXRcgO7Qf4SzIVXQSKCt9zZmh2hM6T33GOWZE4GOxAajcfqTLybRaSirj2spk5+afo3
         SFzH2XAXVXn3bwsQ/QNKjDF8Dfw1I7KWR9bEZn1pFx+Iu9Sk2wbZe9BTXeQlvkg4Kzmg
         i2f8PugiI/k9SNWABgxbwGhlDDAafpLGKQQAemDRxkOE6sADX35l69YAaZMjeYHEHVdc
         qxDv/4180BMllDpATEuX4fYCC5pZNTggFhGTbFfPNyKSliX8e4bVQV9t+ThtAh30V5P+
         6j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143439; x=1787748239;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aFxkMDZOQBabx4zg7nJClUru9l/HhQ40JvBa/Y+K1tQ=;
        b=i0jLVuE9DCUjs/5QeIQWxq77/J2abrYLDkb9GIpfyIK69uyaZ8z6/jWJmH0TDjnfhS
         84pZrID9Sp8N9Jjf3MujOOJLwQlvyCGFz/+C5W0gvkD59R40X5/IjpY7fE21C0CElt05
         wV1A6pXw9jh4LrqWglIRwLoxvyJpZJ05KEe52awqiMpWqc2uPphNNj8B4GJmjt9g88FN
         8VQrr0JgRD/N0VwDAsTCZ9RrOVZjbPK29ej57LAoeNIxNNphRQ3KSfHfIfZj3P9hmQDz
         ZLuVwkumwDDYHka13N0gxTWfj1CzH52QRfbA0uQlbtxVCOQKIpSNHQksQhubiRpRBLQ5
         01Xg==
X-Forwarded-Encrypted: i=1; AHgh+RpNIPYBfvb6kzYYtE8fVHNNKrJTJ1ofFJBDuamOheBg32Iuggvqdjh2ybdWP8bah1lWrYRgEw+89w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhicNH0wfSQipWpdzQ2b3E1UuR3bNwKYGKdpgjKnFU+diqFs08
	BRR5JE0y4FwTSQrL3luulHVBltzfla9RFxUFCZErYfyrwVdrf42wsUgPtWUw1v4Dumq7k14CHT4
	Y/I6f7A==
X-Received: from ejdb4.prod.google.com ([2002:a17:906:1504:b0:c15:d08f:480a])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7b96:b0:c19:45df:1856
 with SMTP id a640c23a62f3a-c242e249bc0mr225824566b.17.1787143438894; Wed, 19
 Aug 2026 05:43:58 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:43:37 +0000
In-Reply-To: <20260819124341.4185621-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260819124341.4185621-1-lrizzo@google.com>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260819124341.4185621-4-lrizzo@google.com>
Subject: [PATCH v5 3/7] genirq: Implement core GSIM moderation logic
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce the core GSIM moderation logic, including full documentation
of the architecture, per-CPU state tracking, basic list-draining
functions and hooks for the interrupt handlers.

Note: The architecture documentation describes how GSIM integrates with
the interrupt flow handlers (e.g. handle_edge_irq, handle_fasteoi_irq).
These handlers are modified and GSIM is integrated in subsequent commits.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 kernel/irq/Makefile         |   1 +
 kernel/irq/irq_moderation.c | 296 ++++++++++++++++++++++++++++++++++++
 kernel/irq/irq_moderation.h |  93 +++++++++++
 3 files changed, 390 insertions(+)
 create mode 100644 kernel/irq/irq_moderation.c
 create mode 100644 kernel/irq/irq_moderation.h

diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index 86a2e5ae08f9a..07c19d4697712 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_GENERIC_IRQ_CHIP) += generic-chip.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_IRQ_DOMAIN) += irqdomain.o
 obj-$(CONFIG_IRQ_SIM) += irq_sim.o
+obj-$(CONFIG_IRQ_SW_MODERATION) += irq_moderation.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
 obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
new file mode 100644
index 0000000000000..8f8893d952de0
--- /dev/null
+++ b/kernel/irq/irq_moderation.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+
+/*
+ * Copyright (C) 2025-2026 Google LLC
+ *
+ * Global Software Interrupt Moderation (GSIM) core logic.
+ */
+
+#include <linux/cpuhotplug.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/suspend.h>
+
+#include "internals.h"
+#include "irq_moderation.h"
+
+/*
+ * Global Software Interrupt Moderation (GSIM)
+ *
+ * Some platforms show reduced I/O performance when the total device interrupt
+ * rate across the entire platform becomes too high. To address the problem,
+ * GSIM runs after the handler to implement software interrupt moderation
+ * with programmable delay.
+ *
+ * === ARCHITECTURE ===
+ *
+ * INTERRUPT HANDLING (for interrupt types that support moderation)
+ * - irq_start_moderation() runs under desc->lock right after the interrupt handler.
+ *   If the interrupt must be moderated, sets IRQD_IRQ_INPROGRESS and IRQD_MODERATED,
+ *   calls __disable_irq(), adds the irq_desc to a per-CPU list of moderated interrupts,
+ *   and starts a moderation timer if not yet active;
+ * - handle_xx_irq() is modified so that when called on a moderated irq_desc it
+ *   calls mask_irq(), sets IRQS_PENDING and returns immediately;
+ * - the timer callback drains the moderation list: on each irq_desc it acquires
+ *   desc->lock, and if desc->action != NULL calls __enable_irq(), possibly calling
+ *   the handler if IRQS_PENDING is set.
+ *
+ * INTERRUPT TEARDOWN
+ * It is protected by IRQD_IRQ_INPROGRESS and checking desc->action != NULL.
+ * This works because free_irq() runs in two steps:
+ * - first clear desc->action (under lock),
+ * - then call synchronize_irq(), which blocks on IRQD_IRQ_INPROGRESS
+ *   before freeing resources.
+ * When the moderation timer races with free_irq() we can have two cases:
+ * 1. timer runs before clearing desc->action. In this case __enable_irq()
+ *    is valid and the subsequent free_irq() will complete as intended
+ * 2. desc->action is cleared before the timer runs. In this case synchronize_irq()
+ *    will block until the timer expires (remember moderation delays are very short,
+ *    comparable to C-state exit times), __enable_irq() will not be run,
+ *    and free_irq() will complete successfully.
+ *
+ * INTERRUPT MIGRATION
+ * It is protected by IRQD_IRQ_INPROGRESS that prevents running the handler on the
+ * new CPU while an interrupt is moderated.
+ *
+ * HOTPLUG
+ * During CPU shutdown, the kernel moves timers and reassigns interrupt affinity
+ * to a new CPU. The easiest way and most robust way to guarantee that pending
+ * events are handled correctly is to use a per-CPU "moderation_allowed" flag
+ * and hotplug callbacks on CPUHP_AP_ONLINE_DYN (some others are equally good):
+ * - on setup, set the flag. That will allow interrupts to be moderated.
+ * - on shutdown, with interrupts disabled, 1. clear the flag thus preventing
+ *   more interrupts to be moderated on that CPU, 2. flush the list of moderated
+ *   interrupts (as if the timer had fired), and 3. cancel the timer.
+ * This avoids depending with the internals of the up/down sequence.
+ *
+ * STATIC ENABLING
+ * GSIM is disabled by default (delay_ns = 0). To statically enable it:
+ * 1. Initialize irq_mod_params.delay_ns to a non-zero value (e.g., 100000 for 100us)
+ *    in kernel/irq/irq_moderation.c.
+ * 2. Call irq_settings_set_moderatable(desc) during interrupt allocation
+ *    (e.g., in __setup_irq() in kernel/irq/manage.c) for the desired interrupts.
+ *
+ * SUSPEND & HIBERNATION
+ * During Suspend-to-RAM or Suspend-to-Disk (Hibernation), secondary CPUs are
+ * taken offline, which triggers the CPU hotplug teardown and setup callbacks.
+ * However, the boot processor is never taken offline via hotplug.
+ *
+ * To ensure the boot processor's GSIM state is safely drained/disabled before
+ * suspend, and safely re-enabled after resume/restore, we register a PM notifier.
+ *
+ * The PM notifier handles all suspend, hibernation, and restore transitions:
+ * - On prepare (*_PREPARE): runs mod_pm_prepare_cb() on all CPUs (via IPI)
+ *   to clear the allowed flag and drain pending moderated interrupts, and
+ *   then cancels GSIM timers on all online CPUs outside IPI context.
+ * - On resume/restore (POST_*): runs mod_pm_resume_cb() on all CPUs to
+ *   safely re-allow moderation. We do NOT run cpu_setup_cb() here to avoid
+ *   dangerous double-initialization of active hrtimers or list heads on
+ *   already-online secondary CPUs.
+ */
+
+/*
+ * GSIM parameters. Initialize delay_ns here to statically enable moderation
+ * (e.g. .delay_ns = 100000).
+ */
+struct irq_mod_params irq_mod_params ____cacheline_aligned;
+
+DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
+
+DEFINE_STATIC_KEY_FALSE(irq_moderation_enabled_key);
+
+static void update_enable_key(void)
+{
+	if (irq_mod_params.delay_ns != 0)
+		static_branch_enable(&irq_moderation_enabled_key);
+	else
+		static_branch_disable(&irq_moderation_enabled_key);
+}
+
+/* Actually start moderation. */
+bool irq_moderation_do_start(struct irq_desc *desc, struct irq_mod_state *m)
+{
+	lockdep_assert_held(&desc->lock);
+
+	if (!hrtimer_is_queued(&m->timer)) {
+		const unsigned int min_delay_ns = 10000;
+		const u64 slack_ns = 2000;
+
+		/* Accumulate sleep time, no moderation if too small. */
+		m->sleep_ns += READ_ONCE(irq_mod_params.delay_ns);
+		if (m->sleep_ns < min_delay_ns)
+			return false;
+		/* We need moderation, start the timer. */
+		m->timer_set++;
+		hrtimer_start_range_ns(&m->timer, ns_to_ktime(m->sleep_ns),
+				       slack_ns, HRTIMER_MODE_REL_PINNED_HARD);
+	}
+
+	/*
+	 * Add to the timer list, set appropriate flags, and call
+	 * __disable_irq() to prevent serving subsequent interrupts.
+	 */
+	m->enqueue++;
+	list_add(&desc->swmod_state.swmod_node, &m->descs);
+	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS | IRQD_MODERATED);
+	__disable_irq(desc);
+	return true;
+}
+
+static void clean_moderation_state(struct irq_desc *desc)
+{
+	/*
+	 * Clearing IRQD_IRQ_INPROGRESS allows synchronize_irq() to complete,
+	 * signaling that GSIM teardown for this descriptor is finished.
+	 */
+	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS | IRQD_MODERATED);
+	/* Only enable if action is set, protect against concurrent free_irq(). */
+	if (desc->action)
+		__enable_irq(desc);
+}
+
+/* Used on timer expiration or CPU shutdown. */
+static void drain_desc_list(struct irq_mod_state *m)
+{
+	struct irq_desc *desc, *next;
+
+	/* Remove from list and enable interrupts back. */
+	list_for_each_entry_safe(desc, next, &m->descs, swmod_state.swmod_node) {
+		guard(raw_spinlock)(&desc->lock);
+		list_del_init(&desc->swmod_state.swmod_node);
+		clean_moderation_state(desc);
+	}
+}
+
+static enum hrtimer_restart timer_callback(struct hrtimer *timer)
+{
+	struct irq_mod_state *m = this_cpu_ptr(&irq_mod_state);
+
+	lockdep_assert_irqs_disabled();
+
+	drain_desc_list(m);
+	/* Prepare to accumulate next moderation delay. */
+	m->sleep_ns = 0;
+	return HRTIMER_NORESTART;
+}
+
+/* Hotplug callback for setup. */
+static int cpu_setup_cb(unsigned int cpu)
+{
+	struct irq_mod_state *m = this_cpu_ptr(&irq_mod_state);
+
+	hrtimer_setup(&m->timer, timer_callback, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
+	INIT_LIST_HEAD(&m->descs);
+	/* Ensure initialization is visible before setting the flag. */
+	smp_store_release(&m->initialized, true);
+	m->moderation_allowed = true;
+	return 0;
+}
+
+/*
+ * Hotplug callback for shutdown.
+ * Mark the CPU as offline for moderation, and drain the list of masked
+ * interrupts. Any subsequent interrupt on this CPU will not be
+ * moderated, but they will be on the new target.
+ */
+static int cpu_remove_cb(unsigned int cpu)
+{
+	struct irq_mod_state *m = this_cpu_ptr(&irq_mod_state);
+
+	/* Protect the desc list, interrupts could modify it. */
+	scoped_guard(irqsave) {
+		m->moderation_allowed = false;
+		drain_desc_list(m);
+	}
+	/* Run hrtimer_cancel() outside hardirq/IPI context. */
+	hrtimer_cancel(&m->timer);
+	/* Ensure state is visible before clearing the flag. */
+	smp_store_release(&m->initialized, false);
+	return 0;
+}
+
+static void mod_pm_prepare_cb(void *arg)
+{
+	struct irq_mod_state *m = this_cpu_ptr(&irq_mod_state);
+
+	/* Called via IPI so local interrupts are disabled. */
+	if (mod_state_initialized(m)) {
+		m->moderation_allowed = false;
+		drain_desc_list(m);
+	}
+}
+
+static void mod_pm_resume_cb(void *arg)
+{
+	struct irq_mod_state *m = this_cpu_ptr(&irq_mod_state);
+
+	/*
+	 * The hrtimer and list head are already initialized (either at boot
+	 * or during hotplug CPU online). We must not re-initialize them here
+	 * as they might already be active if devices resumed and fired
+	 * interrupts before this notifier ran.
+	 */
+	if (mod_state_initialized(m))
+		m->moderation_allowed = true;
+}
+
+static int mod_pm_notifier_cb(struct notifier_block *nb, unsigned long event, void *unused)
+{
+	int cpu;
+
+	switch (event) {
+	case PM_SUSPEND_PREPARE:
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		on_each_cpu(mod_pm_prepare_cb, NULL, 1);
+		/* Run hrtimer_cancel() outside hardirq/IPI context. */
+		for_each_online_cpu(cpu) {
+			struct irq_mod_state *m = per_cpu_ptr(&irq_mod_state, cpu);
+
+			if (mod_state_initialized(m))
+				hrtimer_cancel(&m->timer);
+		}
+		break;
+	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		on_each_cpu(mod_pm_resume_cb, NULL, 1);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+struct notifier_block mod_nb = {
+	.notifier_call	= mod_pm_notifier_cb,
+	.priority	= 100,
+};
+
+static int __init init_irq_moderation(void)
+{
+	int cpuhp_state;
+	int ret;
+
+	cpuhp_state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "sw_moderation",
+					cpu_setup_cb, cpu_remove_cb);
+	if (cpuhp_state < 0) {
+		pr_err("%s: Failed to setup hotplug notifier\n", __func__);
+		return cpuhp_state;
+	}
+
+	ret = register_pm_notifier(&mod_nb);
+	if (ret < 0) {
+		pr_err("%s: Failed to register pm notifier\n", __func__);
+		goto cleanup;
+	}
+
+	/* Enable if the defaults require it. */
+	update_enable_key();
+	return 0;
+
+cleanup:
+	cpuhp_remove_state(cpuhp_state);
+	return ret;
+}
+device_initcall(init_irq_moderation);
diff --git a/kernel/irq/irq_moderation.h b/kernel/irq/irq_moderation.h
new file mode 100644
index 0000000000000..8df350651cd7c
--- /dev/null
+++ b/kernel/irq/irq_moderation.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+
+/*
+ * Copyright (C) 2025-2026 Google LLC
+ *
+ * Common data structures for Global Software Interrupt Moderation, GSIM
+ */
+
+#ifndef _LINUX_IRQ_MODERATION_H
+#define _LINUX_IRQ_MODERATION_H
+
+#ifdef CONFIG_IRQ_SW_MODERATION
+
+#include <linux/hrtimer.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/kernel.h>
+
+/**
+ * struct irq_mod_params - configuration parameters
+ * @delay_ns:		maximum delay
+ */
+struct irq_mod_params {
+	unsigned int	delay_ns;
+};
+
+extern struct irq_mod_params irq_mod_params;
+
+/**
+ * struct irq_mod_state - per-CPU moderation state
+ *
+ * Used on every interrupt:
+ * @timer:		moderation timer
+ * @initialized:	true if hrtimer and list head are initialized
+ * @moderation_allowed:	per-CPU flag, toggled during hotplug/suspend events
+ * @sleep_ns:		accumulated time for actual delay
+ *
+ * Used once per moderation delay per interrupt source:
+ * @descs:		list of	moderated irq_desc on this CPU
+ * @enqueue:		how many enqueue on the list
+ *
+ * Statistics
+ * @timer_set:		how many timer_set calls
+ */
+struct irq_mod_state {
+	struct hrtimer		timer;
+	bool			initialized;
+	bool			moderation_allowed;
+	unsigned int		sleep_ns;
+	struct list_head	descs;
+	unsigned int		enqueue;
+	unsigned int		timer_set;
+};
+
+DECLARE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
+
+static inline bool mod_state_initialized(struct irq_mod_state *m)
+{
+	/*
+	 * There is no public API in the hrtimer or list subsystems to check
+	 * if they are initialized. We use this flag to avoid dereferencing
+	 * uninitialized pointers during CPU hotplug/suspend races.
+	 */
+	return smp_load_acquire(&m->initialized);
+}
+
+extern struct static_key_false irq_moderation_enabled_key;
+
+bool irq_moderation_do_start(struct irq_desc *desc, struct irq_mod_state *m);
+
+/*
+ * Call after running the handler, with lock held. If this source should be
+ * moderated, disable it, add to the timer list for this CPU and return true,
+ * and exit from handle_*_irq() without processing IRQS_PENDING, because
+ * that will happen when the moderation timer fires and calls __enable_irq().
+ */
+static inline bool irq_start_moderation(struct irq_desc *desc)
+{
+	struct irq_mod_state *m = this_cpu_ptr(&irq_mod_state);
+
+	if (static_branch_unlikely(&irq_moderation_enabled_key) &&
+	    irq_settings_moderatable(desc) &&
+	    m->moderation_allowed) {
+		return irq_moderation_do_start(desc, m);
+	}
+	return false;
+}
+
+#else /* CONFIG_IRQ_SW_MODERATION */
+static inline bool irq_start_moderation(struct irq_desc *desc) { return false; }
+#endif /* CONFIG_IRQ_SW_MODERATION */
+
+#endif /* _LINUX_IRQ_MODERATION_H */
-- 
2.55.0.737.g08866a6d13-goog

