Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106CA3DE43D
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143449; cv=none; b=Q6ZgYn6Vgoe9metHoVEDENlor/PoAUyRHlIRA8T4xVtAAo6KwJUycXkHPExE9vdtcM/AeYbfkK1cFM2HB4So4a8RKebUe6rELA3d3cRSbvMdfoWT0daKjqhCECvEs6f7Oq1vVVyXcTYQqcp0WBDvvUHnvd9gieaOcUbN4vOy1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143449; c=relaxed/simple;
	bh=ovoju7LxqUNwF1NpKHUrgY7Zv0XswIrL5zt3gNzoZn8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OsXl5r6sjAdeA5RK7Yvc8YtjXUe5C9K259B1QuVvew9wNqL+nhhcRQrtNEqGyaBhqBqCw4nwMEVw0QLKEo6eNR2TaAAtn9XIDCHPKUtWyrphJ45/4NKbK8mTxbyiaMOLLhWcoi23H7OtyIW/HX+sdIUH4bYIMDa6s8IMHvT+JN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDuBCmoM; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDuBCmoM"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c16740eb587so73993666b.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787143443; x=1787748243; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PonVhEuAEKT0E4a1yU7TgphmO+Mvdl6szG3C0USyxek=;
        b=KDuBCmoM/7V2rAWB5STghO9OvKnC5Jf0UkLa7BkmOnCTWo+TM3NlwkJ2rxVVPoYSRJ
         RVKAX15+xv+SBRFOCzZQKvCr+wBMTsGZcZM0LYhawFiMxsQapWfuvlmFV1gkuc2l1uzY
         wbBML9KOr5L/fZiTw8P5EJc0kTgv6wNm2hCwBDnB4TEehnLAiSvh6J82Nu7zofwKZ8h8
         tmp9q9x/VidzmdcNZNWGBG6shkfrZ816JsXAyxubyL8sR3XEbv3bkbA9PFmPNSRfoYNR
         7Kv7S2RUSZL/21MO8DL2Bvx2JoleZzv6I486mtb/KJJNrIFg7NIN+eC7ssa2i2S3C6RF
         TYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143443; x=1787748243;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PonVhEuAEKT0E4a1yU7TgphmO+Mvdl6szG3C0USyxek=;
        b=e/r/tRQjDjwTDSL/myd6ZpTtvvPtKRwPr8JgsfYdymvaRIsSMwa1sDGMFCt1Gaa1UZ
         jY7OSnk5DRd9jzSA0Z2+ijECqdUhrRgiwTsoKpaKgH1gNWHtOtotfYhUu4AX0tpOz5SN
         4264Qs2kQqhGXt2Bno2et3EH/JU1A3TRxMXvgrfS9te7nKb//bsZJYwO1ZD6W4mSTZTE
         ArGAIAnd2P5s6Bm0Ljp06/Qa47KQLOxsSWTQjZjsJt5WhJ++yrkLsIIK4kAKrZIXAung
         HWvMUIt+kZC1v7cj0gkYou/F0JnDxMsrh8ku8a5m1uK8mHAQ8KdU5mnJgZoLVd23V8N0
         2UZw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6DKtpUO0XtCLT9LYPu+PVognDwDS4YiIOOaUV5EQIMLePMlsB0EbXIHdrEgBGF1ePW/69xZNrIH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNB2UWxjrUvDe2r/4QoTIvae+Qk85XB3ZjATLoCjUgLaq0Ud6D
	OYul5YIc0AoIG8oHgJbxeYqpf3mK3T8PUABHZhrXkpFqe8xv/T/rqgZWaeXZ+vE7q5fpvNcjt+C
	EhuiWuA==
X-Received: from ejbjp20.prod.google.com ([2002:a17:906:f754:b0:c21:148:79d2])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6938:a088:10b0:c24:47b8:ae5b
 with SMTP id a640c23a62f3a-c2447b8af3dmr85868166b.22.1787143443037; Wed, 19
 Aug 2026 05:44:03 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:43:40 +0000
In-Reply-To: <20260819124341.4185621-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260819124341.4185621-1-lrizzo@google.com>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260819124341.4185621-7-lrizzo@google.com>
Subject: [PATCH v5 6/7] genirq: Adaptive Global Software Interrupt Moderation (GSIM).
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

GSIM helps keeping system load (as defined later) under control, but
the use of a fixed moderation delay causes unnecessary latency when the
system load is already low.

We focus on two types of system load related to interrupts:
- total device interrupt rates. Some platforms show severe I/O
  performance degradation with more than 1-2 Mintr/s across the entire
  system. This affects especially server-class hardware with hundreds of
  interrupt sources (NIC or SSD queues from many physical or virtualized
  devices).
- percentage of time spent in hardirq. This can become problematic in
  presence of large numbers of interrupt sources hitting individual CPUs
  (for instance, as a result of attempts to isolate application CPUs
  from interrupt load).

