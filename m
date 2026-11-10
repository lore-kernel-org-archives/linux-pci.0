Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286946;
	b=oMMd+EJubtO+ScWbXWlO76T/L1b1LO7w4YJvBn1Zkrzwucx/gn+KgMB2hI4BEtIDAWaS
	 gcL6+1CGuLd1NQksbK1nAc4nFBT4d34kn3vdQl1poUwiiazKC5xTxYoZXo26QdZ21ukN8
	 UY09sHP8a8E9E+jiXboBScKrAJl/fZkrhHrqXf+K/NS+IzqUpVmRoGhITQ5mWPZV56YBr
	 sG0AAbm9SKPY7MUQ8Z6GAq7atCiULjmfIPg6EbWZ+HrDew5oKyVaP21r15uCog5Lh/MpH
	 d1JZ4IV8uZZnjDZoB2CrFhn3O3UwG9HnDINytTP+A4I0id8oHWEBXKPI9VdCGo1h7Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=CgBCpjKfzBqNZpJUjcpaoZF5kynIHAd0/p/NXGzkOjc=;
	b=TmQqb+5Et2+EYRRMF4J4OHGkYdX1AofdbWwPAZ7Burj1odVpxNNARhILZC1CJj25uV2e
	 Hn2NFFDz+Vc9cRYZX7yppnG8e6eW2Yc6ovza6wfCbp4J5mf4iOUoNre+PYH2S9Yx1oSCN
	 360+EOLLvnGc4uXZ3wGurlP5KFzIeQNALiJLdqA7VLYpF6swOtOc62c5/6GgwbDS3xQSk
	 f1lkf8yg+OZW0gAPUVKQPDc0ydf6VSH4GmHEUIAdE/aArsaN7/s5y1TgCgJTkKtBKhZdG
	 sKAX2kN6oX9U6b6/N10RiEIfHsSshd3XuzReMn5CKvJylUcoOYc3mhSGp3kUnC5sFiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="lNZ/Bmo1";
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD23F606E494
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 05:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD23F606E494
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lNZ/Bmo1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b59665acd6so1151851a12.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 21:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286944; x=1794891744; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgBCpjKfzBqNZpJUjcpaoZF5kynIHAd0/p/NXGzkOjc=;
        b=lNZ/Bmo1B5y2EaXYYAVuaMVIjPQaf0oOdvrpwSasoz6u5vTy/z+s4fr8W3wcvM74hV
         PaIpbKX0Zy0GO/WpCVuxnl6CIkmyb2Z7JhqF88PI/zT6il+h64sSv3oldqJe8UbM7SLD
         h/O1D4qaSAzV9xwZ7wV/yEo47kj6LKtxAVWAc+Urh4R2csyjH+d6FrgmNKsXCn+a8cFf
         hzAO3YKZH2J6mNoE4D57WnD5hoSVzTNT+Y+CyRAYNjmHITTcLWAEmST8KJwRNqm9SkeJ
         cw01d/rm0O7ajm0OSMfPpPXT0+uHLzEX7H+Vq3OznKrXqgMRG7XhDUID7zQIe5xPufj4
         mAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286944; x=1794891744;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CgBCpjKfzBqNZpJUjcpaoZF5kynIHAd0/p/NXGzkOjc=;
        b=sbgXLSDCIMwNmAvU2xs0lPXavLTq6Hl4m4Ec+byfDEqpMFANori06NNhKmfKuimPiU
         bugTCR7HCUy2bQ/O1AQ2SEbna0eIYBZabonpW0wbU/p1WCV2R6Y4sRsk+dJd1hGK53ZV
         O7RSxfZhjE/Buslt4GsiSBxirkHqJBTyWN+cqgE9E3o/Xy1JvXtjyedOlXRAMlx2eilf
         6R5R3W73Uvrvfy2RGM+sBZjMMK8aivc7mw5I2WKU7b5QmZOVH9xFI1H85mEaLRKygkCy
         /oRLhLl3Hb/jiXG7Zcdgblh81Fc/wIj1in+xWzDV66It70RhtfKUUJSnDQchECThvqEC
         Xflg==
