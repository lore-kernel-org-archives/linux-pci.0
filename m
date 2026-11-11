Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425060;
	b=FuR8+195GVScAsJYB1iTcalDH9Oa1UBFFYfBDt0xZkPHJMNwMbG7vVpaKBUdiOql3+w+
	 /zROHtYV7lKX3KXZLlHHElkgOmyE9DKlUWNL6+GQg+dmsqrP0Ecc9x0c30GpEVZEohq0l
	 62ppQdC6ZKyiulneH6Dq63O9F3D5DVFmP2Vrd71SvuIkbYY7YrTiFu8A/bNkEgs27SMUb
	 Gm987hdSKCvBACK8yYusxndORbb/MYKPonPxDPxkB6RRfMGvM7MUwjbMnJflbNUh0aMdq
	 3DmYDFBEPS8x9yjd9KPCCC8CwRFJyCA6z/ZpqlOJIId4q6gpJFtnlB7vtt6XghmkNTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=s6lt1PxCFx0agGLbXpFKlY/hoUAzM5xkPqAiIkWnGNA=;
	b=cY267CHLeV4lpxMjBDkbYoCg28mNFKfFxvJDpYb85kti6d/FtU68y+MbFlA6K1vQx0zb
	 D61jCqRXoJtOCGMyush5dbDPZZ2VPi7VXRV4xoIrM4mA24BOL2SCIdJ8jRkoe8SN3lPZ4
	 CNxfPIxmYtdXMWAII7TZJVJtnu43UV+pyjmCG1al3HUb2ZaqK0VF8Um9TJKFojZGaonXC
	 VCCLgwr36G3yCYtMEhkGcAkeadqLXlIFfpV99X1ks35Nyt2Om7MFeWR/RLq/Udw5nrlQV
	 yrziuCCar8RSslqhN8AaR2ZN93gmAiubyjaICet6uFJaAKeS/j4cs3L36d5BLbHWmmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UOq3nT8j;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4706A606DD43
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 19:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4706A606DD43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UOq3nT8j
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4dab94dc3e7so6119532b6e.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 11:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794425058; x=1795029858; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s6lt1PxCFx0agGLbXpFKlY/hoUAzM5xkPqAiIkWnGNA=;
        b=UOq3nT8jfNIxrMk+znyvt21C9lwSewOGrh1jpeVu5iK5VmdqJeDT4fPjN6nDS+s/rz
         E6Ho+bO3iAXvXkGBGN7CjciNZSs05x40V5C4Z9f0REOobKvYRI7U+31LkNo568hjhRz2
         VA+FxI4lBIGhJ+ugD1He8j+J8VFk+dt26q+Q+oobnfzOprmYbN898bflauRMBfEEy4rd
         5Njig5Se7CnUBaBXRSmjOERE/lZ83r/qYtfGEy9EiotAynG+Zijcmr8jieR2cggp/ebU
         BtjWu6T0pL3mwZ94u0gf7+eonYPgaPav+OYjwJPpOUc8KIt158SxR+gGtte9ruBukesx
         e0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425058; x=1795029858;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s6lt1PxCFx0agGLbXpFKlY/hoUAzM5xkPqAiIkWnGNA=;
        b=PYNNHi4jUatkbjhDEJBWwabZh/BIgPt6meCxBz4lEVserzjN3t558ND+RabdP5fLZD
         s+ij25SJklOlX1g6fGctRARzKW7TJlEbtKPdgtLEQW8NUCpOFkH41ipjDkiT5kfgShD0
         BxDr0yJhFExSAI1eYyEVq922KDOsjkbk46I/7u07H7l8RuGj38jFtDAET/O7txjULLlt
         wImm9zHd/TJFkuegJvhS5PKlcwVtePOXbURmF7nYybA/sTdRg6xxmFZB/eSiPA+bYeqz
         IDVeL3qNVfWDZtVBjIbEXX2WAsfGMWc56MSRVjWol34gwQetNmfvR4xVjjDrXNZMeKXo
         BTfg==