Make GSIM adaptive by measuring total and per-CPU interrupt rates, as
well as time spent in hardirq on each CPU. The metrics are compared to
configurable targets, and each CPU adjusts the moderation delay up
or down depending on the result, using multiplicative increase/decrease.

Configuration of moderation parameters is done via procfs

  echo ${VALUE} > /proc/irq/sw_moderation/${NAME}

Parameters are:

  delay_us (0 off, range 0-500)
      Maximum moderation delay in microseconds.

  target_intr_rate (0 off, range 0-50000000)
      Total rate above which moderation should trigger.

  hardirq_percent (0 off,range 0-100)
      Percentage of time spent in hardirq above which moderation should
      trigger.

  update_ms (range 1-100, default 5)
      How often the metrics should be computed and moderation delay
      updated.

When target_intr_rate and hardirq_percent are both 0, GSIM uses delay_us
as fixed moderation delay. Otherwise, the delay is dynamically adjusted
up or down, independently on each CPU, based on how the total and per-CPU
metrics compare with the targets.

Provided that delay_us suffices to bring the metrics within the target,
the control loop will dynamically converge to the minimum actual
moderation delay to stay within the target.

PERFORMANCE BENEFITS:

The tests below demonstrate how adaptive moderation allows improved
throughput at high load (same as fixed moderation) and low latency ad
moderate load (same as no moderation) without having to hand-tune the
system based on load.

We run experiments on one x86 platform with 8 SSD (64 queues) capable of
an aggregate of approximately 14M IOPS running fio with variable number
of SSD devices (1 or 8), threads per disk (1 or 200), and IODEPTH (from
1 to 128 per thread) the actual command is below:

${FIO} --name=read_IOPs_test ${DEVICES} --iodepth=${IODEPTH} --numjobs=${JOBS} \
    --bs=4K --rw=randread  --filesize=1000G --ioengine=libaio --direct=1 \
    --verify=0 --randrepeat=0 --time_based=1 --runtime=600s \
    --cpus-allowed=1-119 --cpus_allowed_policy=split --group_reporting=1

For each configuration we test three moderations settings:
- OFF:      delay_us=0
- FIXED:    delay_us=200 target_intr_rate=0 hardirq_percent=0
- ADAPTIVE: delay_us=200 target_intr_rate=1000000 hardirq_percent=70

The first set of measurements is for ONE DISK, ONE THREAD.
At low IODEPTH the throughput is latency bound, and moderation is not
necessary. A fixed moderation delay dominates the latency hence reducing
throughput; adaptive moderation avoids the problem.
As the IODEPTH increases, the system becomes I/O bound, and even the
fixed moderation delay does not harm.

Overall: adaptive moderation is better than fixed moderation and
at least as good as moderation off.

         ------ OFF --------   ------ FIXED ------   ----- ADAPTIVE ----
IODEPTH  IOPS  p50  p90  p99   IOPS  p50  p90  p99   IOPS  p50  p90  p99
         -------------------   -------------------   -------------------
1:        12K   78   88   94 .   5K  208  210  215 .  12K   78   88   96
8:        94K   83   91  110 .  38K  210  212  221 .  94K   83   91  105
32:      423K   72   85  124 . 150K  210  219  235 . 424K   72   85  124
128:     698K  180  200  243 . 513K  251  306  347 . 718K  174  194  239

A second set of measurements is with one disk and 200 threads.
The system is I/O bound but without significant interrupt overhead.
All three scenarios are basically equivalent.

         --------- OFF --------   ------- FIXED -------   ------ ADAPTIVE -----
IODEPTH  IOPS    p50  p90   p99   IOPS    p50  p90  p99   IOPS    p50  p90  p99
         ----------------------   ---------------------   ---------------------
1:       1581K   110  174   281 .  933K   208  223  363 . 1556K   114  176  277
8:       1768K   889 1516  1926 . 1768K   848 1516 2147 . 1768K   889 1516 1942
32:      1768K  3589 5735  7701 . 1768K  3589 5735 7635 . 1768K  3589 5735 7504
128:     1768K  14ms 24ms  31ms . 1768K  14ms 24ms 29ms . 1768K  14ms 24ms 30ms

Finally, we have one set of measurements with 8 disks and 200 threads
per disk, all running on socket 0.  The system would be I/O bound (and
CPU/latency bound at low IODEPTH), but this platform is unable to cope with the
high global interrupt rate and so moderation is really necessary to hit
the disk limits.

As we see below, adaptive moderation gives more than 2X higher
throughput at meaningful iodepths, and even latency is much better.
The only case where we see a small regression is with iodepth=1, because
the high interrupt rate triggers the control loop to increase the
moderation delay.

         --------- OFF --------   -------- FIXED -------   ------ ADAPTIVE ------
