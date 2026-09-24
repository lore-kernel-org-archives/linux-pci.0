Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E205383CD
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271319; cv=none; b=VMH8yzgxqQDB5R82HNaznbdDk6iYq55nbzkwScB4ZN85O8V48D4NM/MUHpsrmCUtllfRt7p5SDjlgj9+5fLXpUL15eo2nyJUBrPILxJFTc1LM8/Az2KTPZkRJ7DHJSuuQgH5oLAybtw9izlxfNhijE2L/KhGk9DFF64UtP9teVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271319; c=relaxed/simple;
	bh=pEfV34CkxtfqvOYXgFuWoFiiNWTtD4LGHsGafxuivZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i2Z6k8bYMsODDTaDF/YZME2fpmgt2JUQmvZHD80Ruh8n5BepIH5qzNYfwThOm1JkCi3mC1lHWW9FVjfs2++b7D+/3+LT5Iawh6yvJNYgqx1vLb5c59L0CMzGRaVn14Wwzu5tYvG7u9xrbW7NkTvp5xED7ZS85SHOY/eDGLUD9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fN2xBRp/; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fN2xBRp/"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so209019a91.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271316; x=1790876116; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zFj8/UWJalzVgVbf9Z+bMao7LvxnzpTDorii05nidDQ=;
        b=fN2xBRp/jObSofXIDKagPVsqjnU23mGEGlYHO9O7UcYAlve7jcYhPEvDpqA3TJcAm/
         s7N/geVa9UWPpyJXUtmMu74qqZ8JA7z6GmoSY1W9ThxBeg17jjoP+H43M/tx6FvNe8Dx
         6s/sMtVvSi7rsbJ4wo43XqXsgBc3b8NT08Lwj2mkaarIKeFGYf8nyYsUeiaKuur7l6O7
         BhI6+HFHEWxRRPWpi0LWAweVm+mUB0OY/jXw7BcEP9puB8ojVMQG7T92zkF+jIW9KHWi
         8lT/k5QlEs+c+6fYkbgWPk7IpQSQ2JIIqdl91b7CqE+1HN6+MePKJfYqACzaK2pXjyuK
         pNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271316; x=1790876116;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFj8/UWJalzVgVbf9Z+bMao7LvxnzpTDorii05nidDQ=;
        b=PVzhX1RQNTOJMF2w/MXgQsHPN8umGcTYAtLuwB4W437a/9v/6dzAa1Nngi4TwKN45R
         olGc8vqSOw/zvYS3E5U64Aw4WSRTS/srD790OOTnBVZMdIsPQ5mmz8SPiBgyLWv0jfGF
         08rn+nnPtSggup+9ud0ZXctUEJLom1DEPTp5sHQz5tpWRTPwRpy7REPN7/M1xgOrHCvP
         9pCgDwW1rcXrrW0XrKkoSiSH/ezbSGKVEqREJdgq3JhTvPu+RSAUbEIhM6CV35Y6Ru7V
         qbEBmNvVPrntEqF30FWdzCPGAG+i9WXDJZ9FV/ZLSHvn2BD1+9uy4y/ZGcgQlRLOyONj
         cV9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxafGOXaoVy+uhNbncgEtepcdw+2qogSrONKTi7g1J35KerD6/Or79RBa/4rwdzjyObcVgCv7FPaK0=@vger.kernel.org
X-Gm-Message-State: AFuF++l6OyvfAuk7alJ745CLdJT7AK1Rc1rluYXBOhxOIaxP39kYggtD
	l5xzSOP0Noqq017bn3avT8tsdNgQWxsRpeOuLUVQRuZMLes7YCe3/6xciYzixaW2uYfiBRPs7pA
	tDVcdZsWObuDoxg==
X-Received: from pjzc9.prod.google.com ([2002:a17:90a:e109:b0:39d:bd8c:be19])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c12:b0:3a0:b210:643e with SMTP id 98e67ed59e1d1-3a0b21068bcmr591367a91.22.1790271316212;
 Thu, 24 Sep 2026 10:35:16 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:56 +0000
