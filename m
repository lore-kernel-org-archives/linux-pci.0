Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286935;
	b=ug2euqbwWf5WfOMWRbV38T26kC3nu6BbzvWMbph4KLa27xI5A3FmRkGFQngOGWYjyYia
	 RdH2InsL3Nm7xEv7FLqbYbqX+8cc+++0z0s+1t0Qjijt2id/vKjlDvNrsmjBZatHNfPK9
	 ZhqaICgTLOwNeMt8xXPEtlxyRnpGl9DCfJppXzXLoMCswblJz1Iv62OrygjjvCjFS8o+U
	 TQuC/X7eg7OZtetagoWJX6T5xjKtgsWvczvF5Kkec5+6kSjrM861bHcLW6zTR9LxTP1Dl
	 3ZYZ/S8XwIqY8W8cC/x+qLpZPrCpLvXeugyw1m5g/HmlJ7r9yCQedkmfRCBAl9zWwbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Ebeh5Rs4TXuXQtxviE5PkM1eDaH/25gqcmQnH1h2ass=;
	b=omeyfRBIhPN9PE/qGPhLWq3GjIfdPj/FdIKAzMuB46+7MysT9hfV5cK9EcrAXEPjltUM
	 YfbkmwPuegl8qgF3beh8O30ic8zffxNVXInA13+4KvzBHFTFaOPPFfzX/DaGTbJiGPz7i
	 LJruRnVBB8fAlmp+mGIfXQm7r9Sn89AXS5Zol0elltPavJyzj+OihCvcHbg8byTdmVErD
	 69l2adkj21ayOxzuf+w8gEsRY7gA5ZsQqNX8rjN+uXATfPZ+BI4ZHOCMhhQFRfSQap/nv
	 OWtT8rAxscWqglZC1FjLVJMzkB1a0MEiFcXyPp7AV8FO4fQADKlmi/jvzC9sjEDgqrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IcbFzfkI;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27CF60A6F6A
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 05:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E27CF60A6F6A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IcbFzfkI
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b42827bb4bso1152442a12.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 21:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286933; x=1794891733; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ebeh5Rs4TXuXQtxviE5PkM1eDaH/25gqcmQnH1h2ass=;
        b=IcbFzfkIKOkiLLAWR+0fDMZZLuPlqNDwIueVIN2BJPKczISY1eixPOh4kFx2/U1uPk
         V6X1NdMXm70UTmtKEHjQ0ALW8YjmnjIm/N+gplzBkCJz1MhlT1AjchQglREfiIZwQkgy
         /rL+KS1i6/L5UoORZtOvJClZtrBUJZA4Rv3ApIpHKiElhXD11aNMR1OIWS27dMXOqsvL
         dVVmhuwrmYH4iXF52JgVyXDgAiWy+ALOJu+ZPPbkPuhh8Fffwz6pOOMBK0x30u7WHduC
         pUu1k3mOdqqJxF8KcTWk+W5qAn19uPjP2i11cfepDsuiP2suN4BV1coS3FMBKIINZNOf
         9JCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286933; x=1794891733;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ebeh5Rs4TXuXQtxviE5PkM1eDaH/25gqcmQnH1h2ass=;
        b=kuOACFPLCD4j5pn5zflCELt/qj5KMELvlS+f+c+q5SacSVwIQXP7Ottw/5WEGLEb4j
         rFV2DGeeCajuK8oszXD3oweAsiUNoKl3cQM/lwoUUBVQfOUXdNYKAJtMnHHEbzFZebfS
         fkwq3jhRB7iKrX/WDkCys20hFkvQuYYiPoVizKH8zUmb2zqHQLlEWnJDKK+SxRTzNbsD
         zhUM6UDFtaLNMIaVGYqAdq5P/cz/O4C9UXH4RuHT3aiZKmISPZG8rt8X06Q9pRf5COkJ
         8ueGRJn0QU+jTdW6KT72y1IuHd0tDNHeA1AXL27xyYXvb8YMv9LevzBPHF0q6DiEoVdC
         iekw==