IODEPTH  IOPS    p50  p90   p99   IOPS     p50  p90  p99   IOPS     p50  p90  p99
         ----------------------   ----------------------   ----------------------
1:       2304K    82   94   128 .  1030K   208  277  293 .  1842K    97  149  188
8:       5240K   128  938  1680 .  7500K   208  233  343 . 10000K   151  210  281
32:      5251K   206 3621  3949 . 12300K   184 1106 5407 . 12100K   184 1139 5407
128:     5330K  4228 12ms  17ms . 13800K  1123 4883 7373 . 13800K  1074 4883 7635

Finally, here are experiments indicating how throughput is affected by
the various parameters (with 8 disks and 200 threads).

IOPS vs delay_us (target_intr_rate = 0, hardirq_percent=0)

delay_us	0	50	100	150	200	250
IODEPTH 1	2300	1860	1580	1300	1034	1066
IODEPTH 8	5254	9936	9645	8818	7500	6150
IODEPTH 32	5250	11300	13800	13800	13800	13800
IODEPTH 128	5900	13600	13900	13900	13900	13900

IOPS vs target_intr_rate (delay_us = 200, hardirq_percent=0, iodepth 128)
value		250K	500K	750K	1000K	1250K	1500K	1750K	2000K
socket0		13900	13900	13900	13800	13800	12900	11000	8808
both sockets	13900	13900	13900	13800	8600	8000	6900	6400

hardirq_percent (delay_us = 200, target_intr_rate=0, iodepth 128)
hardirq%	1	10	20	30	40	50	60	70
KIOPS		13900	13800	13300	12100	10400	8600	7400	6500

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 kernel/irq/irq_moderation.c | 391 ++++++++++++++++++++++++++++++++++--
 kernel/irq/irq_moderation.h |  63 ++++++
 2 files changed, 442 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
index 1474d33455410..74bd33c786c90 100644
--- a/kernel/irq/irq_moderation.c
+++ b/kernel/irq/irq_moderation.c
@@ -9,6 +9,9 @@
 #include <linux/cpuhotplug.h>
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
+#include <linux/kallsyms.h>
+#include <linux/kernel_stat.h>
+#include <linux/math64.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/proc_fs.h>
@@ -23,8 +26,9 @@
  *
  * Some platforms show reduced I/O performance when the total device interrupt
  * rate across the entire platform becomes too high. To address the problem,
- * GSIM runs after the handler to implement software interrupt moderation
- * with programmable delay.
+ * GSIM runs after the handler to measure global and per-CPU interrupt rates,
+ * compares them with configurable targets, and implements independent, per-CPU
+ * software moderation delays.
  *
  * Configuration is done at runtime via procfs
  *   echo ${VALUE} > /proc/irq/sw_moderation/${NAME}
@@ -35,6 +39,19 @@
  *       Maximum moderation delay. A reasonable range is 20-100. Higher values
  *       can be useful if the hardirq handler has long runtimes.
  *
+ *   target_intr_rate (default 0, suggested 1000000, 0 off, range 0-50000000)
+ *       The total interrupt rate above which moderation kicks in.
+ *       Not particularly critical, a value in the 500K-1M range is usually ok.
+ *
+ *   hardirq_percent (default 0, suggested 70, 0 off, range 0-100)
+ *       The hardirq percentage above which moderation kicks in.
+ *       50-90 is a reasonable range.
+ *
+ *       FIXED MODERATION mode requires target_intr_rate=0, hardirq_percent=0
+ *
+ *   update_ms (default 5, range 1-100)
+ *       How often the load is measured and moderation delay updated.
+ *
  * Moderation is allowed/disallowed dynamically for individual interrupts with
  *   echo 1 > /proc/irq/NN/allow_sw_moderation # use 0 to disallow
  *
@@ -112,7 +129,47 @@
  * GSIM parameters. Initialize delay_ns here to statically enable moderation
  * (e.g. .delay_ns = 100000).
  */
-struct irq_mod_params irq_mod_params ____cacheline_aligned;
+
+/*
+ * Recommended values for the adaptive control loop.
+ *
+ * update_ns is documented earlier and can be modified via procfs
+ *
+ * The following two allow fine tuning of the control loop and should not
+ * be modified unless there is good understanding of their impact on the
+ * stability of the controller.
+ *
+ * scale_cpus (default 150, range 50-1000)
+ *   Small update_ms may lead to underestimate the number of CPUs
+ *   simultaneously handling interrupts, and the opposite can happen
+ *   with very large values. This parameter may help correct the value,
+ *   though it is not recommended to modify the default unless there are
+ *   very strong reasons.
+ *
+ * increase_divisor (default 8, range 8-128)
+ *   This is base parameter used for multiplicative increase/decrease.
+ */
+
+#define MIN_SCALING_DIVISOR	8
+
+struct irq_mod_params irq_mod_params ____cacheline_aligned = {
+	.update_ns		= 5 * NSEC_PER_MSEC,
+	.scale_cpus		= 150,
+	.increase_divisor	= MIN_SCALING_DIVISOR,
+	.seq			= SEQCNT_ZERO(irq_mod_params.seq),
+};
+
+/*
+ * Accumulator for total interrupt and active CPUs, updated by all active
+ * CPUs on each epoch (update_ns or more).
+ * @total_intrs:	running count of total interrupts
+ * @total_cpus:		running count of total active CPUs
+ */
+struct irq_mod_counters {
+	atomic_t	total_intrs;
+	atomic_t	total_cpus;
+};
+static struct irq_mod_counters irq_mod_counters;
 
 DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
 
