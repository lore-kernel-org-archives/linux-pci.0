Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB5830C15B
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143448; cv=none; b=m4tMglAl/1kjyulrl+jjimyCBbDsYll39bSotG9c8nakBArd6WZ/B6E2AIixOEz/8d4H5lqdfTqnHHdaZT8TpOKGAhMEGsmmb8Q3kwUu3kzQk0+PzPVuT68pEnBWWAeVfQA96aEMv+sZLSyTSf8rnuwgvi0U1bDiwUBJ7rvNc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143448; c=relaxed/simple;
	bh=A1KBG7Ax/8AKi8Isyu+Y2QFb+3dSt59+RI7QmdoANfk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gN8Ndc51xHflla9BTkKvNkYuRytDFrPZu+alB/tQnM24FRDEl6+Nu2xhNRy2B7vdvMB+FkKhMLGaQjqknN3uu1fx1R2iqTLeHT8edhBSgVvRjtCzZ6YUxZGvqyKVjx25AFB5hk5ebUU7koaKcgnMiO+8x5puv/TrfnXA3zIffMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XdAtu4Tc; arc=none smtp.client-ip=209.85.167.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XdAtu4Tc"
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5aebd5e989cso762110e87.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787143442; x=1787748242; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gxSlDtVCWpSOQOgYo4sL5Y8CxzWFyIGgo+drWq4mnP4=;
        b=XdAtu4TcgjJPO/wtC3iqVQTl0AGoTwhbPNvHXkoFBl6KNhNi2x7G5CG8/k7hG7dLvH
         T4cCRM27XLlxeyLo7lpq2lVZrPjT8nl03JOHNY9uTTvua07R/w9qWK49yK+ZecGMgCUa
         luEB+sf/clcSe1CznUBpXjE0zdoj4pArwxu9INlv3OIQDYm5jAyZCrR63uJiyLu2TlOa
         I77NSbtgxzAENfXBvQtuyiDhNzlgqMVfusURdyTrcIU0o4LEJj0M/ctMKZyN/LQoaCK1
         Ob0Zozf7vLlMWadcUN2XsydBKQtK2oEDg2mMiuaOZOqya4u+sXHYBxx3oOinbl2xYjE2
         jcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143442; x=1787748242;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gxSlDtVCWpSOQOgYo4sL5Y8CxzWFyIGgo+drWq4mnP4=;
        b=Fut5wUw2Nv+vVtRg7uyz/CgdWs0ACpDUHlYcrLs5x7Y/eRVsWqargXKDu4Y/6iHUq2
         qgn/4kgWdP0zHBXcTDWdn4G1zIqFnYBf7VdhJAzblWN7q+0ZKh6DpHspYBUb0v7MWqsG
         AvV7Kgk/lzsUM+HzytefzhAVJG/Eud2zyYQyo4F/W3qxrOxzPE4hfcbVgc8ItVZuYDTP
         CXG6QHRVSNp0Z4Hbm1FLjJdE2yJ9ChrRzgaZ75gIzlwbuj6MWBR+haqUkIa4u46aiUjd
         05LHEiNWELmP2h8iyvqgjSxb3V4/r19bAEv0XbDkYhnOKtz7ZWDS2s1DR1ILUijaHUCY
         vPAw==
X-Forwarded-Encrypted: i=1; AHgh+Rq3dV7fU4NhyYZqtk+oGF7qgjTk5iyjZKWGobdqczfcqUlMgsvOAOrdF9OsKTznCXeQvpMVgiNE7hA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8SnMYfFFknJH3FryRhjZ/ISKwY4KViPsMP+Lv0wO2zQlZIna7
	nJHNwpNnAq0rxEEVY/Wxk03/VQWzaH45xQW3aiH+uPOv4K+p9gBffSYPvWphyCmKpIJmZ3VyojP
	2m97bPw==
X-Received: from lfhl6.prod.google.com ([2002:ac2:4306:0:b0:5b1:4ed1:9fa])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6512:a82:b0:5b2:e95a:491d
 with SMTP id 2adb3069b0e04-5b478bbe9e7mr1484145e87.9.1787143441463; Wed, 19
 Aug 2026 05:44:01 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:43:39 +0000
