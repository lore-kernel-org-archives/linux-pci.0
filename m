Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46172DA74C
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143434; cv=none; b=eZ6ag7vgShDiwlVf4kk323srwjdwc8SzxMGalkOZrq3h2U4EPSD/oqdp7j6vdrXEqz0s3s16FZmJTvjQdyamQEHwtH3O1nKV6h2fVYmQNip4GKxlL6KlUx0E8EOCUl+eCL3Pxlo7mI1b5ZjehqNPlz9DxRUcyjpECv5G56ZiEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143434; c=relaxed/simple;
	bh=x5RiQsYAg1MzOZ16NuSw24pWZ89ruF4LyqSVK0cJlhQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ycc5BBOWISn5/yzvVnjO0zCEQ7gSYqXnFileeIgwx0d+wGPIfcLl/psd0VRiyWAn+x8jk1mwmxOV6eKUJNd5MFwTMhJaxH43PFU3BRhuoFfODFrwVhvld2Sliu2FXtj1Vu4jWU9ee6iJ+qTwp2NYyh90zN92q3FZWMcvTCJQF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmIrhWCb; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmIrhWCb"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15dfd34e4cso63426866b.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787143430; x=1787748230; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Amu76wh42/dQkaqjByjf1Zc2SXPLRdyRu0t1vGkxDqA=;
        b=dmIrhWCb9Kd5FXbIQEZu/SRudVDHAXf81b0wwhlwefpLq+vTcDvhNZ/R5qZJWh/mZx
         GevVanCgr33b4PN0avR48/YzxtVOZ25tyhi3g9Zi1V6gBQUal2pTmSne3tjknXrdQJtc
         pLuXtnaSKBTWQl3CdED6iKaXTA0FehUD/qynzDJWTa7Y1tlkf1CIfcn36Ahsqb4ElIXu
         01tw1bjgcxpvlGP4HCE712KuFtbo6/9zTgsvY3mtIGoO6guu+Pl1nwBsJDe9S+PcdVKD
         kHjRjWCrFPzRGTN5PAdqZCapNDWI0eFG89lIR0VuzX8tdVq8G5nphZlrgZeYKeQsg0m3
         LNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143430; x=1787748230;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Amu76wh42/dQkaqjByjf1Zc2SXPLRdyRu0t1vGkxDqA=;
        b=IFxrYSYGr0YsORbG/gyJl5wHLFRJ09jMSla3PWRgNR0hEERHPbBqLpXT8YnzHmVfLg
         46NT9BJjm3oC7VnHGIkGWAMxKoXeh8P218MTxf1YD73HWr5NMqyxeWAvhHw7Zrv2+Z4l
         1o5lQD+auzQEWzJw1a4KqGDhFODR/w1UfOBlidarCGuQANzYn9tYqkfdOmcptHFFsLyt
         UnAAeZPSk8Uj8tjohC7ExIJzoZHgxNsrirw4BngeI+1fiZrUBqC13EJsXkldfy83BA3U
         vFHLnXRyze4V32cK05GBYDWR1PwWAx5uAlhhjFR+Ksj6nQJeScAlLxThjV7JOJ1+4Jtt
         VSOw==
X-Forwarded-Encrypted: i=1; AHgh+RoIkRcueQ40Nl5J7Cbprty/5oM6Lv+h7frbWlz6Zxv8yGV4FZ4/sj5fIIflt9J3YQ+xQOdQvTRajQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyNGMnuLqfWCxUDibIygGcpTM8FtJdCp0vRO3//cE2KTBv9eo+
	qut2S9yVrWAWW2rWK36gbWlQ8gFwpMrDVTQPXcm5/0a9erxZSZ3Kmv3kZYOu9r9Sq90aZmHjR7H
	M+er3FA==
X-Received: from ejbyk21.prod.google.com ([2002:a17:907:70d5:b0:c1c:465f:94bb])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:c78c:b0:c16:13c3:b1ef
 with SMTP id a640c23a62f3a-c242e26272bmr288380866b.24.1787143429690; Wed, 19
 Aug 2026 05:43:49 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:43:34 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260819124341.4185621-1-lrizzo@google.com>
Subject: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Global Software Interrupt Moderation (GSIM) addresses a limitation of
platforms, from many vendors, whose I/O performance drops significantly
when the total rate of MSI-X interrupts is too high (e.g 1..3M intr/s
depending on the platform).

Conventional interrupt moderation, typically implemented in hardware
by NICs or storage devices, operates separately on each source (e.g. a
completion queue). Large servers can have hundreds of sources, and
without knowledge of global activity, keeping the total rate bounded would
require moderation delays of 100-200us. Per-source adaptive moderation
would reach those delays with as little as 10K intr/s per source. These
values (high delay triggering very early) are unacceptable for RPC or
transactional workloads.

To address this problem, GSIM measures efficiently the total and per-CPU
interrupt rates, so that individual moderation delays can be dynamically
adjusted based on current global and local load. This way, delays are
normally 0 or very small except during actual local/global overload.

As an additional benefit, GSIM also monitors the percentage of time
spent by each CPU in hardirq, and can use moderation to reserve some
time for other, lower priority, tasks.

Configuration is easy and robust. System administrators specify the
maximum targets (moderation delay; interrupt rate; percentage of time
spent in hardirq), and which interrupt sources should be moderated.
Independent per-CPU control loops adjust actual delays to try and keep
metrics within the targets.