@@ -122,12 +179,215 @@ static DEFINE_MUTEX(swmod_mutex);
 
 static void update_enable_key(void)
 {
+	lockdep_assert_held(&swmod_mutex);
+
 	if (irq_mod_params.delay_ns != 0)
 		static_branch_enable(&irq_moderation_enabled_key);
 	else
 		static_branch_disable(&irq_moderation_enabled_key);
 }
 
+/* Slow path functions for interrupt moderation. */
+
+/*
+ * Compute smoothed average between old and cur. 'steps' is used
+ * to approximate applying the smoothing multiple times.
+ */
+static inline unsigned int smooth_avg(unsigned int old, unsigned int cur, unsigned int steps)
+{
+	const unsigned int smooth_factor = 64;
+	u64 sum;
+
+	steps = min(steps, smooth_factor - 1);
+	sum = (u64)(smooth_factor - steps) * old + (u64)steps * cur;
+	return div_u64(sum, smooth_factor);
+}
+
+/* Measure and assess time spent in hardirq. */
+static inline bool hardirq_high(struct irq_mod_state *m, unsigned int hardirq_percent,
+				u64 epoch_ns)
+{
+	bool above_threshold;
+	u64 irqtime, cur;
+
+	if (!IS_ENABLED(CONFIG_IRQ_TIME_ACCOUNTING))
+		return false;
+
+	cur = kcpustat_this_cpu->cpustat[CPUTIME_IRQ];
+	irqtime = cur - m->last_irqtime;
+	m->last_irqtime = cur;
+
+	if (hardirq_percent == 0)
+		return false;
+
+	above_threshold = irqtime * 100 > epoch_ns * hardirq_percent;
+	m->hardirq_high += above_threshold;
+	return above_threshold;
+}
+
+/* Measure and assess total and per-CPU interrupt rates. */
+static inline bool irqrate_high(struct irq_mod_state *m, unsigned int target_rate,
+				unsigned int steps, u64 epoch_ns,
+				unsigned int update_ns, unsigned int scale_cpus)
+{
+	unsigned int global_intr_rate, local_intr_rate, delta_intrs, tmp;
+	bool local_rate_high, global_rate_high;
+	u64 num_local, num_global, num_cpus;
+	/* Use unsigned long to avoid overflow in intermediate results. */
+	unsigned long active_cpus;
+	u32 denom = epoch_ns;
+	int shift = 0;
+
+	num_local = (u64)m->intr_count * NSEC_PER_SEC;
+	/* Scale denominator so we can avoid 64-bit division. */
+	if (unlikely(epoch_ns > U32_MAX)) {
+		shift = fls64(epoch_ns) - 32;
+		denom = epoch_ns >> shift;
+		num_local >>= shift;
+	}
+
+	local_intr_rate = div_u64(num_local, denom);
+
+	/* Accumulate global counter and compute global interrupt rate. */
+	tmp = atomic_add_return(m->intr_count, &irq_mod_counters.total_intrs);
+	m->intr_count = 0;
+	delta_intrs = tmp - m->last_total_intrs;
+	m->last_total_intrs = tmp;
+	num_global = (u64)delta_intrs * NSEC_PER_SEC;
+	if (unlikely(shift))
+		num_global >>= shift;
+	global_intr_rate = div_u64(num_global, denom);
+
+	/*
+	 * Count how many CPUs handled interrupts in the last epoch, needed
+	 * to determine the per-CPU target (target_rate / active_cpus).
+	 * Each active CPU increments the global counter approximately every
+	 * update_ns. Scale the value by (update_ns / epoch_ns) to get the
+	 * correct value. Also apply rounding and make sure active_cpus > 0.
+	 */
+	tmp = atomic_add_return(1, &irq_mod_counters.total_cpus);
+	active_cpus = tmp - m->last_total_cpus;
+	m->last_total_cpus = tmp;
+	num_cpus = (u64)active_cpus * update_ns + (epoch_ns / 2);
+	if (unlikely(shift))
+		num_cpus >>= shift;
+	active_cpus = div_u64(num_cpus, denom);
+	if (active_cpus < 1)
+		active_cpus = 1;
+
+	/* Compare with global and per-CPU targets. */
+	global_rate_high = global_intr_rate > target_rate;
+
+	/*
+	 * Short epochs may lead to underestimate the number of active CPUs.
+	 * Apply a scaling factor to compensate. This may make the controller
+	 * a bit more aggressive but does not harm system throughput.
+	 */
+	local_rate_high = (u64)local_intr_rate * active_cpus *
+			scale_cpus > (u64)target_rate * 100;
+
+	/* Statistics. */
+	m->global_intr_rate = smooth_avg(m->global_intr_rate, global_intr_rate, steps);
+	m->local_intr_rate = smooth_avg(m->local_intr_rate, local_intr_rate, steps);
+	m->scaled_cpu_count = smooth_avg(m->scaled_cpu_count, active_cpus * 256, steps);
+
+	if (target_rate == 0)
+		return false;
+
+	m->local_irq_high += local_rate_high;
+	m->global_irq_high += global_rate_high;
+
+	/* Moderate on this CPU only if both global and local rates are high. */
+	return global_rate_high && local_rate_high;
+}
+
+/* Periodic adjustment, called once per epoch. */
+void irq_moderation_update_epoch(struct irq_mod_state *m, u64 epoch_ns)
+{
+	unsigned int hardirq_percent, target_rate, delay_ns, update_ns;
+	unsigned int increase_divisor, scale_cpus;
+	const unsigned int min_delay_ns = 500;
+	bool above_target = false;
+	unsigned int steps, seq;
+
+	do {
+		seq = read_seqcount_begin(&irq_mod_params.seq);
+		hardirq_percent = READ_ONCE(irq_mod_params.hardirq_percent);
+		target_rate = READ_ONCE(irq_mod_params.target_intr_rate);
+		delay_ns = READ_ONCE(irq_mod_params.delay_ns);
+		update_ns = READ_ONCE(irq_mod_params.update_ns);
+		increase_divisor = READ_ONCE(irq_mod_params.increase_divisor);
+		scale_cpus = READ_ONCE(irq_mod_params.scale_cpus);
+	} while (read_seqcount_retry(&irq_mod_params.seq, seq));
+
+	/*
+	 * If one parameter changes, set the moderation delay to max, and rely
+	 * on the adaptive mechanism to adjust it down if necessary.
+	 * Otherwise the system may be stuck with an interrupt rate that is
+	 * already below the threshold because of bus congestion (one of the
+	 * problems that GSIM is trying to address), and the controller would
+	 * have no signal react. Starting from a high value gives it a chance
+	 * to converge if parameters allow it.
+	 */
+	if (seq != m->seq) {
+		m->seq = seq;
+		m->mod_ns = delay_ns;
+		m->intr_count = 0;
+		m->last_total_intrs = atomic_read(&irq_mod_counters.total_intrs);
+		m->last_total_cpus = atomic_read(&irq_mod_counters.total_cpus);
+		if (IS_ENABLED(CONFIG_IRQ_TIME_ACCOUNTING))
+			m->last_irqtime = kcpustat_this_cpu->cpustat[CPUTIME_IRQ];
+		return;
+	}
+
+	if (target_rate == 0 && hardirq_percent == 0) {
+		/* Use fixed moderation delay. */
+		m->mod_ns = delay_ns;
+		m->global_intr_rate = 0;
+		m->local_intr_rate = 0;
+		m->scaled_cpu_count = 0;
+		return;
+	}
+
+	/*
+	 * The controller wants to scale the delay mod_ns by (1 + 1/D) every "update_ns".
+	 * Since we operate every epoch_ns >= update_ns, the formula becomes
+	 *   mod_ns = mod_ns * ((1 + 1/D) ** (epoch_ns / update_ns))
+	 * which we approximate with "mod_ns = mod_ns * (1 + steps/D)"
+	 * where "steps = epoch_ns / update_ns" clamped to a value < D.
+	 */
+	steps = (unsigned int)clamp_t(u64, div_u64(epoch_ns, update_ns),
+				      1ULL, (u64)(MIN_SCALING_DIVISOR - 1u));
+
+	if (irqrate_high(m, target_rate, steps, epoch_ns, update_ns, scale_cpus))
+		above_target = true;
+
+	if (hardirq_high(m, hardirq_percent, epoch_ns))
+		above_target = true;
+
+	/*
+	 * Controller: adjust delay with exponential increase or decrease.
+	 *
+	 * Following standard practices, we increase fast (smaller divisor) to
+	 * aggressively slow down when the interrupt rate goes up, but decrease
+	 * slowly (larger divisor) to reduce the chance of load spikes as the
+	 * delay goes down.
+	 */
+	if (above_target) {
+		/* Make sure the value is large enough for the exponential to grow. */
+		if (m->mod_ns < min_delay_ns)
+			m->mod_ns = min_delay_ns;
+		m->mod_ns += m->mod_ns * steps / increase_divisor;
+		if (m->mod_ns > delay_ns)
+			m->mod_ns = delay_ns;
+	} else {
+		m->mod_ns -= m->mod_ns * steps / (2 * increase_divisor);
+		/* Round down to 0 values that are too small to bother. */
+		if (m->mod_ns < min_delay_ns)
+			m->mod_ns = 0;
+	}
+}
+
 /* Actually start moderation. */
 bool irq_moderation_do_start(struct irq_desc *desc, struct irq_mod_state *m)
 {
@@ -138,7 +398,7 @@ bool irq_moderation_do_start(struct irq_desc *desc, struct irq_mod_state *m)
 		const u64 slack_ns = 2000;
 
 		/* Accumulate sleep time, no moderation if too small. */
-		m->sleep_ns += READ_ONCE(irq_mod_params.delay_ns);
+		m->sleep_ns += m->mod_ns;
 		if (m->sleep_ns < min_delay_ns)
 			return false;
 		/* We need moderation, start the timer. */
@@ -153,6 +413,11 @@ bool irq_moderation_do_start(struct irq_desc *desc, struct irq_mod_state *m)
 	 */
 	m->enqueue++;
 	list_add(&desc->swmod_state.swmod_node, &m->descs);
+	/*
+	 * Set IRQD_IRQ_INPROGRESS so that synchronize_irq() called during
+	 * free_irq() will block until the timer drains this descriptor from
+	 * the moderation list.
+	 */
 	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS | IRQD_MODERATED);
 	__disable_irq(desc);
 	return true;