In-Reply-To: <20260819124341.4185621-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260819124341.4185621-1-lrizzo@google.com>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260819124341.4185621-6-lrizzo@google.com>
Subject: [PATCH v5 5/7] genirq: Add GSIM user space configuration (procfs)
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce procfs interfaces to configure and monitor GSIM at runtime.

This adds:
- A global directory /proc/irq/sw_moderation/ containing:
  - delay_us: Read/write interface to set/get the maximum moderation
    delay in microseconds (defaults to 0, GSIM disabled).
  - stats: Read-only interface to monitor GSIM statistics per-CPU.
- files /proc/irq/NN/allow_sw_moderation (where NN is the IRQ number) to
  individually allow/disallow moderation. Created only for interrupts
  that support moderation (e.g., edge-triggered, single-target, etc.).

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 kernel/irq/internals.h      |   4 +
 kernel/irq/irq_moderation.c | 256 +++++++++++++++++++++++++++++++++++-
 kernel/irq/proc.c           |   2 +
 3 files changed, 261 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 705c3bfe28e12..22a1926910f34 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -403,6 +403,8 @@ static inline void irq_moderation_init_fields(struct irq_desc *desc)
 
 int irq_moderation_allow(struct irq_desc *desc, bool allow);
 bool irq_moderation_supported(struct irq_desc *desc);
+void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode);
+void irq_moderation_procfs_remove(struct irq_desc *desc);
 #else
 static inline void irq_moderation_init_fields(struct irq_desc *desc) {}
 static inline int irq_moderation_allow(struct irq_desc *desc, bool allow)
@@ -410,4 +412,6 @@ static inline int irq_moderation_allow(struct irq_desc *desc, bool allow)
 	return allow ? -EOPNOTSUPP : 0;
 }
 static inline bool irq_moderation_supported(struct irq_desc *desc) { return false; }
+static inline void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode) {}
+static inline void irq_moderation_procfs_remove(struct irq_desc *desc) {}
 #endif
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
index 2c75feb6634f3..1474d33455410 100644
--- a/kernel/irq/irq_moderation.c
+++ b/kernel/irq/irq_moderation.c
@@ -11,6 +11,8 @@
 #include <linux/irqdesc.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/suspend.h>
 
 #include "internals.h"
@@ -24,6 +26,21 @@
  * GSIM runs after the handler to implement software interrupt moderation
  * with programmable delay.
  *
+ * Configuration is done at runtime via procfs
+ *   echo ${VALUE} > /proc/irq/sw_moderation/${NAME}
+ *
+ * Supported parameters:
+ *
+ *   delay_us (default 0, suggested 100, 0 off, range 0-500)
+ *       Maximum moderation delay. A reasonable range is 20-100. Higher values
+ *       can be useful if the hardirq handler has long runtimes.
+ *
+ * Moderation is allowed/disallowed dynamically for individual interrupts with
+ *   echo 1 > /proc/irq/NN/allow_sw_moderation # use 0 to disallow
+ *
+ * Monitoring of per-cpu and global statistics is available via procfs
+ *   cat /proc/irq/sw_moderation/stats
+ *
  * === ARCHITECTURE ===
  *
  * INTERRUPT HANDLING (for interrupt types that support moderation)
@@ -101,6 +118,8 @@ DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
 
 DEFINE_STATIC_KEY_FALSE(irq_moderation_enabled_key);
 
+static DEFINE_MUTEX(swmod_mutex);
+
 static void update_enable_key(void)
 {
 	if (irq_mod_params.delay_ns != 0)
@@ -139,6 +158,185 @@ bool irq_moderation_do_start(struct irq_desc *desc, struct irq_mod_state *m)
 	return true;
 }
 
