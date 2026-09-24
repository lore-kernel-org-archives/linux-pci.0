Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62898535FBA
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271318; cv=none; b=m1vx+n/ei+ghXfEyWvj4l1esm3BrctRnELx5fM/2rTlM4dbUKhalPaNYR3+/Ok50/9wIc4LRtlkOzzUUYE4BWsutDNVGYnzEhzNe6cyLxe/0/G1W1FYqsxDkPkCV0jCoUNP7s4YuRC7TWOhrHLfFmMbCFqXIHDFM2pVsHTJuts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271318; c=relaxed/simple;
	bh=+2XkVyc+d7lmXngp5c27amWCxF9xLyfF2JbamA+2GNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BjDL8SCcZpxfIyX4tTTlYtwa3QdAdp0aiBEQT2jeuZAFens8ESJUfw+LuLFrPADhennrgIPcGeT98CuJ+ak9CMYpyjncnCFZaMuJOBi5KPgg12wH1O4Ph8ybPlWlLWScOIXYMSoqmOx4mdDEt5h8ql8LWWFCHsZd4Urrtdts+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWO5iqQN; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWO5iqQN"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc489e7a701so15499a12.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271315; x=1790876115; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KIWUowhWgqgcS9B9uJaCFyMmng9ri0RWLxjQM7dDfo=;
        b=YWO5iqQN69x7zGNZfbJvjf7KHMBSryoym5VSkLMbGCSvEWwvdwtvdqQeKCMuExcTMb
         0H7vsL1NtBbmp+nMHKXr+xXnP8VB1I9opVv774LQWD7mz5gjZCXGOdhy12py0XTWyWCB
         VYzrdw03Y8d0yRt1Kcqdfh9cJcyL/s1wQNM/KXDWS0bcqTxgvi1qvdjoP8gIIZslggND
         IoFOQxelHbIHs+YHRVYM2EIjk4MzVwuBtI5n7uNcDEYVt42Vh9HczeYx5RjZUVTCtcul
         XE4xX31IyYWzpPWXh7DKyyb0Emp6eLdh3RtU5EZGYQlnZwTtATYZqDOpG6NXQ51sDogx
         c1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271315; x=1790876115;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9KIWUowhWgqgcS9B9uJaCFyMmng9ri0RWLxjQM7dDfo=;
        b=W4Afk6J2NS4U7WesPz1jxy4sY6QR0BGLDIoVa4B7R+/OkNOG3VM/vrSQpfCjN023ve
         jkCQUkIwtpYP+OQmzgXep75UsSfT8wzmiV+EKrzbpsEdIrhgM3MbaRq9n15C2h3nRIqT
         9mcZZThzQL1agwvjmtESWp1EJUFBi3Iknq0SDBHM0x4yMU8VjVI/pjc/IAGYYtDaaIP3
         Sm9apOoCPdwIYiFi7QQxJjPPdm94dtnutfwjBVXqXGhCr+r7q9NQyul6GWM3vgr5I0m0
         crTI6+z7RVOQPmXqe2zptIfUmaBfnOhlHSw/aQPb4Y8TrqoUrU500Pi6kUf6A76xmBNi
         IFiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxURWbM7QuebDiA1WgVkk8EFN/t6NTgPO/Gv2AzGXTrlR8xpBleCPUOB/j2ZgusBLx+ABH53rpInTA=@vger.kernel.org
X-Gm-Message-State: AFuF++kBx7T1/rouaJC56X/Dd5QxmTrarp8s7xk5sjH9oYk3oKB39rPX
	4kgY5UGkC+Lmpb7YojuP/hA7Yxvhl+JRWpcJBUbiu2tRK5VhITp0IuionYxQSnzqKV9aH+hsaTA
	I0t+HjAs6zY8kVw==
X-Received: from pfbmt15.prod.google.com ([2002:a05:6a00:6e6f:b0:87f:a748:7030])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:b7a6:b0:3dd:651e:b71d with SMTP id adf61e73a8af0-3de0e7445c3mr3228498637.24.1790271315360;
 Thu, 24 Sep 2026 10:35:15 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:55 +0000
In-Reply-To: <20260924173501.856380-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173501.856380-10-dmatlack@google.com>
Subject: [PATCH 09/15] PCI/PTM: Save PTM state in the saved capability store
From: David Matlack <dmatlack@google.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Save and restore the PTM Control register through the per-device saved
capability store instead of a private pci_cap_saved_state buffer.

Report a reservation failure. pci_ptm_init() ignored the return value of
pci_add_ext_cap_save_buffer() entirely, so a failed allocation was only
noticed later as silently missing PTM state.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/ptm.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index bd3bd39f6372..a9e29e19b0f9 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -53,7 +53,8 @@ void pci_ptm_init(struct pci_dev *dev)
 
 	dev->ptm_cap = ptm;
 	atomic_set(&dev->ptm_enable_cnt, 0);
-	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u32));
+	if (pci_reserve_saved_cap(dev, ptm + PCI_PTM_CTRL, sizeof(u32)))
+		pci_err(dev, "unable to reserve PTM save state\n");
 
 	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
 	dev->ptm_granularity = FIELD_GET(PCI_PTM_GRANULARITY_MASK, cap);
@@ -90,36 +91,18 @@ void pci_ptm_init(struct pci_dev *dev)
 
 void pci_save_ptm_state(struct pci_dev *dev)
 {
-	u16 ptm = dev->ptm_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!ptm)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state)
+	if (!dev->ptm_cap)
 		return;
 
-	cap = (u32 *)&save_state->cap.data[0];
-	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, cap);
+	pci_save_cap_dword(dev, dev->ptm_cap + PCI_PTM_CTRL);
 }
 
 void pci_restore_ptm_state(struct pci_dev *dev)
 {
-	u16 ptm = dev->ptm_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!ptm)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state)
+	if (!dev->ptm_cap)
 		return;
 
-	cap = (u32 *)&save_state->cap.data[0];
-	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, *cap);
+	pci_restore_cap_dword(dev, dev->ptm_cap + PCI_PTM_CTRL);
 }
 
 /* Enable PTM in the Control register if possible */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

