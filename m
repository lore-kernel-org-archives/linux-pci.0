Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246013;
	b=SKRsHLCpGWBXQGrqaHtQ4cD0Fr6meU6HfIyBWzPgQ9JN64hRvygWYZ8t0fiJyM5SyijU
	 Qgh9iZvLmvG/3m78X9ip/sl+YJ50Rh+Cyg1LWhgSoCa8OfhOSm9wfBEfQ/i3cNcm4x/VY
	 FYwQRfv4brv6juatRgOMyADi9ZlpVvAXGu6sWRwi7Ri9uUklgj0k0YwpmOQsKOo4cH8h3
	 gbQUJnWBV1Bu4NTQKUhZwydEfIDDPoyU5yTcAg6tQfb6U2ufjnm/AMdD3L1blqvxmFShS
	 +6KDjGjHPXUg3wXGCi2isHy6uYuGhrKSx8Jc/Up8wmV1LvYYntGqv8P2zVPiVsn3rmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=V6MeppHP57XkB6Vcbi1NjLSOrXOHPekCDqlyRxgTdoY=;
	b=O7v8cP9nAyfDVFVPLiYjlTKLhWgzrVwoMAZcd7LQXs4i+v7eXH6UiHfDCWxGyonmkuzO
	 mimnsXVjH68YXpwFj1BNTeYyYNfpx4KyEDiwWvglbwT67LTdN2piLjmtlXpLfvnLtzrAV
	 SVDCiMa1bFVU173sR0wxhbJHQqfaLK3L1UXtPntgnfxhTr8LwSUxSDUiOX4+k/3vntdXV
	 26DWUh305xKRncGy0k54ycuEyfbFWqhwVPLHKuNPPsyEK2Hc2Uog8usJRENpnN5/6Cngb
	 EBWrTvLdWtXaYt1EQuMeihtLexudqHWeIPTR59AYF10uYd2yU1IGgWTgQ9c3QKGv6rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lbBipL9q;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3398606A321
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 17:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3398606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lbBipL9q
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c7f887ac6bso1502148b6e.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794246012; x=1794850812; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6MeppHP57XkB6Vcbi1NjLSOrXOHPekCDqlyRxgTdoY=;
        b=lbBipL9q/CiPAjtJIqUn717NAMcDEQhFX8fuN/J4zITLPAIBdEToyQPlO/weR6Qy9M
         p0rODBBU2z40h+ae7ev7h7KNoJi4gVHmYz2MyTZE4QEkfRPhCCtWxUORfF2OGZJnLGSQ
         yXrHa5UFcTlIsMB7i02+40tcEWBBvZ8PnlD1qgMqrTnKpJSqv5Z04zGIil1mYGO/WXeE
         egOXY0ILCkWCKKpsCqtbYc/4/PfDIsAcCoy1gFsEp37dzEwas6rM/FDLqcd6xOqZy32l
         kmu1kV0aB/XxEtekLYY8bz5kzeco2PGGJZWBUiILDU0aVeG3iDnuVN3g737GXNIvMDuV
         Vjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794246012; x=1794850812;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6MeppHP57XkB6Vcbi1NjLSOrXOHPekCDqlyRxgTdoY=;
        b=2j4hyJRBEu4nZuCpmhp29kWN+x4evpRFEdGUSfqP9XNJD1P5sp//8ma1NGuQytP5i+
         8MJ8Ti8mJY50JtmyNGYIKbDv9Z3CsajxKeLZwqI6d+w7UdQ8KyacH/Ihudcc0hCGULPz
         MPMj1rpW114lXDlnaFSMEtSKgg3z4s0WFD8/Yhp/vPnyLc6I1EtXUci+k7+0DYI/3CKA
         I0jF4D7jBtC2/4uBRlFsfM1Zb9ZeJbafqRe8ERzPkkk+kZxcSoPct3yqJ++9RqZyRHC5
         BVtDWMoEgxCBebAxjH8u3R0MZHqLKodzkoENQIkPRpJSe7IDPN30XUCIuw2lpDQuf+Xw
         xVSQ==
X-Forwarded-Encrypted: i=1; AL+hErGoB8wUFuoWEHqtzUxmFPEaqMxzXswk4KEUhR459w134ZtbGrbBevq29AO5fdcO69+wct8uwVd71Zs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9P2HIByVYJq2pSWWmHgQHNn9VS+DrO8YiOlU2X9Hfb3/2Z52Mj
	fRpYFQEs1R56Wox7wGtmeRhxuRsDE5NKDWT8xAJNqTGkIl6P4qomLQvgQSTbJDr809JhU0SUGeN
	TXhV1XVm4yecsQg==
