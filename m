Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0457E3346B4
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104740; cv=none; b=MpbGNao2ZuD+CBHOrLfs+1hkn4Mwd8s83ZomXngWT7g092dX9GynO1ejxBcrWAKswDkmLloIqFXblmTm/Un1P5u3E6szYdjadBJjRYjlypRFsLW9QOjiS7YHROPxpTqpWAWx03xnBWf6YhdaWzbsKYgyRXM0YYmhJgCmxLAiG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104740; c=relaxed/simple;
	bh=cjehl/AogF+ja+2ZcxwqddIpx4w4iJYwr6NEwkFI7Bg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a5uIm4txkw45kDsqEHMRxeQbfXnoNHIXTwlBAXMU7F96exjkus4pJhZamHXqlVnQAWw9TH0bHD6bqIYAzzO7kvy923dUXa8SuUPgwSAl3sRlQl+Vf42p/owJy88rz8dcGHEFRj+kA1y1E1eFxJGDJSpn2bKYpAKQvz6BoWgkPqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I6ZNUuzl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6ZNUuzl"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0bfcd629eso83777745ad.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781104738; x=1781709538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OH2gPa+CKBfgNfPcHJ5LqpJB+w0Mlwm6m76dwlsEpz0=;
        b=I6ZNUuzlDuwjSf8mEIj5cZ8KxNyFHIkRPnjqwkP2aJ3iBuNFm/hL4YqFn0m2+omFQU
         2csptVNh/2aagLG7hhU5H8U2CTKtLCVEgsak4z4jy7jAIriDPcW/WT8inw4tcqbDofK6
         Ib8AQpBzNvJLHNDCbvUHNcXlz8maen4g5lmVtX7AsJ928gv/5r1TRAwusgPxfqapVxKj
         syXIS56j2vfcDa976Ny97YA8kh5UntSICvPDdGeWRkKA/RAU2o5wUrZDBcUz70gNvKRD
         VqOS+xSYASnb5YkHEQj/g4gOToyWEUvkwS/bp5JHHJdkTaIWx6Ky4gSSbGSBS+Y4SkHR
         tjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104738; x=1781709538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OH2gPa+CKBfgNfPcHJ5LqpJB+w0Mlwm6m76dwlsEpz0=;
        b=EQ551JqGzvVSV9WeXYRcBCFP8qwHViVsrzmAsZloI8AA4J2HF+2O0BSNnDR4uyMnaN
         KHC5k8+CW1rflD1Sz2zgOMirgepzqftcs3PEjVPvJPAPufvXrwB5f5uza+IKPZliz+v6
         YSnKBEh2ndY1wJzDWoxN2GT/uRVkFUxWIZ5Ss5MFjYYEbDu95P51WB2rKqQp8WoH+0mO
         erBk9+O/X5U/jhCz/QuyG/ZIwVjDB7+h7nKEUQdC3EwcekgIfdRQT459rv79puzTsiCH
         u/FoulpLLZScpzaqE0buPLGlGVur39RFx5/MlFDjRDeU2BRsGVKXEYyp0JIYgatDpd89
         c7kQ==
X-Gm-Message-State: AOJu0YxpMzz900MD/+GOVAYbC/vTIe/NtTUcQi3aBvdBN57p5YZYHg/k
	NnduQPvf7FqzbRHDtudQaRPo6hWPUnnhJbltLmy6wcv7WfyRS5iu+TymECQ37fmrPrlj1vG26be
	3ddTP9xOqeVT2eBIpte7mrLIcd9PTlMIcSf4eos96MMOTr9kFaiqkAg3PYT4PFgw/yubB1hU+ZX
	u9LZD352ahi5qkdHQPlTd6yGKJTq7FzvfDcMI=
X-Received: from plbmp5.prod.google.com ([2002:a17:902:fd05:b0:2bd:c925:e1dc])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5ce:b0:2bd:5ab:af95
 with SMTP id d9443c01a7336-2c1e77d145fmr286373475ad.0.1781104738079; Wed, 10
 Jun 2026 08:18:58 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:18:49 +0000
In-Reply-To: <20260610151853.3608948-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610151853.3608948-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610151853.3608948-2-praan@google.com>
Subject: [RFC PATCH 1/5] vfio: Add UAPI for ZONE_DEVICE-backed P2P registration
From: Pranjal Shrivastava <praan@google.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Pranjal Shrivastava <praan@google.com>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Shivaji Kant <shivajikant@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce VFIO_DEVICE_FEATURE_P2P_REGISTER to the VFIO_DEVICE_FEATURE
ioctl. This feature allows a privileged userspace process to register
a specific PCI BAR with the kernel's PCI P2P DMA provider framework.

Unlike the standard VFIO dmabuf exporter, this feature leverages the
pci-p2pdma infrastructure to manufacture ZONE_DEVICE struct pages for
the BAR.

Standard VFIO mmap() is not supported for BARs registered via this
interface. Users are instead expected to use the native p2pmem sysfs
interface for memory allocation and management.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 include/uapi/linux/vfio.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..adbac3f965eb 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,21 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET register a PCI BAR with the kernel
+ * P2P DMA subsystem (pci-p2pdma).
+ *
+ * Once a BAR is registered, it will be added to the device's P2P
+ * pool and can be allocated via the standard sysfs p2pmem/allocate
+ * interface.
+ *
+ * Note: Standard VFIO mmap() of the BAR will be blocked once it is
+ * registered for native P2P.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+#define VFIO_DEVICE_FEATURE_P2P_REGISTER 13
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.54.0.1099.g489fc7bff1-goog