@@ -186,17 +451,31 @@ struct swmod_procfs_entry {
 	struct var_info	var;
 };
 
+static void write_param(unsigned int *ptr, unsigned int value)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	write_seqcount_begin(&irq_mod_params.seq);
+	WRITE_ONCE(*ptr, value);
+	write_seqcount_end(&irq_mod_params.seq);
+	local_irq_restore(flags);
+}
+
 static ssize_t swmod_wr(struct var_info *v, const char __user *s, size_t count)
 {
 	unsigned int value;
 	int ret;
 
+	lockdep_assert_held(&swmod_mutex);
+
 	ret = kstrtouint_from_user(s, count, 0, &value);
 	if (ret)
 		return ret;
 	if (value < v->min || value > v->max)
 		return -ERANGE;
-	WRITE_ONCE(*v->ptr, value * v->scale);
+	write_param(v->ptr, value * v->scale);
+
 	return count;
 }
 
@@ -216,34 +495,87 @@ static ssize_t swmod_wr_delay(struct var_info *v, const char __user *s, size_t c
 	return ret;
 }
 
-#define HEAD_FMT "%5s  %8s  %11s  %11s\n"
-#define BODY_FMT "%5u  %8u  %11u  %11u\n"
+#define HEAD_FMT "%5s  %8s  %10s  %4s  %8s  %11s  %11s  %11s  %11s  %11s\n"
+#define BODY_FMT "%5u  %8u  %10u  %4u  %8u  %11u  %11u  %11u  %11u  %11u\n"
 
 /* Print statistics */
 static void rd_stats(struct seq_file *p)
 {
 	unsigned int delay_ns = READ_ONCE(irq_mod_params.delay_ns);
-	int cpu;
+	unsigned long global_intr_rate = 0, global_irq_high = 0;
+	unsigned long local_irq_high = 0, hardirq_high = 0;
+	int recent_epoch_limit, cpu, active_cpus = 0;
 
 	if (delay_ns == 0)
 		return;
 	seq_printf(p, HEAD_FMT,
-		   "# CPU", "delay_ns", "timer_set", "enqueue");
+		   "# CPU", "irq/s", "loc_irq/s", "cpus", "delay_ns",
+		   "irq_hi", "loc_irq_hi", "hardirq_hi", "timer_set",
+		   "enqueue");
+
+	/*
+	 * Accumulate/print only entries updated within ~20-30s. The high 32 bits
+	 * of timestamps give ~4s resolution, so we can use them without the need
+	 * for 64bit atomics (because epoch_start_ns is updated concurrently).
+	 */
+	recent_epoch_limit = (ktime_get_ns() - 20ULL * NSEC_PER_SEC) >> 32;
 
 	for_each_possible_cpu(cpu) {
 		/* Copy statistics, will only use some unsigned int values; races ok. */
 		struct irq_mod_state cur = data_race(*per_cpu_ptr(&irq_mod_state, cpu));
 
+		if (cur.epoch_start_ns && (int)(cur.epoch_start_ns >> 32) >= recent_epoch_limit) {
+			/* Recent entry, accumulate in global rate. */
+			active_cpus++;
+			global_intr_rate += cur.global_intr_rate;
+		} else {
+			/* Stale entries, print as 0. */
+			cur.global_intr_rate = 0;
+			cur.local_intr_rate = 0;
+			cur.scaled_cpu_count = 0;
+			cur.mod_ns = 0;
+		}
+
+		global_irq_high += cur.global_irq_high;
+		local_irq_high += cur.local_irq_high;
+		hardirq_high += cur.hardirq_high;
+
 		seq_printf(p, BODY_FMT,
 			   cpu,
-			   delay_ns,
+			   cur.global_intr_rate,
+			   cur.local_intr_rate,
+			   (cur.scaled_cpu_count + 128) / 256,
+			   cur.mod_ns,
+			   cur.global_irq_high,
+			   cur.local_irq_high,
+			   cur.hardirq_high,
 			   cur.timer_set,
 			   cur.enqueue);
 	}
 
 	seq_printf(p, "\n"
-		   "delay_us             %lu\n",
-		   delay_ns / NSEC_PER_USEC);
+		   "delay_us             %lu\n"
+		   "target_intr_rate     %u\n"
+		   "hardirq_percent      %u\n"
+		   "update_ms            %ld\n"
+		   "scale_cpus           %u\n",
+		   delay_ns / NSEC_PER_USEC,
+		   READ_ONCE(irq_mod_params.target_intr_rate),
+		   READ_ONCE(irq_mod_params.hardirq_percent),
+		   READ_ONCE(irq_mod_params.update_ns) / NSEC_PER_MSEC,
+		   READ_ONCE(irq_mod_params.scale_cpus));
+
+	seq_printf(p,
+		   "intr_rate            %lu\n"
+		   "irq_high             %lu\n"
+		   "my_irq_high          %lu\n"
+		   "hardirq_percent_high %lu\n"
+		   "total_interrupts     %u\n"
+		   "total_cpus           %u\n",
+		   active_cpus ? global_intr_rate / active_cpus : 0,
+		   global_irq_high, local_irq_high, hardirq_high,
+		   atomic_read(&irq_mod_counters.total_intrs),
+		   atomic_read(&irq_mod_counters.total_cpus));
 }
 
 static int param_show(struct seq_file *p, void *v)
