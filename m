Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19B2EEE71
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793869; cv=none; b=EKZvFq4LUGZVWZQl4XdNb689D3tkNh4cCR8ayDrFkvNDdAOdbcS61pxHXVmGLO/6VVswPbSLI3/Yjo1IK6lovwoclfxhOYdIMHWfh9I8RvO21C8q88nXbw8SgZcsj3FCt/fiYTPTSClYeudK7OG7trvzbeuEmu33/fIaZ9oTdrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793869; c=relaxed/simple;
	bh=/n1lx7kZVGHY/CjYSQUPtmCH3DR+8LKo5cFZlGTFwfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LfD3qgnC+1c++IPhAix+bAnjrCAtz32zMTcb/7theDoxNQrdJJNIzdngAgU+Ostn3vL+ikhcd/XBnQep+fLceby1K9Z0ANjbgeFF6wMPuQDtSu3dqwE1/BPexz7Y+HL1SpnjbT2TWmsUS2e4syHog2y3QyHO+28GD/kjgU6N/5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/TGiOku; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/TGiOku"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84870e7f498so4344441b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 14:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785793868; x=1786398668; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3RiD/GImmxOZZ69pO9kk8WyvHse/kOu0dWQ2OD9gW0=;
        b=b/TGiOkucydAQe9yKgtIaVah7Q4/AFgn9vU98tLqDvblGnkJqMmifMVYbAID0cgj/r
         Aq9xwJ1K5zuftraxx9Lvzl6BW87241yaydzFctbGBtV2NnJjOMhoymIjEOK+AXs0JesA
         b7WtJnOX2ySM2zHZE9Rbiz1C3192u29LfLeXv8f71VD/Lt3pMXl+J4B7aMOEtsSc8zTb
         p4k5iUuJcrBK7MmcXrkaw81cwPF13wQl1qZ8D4HWsNGPl/l1603ojOWjakyDV4o/AQjY
         TJd7zrdheBIPcdEVZ4YGg7Iz0MGHy0+bctYC9wv9W3hGdp0UZv+ASYXgUS0h4WtY4xGh
         R+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785793868; x=1786398668;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V3RiD/GImmxOZZ69pO9kk8WyvHse/kOu0dWQ2OD9gW0=;
        b=FMIEF+gGEJKF5SP5hQKyMBtZTom0/HqtJItja9CaJM04WPtj9qR6RC+xqS44r8VXoG
         eXUSX6cNW25DHRLvCiUsqqVLic0YhN5QnasON0AwoOf8sKxdjQWZpdpGIhe/XDRr+El7
         av2kk6t9YxfQyXwHAh0vyi+yNxwVY2OXHAvfJhHuGyuXps1yDxSeKOVhu3rCruCh1bsG
         CoY42WytrMGVNjkAnrV76IGCOHjKFZ6JpaTMghfC+catCO+1jYGFmTY20RnMllfMkf5S
         HqmdMJPo64/+MAku+VpdUi6SBJ30MpDOwlwPiWuXw3HFUCc6iPPpgLaQf9s7olGzJd9j
         D6PQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqgrlzi5eYXdgvjdX0DrGqVc21pzXqu58PQJv8va5qQkHqxdtoWG9a7hOdhYgtDucSo8JbB3tkTlAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5bTydzXwrAvZnZFsdGfbYPWpzZ3uVo9yTUEZckxrd4b+KXfXu
	DUEqHsE506jP7h3lDcAKmsxakddkU9eHrtNPZhiKJd3St6xpQDC/Rr7Tx70VFuNqd7nYZEL1sgZ
	PIfqnRnSoczXZ+62Uc0nxNoY0pbu0WyuHGQ==
X-Received: from pfet15.prod.google.com ([2002:aa7:938f:0:b0:84b:62d1:9fe3])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4293:b0:848:2ae4:d2ba with SMTP id d2e1a72fcca58-84ee4864ed1mr9846295b3a.28.1785793867656;
 Mon, 03 Aug 2026 14:51:07 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:51:05 +0000
In-Reply-To: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260803-b4-fix-aer-memleaks-v3-1-e87159611933@google.com>
Subject: [PATCH v3 1/2] PCI/AER: Fix memory leak in aer_recover_queue() on
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

