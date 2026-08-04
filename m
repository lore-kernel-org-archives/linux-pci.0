Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F0C4734ED
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869469; cv=none; b=cQleeaHr44XCUXrZvd2UJJJH8myNbxlya2iE04NloGxRtsTC4Een2kgXjNX36AhIdAQbLj/n/HC7O6gyuFkQTqecVij5Sq2XBb9Q0cM+AQFqARcMYeMLBzU95uLUJrepSLY9wa8Qodh5fO0mVYqI1S4dw9AdjNZ8ToLqfQtfeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869469; c=relaxed/simple;
	bh=XlkRowI/Bj2yqvZSSpDH2xbYCIlXFfReqBFODIvSLbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mjxhHclO7pG0sfB1hI19/Bkqup7BhhQUFsQGBhxcEMp75cYMcRIrRBXNH3rDw/je8I8YUntN1PL+AB6nGLNkAydCkk37Z7PFW7a5oA8lmQ1B5ksjDbU1UK2oOOZuamIzkC03Vn/Sc1xWtHRdn1vsf1eVPJLCuTdXf8nF6SHHs3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MBB4roiW; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBB4roiW"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so98034a12.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 11:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785869467; x=1786474267; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mN/ftuPXHTO6yPx2v45bEY7G4dZzvWxyQXkizaq1wVU=;
        b=MBB4roiWT6SNt7U1o9vGR9MgpQ8CYYNVUWs2n/mnVLwAcT3lrz5m2d84gRBHrner9I
         2qmo7k+E4+aPEdqPG1cQbaTBcFi7tFBNq/YHnfrQdCHRTecNAPZll8J/uikWAw5e82NC
         TfX0IeNYYd7CwXN8zld7fpCF5GXya/6wiTc66CCEu062Kz5VExeXik1kh4u+ZFRI1Fcy
         tYMY69cyLbGKQKw7J+UK17te/WTkX0kVcPaN6Kr6WU7SknwPx77hsKNF5S4RBCBd/ovm
         aVnHu5x3yx/27N5kc4iGhvH7LAlq1du0cilZUrvDU8ekadkcn3zUovBtbHu3zSkd72Nv
         5ldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869467; x=1786474267;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mN/ftuPXHTO6yPx2v45bEY7G4dZzvWxyQXkizaq1wVU=;
        b=M1q+dUZ4zHmOy57+Orq6Ny9v4JJcPfPXDHh6aQd8fAKDAo0DS9pVyL9oAf0d2GwwPa
         HREM+GWwmyKDKwJDWksrOf5icjN4UuzR8jfxh2d4y72DPQ4dbXLssBLFn7TOCpJRE3NU
         bUdfM4f8esAF6KPT0nhNs5Wv6nUkuxF7Ub/vCztFaIamG5EmzNNwOHxUCtQo25sjfcui
         xZ5cNvC96v9MhYBiFszeNF6boNSNe7iNk2DFVtkoh/jl+rgsK9WMUn3/AZRL0DWE1oc0
         aERgVeI4gQRzun9iexZJcO7ZsdOylelyLdv4+NkGNQcfuIeNpNitpIPusHdd5a90o13/
         yKLA==
X-Gm-Message-State: AOJu0YxJommMPMtohiokOm8WRrFh2JoPLOIEysET0s+HNfp4VXUBmScl
	cfKefyATcw2rqNfLzrPRGvyRw1KYa8xsmQkWKhv2N/+5vncJZrfhqiy7EKlTDhhy+friHVSRzbb
	tgsYtLnzlnMXEzC7nXJX1Y9gy2or3LMnuisALE+1xIc7+Lu455oYWd1NpvzqX6BdjN1nQUr04vL
	WOTrh8dO2M/ThO7z+G2C456b14WdhvIWqWBqA=
X-Received: from pgla35.prod.google.com ([2002:a63:b63:0:b0:c96:da8a:c09c])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:428b:b0:3c3:64cc:311a
 with SMTP id adf61e73a8af0-3cb85ef9229mr901310637.22.1785869467266; Tue, 04
 Aug 2026 11:51:07 -0700 (PDT)
Date: Tue,  4 Aug 2026 18:50:46 +0000
In-Reply-To: <20260804185050.2053672-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804185050.2053672-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804185050.2053672-2-praan@google.com>
Subject: [RFC PATCH v2 1/5] vfio: Add UAPI flag for ZONE_DEVICE-backed DMABUF exports
From: Pranjal Shrivastava <praan@google.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Pranjal Shrivastava <praan@google.com>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Shivaji Kant <shivajikant@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Unnati Sachan <unnatisachan@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an opt-in UAPI flag for exporting VFIO MMIO regions via dmabuf
backed by struct page metadata (via ZONE_DEVICE registration).

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 include/uapi/linux/vfio.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index cbe03e5d1009..3ae025b33e7f 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1505,7 +1505,13 @@ struct vfio_device_feature_bus_master {
  * etc. offset/length specify a slice of the region to create the dmabuf from.
  * nr_ranges is the total number of (P2P DMA) ranges that comprise the dmabuf.
  *
- * flags should be 0.
+ * flags supports:
+ *   - VFIO_DMA_BUF_FLAG_ZONE_DEVICE_BACKED: Request the kernel to allocate
+ *     valid struct pages for the exported dmabuf range (via ZONE_DEVICE
+ *     registration). This allows the exported dmabuf fd to be used by
+ *     subsystems that rely on page metadata.
+ *     (NOTE: This consumes extra system RAM to store BAR_SIZE / PAGE_SIZE
+ *     struct pages).
  *
  * Return: The fd number on success, -1 and errno is set on failure.
  */
@@ -1516,6 +1522,8 @@ struct vfio_region_dma_range {
 	__u64 length;
 };
 
+#define VFIO_DMA_BUF_FLAG_ZONE_DEVICE_BACKED	(1 << 0)
+
 struct vfio_device_feature_dma_buf {
 	__u32	region_index;
 	__u32	open_flags;
-- 
2.55.0.571.g244d577d93-goog

