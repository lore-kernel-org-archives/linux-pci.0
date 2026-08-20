Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF813A3E76;
	Thu, 20 Aug 2026 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787209754; cv=none; b=OdTUrOT4p1qQNkQseW6ae0XrN1voIywI3aPdwaHFCiW/v6THZ/h6020fY4TJC/rV9MZDgRtDmXsvsgooYw/0CTVRpJ6JS5FZgE5xJ1AseqwapgLnNlZPxnZ2a/g0s5pITFZH6xFpBobaVKsSrGmxvFUti9asKHdtrZB/QIaMv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787209754; c=relaxed/simple;
	bh=u/Pyu8UDh375x9Gx9vsa7LFDG9oygb8M4+DhO9QL7hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS9qEBN86LUJ8/paA3SNgRLQXFJHkthgO2NEN0sh5Nw6bJHhD9nbaGECslUVRSQ2sx8YChmntDSCPTsBWcISfU/S68HoOIjKveh3ls9iaZOOdDujIxSmRBkDwlhTFpK52xSl8onqh1EFW8he+ZjQD8xzzjro92/47bfx1t/1pVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c+FNRM3j; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c+FNRM3j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AQFta+WzVPta6DHNYoZVe4Ouq16ur7ggOW2mIZD2zqY=; b=c+FNRM3jZKZaa84JzJUgbrMJmi
	9FxTRdTX5N1bVx6FouHKO8/VvEPFKPrcxtoA9K4A0lpyJtwV2KweQ4iUfuvObdLNwahAO8V0Bf8dN
	sfSkXnvRd1BD4wFxadrJRVqJ4PrmmJ7jWUAL8lHgawP8H7Yh4nUx5hq6K9VY/crU+b7nOvHu706CI
	Lcy0MWL4PeKy1KPk0/pGNbXgbotplN+g/owqVf3jaCi18d0JulqGch2nuxpvhb4QqeccJ6zCfloQT
	zKfkUpfhu3BHumsXO2ORJn8KSpzvn/VlpSqpOIkiRd++xZJjf10/o/gAbbRr6pYnObiaETTwdIMMf
	Lz11C0xQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwwtd-0000000B0Pd-1zvl;
	Thu, 20 Aug 2026 07:09:05 +0000
Date: Thu, 20 Aug 2026 00:09:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Luigi Rizzo <lrizzo@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Luigi Rizzo <rizzo.unipi@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
Message-ID: <aoaoERD5m1MNvMWd@infradead.org>
References: <20260819124341.4185621-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819124341.4185621-1-lrizzo@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 19, 2026 at 12:43:34PM +0000, Luigi Rizzo wrote:
> Configuration is easy and robust. System administrators specify the
> maximum targets (moderation delay; interrupt rate; percentage of time
> spent in hardirq), and which interrupt sources should be moderated.
> Independent per-CPU control loops adjust actual delays to try and keep
> metrics within the targets.

Can we find a way to autodetect and autoenable this?  A magic go faster
mode that needs very specific tuning is annoying compare to sensible
defaults.

Also how does this interact with adaptive polling code inside drivers
like NAPI or the upcoming nvme variant?

