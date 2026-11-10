Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286930;
	b=dtzQXFCigOp+CD8jbWXzzIU6VN9nB4K6gmtPo8SMkkwzWKOrRSBSrO97qj72OHgZzwzE
	 aeD0AjjVgR0KQW3k9+dC5O581hJN6QrLizKBw8CcSiKBwBF/CFXVhBtt+WcEjEeQByweL
	 7X6HAaaeOOiW3O1NZaj+K3gPdys9HOTD5NVcu9fstOOgTO7UBThUBHuHx4/vyxmCvXUZt
	 P3BtUNf1dYEtWLNWLTcLWPq4xw0WYynPgKSV9GuqOOTHePN+m1yggqKDQ33lFzfc90W26
	 9JHeevHogSzjCVmG3+EhzRt+/Wci2w3xwrb8CSifec1XXj14x/e9LT0dBxrKJJ9qBqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Sj2aHvE/30fRUSODl4VGY86EHM+govAz/p3nvPD2KF0=;
	b=nmopEXKl1v8c3yQ9Eedh6fYdAeaXQLha0RMRGpDs1iOSYBuNw3LFWTFbgUN0KGX+lC++
	 r+cOEA8jNTrsgF11lRX97aW+/THf+vFvIU++Fe7QYCtbhEJgLNdkTwlQcnvtONYOwN5kc
	 ico1ralK0tGFimEW+SyQ1i3kit/fxD0MQlaZb+XgjTVt+OWZIwcwyR1xNHZJINnlvuUo6
	 0fY4o4w4t+WuDRU6sL/Sj7GrlQmry3b/mcavAsmJsL8BKdFfTMGTTrMNNQlm050GEMCtS
	 v7b9Ab0WGjliBbb00roDXQL0iTGGffzA65KkWHcAW9sR/QHbbEzmnwetlXYqo5R30vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Cgg8+hEJ;
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC560A263B
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 05:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EFC560A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Cgg8+hEJ
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b706aec65bso1580343a12.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 21:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286929; x=1794891729; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sj2aHvE/30fRUSODl4VGY86EHM+govAz/p3nvPD2KF0=;
        b=Cgg8+hEJHtrduALRlDiOuRmoz9daznQJncUd/jI6D1C0a0P78gfVMq1qYSSUBIxntu
         uzXynVIrtpVGqCarHL1/1aoU94CADB9J10XDrxnovtEKs0Jdqz/K3PlePHwjS8mWM3Zz
         cid57aUvJKRjdygiNpoDC4iNrsWhp8zzvvMg7mbwJhxh8YtCrKP6yZCrIdqwK/vLZWt8
         UGvFori/1IDbq7YClAL+WVkGTfOQKxdw23JdG+hhmLLaaDVj4iv/HXYVp4e1+tikXLYj
         Xdwjzs0SaTkQjTR59vbrWznYw651/XxcelWfMcwICWnh7LbKTSEqQgqMgm+8s1dsg6ou
         7bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286929; x=1794891729;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sj2aHvE/30fRUSODl4VGY86EHM+govAz/p3nvPD2KF0=;
        b=blRg8g0fHvK9QtFbiDTQ+YgHg0WVw7p57OFUedhEREronn02AzlGXdXKPY3ISYetU0
         CBDJzIBeWJMv9ofC3nONvbFjpHbNpwdRxv/HEFjaN65Fr3eAYmp4wqwCZl/wvNuELKjx
         Orqe1xbkqrisP/k/JGAgnF+IIgLfJqYUfy4HYvAhnMGs5bGXepSAdzkWuqyNK8p9u/5z
         +6x/J4vW+ADaOsU8qswBACUw2b9NBWYaawI2lSyJ9t9EHzrEqgi+1rkOe5/8d6CJ2f84
         CFRumNHvR3OO0NK3nz8HjNZGaG153UB0Nppdr8YGChyV33h9FeHUea5s0OIYPAXLTN1b
         B48A==
X-Forwarded-Encrypted: i=1; AL+hErFSn1+EUWHnX9+aW8nNxuEoCmD0qFfYlKef2GjYpNXkpxvtw96Vhq8u+Yc8UQJFPP3PrqwRVOpYycM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KHVXG7fryYz9xcqc1mjIyRW3YcxF1kStFDuzICHgz+7YBwFL+
	7sTISN14goQvZTKeYF2pX6OLxGRFYh+JnKRlrL/sJhinb6DU/ISHGacCijqqPOPtOsjlG4tSpYd
	/zxsHhzUQkk7sjoHAvQ==
