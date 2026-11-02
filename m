Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633844;
	b=H0oQmCtT6qZPoVeAm7ekg/qVVwPbaLgoi/gCaBK8vX6iUpaZoLiO+vJ2ZQxl8YvlKMiD
	 cPrJrcQIjptnz4ohZ8S3bXTelIJ4VgCkY+XdWla8PR+Li7Q2BkPJlxCtZ9b/jneIL3IMz
	 xh4crzh26aN4q9XABfEHLGleuNGJQP7OyFQKqlym+QeOg106pl9zyArSf5mufC53ZLzhJ
	 GQSgmW4NbwZwxqyptYYVTbROx1ecGKr3Gi2Jd9pnCP4lxZQdFNngfD4OmkW9oXz0E2IYn
	 Xa6+kkrRbqvb3RiMgypCqvRTWrOkqeoGL+cE1/YGTlYR7zqgBxYnOgU+Uo/ac6HWyXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=3Pjs45S57+QYe3zCfvXOSLki7qU0AqGmneDsSzoE048=;
	b=NnTQtwSh95PKodykpd8wnff/Lw5fFgCSnHgA81vmC/ckD4AYdIl01W5XwL8mHVOf/BNY
	 2dLNjqjr7d2G1KHiEhqF6qyfxjVWHXmn2FI/mE+rJWrTboShKs/Er+LxK5IG5OnxtmZ3H
	 rJ9funU7ksy096G7n6X/uDOiq5kiwDEWisHmN+TBbos7SNczIGav8oXVVUUC0pDPCWatZ
	 KpSCUaC5hEBcnow+5d5q1sInsnDMRftlubty0O97HoAI4ueCtO5V8kD3XxarTuR5sAEeZ
	 e4s+kwl+b932NaOKNQYqnqn9hV7Tyyko984/PUCcQFHeWfGzPqRpDFc3D/93ybFyfxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FAaVSdjU;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779060EB63B
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 15:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4779060EB63B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FAaVSdjU
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-88c768885b4so3452817b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 07:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633843; x=1794238643; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Pjs45S57+QYe3zCfvXOSLki7qU0AqGmneDsSzoE048=;
        b=FAaVSdjUd0cfsq/b7VcuT8axjNOEN+7MFV5Y7WJXuTArFkLs3yupDaLWDBxj8/DVa1
         1ynAmNmwqx7A6A0XhZcNV3Z44L7Dmdn+befI7wSwfczoF1hPYM1uVVhoCydWn2EVB6S0
         WwOZEen3E31komCspSB+f1pW3ChpZkrgywL8NV2ZEF9jcWhGQ604kE3IqfCOv9bx2+9p
         5rbSlddU+X+JaDalXYFIsBYbtosEkvx5d6b4zsxj/vqjRS2OvPWCfmkhIFeVHl69Otz2
         G0uNGDNenv9aH4Gc6d8kf7Lwl/HPUDx6Bp+CXXygBvDr8OIwTrPFjfoUy7KhjVoOKmWu
         mGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633843; x=1794238643;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Pjs45S57+QYe3zCfvXOSLki7qU0AqGmneDsSzoE048=;
        b=MmEtWqOf72hlKXmd3PkpdO3G4eHUUaE3UQa53pi3w+ivMHmnJqZv57iMnS9t+W6G7m
         Stp8QEKDXAkVucB7eU2kvEHYtw7pfMDEDVhHOqJlDssIRJ06FkgAOrwcSfYH7dYIcK4x
         cjj8hCOCHl+ljjD+WBWBzT9ABwlbdukyJL8D2jQ4ntpuaKUEsf8jwZAF6patYi8h+ue/
         fXIz39jZMbtbhAPnyAuLp12qhaoJpF0zHTbmltxRTX3QX9J4cn3iDTAMRKoGMHkhw18E
         ++Z6WFKdw+EWjP9/oMCDY3MC8drZAzVIrXHInBKyxbucJpkBxLki1/o8lSlNZoiYTF+u
         9NBw==
X-Forwarded-Encrypted: i=1; AKwUvBzQHoewtRbr4p/5Ca6868NA7aN6AflVw9KprCae/kQ/JKequ6gFVVQRCMXBxd6Ar5UbNNFE2GBbV84=@vger.kernel.org
X-Gm-Message-State: AFq9FYKt60LbBAnnAa5B3xz136qdfullk9WQGSBFNN6TAT2MBAjYhZ59
	tI1m61v8T+BsL3waBxGa/rfOmcI3UQECwffYmVbyRz3le0AlRczXd7BgbbUDCGrqc5gR7sGehWE
	tuosO3c1CAA==
X-Received: from pgia4.prod.google.com ([2002:a63:e404:0:b0:cc7:865b:2dc5])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4cc1:b0:3e2:778e:3cdd
 with SMTP id adf61e73a8af0-3e9289abb68mr8817317637.37.1793633842371; Mon, 02
 Nov 2026 07:37:22 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:50 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-22-vipinsh@google.com>
