Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925789;
	b=q3iAt9kZB92YrvZ6XHxaQOtflZ47kOYr15i1s2n7In3yWj8XdvRL/m0GezVNI5RIk8o4
	 BCul3XHfyAShTA3jCon+cbi8C0omWjACVaMRXylrkjSVVTjTY81F3eAnhZFZ74lk9gTOL
	 7Mh4zR8lgZ0uILpf46tUfbCcLctyH0BJfaTJy4E7oj/6oP8+JWfBHMxx7jkEgRkvuXnMo
	 VliURmvCyoYaQQlxafFjLep+qlXRSsBcq3JYHdjPJZNentzjDCixJaVVkPFG8awmvHvFu
	 puliqFLwRawgmgOXTKFWwMHyYQ0jIrMNILQyIjDbSOPUyGKPaK/spe857UdJxiWJwPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=iHjhOa1kArquGp6NzqJKIMKukUgu91Ev2XX32EWf/dM=;
	b=xuPmFJUraHwvoCei3hzMEHffiixBZrnzKoHxH0zdyBH3inim5KL0vxAcqjm/l6ZoR2Vw
	 utnH8ervmm2B7h3da3HkOi820ZBjmI6e7e0RNQmTRs5GwBTX6EBTttYI84uey2jmrEQFR
	 nJhsMT61nA6zaV5AWTxBKXktCB9dbKHCLh4BnYMSiao8orgyaRz0EZS0eRYJcDCoyd0s4
	 vYjJLCNcjcn2LOia7sjOYJ0oGSG5Xd9dbZFMI2QVA22Q14MKiPmRVU0cS0ZAJg9gVyGmC
	 IoHI2OZu8L63rnJ/jlaQbK4V+H1leDvbTnebxWhL0MQOHF10p8B2/WuxB3AQ+BWleDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XEzLTg5L;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6E606D80E
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 00:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3F6E606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XEzLTg5L
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4cc89e86e4dso86782b6e.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 16:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925788; x=1794530588; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHjhOa1kArquGp6NzqJKIMKukUgu91Ev2XX32EWf/dM=;
        b=XEzLTg5LO+6fZIlCzp7Ttw4D0M1RQeoXWDGHhSssqYAuqqjYS+cfVidU04GIqomibB
         wabtjdC8BVjVhCmmK516sQqRf6ODgThpJCMx8T5JSXv+17u6KOw/0+t3f+ikkALuzW3C
         2X/w3T6QV/fc/h47bpBSUn6DVJsZxHY2df15Y7HZy8lO0VLuDF7Zk53WNRADLCmnCBdv
         yYSZWnw2v0PRQnktGmZUjkTp78gZ/Gn7YL32SfML0rPaWzkTqz3yrAdI0H3Xoqx1TJqQ
         fzniFPjSu9USmkbFkogfNYqoZKdgNK83EUOOc2BhtvYi5jTlosvtH6ayj3mRCqVZ2mAw
         ZWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925788; x=1794530588;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHjhOa1kArquGp6NzqJKIMKukUgu91Ev2XX32EWf/dM=;
        b=0L+3vcayDrLYlngwLpJ6ccXi5KddwxAKrYW7/79EocNjF3n4R4cLJua1p1GD9Nb3zn
         MPUuuP6xcAEJt34+4bJb01LbfJF+LtzMTevkGGpAIzE1/uLlNrMWjHQYDDNZRTW/+tVZ
         wFcdR3zKjy/8+yK6w8mMHoCS99jmLNJ/cqh1+UwlrCb9bif7h+TvbMSSqdXLoHCX78mz
         v89jC6AU3/Lfnznj9YJXKD9aQbJzM4gFXv4EMKvTJW/VgCgN36e8Ws+FXQsPhznKoBss
         AeQfkRgsoUYDNaO3n7wb4W/T3a5vJ8q3e572kASzlhQAlKm651YcPICM6Gya7S3tAGjm
         mgSA==
X-Forwarded-Encrypted: i=1; AKwUvBxu9MfOZg0mM7ZeO2R6MywN7uZ+2ZjRE7Ae5NozHbVGP0BBeyySO3L+aSjMGwMPE6S3D75H1fjqS+w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xkB2Dc/8EJlGr3BJRXaXOmAnzeyWlijuX6f7MG+hWWnfo/QXs
	6KYc+/iSDXkJpPDpM8hgdR5lF9fmtkTtMnaya4g8BR4w81bQODlXskwCcuajAeOIQkTVk5tYjOn
	O/uQ3PkRKkLXwug==
X-Received: from jabfi10.prod.google.com ([2002:a05:6638:630a:b0:61a:c6d0:4104])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f66:b0:4b2:8d7b:41b8 with SMTP id 5614622812f47-567e1440ea0mr750093b6e.18.1793925787537;
 Thu, 05 Nov 2026 16:43:07 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:10 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-10-dmatlack@google.com>
Subject: [PATCH v2 09/17] PCI/PTM: Save PTM state in the saved capability store
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Save and restore the PTM Control register through the per-device saved
capability store instead of a private pci_cap_saved_state buffer.

Reserve the register in pci_reserve_ptm_state(), called from
pci_ptm_init(), and report a refused reservation. pci_ptm_init() ignored
the return value of pci_add_ext_cap_save_buffer(), so a failed
allocation left PTM state unsaved without any message. An allocation
failure is now reported once by pci_saved_caps_finalize().

No other functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/ptm.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index bd3bd39f6372..fc653d2d1ec5 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -34,6 +34,16 @@ static struct pci_dev *pci_upstream_ptm(struct pci_dev *dev)
 	return NULL;
 }
 
+static void pci_reserve_ptm_state(struct pci_dev *dev)
+{
+	int rc;
+
+	rc = pci_reserve_saved_cap(dev, dev->ptm_cap + PCI_PTM_CTRL, sizeof(u32));
+	if (rc)
+		pci_err(dev, "unable to reserve PTM save state (%pe)\n",
+			ERR_PTR(rc));
+}
+
 /*
  * Find the PTM Capability (if present) and extract the information we need
  * to use it.
@@ -53,7 +63,7 @@ void pci_ptm_init(struct pci_dev *dev)
 
 	dev->ptm_cap = ptm;
 	atomic_set(&dev->ptm_enable_cnt, 0);
-	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u32));
+	pci_reserve_ptm_state(dev);
 
 	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
 	dev->ptm_granularity = FIELD_GET(PCI_PTM_GRANULARITY_MASK, cap);
@@ -90,36 +100,18 @@ void pci_ptm_init(struct pci_dev *dev)
 
 void pci_save_ptm_state(struct pci_dev *dev)
 {
-	u16 ptm = dev->ptm_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!ptm)
+	if (!dev->ptm_cap)
 		return;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state)
-		return;
-
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
2.56.0.455.g6c5a503b38-goog