X-Forwarded-Encrypted: i=1; AL+hErFnX1YAuZfeQUXXwO+DGe+vc12iyNAE/DSotAFYqx918nuIvSn0AOibANlwwhp3XOYvMTrOc4f1M3Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z98uA51Q2ybWHISZrCFUQbk6CNbqWNYw3cz9YkGKjlmgUQnVm4I
	M8vpQVkog/GV3BKQYji/ir1R/Zol6Zv1lOgvhtohcT3uJMq5yi5wkb74WQxqhU+9cE49DLudQBY
	CWbWpq8QfZTXLVQ==
X-Received: from iltr6.prod.google.com ([2002:a92:c5a6:0:b0:542:f469:6209])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:23c7:b0:568:e5f:5dbe with SMTP id 5614622812f47-56b97d0f43cmr3278637b6e.61.1794425058062;
 Wed, 11 Nov 2026 11:24:18 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:06 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-3-dmatlack@google.com>
Subject: [RFC PATCH 2/7] vfio: selftests: Verify memory behavior in vfio_pci_find_mem_bar()
From: David Matlack <dmatlack@google.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>, 
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Write and read back test patterns before returning a BAR from
vfio_pci_find_mem_bar(), restoring the original contents and
PCI_COMMAND_MEMORY state afterward.

QEMU's pci-testdev exposes a readable, writable, mmap-capable BAR2
whenever membar=<size> is passed, even if membar-backed=on was omitted
and accesses are dropped as unimplemented MMIO. Probing the BAR upfront
lets callers skip cleanly instead of failing later DMA or fault checks.

Suggested-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/vfio_pci_device.c      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index d5308fe61490..9840463594ab 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -13,6 +13,7 @@
 #include <sys/mman.h>
 
 #include <linux/align.h>
+#include <linux/io.h>
 #include <linux/iommufd.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
@@ -265,6 +266,33 @@ static const struct vfio_pci_mem_bar_desc mem_bar_descs[] = {
 	},
 };
 
+static bool vfio_pci_mem_bar_verify(struct vfio_pci_device *device, void *vaddr)
+{
+	const u64 pattern = 0x55aa55aa55aa55aaULL;
+	u16 orig_cmd;
+	u64 orig;
+	bool ok;
+
+	orig_cmd = vfio_pci_config_readw(device, PCI_COMMAND);
+	if (!(orig_cmd & PCI_COMMAND_MEMORY))
+		vfio_pci_config_writew(device, PCI_COMMAND,
+				       orig_cmd | PCI_COMMAND_MEMORY);
+
+	orig = readq(vaddr);
+	writeq(pattern, vaddr);
+	ok = (readq(vaddr) == pattern);
+	if (ok) {
+		writeq(~pattern, vaddr);
+		ok = (readq(vaddr) == ~pattern);
+	}
+	writeq(orig, vaddr);
+
+	if (!(orig_cmd & PCI_COMMAND_MEMORY))
+		vfio_pci_config_writew(device, PCI_COMMAND, orig_cmd);
+
+	return ok;
+}
+
 bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 			   struct vfio_pci_mem_bar *mem_bar)
 {
@@ -273,6 +301,8 @@ bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 				  VFIO_REGION_INFO_FLAG_WRITE;
 	size_t i;
 
+	min_size = max_t(u64, min_size, sizeof(u64));
+
 	for (i = 0; i < ARRAY_SIZE(mem_bar_descs); i++) {
 		const struct vfio_pci_mem_bar_desc *desc = &mem_bar_descs[i];
 		struct vfio_pci_bar *bar;
@@ -300,6 +330,9 @@ bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 		if (size < min_size)
 			continue;
 
+		if (!vfio_pci_mem_bar_verify(device, bar->vaddr + desc->offset))
+			continue;
+
 		*mem_bar = (struct vfio_pci_mem_bar){
 			.bar = bar,
 			.vaddr = bar->vaddr + desc->offset,
-- 
2.56.0.567.gdb80ae8cd5-goog