@@ -476,15 +808,41 @@ static struct swmod_procfs_entry procfs_entries[] = {
 		.rd	= swmod_rd,
 		.var	= SET_VAR(&irq_mod_params.delay_ns, 0, 500, NSEC_PER_USEC),
 	},
+	{
+		.name	= "target_intr_rate",
+		.wr	= swmod_wr,
+		.rd	= swmod_rd,
+		.var	= SET_VAR(&irq_mod_params.target_intr_rate, 0, 50000000, 1),
+	},
+	{
+		.name	= "hardirq_percent",
+		.wr	= swmod_wr,
+		.rd	= swmod_rd,
+		.var	= SET_VAR(&irq_mod_params.hardirq_percent, 0, 100, 1),
+	},
+	{
+		.name	= "update_ms",
+		.wr	= swmod_wr,
+		.rd	= swmod_rd,
+		.var	= SET_VAR(&irq_mod_params.update_ns, 1, 100, NSEC_PER_MSEC),
+	},
 	{
 		.name = "stats",
 		.rd = rd_stats,
 	},
+	/* The next parameters have no procfs entries, only range validation. */
+	{
+		.var	= SET_VAR(&irq_mod_params.increase_divisor, MIN_SCALING_DIVISOR, 128, 1),
+	},
+	{
+		.var	= SET_VAR(&irq_mod_params.scale_cpus, 50, 1000, 1),
+	},
 };
 
 static int __init init_irq_moderation(void)
 {
 	struct proc_dir_entry *dir;
+	unsigned long flags;
 	int cpuhp_state;
 	int i, ret;
 
@@ -535,8 +893,17 @@ static int __init init_irq_moderation(void)
 		goto cleanup_1;
 	}
 