X-Forwarded-Encrypted: i=1; AL+hErH2MGVHduHrov2KYFo0uPGRY0ryogytyw1mFkbwP2NnAf1NVzk/uuaU+TClcC73EQVAot138ilt6fI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VWDMDGTMx3cEoBdcDeAv7SCL+GaplgB00uMQOzmZgRbt8QPV2
	ftTBACGYT/a9hmEw+04IzCE3/UOxvYqP4ZAdBO3uGvKSIyaeSMFFEx//FwJ+86uhnhxDT+Wjg9j
	YeeGPBzuPykFBHygrUg==
X-Received: from edsa5.prod.google.com ([2002:aa7:d745:0:b0:6af:ab34:1a21])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:43cb:b0:6b7:1bb8:5a5 with SMTP id 4fb4d7f45d1cf-6b756ad506dmr1143844a12.19.1794286933123;
 Mon, 09 Nov 2026 21:02:13 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:50 +0000
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
Message-ID: <20261110050202.529473-8-tarunsahu@google.com>
Subject: [PATCH v4 07/19] kho: vmalloc: Add the feature header
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

Register struct kho_vmalloc with the KHO serialization feature header
mechanism to allow future additive fields or feature extensions without
breaking live update ABI compatibility.

Add DECLARE_KHO_SER(kho_vmalloc, 16, 0, 0) to register the 16-byte
structure with 0 required and 0 optional features. Update function
prototypes in include/linux/kexec_handover.h to take
DECLARE_KHO_SER_HDR(kho_vmalloc, *fhdr) parameters, documenting which
registered structure the feature header belongs to while enforcing
compile-time type verification.

In kho_preserve_vmalloc(), initialize the feature header with
kho_ser_init() and access the payload fields via kho_ser_payload().
In kho_restore_vmalloc(), validate incoming required features with
kho_ser_validate() and access payload fields via kho_ser_payload().
In kho_unpreserve_vmalloc(), access payload fields via kho_ser_payload().
The chunk page format and traversal remain unchanged.

Update memfd_luo and test_kho to pass typed feature header pointers
and use kho_ser_size() for allocation sizing.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kexec_handover.h         | 15 +++----
 include/linux/kho/abi/kexec_handover.h |  5 +--
 include/linux/kho/abi/memfd.h          |  8 ++--
 kernel/liveupdate/kexec_handover.c     | 60 ++++++++++++++++++--------
 lib/test_kho.c                         | 35 +++++++--------
 mm/memfd_luo.c                         | 21 ++++-----
 6 files changed, 83 insertions(+), 61 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index ef2b188c8ed0..b52e7a5173f8 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -6,10 +6,9 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/mm.h>
+#include <linux/kho/abi/kexec_handover.h>
 #include <asm-generic/kexec_handover.h>
 
-struct kho_vmalloc;
-
 struct folio;
 struct page;
 
@@ -21,14 +20,14 @@ int kho_preserve_folio(struct folio *folio);
 void kho_unpreserve_folio(struct folio *folio);
 int kho_preserve_pages(struct page *page, unsigned long nr_pages);
 void kho_unpreserve_pages(struct page *page, unsigned long nr_pages);
-int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
-void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
+int kho_preserve_vmalloc(void *ptr, DECLARE_KHO_SER_HDR(kho_vmalloc, *fhdr));
+void kho_unpreserve_vmalloc(DECLARE_KHO_SER_HDR(kho_vmalloc, *fhdr));
 void *kho_alloc_preserve(size_t size);
 void kho_unpreserve_free(void *mem);
 void kho_restore_free(void *mem);
 struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
-void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
+void *kho_restore_vmalloc(const DECLARE_KHO_SER_HDR(kho_vmalloc, *fhdr));
 int kho_add_subtree(const char *name, void *blob, size_t size);
 void kho_remove_subtree(void *blob);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size);
@@ -74,12 +73,12 @@ static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 static inline void kho_unpreserve_pages(struct page *page, unsigned int nr_pages) { }
 
 static inline int kho_preserve_vmalloc(void *ptr,
-				       struct kho_vmalloc *preservation)
+				       DECLARE_KHO_SER_HDR(kho_vmalloc, *fhdr))
 {
 	return -EOPNOTSUPP;
 }
 
