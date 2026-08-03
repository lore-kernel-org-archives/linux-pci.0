Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63CF2F12A1
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 21:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793869; cv=none; b=nu1zMK4mwSb+Py/GzZStEhtUDonDWR1tzaWEeXYXse0NpDaEwDSmJj+BwwgzBL8z5uEqHI9yBH+nUrbpa6Ydhh4HcI6dnEjLuOxz9jTUwMzYzGRIvxbhGZ9lqhzDQuY1oWA/SyYs5YFhdxb00bAa2eYyUPfNfNQ3i9AaoXYMN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793869; c=relaxed/simple;
	bh=v2huOq5Ii3U8uHYjyGEzNQQm0blUV5hlazMw/9temZE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oA/FgeAmlP+GxIOfewY9wX7c+X5JFeb5mGZHMJDUbhVE+21m8kpXz5Aw8ChDFAAPOgJYJ2nrr+gZZ/6U6hlV6SptxLdUR0sk71f/1WUe34nUyYYZKaKTzoXRtz3rdzJm74DUBEptCpgbq4ILhy18TkrmzFSwTDrbo2JbmaeRjQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EdPhnkxA; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdPhnkxA"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so2667491a12.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785793867; x=1786398667; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ueF7qsDhWv0EVJ6I0YWRQAEPyu9W9Hcp8n0Sycy3r8=;
        b=EdPhnkxAoiFMX8/bOa9Ob8axPlYFr44LzDrdnty8N0N9ZTxRZ+Y3URnO1mYIWATskT
         5ijn/nGC1qU/nwvYn8rntNqYAMY937J1t0WwIES4RNzuasDu8YMKOi5ke0kUEwhEJKEq
         gdSzxfoVjd3TKB0uSC81zZ9PbZ+S1mwZ6y4L0v19HFqV1tuWejeFAQipAPdxuDe6ft1e
         tUzYttEM2htyON8D0dKnnLIOgm0La/ivfHIisvpv2GMKHuqpuRYtVKt084lBum1Sg6cv
         viZbVIMqhbrA/rry0kCkO0iicRwwPfOau8ouZ9hKH3gWAbXwDNcIL2gP8CHN+WOOZ/i1
         QnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785793867; x=1786398667;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ueF7qsDhWv0EVJ6I0YWRQAEPyu9W9Hcp8n0Sycy3r8=;
        b=AhdEoi2GvHQj1DarI3uqLX8HCMeaidoZdCjKwcZQp4vGu8NQG4uEvv4xToeyK6ZAgz
         NsRlUxngWh1Fl+1SK45/u26IXSxhm7eHTsk2zuYJf8iULssFRNlwr7VK/fwMlMRDkN3T
         jPmOgfz9f9/3Aw4nFJgB+cM4Akdj2hX7+a/pgPOKjtYn8QRQZE9r7YJZbYA1It6pGkrG
         /JdppmDqtBZaRphuqcM/XejxrKUgzSHAqpgDI0VdkHfjIcME1AGoNZ/Az3NzCGOUdcoK
         9+ku9vsB2q5HAcWWg+IDbt9vwPilWhkCKi2Wg53czIZVIM5tBo3AiYgf3PcSyrkCIHkF
         0G/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqXxWAKhEb9qNo2PSCFHdICArXYi8p9gD7drrIRe+NeJ7kcm/EVhcWibtCpqRdrw5NFNcHhINw+pU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRbEOAmAp4GnEHSkS6h3CH5uLx1Pjp29NVjMBYnl9kfYaRxRl
	NhDpjQu/bl+nG4WfC9ZjVPnDFRY42AKT+FNzMnmg1vr4BCDSud/T9zHQHN+RWO8iCwYUzyc/Jeu
	36o07fhrT67iqVfKLqRlniR3i8/iTikdzvA==
X-Received: from pgcp20.prod.google.com ([2002:a63:7414:0:b0:c99:aff5:707b])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:468a:b0:3c4:1c9f:d91 with SMTP id adf61e73a8af0-3c92aa7d0cdmr12901949637.59.1785793866780;
 Mon, 03 Aug 2026 14:51:06 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:51:04 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEgNcWoC/22OywqDMBBFf0Wy7khMosSu+h+li8RMNfiIJBIq4
 r83uigIXZ7L3HNnIwG9xUDu2UY8RhusmxLwW0aaTk0tgjWJCaOsopJy0ALe9gMKPYw4Dqj6ACU
 TqtCmRCklSc3ZY7o5rc9X4s6Gxfn1HInFkf58heSy5LngTJQ1MPBq6ZyZvV3V1D9a59oB88aN5 PBEdun+/SUyoGCYRspNLSuhL5J937+3l1k48wAAAA==
X-Change-Id: 20260803-b4-fix-aer-memleaks-524a1bd5e888
X-Mailer: b4 0.14.3
Message-ID: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
Subject: [PATCH v3 0/2] (no cover subject)
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

Changes in v3:
- Updated cover letter and auto-populated maintainer To/Cc trailers.
- Updated commit formatting per checkpatch guidelines.
- Link to v2: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v2-0-d2be03d9864b@google.com

PCI/AER: Fix ghes_estatus_pool memory leaks in error handling

This series addresses two memory leaks in PCIe Advanced Error Reporting (AER)
handling where memory snapshot buffers allocated from ghes_estatus_pool
are not released back to the pool.

When firmware reports PCIe errors via ACPI APEI GHES (ghes_handle_aer()), it
allocates a buffer from ghes_estatus_pool for aer_capability_regs and
enqueues it into aer_recover_ring. If errors are dropped or skipped, these
buffers must be freed to prevent ghes_estatus_pool memory exhaustion.

Patch 1: Fixes memory leak in aer_recover_queue() when kfifo_in_spinlocked()
         fails due to a buffer overflow (ring capacity of 16 entries full).
Patch 2: Fixes memory leak in aer_recover_work_func() when a dequeued entry
         cannot be mapped to a PCI device (pdev is NULL).

Changes in v2:
  - Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
    is called unconditionally for every dequeued record.
  - Added Patch 2 to fix related memory leak in aer_recover_queue() on
    kfifo buffer overflow.
  - Updated commit messages with detailed pool lifetime explanations.

Priyank Rathod (2):
  PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow
  PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing

 drivers/pci/pcie/aer.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Changes in v3:
- Updated cover letter and auto-populated maintainer To/Cc trailers.
- Updated commit formatting per checkpatch guidelines.
- Link to v2: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v2-0-d2be03d9864b@google.com

Changes in v2:
- Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
  is called unconditionally for every dequeued record.
- Added Patch 2 to fix related memory leak in aer_recover_queue() on
  kfifo buffer overflow.
- Link to v1: https://lore.kernel.org/r/20260803183853.432459-2-rathodpriyank@google.com

---
Priyank Rathod (2):
      PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow
      PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing

 drivers/pci/pcie/aer.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)
---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 20260803-b4-fix-aer-memleaks-524a1bd5e888

Best regards,
-- 
Priyank Rathod <rathodpriyank@google.com>

