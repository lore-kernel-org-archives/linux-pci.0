Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286941;
	b=STlsJYeBZ62DAD2T48s3laemSRB7o0OKnrYpvbuzFcRlYVhUpG22zkrpMGvoo2dVpCrd
	 zeEwzZq1KZR8OzS3LlF3hfDK1Vsssip2XCOG1sWfwrhQ8C2xpWTBPEXeRfEmdw62hCrtE
	 7j7Kzp+uhgv68fvGIVwD1rfzq+v1f8HH1nZro81Sa90mDLZcHu1IBffwj2sxRctChiEV+
	 TYYn2HDqs8YZQZtBATsOOJppYLd8/N52Z+mi6aszVNLoMTUDDBNn0Rtl7rtUzaSAeqgGe
	 4SL9ihx1H2jGCAEUiLt3zXNnUJCTbH/jixQoBl66ASCvhj6M2h06z/mANgvDh+OO2xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hqbeun0C1/XgWjYnTEG1QqOg75mMAInimMPRhrMj/I8=;
	b=L7MtgRbQLh7EuOdoMb13bKXWGQBirWokXLBhT3sIZf4bEdBdh3NSGdMgK3kwvFrhzCuZ
	 VxZjX2LTn4akPrbi6h3hdg8yUB4RoLqpvMF6guZ0yzvp+XwEIujyHrw251XOH/L/LIIX9
	 dk9ylOKolkdfpeNMZCbrGKS2SM2hP2WHCLKA9R6250YS9hl25wc19MTfJNR9cXM/3/eKR
	 5mfNB2HUK7KRMwZ/89C1Snxc9hkkTKLfw0k5cMbp6z4nwmB7vSrvCPxOYkWQskEspiX2d
	 qvPN32ffLgM7eMDfNdfMHV5irJOqBy+wBiZvy9PBEtge8YpuF1spz19Bqfx4Hn0MiHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dkXkrqwE;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8460A261B
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 05:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EE8460A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dkXkrqwE
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c49df8fe86eso118463266b.2
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 21:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286940; x=1794891740; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hqbeun0C1/XgWjYnTEG1QqOg75mMAInimMPRhrMj/I8=;
        b=dkXkrqwEGNEDtfAJrBWu9i+56LtaxxhGwkb9g1/jwQEf/fxYtpkn3fbxvgYGkrkwkU
         CeYwrcybh/KpQIpSNgBX2H625aG+ztkGYiGlOqvFI28+Fco7oggacZmuZkGx0VsmKzm8
         ylDjZJFS8JvZxO7Uz54jYPuKANhX+QU/gO3NWiHYij8wLM+zGJJAqeXI38mS4R/QLdaf
         EjShecLrks8cWfdhup4973WJG2mvGpBHycAJWz0WM8YOLjAu00ttLKfxhznSrGUO66lr
         jLktiZ7Y9LuUURVD9vtr7HFu0MjZYiXjsJl1EyLcKIyKd0zET84ZHuXK9ndP9wBwxHn8
         hyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286940; x=1794891740;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hqbeun0C1/XgWjYnTEG1QqOg75mMAInimMPRhrMj/I8=;
        b=aqlE8WeukZQPITNOqfnX8VfCUKRoEsqotYdnLK1gCrueMd+OO0K9dZ1PzEbAdSKvwY
         xNCYBhcbZpPe+GpBSVXQYhS+8dpFPnD+oSI6r2tb9aJ1ICJFOBVCTJbWSg7O0gATGUKN
         NL15flZNJ3qqF2EbY2aFpwQYeYLEX4U7ECJGm1iKWeoa7VPLSZ5dtQogIa964CYwobOV
         QqHslgVGm2lbb0lIpaR81BBtT4yyLCY0WFosFME+tLWj22svRfaJ3jQorLbAM3wuzZSp
         nCFnkGIVOFQ1uUsy/4Kw0IOF8+srcsiy6IHSXSD6p9SeFCf3Fm0QnjXrjPfKuVKQnJCc
         sGqw==
X-Forwarded-Encrypted: i=1; AL+hErHbFMgXXlFXPaugQPllaY+dhmR+L1dU6LNZK+zA6qV23dW0r+lpZmieULTbixqgTMuPOgAciszSqdQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wWDmDSqJzWzaMh7HIWsAQpOQ7gEwlFUMc6zdiSdgPwB/W4gx9
	6tqIE+D10eAnCo/TPTqUFWp/OJvC/dd7zgSGmC/s01nDT8Yxu0b393xg7clVpqawDQhdTdOTAFl
	7mzq+Ps2oJrUtME4uWQ==
X-Received: from ejqs13.prod.google.com ([2002:a17:906:454d:b0:c3f:2fd1:c5c])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d0d:b0:c41:e0c0:e6b7 with SMTP id a640c23a62f3a-c504951cddfmr104842866b.12.1794286939400;
 Mon, 09 Nov 2026 21:02:19 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:56 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-14-tarunsahu@google.com>
Subject: [PATCH v4 13/19] liveupdate: Add feature header to struct luo_flb_header_ser
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

Precede struct luo_flb_header_ser with struct kho_ser_hdr via
DECLARE_KHO_SER so future File-Lifecycle-Bound (FLB) header features can
append fields to struct luo_flb_header_ser without breaking compatibility
between adjacent kernels.