The system is adaptive. Moderation affects only latency and only in
high load scenarios.  Throughput and CPU efficiencly generally benefits
significantly.  Targets don't need to match precisely the platform
limits, and one can make conservative and robust choices. Values like
delay_us=100, target_intr_rate=1000000, hardirq_percent=70 are a very
good starting point.

GSIM does not rely on any special hardware feature.

Global parameters can be modified at runtime with

    echo ${VALUE} | sudo tee /proc/irq/sw_moderation/${NAME}

/proc/irq/sw_moderation/stats exports statistics when enabled.

and moderation on individual interrupts can be turned on/off at runtime with

    echo 1 | sudo tee /proc/irq/NN/allow_moderation  # use 0 to disable

EXAMPLE:
    # global configuration: 50us, target max 1M intr/s, and 70% in intr
    echo 50 | sudo tee /proc/irq/sw_moderation/delay_us
    echo 1000000 | sudo tee /proc/irq/sw_moderation/target_intr_rate
    echo 70 | sudo tee /proc/irq/sw_moderation/hardirq_percent

    # allow moderation on all interrupts that support it
    # remember to periodically check and set the flag for dynamically
    # created interrupts since the default is 0
    echo 1 | sudo tee /proc/irq/*/allow_moderation
    
    #  check the status
    grep -r . /proc/irq/*/*/../allow_moderation

    # look at statistics
    less /proc/irq/sw_moderation/stats

PERFORMANCE BENEFITS:
Below are some experimental results under high load comparing conventional
moderation with GSIM:

- 100Gbps NIC, 32 queues: rx goes from 50 Gbps to 92.8 Gbps (line rate).
- 200Gbps NIC, 10 VMs (total 160 queues): rx goes from 30 Gbps to 190 Gbps (line rate).
- 12 SSD, 96 queues: 4K random read goes from 6M to 20.5M IOPS (device max).

In all cases, with adaptive moderatrion, latency up to p95 is unaffected
at low/moderate load, even if compared with no moderation at all.

Changes in v5:
- refactored the commits based on previous feedback
- various cleanups
- conditionally reverted parent IRQ mask/unmask, which would completely
  defeat the mechanism GSIM is based on.

Changes in v4:
- added irqdesc and irqdata flags as suggested by maintainer
- parameters are only configured via independent procfs entries.
  No module parameters anymore.
- merged control and interrupt functions back into a single header/C files
- applied various annotations (lockdep, data_race())
- formatting and various renaming as suggested by maintainer.
- added performance measurements with adaptive moderation.
- removed the mechanism to conditionally enable moderation at interrupt
  creation. This can be done in userspace and suitable udev extensions
  will be handled separately.

Changes in v3:
- clearly documented architecture in kernel/irq/irq_moderation.c
  including how to handle enable/disable/mask, interrupt migration,
  hotplug and suspend.
- split implementation in 4 files irq_moderation.[ch] and
  irq_moderation_hook.[ch] for better separation of control plane and
  "dataplane" (functions ran on each interrupt)
- limited scope to handle_edge_irq() and handle_fasteoi_irq() which
  have been tested on actual hardware.
- tested on Intel (also with intremap=posted_msi), AMD, ARM, with NIC,
  nvme, vfio

Changes in v2:
- many style fixes (mostly on comments) based on reviewers' comments on v1
- removed background from Documentation/core-api/irq/irq-moderation.rst
- split procfs handlers
- moved internal details to kernel/irq/irq_moderation.h
- use cpu hotplug for per-CPU setup, removed unnecessary arch-specific changes
- select suitable irqs based on !irqd_is_level_type(irqd) && irqd_is_single_target(irqd)
- use a static_key to enable/disable the feature



Luigi Rizzo (7):
  genirq: Add flags for software interrupt moderation.
  genirq: Add GSIM infrastructure
  genirq: Implement core GSIM moderation logic
  genirq: Integrate GSIM into interrupt flow
  genirq: Add GSIM user space configuration (procfs)
  genirq: Adaptive Global Software Interrupt Moderation (GSIM).
  PCI/MSI: re-enable conditional parent mask/unmask with sw moderation

 drivers/irqchip/irq-msi-lib.c |   8 +
 drivers/pci/msi/irqdomain.c   |  20 +
 include/linux/irq.h           |  11 +-
 include/linux/irqdesc.h       |  12 +
 kernel/irq/Kconfig            |  11 +
 kernel/irq/Makefile           |   1 +
 kernel/irq/chip.c             |  14 +
 kernel/irq/debugfs.c          |   3 +
 kernel/irq/internals.h        |  20 +
 kernel/irq/irq_moderation.c   | 959 ++++++++++++++++++++++++++++++++++
 kernel/irq/irq_moderation.h   | 156 ++++++
 kernel/irq/irqdesc.c          |   1 +
 kernel/irq/manage.c           |  10 +
 kernel/irq/proc.c             |   2 +
 kernel/irq/settings.h         |  17 +
 15 files changed, 1244 insertions(+), 1 deletion(-)
 create mode 100644 kernel/irq/irq_moderation.c
 create mode 100644 kernel/irq/irq_moderation.h

-- 
2.55.0.737.g08866a6d13-goog