+/*
+ * struct var_info - target and limits for parameters
+ * @ptr:	pointer to the value, NULL if not used.
+ * @min:	minimum value allowed
+ * @max:	maximum value allowed
+ * @scale:	scale factor between procfs and internal.
+ */
+struct var_info {
+	unsigned int	*ptr;
+	unsigned int	min;
+	unsigned int	max;
+	unsigned int	scale;
+};
+
+/*
+ * struct swmod_procfs_entry - description for procfs entries and parameter limits
+ * @name:	name in procfs. If NULL, the entry is only for limit checks.
+ * @wr:		write handler for procfs. NULL if readonly
+ * @rd:		read handler for procfs.
+ * @var:	variable address and limits, if used.
+ */
+struct swmod_procfs_entry {
+	const char	*name;
+	ssize_t		(*wr)(struct var_info *n, const char __user *s, size_t count);
+	void		(*rd)(struct seq_file *p);
+	struct var_info	var;
+};
+
+static ssize_t swmod_wr(struct var_info *v, const char __user *s, size_t count)
+{
+	unsigned int value;
+	int ret;
+
+	ret = kstrtouint_from_user(s, count, 0, &value);
+	if (ret)
+		return ret;
+	if (value < v->min || value > v->max)
+		return -ERANGE;
+	WRITE_ONCE(*v->ptr, value * v->scale);
+	return count;
+}
+
+static void swmod_rd(struct seq_file *p)
+{
+	struct swmod_procfs_entry *n = p->private;
+
+	seq_printf(p, "%u\n", *n->var.ptr / n->var.scale);
+}
+
+static ssize_t swmod_wr_delay(struct var_info *v, const char __user *s, size_t count)
+{
+	ssize_t ret = swmod_wr(v, s, count);
+
+	if (ret >= 0)
+		update_enable_key();
+	return ret;
+}
+
+#define HEAD_FMT "%5s  %8s  %11s  %11s\n"
+#define BODY_FMT "%5u  %8u  %11u  %11u\n"
+
+/* Print statistics */
+static void rd_stats(struct seq_file *p)
+{
+	unsigned int delay_ns = READ_ONCE(irq_mod_params.delay_ns);
+	int cpu;
+
+	if (delay_ns == 0)
+		return;
+	seq_printf(p, HEAD_FMT,
+		   "# CPU", "delay_ns", "timer_set", "enqueue");
+
+	for_each_possible_cpu(cpu) {
+		/* Copy statistics, will only use some unsigned int values; races ok. */
+		struct irq_mod_state cur = data_race(*per_cpu_ptr(&irq_mod_state, cpu));
+
+		seq_printf(p, BODY_FMT,
+			   cpu,
+			   delay_ns,
+			   cur.timer_set,
+			   cur.enqueue);
+	}
+
+	seq_printf(p, "\n"
+		   "delay_us             %lu\n",
+		   delay_ns / NSEC_PER_USEC);
+}
+
+static int param_show(struct seq_file *p, void *v)
+{
+	struct swmod_procfs_entry *n = p->private;
+
+	n->rd(p);
+	return 0;
+}
+
+static int param_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, param_show, pde_data(inode));
+}
+
+static ssize_t param_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct swmod_procfs_entry *n = (struct swmod_procfs_entry *)pde_data(file_inode(f));
+	ssize_t ret;
+
+	if (!n->wr)
+		return -EINVAL;
+	mutex_lock(&swmod_mutex);
+	ret = n->wr(&n->var, buf, count);
+	mutex_unlock(&swmod_mutex);
+	return ret;
+}
+
+static const struct proc_ops param_ops = {
+	.proc_open	= param_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+	.proc_write	= param_write,
+};
+
+/* Handlers for /proc/irq/NN/allow_sw_moderation */
+static int allow_flag_show(struct seq_file *p, void *v)
+{
+	struct irq_desc *desc = irq_to_desc((long)p->private);
+
+	if (!desc)
+		return -ENODEV;
+
+	seq_puts(p, irq_settings_moderatable(desc) ? "on\n" : "off\n");
+	return 0;
+}
+
+
+static ssize_t allow_flag_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct irq_desc *desc = irq_to_desc((long)pde_data(file_inode(f)));
+	bool allow;
+	int ret;
+
+	if (!desc)
+		return -ENODEV;
+
+	ret = kstrtobool_from_user(buf, count, &allow);
+
+	if (!ret) {
+		guard(raw_spinlock_irq)(&desc->lock);
+		ret = irq_moderation_allow(desc, allow);
+	}
+	return ret ? : count;
+}
+
+static int allow_flag_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, allow_flag_show, pde_data(inode));
+}
+
+static const struct proc_ops allow_flag_ops = {
+	.proc_open	= allow_flag_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+	.proc_write	= allow_flag_write,
+};
+
+void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode)
+{
+	if (!irq_moderation_supported(desc))
+		return;
+	proc_create_data("allow_sw_moderation", umode, desc->dir,
+			 &allow_flag_ops, (void *)(long)desc->irq_data.irq);
+}
+
+void irq_moderation_procfs_remove(struct irq_desc *desc)
+{
+	remove_proc_entry("allow_sw_moderation", desc->dir);
+}
+
 static void clean_moderation_state(struct irq_desc *desc)
 {
 	/*
@@ -267,10 +465,41 @@ struct notifier_block mod_nb = {
 	.priority	= 100,
 };
 
+/* Helper to initialize the struct var_info. */
+#define SET_VAR(_ptr, _min, _max, _scale)					\
+	{ .ptr = (_ptr), .min = (_min), .max = (_max), .scale = (_scale), }
+
+static struct swmod_procfs_entry procfs_entries[] = {
+	{
+		.name	= "delay_us",
+		.wr	= swmod_wr_delay,
+		.rd	= swmod_rd,
+		.var	= SET_VAR(&irq_mod_params.delay_ns, 0, 500, NSEC_PER_USEC),
+	},
+	{
+		.name = "stats",
+		.rd = rd_stats,
+	},
+};
+
 static int __init init_irq_moderation(void)
 {
+	struct proc_dir_entry *dir;
 	int cpuhp_state;
-	int ret;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(procfs_entries); i++) {
+		struct var_info *v = &procfs_entries[i].var;
+
+		if (!v->ptr)
+			continue;
+		if (*v->ptr >= v->min * v->scale && *v->ptr <= v->max * v->scale)
+			continue;
+		pr_err("%s: Parameter %s: value %u out of bounds [%u,%u]\n",
+		       __func__, procfs_entries[i].name ? : "no-name",
+		       *v->ptr / v->scale, v->min, v->max);
+		return -ERANGE;
+	}
 
 	cpuhp_state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "sw_moderation",
 					cpu_setup_cb, cpu_remove_cb);