> 
> The system is adaptive. Moderation affects only latency and only in
> high load scenarios.  Throughput and CPU efficiencly generally benefits
> significantly.  Targets don't need to match precisely the platform
> limits, and one can make conservative and robust choices. Values like
> delay_us=100, target_intr_rate=1000000, hardirq_percent=70 are a very
> good starting point.
> 
> GSIM does not rely on any special hardware feature.
> 
> Global parameters can be modified at runtime with
> 
>     echo ${VALUE} | sudo tee /proc/irq/sw_moderation/${NAME}
> 
> /proc/irq/sw_moderation/stats exports statistics when enabled.
> 
> and moderation on individual interrupts can be turned on/off at runtime with
> 
>     echo 1 | sudo tee /proc/irq/NN/allow_moderation  # use 0 to disable
> 
> EXAMPLE:
>     # global configuration: 50us, target max 1M intr/s, and 70% in intr
>     echo 50 | sudo tee /proc/irq/sw_moderation/delay_us
>     echo 1000000 | sudo tee /proc/irq/sw_moderation/target_intr_rate
>     echo 70 | sudo tee /proc/irq/sw_moderation/hardirq_percent
> 
>     # allow moderation on all interrupts that support it
>     # remember to periodically check and set the flag for dynamically
>     # created interrupts since the default is 0
>     echo 1 | sudo tee /proc/irq/*/allow_moderation
>     
>     #  check the status
>     grep -r . /proc/irq/*/*/../allow_moderation
> 
>     # look at statistics
>     less /proc/irq/sw_moderation/stats
> 
> PERFORMANCE BENEFITS:
> Below are some experimental results under high load comparing conventional
> moderation with GSIM:
> 
> - 100Gbps NIC, 32 queues: rx goes from 50 Gbps to 92.8 Gbps (line rate).
> - 200Gbps NIC, 10 VMs (total 160 queues): rx goes from 30 Gbps to 190 Gbps (line rate).
> - 12 SSD, 96 queues: 4K random read goes from 6M to 20.5M IOPS (device max).
> 
> In all cases, with adaptive moderatrion, latency up to p95 is unaffected
> at low/moderate load, even if compared with no moderation at all.
> 
> Changes in v5:
> - refactored the commits based on previous feedback
> - various cleanups
> - conditionally reverted parent IRQ mask/unmask, which would completely
>   defeat the mechanism GSIM is based on.
> 
> Changes in v4:
> - added irqdesc and irqdata flags as suggested by maintainer
> - parameters are only configured via independent procfs entries.
>   No module parameters anymore.
> - merged control and interrupt functions back into a single header/C files
> - applied various annotations (lockdep, data_race())
> - formatting and various renaming as suggested by maintainer.
> - added performance measurements with adaptive moderation.
> - removed the mechanism to conditionally enable moderation at interrupt
>   creation. This can be done in userspace and suitable udev extensions
>   will be handled separately.
> 
> Changes in v3:
> - clearly documented architecture in kernel/irq/irq_moderation.c
>   including how to handle enable/disable/mask, interrupt migration,
>   hotplug and suspend.
> - split implementation in 4 files irq_moderation.[ch] and
>   irq_moderation_hook.[ch] for better separation of control plane and
>   "dataplane" (functions ran on each interrupt)
> - limited scope to handle_edge_irq() and handle_fasteoi_irq() which
>   have been tested on actual hardware.
> - tested on Intel (also with intremap=posted_msi), AMD, ARM, with NIC,
>   nvme, vfio
> 
> Changes in v2:
> - many style fixes (mostly on comments) based on reviewers' comments on v1
> - removed background from Documentation/core-api/irq/irq-moderation.rst
> - split procfs handlers
> - moved internal details to kernel/irq/irq_moderation.h
> - use cpu hotplug for per-CPU setup, removed unnecessary arch-specific changes
> - select suitable irqs based on !irqd_is_level_type(irqd) && irqd_is_single_target(irqd)
> - use a static_key to enable/disable the feature
> 
> 
> 
> Luigi Rizzo (7):
>   genirq: Add flags for software interrupt moderation.
>   genirq: Add GSIM infrastructure
>   genirq: Implement core GSIM moderation logic
>   genirq: Integrate GSIM into interrupt flow
>   genirq: Add GSIM user space configuration (procfs)
>   genirq: Adaptive Global Software Interrupt Moderation (GSIM).
>   PCI/MSI: re-enable conditional parent mask/unmask with sw moderation
> 
>  drivers/irqchip/irq-msi-lib.c |   8 +
>  drivers/pci/msi/irqdomain.c   |  20 +
>  include/linux/irq.h           |  11 +-
>  include/linux/irqdesc.h       |  12 +
>  kernel/irq/Kconfig            |  11 +
>  kernel/irq/Makefile           |   1 +
>  kernel/irq/chip.c             |  14 +
>  kernel/irq/debugfs.c          |   3 +
>  kernel/irq/internals.h        |  20 +
>  kernel/irq/irq_moderation.c   | 959 ++++++++++++++++++++++++++++++++++
>  kernel/irq/irq_moderation.h   | 156 ++++++
>  kernel/irq/irqdesc.c          |   1 +
>  kernel/irq/manage.c           |  10 +
>  kernel/irq/proc.c             |   2 +
>  kernel/irq/settings.h         |  17 +
>  15 files changed, 1244 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/irq/irq_moderation.c
>  create mode 100644 kernel/irq/irq_moderation.h
> 
> -- 
> 2.55.0.737.g08866a6d13-goog
> 
> 
---end quoted text---
