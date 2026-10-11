Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E474376475
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791704376; cv=none; b=O0l4tPBYIyzX5Dff2JtAWNdHn9Au+6YSNitd4dTx4vcOV60wc1flKPJebcCzBYsqemx8RVjfsWxd1RwcAjrz6qNPrzoDhhjmKsLkfWh9oMaOXD9nhE03VgH06W7jZ1XSkW6V8rYedIdgK4AT33hwFpccOS9V13A1mgIZs/Ym11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791704376; c=relaxed/simple;
	bh=lfjQsW/BihdPhJc0SS5cZaHH3aIlRKIEDNJEQgrglLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrtFR3LQjvq+cfbf7PcdgMPB0wU5DosvouGbukN9yaQd+stPqFzgu528d+xHm0uH/pD2hd5HS1JDp6kdUlsZQ/WnI4gvZpYMvLiL3NH2qqxXSMUSqT64ocKGyLCJGf4gAjhsMB9J3ZoBzSjO+vQtUFALbIbgdfpmwsMnHjKwBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHoj+oZr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHoj+oZr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791704373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmGOEmeyU6IwIm9lfYDfhaSFdYb+m5YlDJ7SsX9QGGQ=;
	b=HHoj+oZru+LH7XbzWVkpI6l4BTxuy3Kw3gkK1CKw03dBkbMoUcvUQ3JGzUA2eXsHxCj3KR
	eBkwrltSsVKynoRKwYUcnkHYxUc4WVXxn4rYNPZOZ53AlF5Lcrq1I/GQ8kIipWd2nEH7Rh
	wmmOMwyCtm4hM3LgVqBbiKEzSq/nYWw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-mepeEYrdO3yJn6mUatepNw-1; Sun,
 11 Oct 2026 07:39:30 +0000
X-MC-Unique: mepeEYrdO3yJn6mUatepNw-1
X-Mimecast-MFC-AGG-ID: mepeEYrdO3yJn6mUatepNw_1791704369
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23B01195609F;
	Sun, 11 Oct 2026 07:39:29 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 751FA418;
	Sun, 11 Oct 2026 07:39:27 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: sashiko-bot@kernel.org
Cc: jtornosm@redhat.com,
	kvm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 6/7] ath12k: add PCIe link recovery retry
Date: Sun, 11 Oct 2026 09:39:26 +0200
Message-ID: <20261011073926.508795-1-jtornosm@redhat.com>
In-Reply-To: <20260930151745.DDE401F00893@smtp.kernel.org>
References: <20260930151745.DDE401F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

> [Severity: High]
> Will this create an infinite loop during a kernel panic?
>
> The panic handler ath12k_pci_panic_handler() executes via the panic notifier
> chain:
>
> ath12k_pci_panic_handler()
>     ath12k_pci_sw_reset()
>         ath12k_pci_soc_global_reset()
>
> Since interrupts are disabled during a panic, jiffies does not advance. If
> the PCIe link fails to recover, which is common during a system crash, does
> this loop evaluate to true indefinitely and prevent kexec or reboot?

Valid bug. ath12k_pci_panic_handler() calls sw_reset with interrupts
disabled, so jiffies never advances and the while (time_before(jiffies,
timeout)) loop runs forever when the PCIe link is dead (which is common
during a panic).

Fixed in v2: replaced jiffies-based timeout with a simple iteration
counter (250 retries * 20ms = 5000ms). This works correctly in both
normal and atomic/panic contexts.

> [Severity: Medium]
> Does this busy-wait cause a severe CPU stall?
>
> A 5000ms busy-wait monopolizes the CPU, causing a severe latency spike. In a
> virtualized environment, which this patch targets, it can starve other vCPUs
> or host tasks, and risks triggering RCU stall warnings.
>
> Since mdelay() relies on a spinning loop and actively consumes 100% of the
> CPU instead of yielding, should msleep() or context-aware wait functions be
> used for delays this long outside of atomic contexts?

mdelay() is required here because ath12k_pci_panic_handler() calls
this from atomic context with interrupts disabled. msleep() would sleep
forever in that context. The 5-second busy-wait is bounded and only
triggers in error conditions (link failure after reset).

> [Severity: Medium]
> Can this cause a spurious timeout if the thread is preempted?
>
> If the thread is preempted or descheduled during or just after the mdelay()
> call, which is common in VM environments due to vCPU scheduling, jiffies may
> advance past the timeout.
>
> When the loop terminates due to time_before() evaluating to false, it returns
> -ETIMEDOUT without verifying the register one last time. Does this ignore the
> possibility that the hardware condition was satisfied during the preemption
> window?

With mdelay() (busy-wait), preemption during the spin is not a
practical concern. The counter-based approach in v2 makes this moot
entirely since it counts iterations, not time.