@@ -285,10 +514,35 @@ static int __init init_irq_moderation(void)
 		goto cleanup;
 	}
 
+	/* Safe because /proc/irq is created earlier, in kernel_init_freeable(). */
+	dir = proc_mkdir("irq/sw_moderation", NULL);
+	if (!dir) {
+		pr_err("%s: Failed to create procfs directory\n", __func__);
+		goto cleanup_1;
+	}
+	for (i = 0; i < ARRAY_SIZE(procfs_entries); i++) {
+		struct swmod_procfs_entry *n = &procfs_entries[i];
+
+		if (!n->name || proc_create_data(n->name, n->wr ? 0644 : 0444, dir, &param_ops, n))
+			continue;
+		pr_err("%s: Failed to create procfs entry %s\n", __func__, n->name);
+		for (i--; i >= 0; i--) {
+			n = &procfs_entries[i];
+			if (n->name)
+				remove_proc_entry(n->name, dir);
+		}
+		remove_proc_entry("irq/sw_moderation", NULL);
+		goto cleanup_1;
+	}
+
 	/* Enable if the defaults require it. */
 	update_enable_key();
 	return 0;
 
+cleanup_1:
+	ret = -ENOMEM;
+	unregister_pm_notifier(&mod_nb);
+
 cleanup:
 	cpuhp_remove_state(cpuhp_state);
 	return ret;
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 1b835725f7b1c..edffb30efab58 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -379,6 +379,7 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 				irq_effective_aff_list_proc_show, irqp);
 # endif
 #endif
+	irq_moderation_procfs_add(desc, 0644);
 	proc_create_single_data("spurious", 0444, desc->dir,
 				irq_spurious_proc_show, (void *)(long)irq);
 
@@ -400,6 +401,7 @@ void unregister_irq_proc(unsigned int irq, struct irq_desc *desc)
 	remove_proc_entry("effective_affinity_list", desc->dir);
 # endif
 #endif
+	irq_moderation_procfs_remove(desc);
 	remove_proc_entry("spurious", desc->dir);
 
 	snprintf(name, MAX_NAMELEN, "%u", irq);
-- 
2.55.0.737.g08866a6d13-goog