+	/* Increment sequence counter so per-CPU m->seq (0) mismatches on epoch 1 */
+	local_irq_save(flags);
+	write_seqcount_begin(&irq_mod_params.seq);
+	write_seqcount_end(&irq_mod_params.seq);
+	local_irq_restore(flags);
+
 	/* Enable if the defaults require it. */
+	/* Acquire swmod_mutex to satisfy lockdep assertions. */
+	mutex_lock(&swmod_mutex);
 	update_enable_key();
+	mutex_unlock(&swmod_mutex);
 	return 0;
 
 cleanup_1:
diff --git a/kernel/irq/irq_moderation.h b/kernel/irq/irq_moderation.h
index 8df350651cd7c..007c7c8646698 100644
--- a/kernel/irq/irq_moderation.h
+++ b/kernel/irq/irq_moderation.h
@@ -15,13 +15,26 @@
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
 #include <linux/kernel.h>
+#include <linux/seqlock.h>
 
 /**
  * struct irq_mod_params - configuration parameters
  * @delay_ns:		maximum delay
+ * @target_intr_rate:	target maximum interrupt rate
+ * @hardirq_percent:	target maximum hardirq percentage
+ * @update_ns:		how often to update delay/rate/fraction (epoch duration)
+ * @increase_divisor:	constant for multiplicative increase/decrease of delay
+ * @scale_cpus:		(percent) scale factor to estimate active CPUs
+ * @seq:		incremented every time parameters change
  */
 struct irq_mod_params {
 	unsigned int	delay_ns;
+	unsigned int	target_intr_rate;
+	unsigned int	hardirq_percent;
+	unsigned int	update_ns;
+	unsigned int	increase_divisor;
+	unsigned int	scale_cpus;
+	seqcount_t	seq;
 };
 
 extern struct irq_mod_params irq_mod_params;