X-Received: from ejczh1.prod.google.com ([2002:a17:907:e901:b0:c42:9eb:1d43])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f03:b0:c50:475d:9804 with SMTP id a640c23a62f3a-c5049583bf0mr103443266b.13.1794286928328;
 Mon, 09 Nov 2026 21:02:08 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:46 +0000
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
Message-ID: <20261110050202.529473-4-tarunsahu@google.com>
Subject: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc via
 serialized pointer
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

Subsystems preserving vmalloc allocations currently embed struct
kho_vmalloc directly by value in their serialized structures or device
tree properties. For example, struct memfd_luo_ser embeds struct
kho_vmalloc folios, and test_kho writes the structure directly into the
folios_info FDT property.

Embedding struct kho_vmalloc directly couples the containing layout's
field offsets and size to struct kho_vmalloc. Any modification to struct
kho_vmalloc shifts subsequent fields in the containing structure and
breaks the handover ABI across kexec.

Convert callers to hold a DECLARE_KHOSER_PTR pointer to struct
kho_vmalloc instead of embedding it by value. In memfd_luo, allocate the
main structure and struct kho_vmalloc in the same preserved folio, placing
struct kho_vmalloc in the remaining 8-byte-aligned space, and bump the
compatibility string to memfd-v3. In test_kho, place struct kho_vmalloc
in the remaining space of the FDT folio, store the serialized pointer in
the folios_info property, and bump the compatibility string to
kho-test-v2.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/kexec_handover.h |  6 +++
 include/linux/kho/abi/memfd.h          |  8 ++--
 lib/test_kho.c                         | 29 ++++++++----
 mm/memfd_luo.c                         | 63 ++++++++++++++++----------
 4 files changed, 68 insertions(+), 38 deletions(-)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 6f12f5037ea5..bee75a7006e8 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -11,6 +11,8 @@
 #define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
 
 #include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/kconfig.h>
 #include <linux/log2.h>
 #include <linux/math.h>
 #include <linux/types.h>
@@ -177,6 +179,10 @@ struct kho_vmalloc {
 	unsigned short order;
 };
 