In-Reply-To: <20260924173501.856380-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173501.856380-11-dmatlack@google.com>
Subject: [PATCH 10/15] PCI/TPH: Save TPH state in the saved capability store
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

Save and restore the TPH Control register and Steering Tag table through
the per-device saved capability store instead of a private
pci_cap_saved_state buffer.

The Steering Tag table is variable length, so pci_tph_init() had to compute
a buffer size and both the save and restore loops had to walk that buffer
in step with configuration space. Reserve the table by offset instead so
that the loops can address the entries directly.

Report a reservation failure. pci_tph_init() ignored the return value of
pci_add_ext_cap_save_buffer() entirely, so a failed allocation was only
noticed later as silently missing TPH state.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/tph.c | 44 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 655ffd60e62f..fa9f60e5a431 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -439,10 +439,7 @@ EXPORT_SYMBOL(pcie_enable_tph);
 
 void pci_restore_tph_state(struct pci_dev *pdev)
 {
-	struct pci_cap_saved_state *save_state;
 	int num_entries, i, offset;
-	u16 *st_entry;
-	u32 *cap;
 
 	if (!pdev->tph_cap)
 		return;
@@ -450,29 +447,19 @@ void pci_restore_tph_state(struct pci_dev *pdev)
 	if (!pdev->tph_enabled)
 		return;
 
-	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
-	if (!save_state)
-		return;
-
 	/* Restore control register and all ST entries */
-	cap = &save_state->cap.data[0];
-	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, *cap++);
-	st_entry = (u16 *)cap;
+	pci_restore_cap_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL);
 	offset = PCI_TPH_BASE_SIZEOF;
 	num_entries = pcie_tph_get_st_table_size(pdev);
 	for (i = 0; i < num_entries; i++) {
-		pci_write_config_word(pdev, pdev->tph_cap + offset,
-				      *st_entry++);
+		pci_restore_cap_word(pdev, pdev->tph_cap + offset);
 		offset += sizeof(u16);
 	}
 }
 
 void pci_save_tph_state(struct pci_dev *pdev)
 {
-	struct pci_cap_saved_state *save_state;
 	int num_entries, i, offset;
-	u16 *st_entry;
-	u32 *cap;
 
 	if (!pdev->tph_cap)
 		return;
@@ -480,21 +467,14 @@ void pci_save_tph_state(struct pci_dev *pdev)
 	if (!pdev->tph_enabled)
 		return;
 
-	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
-	if (!save_state)
-		return;
-
 	/* Save control register */
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, cap++);
+	pci_save_cap_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL);
 
 	/* Save all ST entries in extended capability structure */
-	st_entry = (u16 *)cap;
 	offset = PCI_TPH_BASE_SIZEOF;
 	num_entries = pcie_tph_get_st_table_size(pdev);
 	for (i = 0; i < num_entries; i++) {
-		pci_read_config_word(pdev, pdev->tph_cap + offset,
-				     st_entry++);
+		pci_save_cap_word(pdev, pdev->tph_cap + offset);
 		offset += sizeof(u16);
 	}
 }
@@ -508,14 +488,22 @@ void pci_no_tph(void)
 
 void pci_tph_init(struct pci_dev *pdev)
 {
-	int num_entries;
-	u32 save_size;
+	unsigned int off, len;
+	int error, num_entries;
 
 	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
 	if (!pdev->tph_cap)
 		return;
 
+	off = pdev->tph_cap + PCI_TPH_CTRL;
+	error = pci_reserve_saved_cap(pdev, off, sizeof(u32));
+
 	num_entries = pcie_tph_get_st_table_size(pdev);
-	save_size = sizeof(u32) + num_entries * sizeof(u16);
-	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
+	if (!error && num_entries) {
+		off = pdev->tph_cap + PCI_TPH_BASE_SIZEOF;
+		len = num_entries * sizeof(u16);
+		error = pci_reserve_saved_cap(pdev, off, len);
+	}
+	if (error)
+		pci_err(pdev, "unable to reserve TPH save state\n");
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