Subject: [PATCH v6 21/27] vfio: selftests: Add helpers to map DMA memory at
 IOVA == PA in noiommu mode
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Selftest drivers program the IOVA returned by to_iova() into the device.
Because a device in noiommu mode uses those addresses directly as
physical addresses, DMA buffers must be mapped at IOVA == PA so that
to_iova() returns the buffer's physical address without changing the
drivers.

Add __iommu_noiommu_get_pa() to wrap IOMMU_IOAS_NOIOMMU_GET_PA and
iommu_map_identity() to map a physically contiguous buffer at IOVA == PA
by first pinning it at a scratch IOVA (BIT_ULL(52), above the 52-bit
output address space of the noiommu page table), querying its physical
address and contiguity, mapping it at IOVA == PA, and then unmapping the
scratch range while keeping the pages pinned.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          | 26 ++++++++
 tools/testing/selftests/vfio/lib/iommu.c      | 61 +++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e652b8caf5bb..d449813f9bc4 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -65,6 +65,32 @@ static inline void iommu_unmap_all(struct iommu *iommu)
 int __iommu_hva2iova(struct iommu *iommu, void *vaddr, iova_t *iova);
 iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr);
 
+/*
+ * Look up the physical address @iova maps to in the noiommu IOAS of @iommu
+ * (IOMMU_IOAS_NOIOMMU_GET_PA, requires CAP_SYS_RAWIO). On success, *@length is
+ * the number of physically contiguous bytes from *@pa, at most @max_length.
+ */
+int __iommu_noiommu_get_pa(struct iommu *iommu, iova_t iova, u64 max_length,
+			   u64 *pa, u64 *length);
+
+/*
+ * Map @region->size bytes at @region->vaddr at IOVA == PA, and set
+ * @region->iova to that PA. Devices in noiommu mode use the addresses that
+ * drivers program into them, i.e. to_iova(), as physical addresses, which such
+ * a mapping makes right.
+ *
+ * The buffer must be physically contiguous (e.g. a hugepage or a THP), and a
+ * noiommu device must be attached to @iommu already. The memory stays pinned,
+ * and so at the same physical address, until iommu_unmap(@region), which must
+ * not be called before the device stopped accessing it.
+ */
+int __iommu_map_identity(struct iommu *iommu, struct dma_region *region);
+
+static inline void iommu_map_identity(struct iommu *iommu, struct dma_region *region)
+{
+	VFIO_ASSERT_EQ(__iommu_map_identity(iommu, region), 0);
+}
+
 struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges);
 
 #define MODE_VFIO_TYPE1_IOMMU "vfio_type1_iommu"
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 0df49646d016..46e9635cbfc5 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -11,6 +11,7 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 
+#include <linux/bits.h>
 #include <linux/limits.h>
 #include <linux/mman.h>
 #include <linux/types.h>
@@ -244,6 +245,66 @@ int __iommu_unmap_all(struct iommu *iommu, u64 *unmapped)
 	return 0;
 }
 
+/*
+ * The noiommu IOAS page table translates to physical addresses of at most 52
+ * bits (drivers/iommu/iommufd/hwpt_noiommu.c), so a mapping at or above this
+ * IOVA never overlaps one at IOVA == PA.
+ */
+#define NOIOMMU_SCRATCH_IOVA	BIT_ULL(52)
+
+int __iommu_noiommu_get_pa(struct iommu *iommu, iova_t iova, u64 max_length,
+			   u64 *pa, u64 *length)
+{
+	struct iommu_ioas_noiommu_get_pa args = {
+		.size = sizeof(args),
+		.ioas_id = iommu->ioas_id,
+		.iova = iova,
+		.length = max_length,
+	};
+
+	if (!iommu->iommufd || !iommu->mode->noiommu)
+		return -EOPNOTSUPP;
+
+	if (ioctl(iommu->iommufd, IOMMU_IOAS_NOIOMMU_GET_PA, &args))
+		return -errno;
+
+	*pa = args.out_phys;
+	*length = args.length;
+	return 0;
+}
+
+int __iommu_map_identity(struct iommu *iommu, struct dma_region *region)
+{
+	struct dma_region scratch = {
+		.vaddr = region->vaddr,
+		.iova = NOIOMMU_SCRATCH_IOVA,
+		.size = region->size,
+	};
+	u64 pa, length;
+	int ret;
+
+	/* Pin the buffer with a scratch mapping to look up its physical address. */
+	ret = __iommu_map(iommu, &scratch);
+	if (ret)
+		return ret;
+
+	ret = __iommu_noiommu_get_pa(iommu, scratch.iova, scratch.size, &pa, &length);
+	if (!ret && length != region->size)
+		ret = -EINVAL;	/* Not physically contiguous. */
+
+	/*
+	 * Map it at IOVA == PA before dropping the scratch mapping, so that it
+	 * stays pinned, and hence at the same physical address, throughout.
+	 */
+	if (!ret) {
+		region->iova = pa;
+		ret = __iommu_map(iommu, region);
+	}
+
+	VFIO_ASSERT_EQ(__iommu_unmap(iommu, &scratch, NULL), 0);
+	return ret;
+}
+
 static struct vfio_info_cap_header *next_cap_hdr(void *buf, u32 bufsz,
 						 u32 *cap_offset)
 {
-- 
2.56.0.317.g454f8302e1-goog