@@ -34,22 +47,50 @@ extern struct irq_mod_params irq_mod_params;
  * @initialized:	true if hrtimer and list head are initialized
  * @moderation_allowed:	per-CPU flag, toggled during hotplug/suspend events
  * @sleep_ns:		accumulated time for actual delay
+ * @mod_ns:		dynamically computed moderation delay
+ * @intr_count:		interrupt counter
+ * @epoch_start_ns:	start time of current epoch
  *
  * Used once per moderation delay per interrupt source:
  * @descs:		list of	moderated irq_desc on this CPU
  * @enqueue:		how many enqueue on the list
  *
+ * Used once per epoch:
+ * @seq:		latest seq from irq_mod_info
+ * @last_total_intrs:	from irq_mod_info
+ * @last_total_cpus:	from irq_mod_info
+ * @last_irqtime:	from cpustat[CPUTIME_IRQ]
+ *
  * Statistics
+ * @global_intr_rate:	smoothed global interrupt rate
+ * @local_intr_rate:	smoothed interrupt rate for this CPU
  * @timer_set:		how many timer_set calls
+ * @scaled_cpu_count:	smoothed CPU count (scaled)
+ * @global_irq_high:	how many times global irq rate was above threshold
+ * @local_irq_high:	how many times local irq rate was above threshold
+ * @hardirq_high:	how many times local hardirq_percent was above threshold
  */
 struct irq_mod_state {
 	struct hrtimer		timer;
 	bool			initialized;
 	bool			moderation_allowed;
 	unsigned int		sleep_ns;
+	unsigned int		mod_ns;
+	unsigned int		intr_count;
+	u64			epoch_start_ns;
 	struct list_head	descs;
 	unsigned int		enqueue;
+	unsigned int		seq;
+	unsigned int		last_total_intrs;
+	unsigned int		last_total_cpus;
+	u64			last_irqtime;
+	unsigned int		global_intr_rate;
+	unsigned int		local_intr_rate;
 	unsigned int		timer_set;
+	unsigned int		scaled_cpu_count;
+	unsigned int		global_irq_high;
+	unsigned int		local_irq_high;
+	unsigned int		hardirq_high;
 };
 
 DECLARE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
@@ -67,6 +108,26 @@ static inline bool mod_state_initialized(struct irq_mod_state *m)
 extern struct static_key_false irq_moderation_enabled_key;
 
 bool irq_moderation_do_start(struct irq_desc *desc, struct irq_mod_state *m);
+void irq_moderation_update_epoch(struct irq_mod_state *m, u64 epoch_ns);
+
+static inline void check_epoch(struct irq_mod_state *m)
+{
+	const unsigned int slack_ns = 5000;
+	u64 now, epoch_ns;
+
+	/* Don't check too often, fetching time is moderately expensive. */
+	if ((m->intr_count & 0xf) != 0)
+		return;
+	now = ktime_get_ns();
+	epoch_ns = now - m->epoch_start_ns;
+
+	/* Run approximately every update_ns, a little bit early is ok. */
+	if (epoch_ns < READ_ONCE(irq_mod_params.update_ns) - slack_ns)
+		return;
+	WRITE_ONCE(m->epoch_start_ns, now);
+	/* Do the expensive processing. */
+	irq_moderation_update_epoch(m, epoch_ns);
+}
 
 /*
  * Call after running the handler, with lock held. If this source should be
@@ -81,6 +142,8 @@ static inline bool irq_start_moderation(struct irq_desc *desc)
 	if (static_branch_unlikely(&irq_moderation_enabled_key) &&
 	    irq_settings_moderatable(desc) &&
 	    m->moderation_allowed) {
+		m->intr_count++;
+		check_epoch(m);
 		return irq_moderation_do_start(desc, m);
 	}
 	return false;
-- 
2.55.0.737.g08866a6d13-goog