+static_assert(sizeof(struct kho_vmalloc) == 16);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct kho_vmalloc) == 8);
+
 /**
  * DOC: KHO persistent memory tracker
  *
diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 376a724a1d8c..7b49dd6d7e2a 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -81,7 +81,7 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  *             to directly use them in the ABI.
  * @flags:     Flags for the file. Unused flag bits must be set to 0.
  * @nr_folios: Number of folios in the folios array.
- * @folios:    KHO vmalloc descriptor pointing to the array of
+ * @folios:    Pointer to KHO vmalloc descriptor for the array of
  *             struct memfd_luo_folio_ser.
  */
 struct memfd_luo_ser {
@@ -90,14 +90,14 @@ struct memfd_luo_ser {
 	u32 seals;
 	u32 flags;
 	u64 nr_folios;
-	struct kho_vmalloc folios;
+	DECLARE_KHOSER_PTR(folios, struct kho_vmalloc *);
 };
 
-static_assert(sizeof(struct memfd_luo_ser) == 48);
+static_assert(sizeof(struct memfd_luo_ser) == 40);
 static_assert(!IS_ENABLED(CONFIG_64BIT) ||
 	      __alignof__(struct memfd_luo_ser) == 8);
 
 /* The compatibility string for memfd file handler */
-#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
+#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v3"
 
 #endif /* _LINUX_KHO_ABI_MEMFD_H */
diff --git a/lib/test_kho.c b/lib/test_kho.c
index aa6a0956bb8b..cd0f183ff68e 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -25,7 +25,7 @@
 
 #define KHO_TEST_MAGIC	0x4b484f21	/* KHO! */
 #define KHO_TEST_FDT	"kho_test"
-#define KHO_TEST_COMPAT "kho-test-v1"
+#define KHO_TEST_COMPAT "kho-test-v2"
 
 static long max_mem = (PAGE_SIZE << MAX_PAGE_ORDER) * 2;
 module_param(max_mem, long, 0644);
@@ -34,7 +34,7 @@ struct kho_test_state {
 	unsigned int nr_folios;
 	struct folio **folios;
 	phys_addr_t *folios_info;
-	struct kho_vmalloc folios_info_phys;
+	DECLARE_KHOSER_PTR(folios_info_phys, struct kho_vmalloc *);
 	int nr_folios_preserved;
 	struct folio *fdt;
 	__wsum csum;
@@ -47,13 +47,13 @@ static void kho_test_unpreserve_data(struct kho_test_state *state)
 	for (int i = 0; i < state->nr_folios_preserved; i++)
 		kho_unpreserve_folio(state->folios[i]);
 
-	kho_unpreserve_vmalloc(&state->folios_info_phys);
+	if (KHOSER_LOAD_PTR(state->folios_info_phys))
+		kho_unpreserve_vmalloc(KHOSER_LOAD_PTR(state->folios_info_phys));
 	vfree(state->folios_info);
 }
 
 static int kho_test_preserve_data(struct kho_test_state *state)
 {
-	struct kho_vmalloc folios_info_phys;
 	phys_addr_t *folios_info;
 	int err;
 
@@ -61,11 +61,10 @@ static int kho_test_preserve_data(struct kho_test_state *state)
 	if (!folios_info)
 		return -ENOMEM;
 
-	err = kho_preserve_vmalloc(folios_info, &folios_info_phys);
+	err = kho_preserve_vmalloc(folios_info, KHOSER_LOAD_PTR(state->folios_info_phys));
 	if (err)
 		goto err_free_info;
 
-	state->folios_info_phys = folios_info_phys;
 	state->folios_info = folios_info;
 
 	for (int i = 0; i < state->nr_folios; i++) {
@@ -123,14 +122,19 @@ static int kho_test_prepare_fdt(struct kho_test_state *state, ssize_t fdt_size)
 
 static int kho_test_preserve(struct kho_test_state *state)
 {
-	ssize_t fdt_size;
+	struct kho_vmalloc *folios_vmalloc;
+	ssize_t fdt_size, alloc_size;
 	int err;
 
 	fdt_size = state->nr_folios * sizeof(phys_addr_t) + PAGE_SIZE;
-	state->fdt = folio_alloc(GFP_KERNEL, get_order(fdt_size));
+	alloc_size = fdt_size + sizeof(struct kho_vmalloc);
+	state->fdt = folio_alloc(GFP_KERNEL, get_order(alloc_size));
 	if (!state->fdt)
 		return -ENOMEM;
 
+	folios_vmalloc = folio_address(state->fdt) + fdt_size;
+	KHOSER_STORE_PTR(state->folios_info_phys, folios_vmalloc);
+
 	err = kho_preserve_folio(state->fdt);
 	if (err)
 		goto err_free_fdt;
@@ -234,7 +238,8 @@ static int kho_test_save(void)
 
 static int kho_test_restore_data(const void *fdt, int node)
 {
-	const struct kho_vmalloc *folios_info_phys;
+	const DECLARE_KHOSER_PTR(*folios_info_phys, struct kho_vmalloc *);
+	const struct kho_vmalloc *folios_vmalloc;
 	const unsigned int *nr_folios;
 	phys_addr_t *folios_info;
 	const __wsum *old_csum;
@@ -255,7 +260,11 @@ static int kho_test_restore_data(const void *fdt, int node)
 	if (!folios_info_phys || len != sizeof(*folios_info_phys))
 		return -EINVAL;
 
-	folios_info = kho_restore_vmalloc(folios_info_phys);
+	folios_vmalloc = KHOSER_LOAD_PTR(*folios_info_phys);
+	if (!folios_vmalloc)
+		return -EINVAL;
+
+	folios_info = kho_restore_vmalloc(folios_vmalloc);
 	if (!folios_info)
 		return -EINVAL;
 
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 6b68220275eb..4471cced57db 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -85,9 +85,8 @@
 #include "internal.h"
 
 static int memfd_luo_preserve_folios(struct file *file,
-				     struct kho_vmalloc *kho_vmalloc,
-				     struct memfd_luo_folio_ser **out_folios_ser,
-				     u64 *nr_foliosp)
+				     struct memfd_luo_ser *ser,
+				     struct memfd_luo_folio_ser **out_folios_ser)
 {
 	struct inode *inode = file_inode(file);
 	struct memfd_luo_folio_ser *folios_ser;
@@ -104,7 +103,8 @@ static int memfd_luo_preserve_folios(struct file *file,
 	 * are not set.
 	 */
 	if (!size) {
-		*nr_foliosp = 0;
+		ser->folios.phys = 0;
+		ser->nr_folios = 0;
 		*out_folios_ser = NULL;
 		return 0;
 	}
@@ -200,12 +200,12 @@ static int memfd_luo_preserve_folios(struct file *file,
 		pfolio->index = folio->index;
 	}
 
-	err = kho_preserve_vmalloc(folios_ser, kho_vmalloc);
+	err = kho_preserve_vmalloc(folios_ser, KHOSER_LOAD_PTR(ser->folios));
 	if (err)
 		goto err_unpreserve;
 
 	kvfree(folios);
-	*nr_foliosp = nr_folios;
+	ser->nr_folios = nr_folios;
 	*out_folios_ser = folios_ser;
 
 	/*
@@ -254,37 +254,43 @@ static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
 	vfree(folios_ser);
 }
 
+static size_t memfd_luo_ser_size(void)
+{
+	return sizeof(struct memfd_luo_ser) + sizeof(struct kho_vmalloc);
+}
+
+static struct memfd_luo_ser *memfd_luo_ser_init(void *mem)
+{
+	struct kho_vmalloc *kho_vmalloc = mem + sizeof(struct memfd_luo_ser);
+	struct memfd_luo_ser *ser = mem;
+
+	KHOSER_STORE_PTR(ser->folios, kho_vmalloc);
+	return ser;
+}
+
 static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
-	u64 nr_folios, inode_size;
 	int err = 0, seals;
+	u64 inode_size;
 
 	inode_lock(inode);
 	shmem_freeze(inode, true);
 
-	/* Allocate the main serialization structure in preserved memory */
-	ser = kho_alloc_preserve(sizeof(*ser));
-	if (IS_ERR(ser)) {
-		err = PTR_ERR(ser);
-		goto err_unlock;
-	}
-
 	seals = memfd_get_seals(args->file);
 	if (seals < 0) {
 		err = seals;
-		goto err_free_ser;
+		goto err_unlock;
 	}
 
 	/* Make sure the file only has the seals supported by this version. */
 	if (seals & ~MEMFD_LUO_ALL_SEALS) {
 		err = -EOPNOTSUPP;
-		goto err_free_ser;
+		goto err_unlock;
 	}
 
-	ser->pos = args->file->f_pos;
 	inode_size = i_size_read(inode);
 
 	/*
@@ -293,18 +299,26 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	 */
 	if (DIV_ROUND_UP_ULL(inode_size, PAGE_SIZE) > UINT_MAX) {
 		err = -EFBIG;
-		goto err_free_ser;
+		goto err_unlock;
+	}
+
+	/* Allocate the main serialization structure in preserved memory */
+	ser = kho_alloc_preserve(memfd_luo_ser_size());
+	if (IS_ERR(ser)) {
+		err = PTR_ERR(ser);
+		goto err_unlock;
 	}
+	ser = memfd_luo_ser_init(ser);
 
+	ser->pos = args->file->f_pos;
 	ser->size = inode_size;
 	ser->seals = seals;
+	ser->flags = 0;
 
-	err = memfd_luo_preserve_folios(args->file, &ser->folios,
-					&folios_ser, &nr_folios);
+	err = memfd_luo_preserve_folios(args->file, ser, &folios_ser);
 	if (err)
 		goto err_free_ser;
 
-	ser->nr_folios = nr_folios;
 	inode_unlock(inode);
 
 	args->private_data = folios_ser;
@@ -351,7 +365,8 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 
 	ser = phys_to_virt(args->serialized_data);
 
-	memfd_luo_unpreserve_folios(&ser->folios, args->private_data,
+	memfd_luo_unpreserve_folios(KHOSER_LOAD_PTR(ser->folios),
+				    args->private_data,
 				    ser->nr_folios);
 
 	kho_unpreserve_free(ser);
@@ -401,7 +416,7 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 		return;
 
 	if (ser->nr_folios) {
-		folios_ser = kho_restore_vmalloc(&ser->folios);
+		folios_ser = kho_restore_vmalloc(KHOSER_LOAD_PTR(ser->folios));
 		if (!folios_ser)
 			goto out;
 
@@ -552,7 +567,7 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	i_size_write(file_inode(file), ser->size);
 
 	if (ser->nr_folios) {
-		folios_ser = kho_restore_vmalloc(&ser->folios);
+		folios_ser = kho_restore_vmalloc(KHOSER_LOAD_PTR(ser->folios));
 		if (!folios_ser) {
 			err = -EINVAL;
 			goto put_file;
-- 
2.56.0.506.g506a7eabc5-goog

