Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6235C233942
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794381; cv=none; b=S9nAx1iqlY/U7XBOAttiRS7COCudcbw+FbAiBxeH3H9Y/yLXtx7JV5k3J/xjUXqJTFUm4Khya0krEGOBEcS96C7uhNdJc0tzym7ne23a5FwFjCuzI66+x3e6crNNC0N1+vE2xcbGtFJKEoNEBxCcstXbkr5KiuM3koSNEkBFdx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794381; c=relaxed/simple;
	bh=R1EzwM0iGQZ03G4a5hqC73Y0K499jeEQ4KP6FVLTvjI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S5TP2JCKsERoWuKewuWgQaxlAfd8PtKhxGLJi7l+db/MyA/9yVV1wWydkfV4mGtEuPsZnu4hQmn12F2z8RSwyuTAvEybWD1kLcpEx4CB6aEoAgE+LM9MrheEP/LH2yaCdvr9hnMX2oITx8clxcRhSkSTFFm3M4wpK6+lMkid72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4WxpEK+; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4WxpEK+"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb4cdf95b5aso7928969a12.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 14:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785794380; x=1786399180; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uVEhXqZ2S4ZB77O3YdEcMlIVSh8TdZgWM5WFDU+zGjc=;
        b=I4WxpEK+OvxkYGre5DvPosNir6eP7+MG0Ypv19POJ2i6M9YIlqGxlPH6QFn77vFBjq
         kf/i62Z5+ly7TaPtXogd2Ki9awJrWO0qhH+xjFkLjEZuiNu6PEkRZHjl5NlEw5Frhx3d
         yGIuihWZjahX5vgHXHwIxoEUWhC8Txm0Rmoh/V/un3nx6gRSwZHV9OuqAm9WIhHUGtwN
         x06DBGuM83WlM8dzUChOnNFzzcqb70LAJ+zRQPsGb69Hq6RI/o2Ead3yfjSnXgCKGekz
         4/wdEWNBU9p0IUKu5okwKXnGd31ALxUR+nd/IPPWjFLfO7kINq9xd3+WlIGKp22adKVb
         5Tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785794380; x=1786399180;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVEhXqZ2S4ZB77O3YdEcMlIVSh8TdZgWM5WFDU+zGjc=;
        b=BkbiTsT4GpEVGar5VDJhZfCr2l4TqQSGTzpLZckoKTDhZDroU6JqroU10yMsH14aR9
         hHQOpOwZ3T77ZlldRVuRrsNbS1uyF4d5rlZz3ar7BK/sp8doa3ouCES+R7PvYb7uPvEk
         JCavxHLCH9JbxGynr3hS3vhPrR+NBKE2zi73AQ2uoZ8uZv7EEiiyeuueyOPyBCUBQTe6
         wUdyL4CSGeCVoFFQra0cNN5xJBWsKcnJWkjwzEtu0XoIIfcaW6tP8F0H8LpntQga6vMa
         iqOHGnOx3LWyX2jY10wvy2yMNcJUEraHdh83UEV8zya2bCN4twwmNMqyiHnPgPo9LhHx
         7qeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrv6+508U4ITgULhGz/uwSqBf1pM23IoDkvEdKKwcVMTjv1oPQYvYrXHYC9HmAsEay8FhkTMcCzYBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCh3aOw7oucmGzxYgZGh9Tm8cjiC7pLiAhG1kzZd6zo23mTgnf
	iWdZ3eSyIdU2nv0JSbg4rrAb14HCldYohnwE5VuffEjFwjFj73oVHAIXrer+CNyohwJ8vo8HilT
	xuKthn7aTHIHjm+RsFkOW4fDh6z0PXjR21g==
X-Received: from pgah3.prod.google.com ([2002:a05:6a02:4e83:b0:c9e:bb:ebaa])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3392:b0:3c3:bbe6:95c7 with SMTP id adf61e73a8af0-3c92a59957dmr12749564637.17.1785794379417;
 Mon, 03 Aug 2026 14:59:39 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:59:37 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEkPcWoC/z2NSw6CQBBEr2J6bROYjxldeQ/DYoAWOnyG9BAiI
 dzdkYXLV6l6tUMkYYrwuOwgtHLkMCVQ1wvUnZ9aQm4Sg8rVLXe5xsrgmz/oSXCkcSDfR7TK+KJ
 qLDnnIC1nodQ5ra8yccdxCbKdJ2vxS/++wmlndWa0MvaOCsUvXWhm4c1P/bMNoR0oq8MI5XEcX wx5i6muAAAA
X-Change-Id: 20260803-b4-fix-aer-memleaks-524a1bd5e888
X-Mailer: b4 0.14.3
Message-ID: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
Subject: [PATCH v2 0/2] PCI/AER: Fix ghes_estatus_pool memory leaks in error handling
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

When firmware reports PCIe Advanced Error Reporting (AER) events via ACPI
APEI GHES (ghes_handle_aer()), it allocates a snapshot buffer from
ghes_estatus_pool to store the aer_capability_regs registers before
enqueuing the error record into aer_recover_ring.

If the error record cannot be enqueued or if the dequeued record cannot be
processed, the pool memory allocated for aer_capability_regs must be released.
Otherwise, unhandled errors silently leak memory in ghes_estatus_pool,
eventually leading to pool exhaustion and breaking system-wide GHES hardware
error reporting.

This series fixes two memory leaks in PCIe AER error handling:

Patch 1: Fixes a memory leak in aer_recover_queue() when kfifo_in_spinlocked()
         fails due to a buffer overflow (aer_recover_ring capacity of 16 full).
         The rejected entry is immediately freed via ghes_estatus_pool_region_free().

Patch 2: Fixes a memory leak in aer_recover_work_func() when a dequeued entry
         cannot be mapped to an active PCI device (pdev is NULL). Refactors the
         loop so ghes_estatus_pool_region_free() is called unconditionally for
         every dequeued item.

Changes in v2:
  - Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
    is called unconditionally for every dequeued item.
  - Added Patch 1 to fix related memory leak in aer_recover_queue() on kfifo
    buffer overflow.
  - Updated commit messages with detailed pool allocation and lifecycle explanations.

Priyank Rathod (2):
  PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow
  PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing

 drivers/pci/pcie/aer.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Changes in v2:
- Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
  is called unconditionally for every dequeued record.
- Added Patch 1 to fix related memory leak in aer_recover_queue() on kfifo
  buffer overflow.
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