-static inline void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation) { }
+static inline void kho_unpreserve_vmalloc(DECLARE_KHO_SER_HDR(kho_vmalloc, *fhdr)) { }
 
 static inline void *kho_alloc_preserve(size_t size)
 {
@@ -100,7 +99,7 @@ static inline struct page *kho_restore_pages(phys_addr_t phys,
 	return NULL;
 }
 
-static inline void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
+static inline void *kho_restore_vmalloc(const DECLARE_KHO_SER_HDR(kho_vmalloc, *fhdr))
 {
 	return NULL;
 }
diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index bee75a7006e8..f9b9b18f5820 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -13,6 +13,7 @@
 #include <linux/bits.h>
 #include <linux/build_bug.h>
 #include <linux/kconfig.h>
+#include <linux/kho/abi/feature.h>
 #include <linux/log2.h>
 #include <linux/math.h>
 #include <linux/types.h>
@@ -179,9 +180,7 @@ struct kho_vmalloc {
 	unsigned short order;
 };
 
-static_assert(sizeof(struct kho_vmalloc) == 16);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct kho_vmalloc) == 8);
+DECLARE_KHO_SER(kho_vmalloc, 16, 0, 0);
 
 /**
  * DOC: KHO persistent memory tracker
diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 7b49dd6d7e2a..b0597c438973 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -80,9 +80,9 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  * @seals:     The seals present on the memfd. The seals are uABI so it is safe
  *             to directly use them in the ABI.
  * @flags:     Flags for the file. Unused flag bits must be set to 0.
- * @nr_folios: Number of folios in the folios array.
- * @folios:    Pointer to KHO vmalloc descriptor for the array of
- *             struct memfd_luo_folio_ser.
+ * @nr_folios:   Number of folios in the folios array.
+ * @folios_fhdr: Pointer to KHO vmalloc descriptor for the array of
+ *               struct memfd_luo_folio_ser.
  */
 struct memfd_luo_ser {
 	u64 pos;
@@ -90,7 +90,7 @@ struct memfd_luo_ser {
 	u32 seals;
 	u32 flags;
 	u64 nr_folios;
-	DECLARE_KHOSER_PTR(folios, struct kho_vmalloc *);
+	DECLARE_KHOSER_PTR(folios_fhdr, DECLARE_KHO_SER_HDR(kho_vmalloc, *));
 };
 
 static_assert(sizeof(struct memfd_luo_ser) == 40);
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 641a3b4c88fb..6e428df717cc 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1378,20 +1378,20 @@ static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk,
 /**
  * kho_preserve_vmalloc - preserve memory allocated with vmalloc() across kexec
  * @ptr: pointer to the area in vmalloc address space
- * @preservation: placeholder for preservation metadata
+ * @fhdr:         placeholder for preservation metadata
  *
  * Instructs KHO to preserve the area in vmalloc address space at @ptr. The
  * physical pages mapped at @ptr will be preserved and on successful return
- * @preservation will hold the physical address of a structure that describes
- * the preservation.
+ * @fhdr will hold the preservation metadata.
  *
  * NOTE: The memory allocated with vmalloc_node() variants cannot be reliably
  * restored on the same node
  *
  * Return: 0 on success, error code on failure
  */
-int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
+int kho_preserve_vmalloc(void *ptr, DECLARE_KHO_SER_HDR(kho_vmalloc, *fhdr))
 {
+	struct kho_vmalloc *vmalloc_ser;
 	struct kho_vmalloc_chunk *chunk;
 	struct vm_struct *vm = find_vm_area(ptr);
 	unsigned int order, flags, nr_contig_pages;
@@ -1404,13 +1404,18 @@ int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
 	if (vm->flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
 		return -EOPNOTSUPP;
 
+	kho_ser_init(fhdr, kho_vmalloc);
+
+	vmalloc_ser = kho_ser_payload(fhdr, kho_vmalloc);
+
 	flags = vmalloc_flags_to_kho(vm->flags);
 	order = get_vm_area_page_order(vm);
+	vmalloc_ser->order = order;
 
 	chunk = new_vmalloc_chunk(NULL);
 	if (!chunk)
 		return -ENOMEM;
-	KHOSER_STORE_PTR(preservation->first, chunk);
+	KHOSER_STORE_PTR(vmalloc_ser->first, chunk);
 
 	nr_contig_pages = (1 << order);
 	for (int i = 0; i < vm->nr_pages; i += nr_contig_pages) {
@@ -1431,33 +1436,39 @@ int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
 		}
 	}
 
-	preservation->total_pages = vm->nr_pages;
-	preservation->flags = flags;
-	preservation->order = order;
+	vmalloc_ser->total_pages = vm->nr_pages;
+	vmalloc_ser->flags = flags;
 
 	return 0;
 
 err_free:
-	kho_unpreserve_vmalloc(preservation);
+	kho_unpreserve_vmalloc(fhdr);
 	return err;
 }
 EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
 
 /**
  * kho_unpreserve_vmalloc - unpreserve memory allocated with vmalloc()
- * @preservation: preservation metadata returned by kho_preserve_vmalloc()
+ * @fhdr:         preservation metadata returned by kho_preserve_vmalloc()
  *
  * Instructs KHO to unpreserve the area in vmalloc address space that was
  * previously preserved with kho_preserve_vmalloc().
  */
-void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
+void kho_unpreserve_vmalloc(DECLARE_KHO_SER_HDR(kho_vmalloc, *fhdr))
 {
-	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(preservation->first);
+	struct kho_vmalloc *vmalloc_ser;
+	struct kho_vmalloc_chunk *chunk;
+
+	if (!fhdr)
+		return;
+
+	vmalloc_ser = kho_ser_payload(fhdr, kho_vmalloc);
+	chunk = KHOSER_LOAD_PTR(vmalloc_ser->first);
 
 	while (chunk) {
 		struct kho_vmalloc_chunk *tmp = chunk;
 
-		kho_vmalloc_unpreserve_chunk(chunk, preservation->order);
+		kho_vmalloc_unpreserve_chunk(chunk, vmalloc_ser->order);
 
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
 		free_page((unsigned long)tmp);
@@ -1468,16 +1479,17 @@ EXPORT_SYMBOL_GPL(kho_unpreserve_vmalloc);
 /**
  * kho_restore_vmalloc - recreates and populates an area in vmalloc address
  * space from the preserved memory.
- * @preservation: preservation metadata.
+ * @fhdr:         preservation metadata.
  *
  * Recreates an area in vmalloc address space and populates it with memory that
  * was preserved using kho_preserve_vmalloc().
  *
  * Return: pointer to the area in the vmalloc address space, NULL on failure.
  */
-void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
+void *kho_restore_vmalloc(const DECLARE_KHO_SER_HDR(kho_vmalloc, *fhdr))
 {
-	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(preservation->first);
+	const struct kho_vmalloc *vmalloc_ser;
+	struct kho_vmalloc_chunk *chunk;
 	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_PROT_NORMAL;
 	unsigned int align, order, shift, vm_flags;
 	unsigned long total_pages, contig_pages;
@@ -1487,19 +1499,29 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 	unsigned int idx = 0;
 	int err;
 
-	vm_flags = kho_flags_to_vmalloc(preservation->flags);
+	if (!fhdr)
+		return NULL;
+
+	err = kho_ser_validate(fhdr, kho_vmalloc);
+	if (err)
+		return NULL;
+
+	vmalloc_ser = kho_ser_payload(fhdr, kho_vmalloc);
+
+	vm_flags = kho_flags_to_vmalloc(vmalloc_ser->flags);
 	if (vm_flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
 		return NULL;
 
-	total_pages = preservation->total_pages;
+	total_pages = vmalloc_ser->total_pages;
 	pages = kvmalloc_objs(*pages, total_pages);
 	if (!pages)
 		return NULL;
-	order = preservation->order;
+	order = vmalloc_ser->order;
 	contig_pages = (1 << order);
 	shift = PAGE_SHIFT + order;
 	align = 1 << shift;
 
+	chunk = KHOSER_LOAD_PTR(vmalloc_ser->first);
 	while (chunk) {
 		struct page *page;
 
diff --git a/lib/test_kho.c b/lib/test_kho.c
index cd0f183ff68e..cfd80b8b3c6d 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -34,7 +34,7 @@ struct kho_test_state {
 	unsigned int nr_folios;
 	struct folio **folios;
 	phys_addr_t *folios_info;
-	DECLARE_KHOSER_PTR(folios_info_phys, struct kho_vmalloc *);
+	DECLARE_KHOSER_PTR(folios_info_fhdr, DECLARE_KHO_SER_HDR(kho_vmalloc, *));
 	int nr_folios_preserved;
 	struct folio *fdt;
 	__wsum csum;
@@ -47,8 +47,8 @@ static void kho_test_unpreserve_data(struct kho_test_state *state)
 	for (int i = 0; i < state->nr_folios_preserved; i++)
 		kho_unpreserve_folio(state->folios[i]);
 
-	if (KHOSER_LOAD_PTR(state->folios_info_phys))
-		kho_unpreserve_vmalloc(KHOSER_LOAD_PTR(state->folios_info_phys));
+	if (KHOSER_LOAD_PTR(state->folios_info_fhdr))
+		kho_unpreserve_vmalloc(KHOSER_LOAD_PTR(state->folios_info_fhdr));
 	vfree(state->folios_info);
 }
 
@@ -61,7 +61,7 @@ static int kho_test_preserve_data(struct kho_test_state *state)
 	if (!folios_info)
 		return -ENOMEM;
 
-	err = kho_preserve_vmalloc(folios_info, KHOSER_LOAD_PTR(state->folios_info_phys));
+	err = kho_preserve_vmalloc(folios_info, KHOSER_LOAD_PTR(state->folios_info_fhdr));
 	if (err)
 		goto err_free_info;
 
@@ -109,8 +109,8 @@ static int kho_test_prepare_fdt(struct kho_test_state *state, ssize_t fdt_size)
 	err |= fdt_begin_node(fdt, "data");
 	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
 			    sizeof(state->nr_folios));
-	err |= fdt_property(fdt, "folios_info", &state->folios_info_phys,
-			    sizeof(state->folios_info_phys));
+	err |= fdt_property(fdt, "folios_info", &state->folios_info_fhdr,
+			    sizeof(state->folios_info_fhdr));
 	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
 	err |= fdt_end_node(fdt);
 
@@ -122,18 +122,18 @@ static int kho_test_prepare_fdt(struct kho_test_state *state, ssize_t fdt_size)
 
 static int kho_test_preserve(struct kho_test_state *state)
 {
-	struct kho_vmalloc *folios_vmalloc;
+	DECLARE_KHO_SER_HDR(kho_vmalloc, *folios_fhdr);
 	ssize_t fdt_size, alloc_size;
 	int err;
 
 	fdt_size = state->nr_folios * sizeof(phys_addr_t) + PAGE_SIZE;
-	alloc_size = fdt_size + sizeof(struct kho_vmalloc);
+	alloc_size = fdt_size + kho_ser_size(kho_vmalloc);
 	state->fdt = folio_alloc(GFP_KERNEL, get_order(alloc_size));
 	if (!state->fdt)
 		return -ENOMEM;
 
-	folios_vmalloc = folio_address(state->fdt) + fdt_size;
-	KHOSER_STORE_PTR(state->folios_info_phys, folios_vmalloc);
+	folios_fhdr = folio_address(state->fdt) + fdt_size;
+	KHOSER_STORE_PTR(state->folios_info_fhdr, folios_fhdr);
 
 	err = kho_preserve_folio(state->fdt);
 	if (err)
@@ -238,8 +238,9 @@ static int kho_test_save(void)
 
 static int kho_test_restore_data(const void *fdt, int node)
 {
-	const DECLARE_KHOSER_PTR(*folios_info_phys, struct kho_vmalloc *);
-	const struct kho_vmalloc *folios_vmalloc;
+	const DECLARE_KHOSER_PTR(*folios_fhdr_phys,
+				 DECLARE_KHO_SER_HDR(kho_vmalloc, *));
+	const DECLARE_KHO_SER_HDR(kho_vmalloc, *folios_fhdr);
 	const unsigned int *nr_folios;
 	phys_addr_t *folios_info;
 	const __wsum *old_csum;
@@ -256,15 +257,15 @@ static int kho_test_restore_data(const void *fdt, int node)
 	if (!old_csum || len != sizeof(*old_csum))
 		return -EINVAL;
 
-	folios_info_phys = fdt_getprop(fdt, node, "folios_info", &len);
-	if (!folios_info_phys || len != sizeof(*folios_info_phys))
+	folios_fhdr_phys = fdt_getprop(fdt, node, "folios_info", &len);
+	if (!folios_fhdr_phys || len != sizeof(*folios_fhdr_phys))
 		return -EINVAL;
 
-	folios_vmalloc = KHOSER_LOAD_PTR(*folios_info_phys);
-	if (!folios_vmalloc)
+	folios_fhdr = KHOSER_LOAD_PTR(*folios_fhdr_phys);
+	if (!folios_fhdr)
 		return -EINVAL;
 
-	folios_info = kho_restore_vmalloc(folios_vmalloc);
+	folios_info = kho_restore_vmalloc(folios_fhdr);
 	if (!folios_info)
 		return -EINVAL;
 
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 4471cced57db..74c1ff5877c3 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -103,7 +103,7 @@ static int memfd_luo_preserve_folios(struct file *file,
 	 * are not set.
 	 */
 	if (!size) {
-		ser->folios.phys = 0;
+		ser->folios_fhdr.phys = 0;
 		ser->nr_folios = 0;
 		*out_folios_ser = NULL;
 		return 0;
@@ -200,7 +200,7 @@ static int memfd_luo_preserve_folios(struct file *file,
 		pfolio->index = folio->index;
 	}
 
-	err = kho_preserve_vmalloc(folios_ser, KHOSER_LOAD_PTR(ser->folios));
+	err = kho_preserve_vmalloc(folios_ser, KHOSER_LOAD_PTR(ser->folios_fhdr));
 	if (err)
 		goto err_unpreserve;
 
@@ -227,7 +227,7 @@ static int memfd_luo_preserve_folios(struct file *file,
 	return err;
 }
 
-static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
+static void memfd_luo_unpreserve_folios(DECLARE_KHO_SER_HDR(kho_vmalloc, *folios_fhdr),
 					struct memfd_luo_folio_ser *folios_ser,
 					u64 nr_folios)
 {
@@ -236,7 +236,7 @@ static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
 	if (!nr_folios)
 		return;
 
-	kho_unpreserve_vmalloc(kho_vmalloc);
+	kho_unpreserve_vmalloc(folios_fhdr);
 
 	for (i = 0; i < nr_folios; i++) {
 		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
@@ -256,15 +256,16 @@ static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
 
 static size_t memfd_luo_ser_size(void)
 {
-	return sizeof(struct memfd_luo_ser) + sizeof(struct kho_vmalloc);
+	return sizeof(struct memfd_luo_ser) + kho_ser_size(kho_vmalloc);
 }
 
 static struct memfd_luo_ser *memfd_luo_ser_init(void *mem)
 {
-	struct kho_vmalloc *kho_vmalloc = mem + sizeof(struct memfd_luo_ser);
+	DECLARE_KHO_SER_HDR(kho_vmalloc, *folios_fhdr);
 	struct memfd_luo_ser *ser = mem;
 
-	KHOSER_STORE_PTR(ser->folios, kho_vmalloc);
+	folios_fhdr = mem + sizeof(struct memfd_luo_ser);
+	KHOSER_STORE_PTR(ser->folios_fhdr, folios_fhdr);
 	return ser;
 }
 
@@ -365,7 +366,7 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 
 	ser = phys_to_virt(args->serialized_data);
 
-	memfd_luo_unpreserve_folios(KHOSER_LOAD_PTR(ser->folios),
+	memfd_luo_unpreserve_folios(KHOSER_LOAD_PTR(ser->folios_fhdr),
 				    args->private_data,
 				    ser->nr_folios);
 
@@ -416,7 +417,7 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 		return;
 
 	if (ser->nr_folios) {
-		folios_ser = kho_restore_vmalloc(KHOSER_LOAD_PTR(ser->folios));
+		folios_ser = kho_restore_vmalloc(KHOSER_LOAD_PTR(ser->folios_fhdr));
 		if (!folios_ser)
 			goto out;
 
@@ -567,7 +568,7 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	i_size_write(file_inode(file), ser->size);
 
 	if (ser->nr_folios) {
-		folios_ser = kho_restore_vmalloc(KHOSER_LOAD_PTR(ser->folios));
+		folios_ser = kho_restore_vmalloc(KHOSER_LOAD_PTR(ser->folios_fhdr));
 		if (!folios_ser) {
 			err = -EINVAL;
 			goto put_file;
-- 
2.56.0.506.g506a7eabc5-goog