X-Forwarded-Encrypted: i=1; AL+hErEmyRENFhOBR2cAhLbHBmyjVfh6eioYMBcCzZNSAQz/4W98SRQ86aDO5OH0FnRIct2SGOKw3nSkw3I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wjE8l873z6hYQnN5XbLrWKxWDJ6OqiQ79y8N1nKyEr65HJXsO
	WPOBzEJO4D94Dx+MRqs8mkZ85y+DRybaEo02FGpViL/7nT7kuVQYmIOV/qhOXsq7YW5QJ6umcV7
	7rAuJ811ufX2Y0588SQ==
X-Received: from edtj4.prod.google.com ([2002:aa7:ca44:0:b0:6b7:3b3e:5148])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d496:0:b0:6ac:934e:a9ca with SMTP id 4fb4d7f45d1cf-6b755626f5fmr907953a12.0.1794286944079;
 Mon, 09 Nov 2026 21:02:24 -0800 (PST)
Date: Tue, 10 Nov 2026 05:02:00 +0000
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
Message-ID: <20261110050202.529473-18-tarunsahu@google.com>
Subject: [PATCH v4 17/19] mm: memfd_luo: Add feature header to struct memfd_luo_ser
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

Precede struct memfd_luo_ser with struct kho_ser_hdr using
DECLARE_KHO_SER. Later memfd features can be appended under new
feature indices without breaking compatibility between adjacent kernels.

Allocate both the memfd_luo_ser feature header and the kho_vmalloc
feature header in the same preserved folio. On restore and retrieve,
validate incoming required features before accessing payload fields.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/memfd.h |  7 ++--
 mm/memfd_luo.c                | 67 ++++++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index b0597c438973..27f8880ee593 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -83,6 +83,8 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  * @nr_folios:   Number of folios in the folios array.
  * @folios_fhdr: Pointer to KHO vmalloc descriptor for the array of
  *               struct memfd_luo_folio_ser.
+ *
+ * Preceded by &struct kho_ser_hdr.
  */
 struct memfd_luo_ser {
 	u64 pos;
@@ -93,9 +95,8 @@ struct memfd_luo_ser {
 	DECLARE_KHOSER_PTR(folios_fhdr, DECLARE_KHO_SER_HDR(kho_vmalloc, *));
 };
 
-static_assert(sizeof(struct memfd_luo_ser) == 40);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct memfd_luo_ser) == 8);
+/* Register memfd_luo_ser with KHO serialization accessors */
+DECLARE_KHO_SER(memfd_luo_ser, 40, 0, 0);
 
 /* The compatibility string for memfd file handler */
 #define MEMFD_LUO_FH_COMPATIBLE	"memfd-v3"
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 74c1ff5877c3..94510f73a606 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -256,16 +256,21 @@ static void memfd_luo_unpreserve_folios(DECLARE_KHO_SER_HDR(kho_vmalloc, *folios
 
 static size_t memfd_luo_ser_size(void)
 {
-	return sizeof(struct memfd_luo_ser) + kho_ser_size(kho_vmalloc);
+	return kho_ser_size(memfd_luo_ser) + kho_ser_size(kho_vmalloc);
 }
 
-static struct memfd_luo_ser *memfd_luo_ser_init(void *mem)
+static struct memfd_luo_ser *
+memfd_luo_ser_init(DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr))
 {
 	DECLARE_KHO_SER_HDR(kho_vmalloc, *folios_fhdr);
-	struct memfd_luo_ser *ser = mem;
+	struct memfd_luo_ser *ser;
+
+	kho_ser_init(fhdr, memfd_luo_ser);
+	folios_fhdr = (void *)fhdr + kho_ser_size(memfd_luo_ser);
 
-	folios_fhdr = mem + sizeof(struct memfd_luo_ser);
+	ser = kho_ser_payload(fhdr, memfd_luo_ser);
 	KHOSER_STORE_PTR(ser->folios_fhdr, folios_fhdr);
+
 	return ser;
 }
 
@@ -273,6 +278,7 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
 	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 	int err = 0, seals;
 	u64 inode_size;
@@ -304,12 +310,12 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	}
 
 	/* Allocate the main serialization structure in preserved memory */
