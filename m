Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40575332610
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794382; cv=none; b=B0yWUwEXjjPZ3kWoUfNOIoQgGw6FIN4IOgXh/6qR7ByOeC1cBmJgVsTdFn4ba4ZJs1mNPyQ34ABApJ+tnlNlXqejrR5sV5n2kM/aodSSuZ88djLi1jndIlipypkRNrccGgc3m7+8zYNNtS27Vn97J0FwpJa/ry17Gmppfm63/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794382; c=relaxed/simple;
	bh=/n1lx7kZVGHY/CjYSQUPtmCH3DR+8LKo5cFZlGTFwfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FxWHbGN0NlB5O4EgcT0NKAx+q9eYNP2wEJStFMtLqS4SJV67WfF4h4ScjYI/rdRwnPKFw+wg8RdEJadakYZeA/hIcQkEYvajtDzwmHm+jz7JsLbKRgVeu/O8356Hbny/gwOVmXnK5ptFU7E9Xxs3GKUcXhty9yPzqVDqojjEvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kQFnx67H; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kQFnx67H"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3811279d51aso7247108a91.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785794381; x=1786399181; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3RiD/GImmxOZZ69pO9kk8WyvHse/kOu0dWQ2OD9gW0=;
        b=kQFnx67HHRDfiJjIyOX1CP6HbYLNXTUCO4gH3g3lE4RvDK6catGOyxUBQpY5Kly6Yq
         xa4DFd+cEOYNuz+Uj8YVEiWhGF2E3kbFMEbhCjov+5SInAU39baJ/YiFY/gJ7MaT3c/7
         QX6tTDNThccKDHneq2N90eRIhOCvCNZTPg4PyxHM3YBD+b617wNKIoEhXh3AxrPL+dIA
         jH+38BBp+fvDJZRstfFXy40IbaP2lIRM4Apm2zG0rfIUBo0Q3nJcMzJpBVFY5FwDSvbl
         qehMlh15eYPpfn5C99wdH9adVigC4XSu+n9v8lvW/spF81sexJHBzeAcWjokRfE/GB1C
         X4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785794381; x=1786399181;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V3RiD/GImmxOZZ69pO9kk8WyvHse/kOu0dWQ2OD9gW0=;
        b=KwLCKRtaZA26CEwQ6eU1aQiZjr3DGSgwMgtkFxFTUVvVRJ0saS9UZcjXuUghailj34
         1T6kNsPQuL0QHb2X9AIAWcfCcb3UZGFlHRuDu00vHMK827x8BhRG09jN6QFwB4/0TS46
         0dpNAWIVDUiBHVfMzR08xfra4KvO768BxuNpMqJ2tOA0ExzawA0Zgt9LOcpRwmJ3U4mY
         dgFvL1BTE8c/zP6ULBl6kKbEP+DRh7GNv1sSkmJsQHC3iNs9l762E8gJCxs+AV7VTokF
         JUT1WFahKrC9K0DT4QxvZ7lBUBDLBqyBhQ1GSzpVPt9NNT2/RqUYXPJEuz+FnFt0gPkz
         fhHg==
X-Forwarded-Encrypted: i=1; AHgh+Rrtti0CalgIHI8jRwmjcopFS0/pF51VYirVjbgDnQdPjyFxQns+/CuJZBWbvTYADXTpi4Mor58iWkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRK0QTHokqtHUnOsqjtuuNdnP9euGQYn5oNjRWuXpyoyo2aBx8
	IJAuHu61u9dVqNT60+75lZuJkdZHMvA3FEcthAbkfKnG0EW6rp4uluAVju5AQei0De3lYp/Rdao
	8gZFsSr7xft2aRZuyMjVU9ioRabXhsbT9Zw==
X-Received: from pjqq12.prod.google.com ([2002:a17:90b:584c:b0:380:f389:2b67])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fc3:b0:381:e74f:8a6a with SMTP id 98e67ed59e1d1-38fbc4681dcmr10873794a91.16.1785794380433;
 Mon, 03 Aug 2026 14:59:40 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:59:38 +0000
In-Reply-To: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260803-b4-fix-aer-memleaks-v2-1-fd199b0171fd@google.com>
Subject: [PATCH v2 1/2] PCI/AER: Fix memory leak in aer_recover_queue() on
 kfifo buffer overflow
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (aer_regs) from ghes_estatus_pool and passes it
to aer_recover_queue() to be enqueued into aer_recover_ring.

If kfifo_in_spinlocked() fails due to a buffer overflow,
aer_recover_queue() logged an error message but returned without freeing
aer_regs. Because the entry was rejected and never inserted into the
queue, aer_recover_work_func() could never dequeue or free it, leaking
the allocated ghes_estatus_pool memory.

Free aer_regs via ghes_estatus_pool_region_free() when
kfifo_in_spinlocked() fails on buffer overflow.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pcie/aer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c4fd9c0b2a54..967cde9dd519 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1274,9 +1274,12 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
 				 &aer_recover_ring_lock))
 		schedule_work(&aer_recover_work);
-	else
+	else {
 		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
 		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+		ghes_estatus_pool_region_free((unsigned long)aer_regs,
+					    sizeof(struct aer_capability_regs));
+	}
 }
 EXPORT_SYMBOL_GPL(aer_recover_queue);
 #endif

-- 
2.55.0.571.g244d577d93-goog