X-Received: from iofm3-n1.prod.google.com ([2002:a05:6602:83c3:10b0:9c7:7259:cd7e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c126:b0:4d6:9113:25ad with SMTP id 5614622812f47-5683ce779b1mr275284b6e.48.1794246011548;
 Mon, 09 Nov 2026 09:40:11 -0800 (PST)
Date: Mon,  9 Nov 2026 17:40:09 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261109174009.735309-1-dmatlack@google.com>
Subject: [PATCH] PCI: liveupdate: Factor out pci_dev_ser allocation and release
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Move the code that starts and stops preserving a device into
pci_liveupdate_alloc_dev_ser() and pci_liveupdate_free_dev_ser(), and
split pci_liveupdate_preserve_device() into separate paths for devices
that are already preserved and devices being preserved for the first
time. Leave a single refcount increment shared by both paths.

Since upstream bridges are preserved once for every preserved device
below them, nr_devices is only incremented when a device's struct
pci_dev_ser is allocated and only decremented when it is released, not
on every preserve and unpreserve. Keeping that accounting in a pair of
helpers makes the relationship explicit.

A side-effect of the refactor to pci_liveupdate_preserve_device() is
that preserving an already-preserved endpoint after it is frozen now
fails with -EINVAL instead of -EBUSY, since the frozen check now happens
first.

Link: https://lore.kernel.org/linux-pci/20261106173427.GA1633106@bhelgaas/
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 88 ++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 6f92d4ddca2b..3a18a7e2d81f 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -498,6 +498,44 @@ static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoi
 	return dev_ser;
 }
 
+/*
+ * Start preserving @dev by allocating its struct pci_dev_ser. The caller is
+ * responsible for taking a reference on it.
+ */
+static struct pci_dev_ser *pci_liveupdate_alloc_dev_ser(
+		struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser;
+
+	dev_ser = pci_flb_alloc_dev_ser(outgoing);
+	if (IS_ERR(dev_ser))
+		return dev_ser;
+
+	pci_info(dev, "Device will be preserved across next Live Update\n");
+	outgoing->ser->nr_devices++;
+	outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
+
+	dev_ser->domain = pci_domain_nr(dev->bus);
+	dev_ser->bdf = pci_dev_id(dev);
+	dev->liveupdate.outgoing = dev_ser;
+	return dev_ser;
+}
+
+/*
+ * Stop preserving @dev by releasing its struct pci_dev_ser. The caller must
+ * have dropped the last reference on it.
+ */
+static void pci_liveupdate_free_dev_ser(struct pci_flb_outgoing *outgoing,
+					struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
+
+	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
+	outgoing->ser->nr_devices--;
+	memset(dev_ser, 0, sizeof(*dev_ser));
+	dev->liveupdate.outgoing = NULL;
+}
+
 static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
 					    struct pci_dev *dev)
 {
@@ -521,10 +559,7 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
 	if (--dev_ser->refcount)
 		return 0;
 
-	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
-	outgoing->ser->nr_devices--;
-	memset(dev_ser, 0, sizeof(*dev_ser));
-	dev->liveupdate.outgoing = NULL;
+	pci_liveupdate_free_dev_ser(outgoing, dev);
 	return 0;
 }
 
@@ -544,6 +579,8 @@ static void pci_liveupdate_unpreserve_path(struct pci_flb_outgoing *outgoing,
 static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 					  struct pci_dev *dev)
 {
+	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
+
 	if (dev->is_virtfn) {
 		pci_warn(dev, "Cannot preserve Virtual Functions\n");
 		return -EINVAL;
@@ -559,43 +596,32 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 		return -EINVAL;
 	}
 
-	/*
-	 * Endpoint devices should not be preserved more than once.
-	 * Bridges are preserved once for every downstream device that
-	 * is preserved.
-	 */
-	if (dev->liveupdate.outgoing && !dev->subordinate) {
-		pci_warn(dev, "Device is already preserved\n");
-		return -EBUSY;
-	}
-
-	if (dev->liveupdate.outgoing && !dev->liveupdate.outgoing->refcount) {
-		pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
-		return -EINVAL;
-	}
-
 	if (dev->liveupdate.frozen) {
 		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
 		return -EINVAL;
 	}
 
-	if (!dev->liveupdate.outgoing) {
-		struct pci_dev_ser *dev_ser;
+	if (dev_ser) {
+		/*
+		 * Endpoint devices can only be preserved once. Bridges are
+		 * preserved once for every preserved device below them.
+		 */
+		if (!dev->subordinate) {
+			pci_warn(dev, "Device is already preserved\n");
+			return -EBUSY;
+		}
 
-		dev_ser = pci_flb_alloc_dev_ser(outgoing);
+		if (!dev_ser->refcount) {
+			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
+			return -EINVAL;
+		}
+	} else {
+		dev_ser = pci_liveupdate_alloc_dev_ser(outgoing, dev);
 		if (IS_ERR(dev_ser))
 			return PTR_ERR(dev_ser);
-
-		pci_info(dev, "Device will be preserved across next Live Update\n");
-		outgoing->ser->nr_devices++;
-		outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
-
-		dev_ser->domain = pci_domain_nr(dev->bus);
-		dev_ser->bdf = pci_dev_id(dev);
-		dev->liveupdate.outgoing = dev_ser;
 	}
 
-	dev->liveupdate.outgoing->refcount++;
+	dev_ser->refcount++;
 	return 0;
 }
 

base-commit: 7e966191f7a235c2f29d5450090b3bd9106c5f99
-- 
2.56.0.506.g506a7eabc5-goog