-	ser = kho_alloc_preserve(memfd_luo_ser_size());
-	if (IS_ERR(ser)) {
-		err = PTR_ERR(ser);
+	fhdr = kho_alloc_preserve(memfd_luo_ser_size());
+	if (IS_ERR(fhdr)) {
+		err = PTR_ERR(fhdr);
 		goto err_unlock;
 	}
-	ser = memfd_luo_ser_init(ser);
+	ser = memfd_luo_ser_init(fhdr);
 
 	ser->pos = args->file->f_pos;
 	ser->size = inode_size;
@@ -323,12 +329,12 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	inode_unlock(inode);
 
 	args->private_data = folios_ser;
-	args->serialized_data = virt_to_phys(ser);
+	args->serialized_data = virt_to_phys(fhdr);
 
 	return 0;
 
 err_free_ser:
-	kho_unpreserve_free(ser);
+	kho_unpreserve_free(fhdr);
 err_unlock:
 	shmem_freeze(inode, false);
 	inode_unlock(inode);
@@ -337,12 +343,14 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 
 static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
 {
+	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 
 	if (WARN_ON_ONCE(!args->serialized_data))
 		return -EINVAL;
 
-	ser = phys_to_virt(args->serialized_data);
+	fhdr = phys_to_virt(args->serialized_data);
+	ser = kho_ser_payload(fhdr, memfd_luo_ser);
 
 	/*
 	 * The pos might have changed since prepare. Everything else stays the
@@ -356,6 +364,7 @@ static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
 static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
+	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 
 	if (WARN_ON_ONCE(!args->serialized_data))
@@ -364,13 +373,14 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 	inode_lock(inode);
 	shmem_freeze(inode, false);
 
-	ser = phys_to_virt(args->serialized_data);
+	fhdr = phys_to_virt(args->serialized_data);
+	ser = kho_ser_payload(fhdr, memfd_luo_ser);
 
 	memfd_luo_unpreserve_folios(KHOSER_LOAD_PTR(ser->folios_fhdr),
 				    args->private_data,
 				    ser->nr_folios);
 
-	kho_unpreserve_free(ser);
+	kho_unpreserve_free(fhdr);
 	inode_unlock(inode);
 }
 
@@ -402,6 +412,7 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
 static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 {
 	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 
 	/*
@@ -412,10 +423,16 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	if (args->retrieve_status)
 		return;
 
-	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
+	if (WARN_ON_ONCE(!args->serialized_data))
 		return;
 
+	fhdr = phys_to_virt(args->serialized_data);
+	if (kho_ser_validate(fhdr, memfd_luo_ser)) {
+		pr_warn("invalid feature header, folios not discarded\n");
+		goto out;
+	}
+
+	ser = kho_ser_payload(fhdr, memfd_luo_ser);
 	if (ser->nr_folios) {
 		folios_ser = kho_restore_vmalloc(KHOSER_LOAD_PTR(ser->folios_fhdr));
 		if (!folios_ser)
@@ -426,7 +443,7 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	}
 
 out:
-	kho_restore_free(ser);
+	kho_restore_free(fhdr);
 }
 
 static int memfd_luo_retrieve_folios(struct file *file,
@@ -533,14 +550,24 @@ static int memfd_luo_retrieve_folios(struct file *file,
 static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 {
 	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 	struct file *file;
 	int err;
 
-	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
+	if (WARN_ON_ONCE(!args->serialized_data))
 		return -EINVAL;
 
+	fhdr = phys_to_virt(args->serialized_data);
+	err = kho_ser_validate(fhdr, memfd_luo_ser);
+	if (err) {
+		pr_err("memfd_luo_ser feature validation failed: %pe\n",
+		       ERR_PTR(err));
+		goto free_ser;
+	}
+
+	ser = kho_ser_payload(fhdr, memfd_luo_ser);
+
 	/* Make sure the file only has seals supported by this version. */
 	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
 		err = -EOPNOTSUPP;
@@ -581,14 +608,14 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	}
 
 	args->file = file;
-	kho_restore_free(ser);
+	kho_restore_free(fhdr);
 
 	return 0;
 
 put_file:
 	fput(file);
 free_ser:
-	kho_restore_free(ser);
+	kho_restore_free(fhdr);
 	return err;
 }
 
-- 
2.56.0.506.g506a7eabc5-goog