Initialize the header in luo_flb_setup_outgoing() and place the outgoing
entry array immediately after kho_ser_size(luo_flb_header_ser). On the
incoming path in luo_flb_setup_incoming(), validate the feature header
with kho_ser_validate() and locate the incoming entry array at
fhdr->size so entries remain properly aligned even if the source kernel
serialized a different header layout.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h      |  6 ++----
 kernel/liveupdate/luo_core.c     |  4 +---
 kernel/liveupdate/luo_flb.c      | 36 +++++++++++++++++++++-----------
 kernel/liveupdate/luo_internal.h |  2 +-
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 38b4658183a2..4913707ba0d3 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -157,16 +157,14 @@ DECLARE_KHO_SER(luo_session_ser, 72, 0, 0);
  * This structure is located at the physical address specified by the
  * flbs_pa in luo_ser.
  *
- * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
+ * Preceded by &struct kho_ser_hdr.
  */
 struct luo_flb_header_ser {
 	u64 pgcnt;
 	u64 count;
 };
 
-static_assert(sizeof(struct luo_flb_header_ser) == 16);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct luo_flb_header_ser) == 8);
+DECLARE_KHO_SER(luo_flb_header_ser, 16, 0, 0);
 
 /**
  * struct luo_flb_ser - Represents the serialized state of a single FLB object.
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index d0f72f27001d..79bb5f64bfac 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -131,9 +131,7 @@ static int __init luo_early_startup(void)
 	if (err)
 		goto out_free_ser;
 
-	luo_flb_setup_incoming(luo_ser->flbs_pa);
-
-	err = 0;
+	err = luo_flb_setup_incoming(luo_ser->flbs_pa);
 
 out_free_ser:
 	kho_restore_free(fhdr);
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index cd715a7c1d99..a8dcdb8456fd 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -53,7 +53,7 @@
 
 #define LUO_FLB_PGCNT		1ul
 #define LUO_FLB_MAX		(((LUO_FLB_PGCNT << PAGE_SHIFT) -	\
-		sizeof(struct luo_flb_header_ser)) / sizeof(struct luo_flb_ser))
+		kho_ser_size(luo_flb_header_ser)) / sizeof(struct luo_flb_ser))
 
 struct luo_flb_header {
 	struct luo_flb_header_ser *header_ser;
@@ -559,33 +559,45 @@ int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp)
 
 int __init luo_flb_setup_outgoing(u64 *flbs_pa)
 {
+	DECLARE_KHO_SER_HDR(luo_flb_header_ser, *fhdr);
 	struct luo_flb_header_ser *header_ser;
 
-	header_ser = kho_alloc_preserve(LUO_FLB_PGCNT << PAGE_SHIFT);
-	if (IS_ERR(header_ser))
-		return PTR_ERR(header_ser);
+	fhdr = kho_alloc_preserve(LUO_FLB_PGCNT << PAGE_SHIFT);
+	if (IS_ERR(fhdr))
+		return PTR_ERR(fhdr);
 
-	*flbs_pa = virt_to_phys(header_ser);
+	kho_ser_init(fhdr, luo_flb_header_ser);
+	header_ser = kho_ser_payload(fhdr, luo_flb_header_ser);
+
+	*flbs_pa = virt_to_phys(fhdr);
 
 	header_ser->pgcnt = LUO_FLB_PGCNT;
 	luo_flb_global.outgoing.header_ser = header_ser;
-	luo_flb_global.outgoing.ser = (void *)(header_ser + 1);
+	luo_flb_global.outgoing.ser = (void *)fhdr + kho_ser_size(luo_flb_header_ser);
 	luo_flb_global.outgoing.active = true;
 
 	return 0;
 }
 
-void __init luo_flb_setup_incoming(u64 flbs_pa)
+int __init luo_flb_setup_incoming(u64 flbs_pa)
 {
-	struct luo_flb_header_ser *header_ser;
+	DECLARE_KHO_SER_HDR(luo_flb_header_ser, *fhdr);
+	int err;
 
 	if (!flbs_pa)
-		return;
+		return 0;
 
-	header_ser = phys_to_virt(flbs_pa);
-	luo_flb_global.incoming.header_ser = header_ser;
-	luo_flb_global.incoming.ser = (void *)(header_ser + 1);
+	fhdr = phys_to_virt(flbs_pa);
+	err = kho_ser_validate(fhdr, luo_flb_header_ser);
+	if (err)
+		return err;
+
+	luo_flb_global.incoming.header_ser =
+		kho_ser_payload(fhdr, luo_flb_header_ser);
+	luo_flb_global.incoming.ser = (void *)fhdr + fhdr->size;
 	luo_flb_global.incoming.active = true;
+
+	return 0;
 }
 
 /**
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index e22a8cf39d91..df8306d73768 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -121,7 +121,7 @@ void luo_flb_file_unpreserve(struct liveupdate_file_handler *fh);
 void luo_flb_file_finish(struct liveupdate_file_handler *fh);
 void luo_flb_unregister_all(struct liveupdate_file_handler *fh);
 int __init luo_flb_setup_outgoing(u64 *flbs_pa);
-void __init luo_flb_setup_incoming(u64 flbs_pa);
+int __init luo_flb_setup_incoming(u64 flbs_pa);
 void luo_flb_serialize(void);
 
 #ifdef CONFIG_LIVEUPDATE_TEST
-- 
2.56.0.506.g506a7eabc5-goog

