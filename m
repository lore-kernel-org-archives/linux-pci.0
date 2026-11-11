Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425065;
	b=ftsya9vOOlYkxfYpDG2UUXuwoYXH9tGiFFlEKLOHVaNIkuqktzhm8qJtBbvjHZtXBFeA
	 cMbhxRh/2GGD90KJGQf/ruwXOIHJcfBjdB2VgCrz6RS4PwZryTxi93Yj6+ZMJSIoJVz80
	 h96vJycE33ZQ3FNNnxPBmO2nuL5MPBcMuu6P9SAJotDJ+F8F6YGSB2lJ7ZFK0P1WS5jay
	 gcLMtVbP8tH5h45Yi9zJNd7bPkpW3IVnOLusnRJs425YojpqR9vPYaca8fnqZOGmSqYES
	 W3WFdDAxtfOyq/hzUR6UnLabDz/p1MxKZnQGY+xFdOD350slZ4gqkrOmVVzutygONeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=S4+DQ/5hS2/5UfXO0mi1ZgFeMRsr05x8y1FYZlBsi/k=;
	b=cwsas+moEHE70A8QaSMtcH7ZSHV2EcI9W3jI/fpPGpvQPrSthsTLMipbT34bLucv7XwG
	 jwtYguDgGqJy4y9ZbhvXCHgC9STiQz7UJofTFUQSbASK9CVULMrDDBqtcYGLH/9U305Wq
	 dOC7yV++TwtSFbLFmr6u6IV3V5EKYEKtPBHaQ4gDOpZ4yyrt09lhaUwjWzC7oK7BvlvGY
	 INzxnN1gxFJh1C579kIs/kJnur1t+jeI2Jnhtel2igOxabDsbyvLmJPnvQ6gjBfmGlwtR
	 uoW96gxrd89NpQP7HUYYKz9nCO2mZTx7v5UWNKR+AfgrVFBcbeqNT3/9xf049v2Sjpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="lM/CPmgi";
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF52606F385
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 19:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DF52606F385
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lM/CPmgi
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-8520e83f715so3842603a34.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 11:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794425063; x=1795029863; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S4+DQ/5hS2/5UfXO0mi1ZgFeMRsr05x8y1FYZlBsi/k=;
        b=lM/CPmgi2MxnhCIljbY1J6j5HJCMMekv0//LIx4rqPP+rmTASzEwn/BZTlI+Fvfwof
         f5lzQB0rVXFPhPx5zlOmCXnEZsPPgqwyajdOHm2HucaXGcohS4WqmpNnnr0r28fxAkpE
         lg/UcKD+gr2bXmw6OtsYfNTumii+2oGuZptwjhXEy2C8uOHAWNG0YYDFtvZLbBscAarT
         KRjZxsb4x9C8/ukL2U6mxnyYxFXQQR0ZKVLlW4ebshXJs56UjXEXgV5bCqzi520CgmbZ
         ytScVeEa8/BkQ5DOx6FUZPGNcU6+g53Tsl0ljpXVfOyoViGc3s7rFDA5dCAACnp88HpA
         e5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425063; x=1795029863;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S4+DQ/5hS2/5UfXO0mi1ZgFeMRsr05x8y1FYZlBsi/k=;
        b=V/LnavSwkLjSadwJRg7OOrs9dJ1XAmpc0M20ipeAFBy9syFX6RT0oBg9zXlCVxdU9w
         NFdSj64dNCejoL9eUFyyy8EMna6ELA9GLf/gy0bGMXP7nHYfV8DEf0ZItDb54+I0LB23
         krw6UNXZI0yDuB+fu5MR0F50nvBT5qi79sF5XJI6nFfCRXGL3NQDWI+EdIi8JLZIxAgM
         rTNBDhsdXK4KN2UFRS07ANJl5DO/kHPyPqTVLMSswhGKGOvOf98js2GrL3YKHFmHSoQ5
         h/JPCB4493bC4wnL0OsWdIfmDcA+uDzOrP1s6CWccYj/1Tf0KLZ+KKFot6FNP53Ie7ZD
         EaBQ==
X-Forwarded-Encrypted: i=1; AL+hErHaBjBOPzkF5R00DNxKmanYeR7knayMoVsH2o5PItViw3sQ+V6Zyt9u1rV5IEdC3dRv6+w1Aao0hQs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CfXdLPFFgerc41H+n4zHh5m9+729yW6w5dPmmhMKwLTPebvbD
	vI8D3uRjTIVpaMTywOefu5ty3LCtIw6HAPgy4hWUAxDYTlNPtVBiyg28EVE2TTbrZrE6AMeKIRT
	8U356f+HSRyOD8Q==
X-Received: from jabll4.prod.google.com ([2002:a05:6638:9804:b0:61f:e4cd:8716])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:318a:b0:4af:5d69:1cb4 with SMTP id 5614622812f47-56b96ad0615mr3028788b6e.15.1794425063307;
 Wed, 11 Nov 2026 11:24:23 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:10 +0000
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
Message-ID: <20261111192411.4133780-7-dmatlack@google.com>
Subject: [RFC PATCH 6/7] vfio: selftests: Add vfio_pci_find_p2p_pair() helper
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

Add vfio_pci_find_p2p_pair() to locate an initiator device with memcpy
driver support and a distinct target device with a memory BAR of at
least min_bar_size bytes from an array of VFIO PCI devices.

Factor out vfio_pci_has_p2p_path() as the central place to validate PCI
topology and P2P DMA reachability between the two devices in the future.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  8 ++++
 .../selftests/vfio/lib/vfio_pci_device.c      | 48 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index fd130f680a2d..9bda93712859 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -42,6 +42,12 @@ struct vfio_pci_device {
 	struct vfio_pci_driver driver;
 };
 
+struct vfio_pci_p2p_pair {
+	struct vfio_pci_device *initiator;
+	struct vfio_pci_device *target;
+	struct vfio_pci_mem_bar mem_bar;
+};
+
 #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 
@@ -171,6 +177,8 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 
 bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 			   struct vfio_pci_mem_bar *mem_bar);
+bool vfio_pci_find_p2p_pair(struct vfio_pci_device **devices, int nr_devices,
+			    u64 min_bar_size, struct vfio_pci_p2p_pair *pair);
 
 int __vfio_pci_dmabuf_create(struct vfio_pci_device *device, u32 region_index,
 			     u64 offset, u64 length, u32 open_flags);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index eca6eb13d7f0..16fc98ed170b 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -378,6 +378,54 @@ bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 	return false;
 }
 
+static bool vfio_pci_has_p2p_path(struct vfio_pci_device *initiator,
+				  struct vfio_pci_device *target)
+{
+	/*
+	 * TODO: Check PCI topology / ACS / host bridge support to verify that
+	 * P2P DMA transactions from @initiator can reach @target.
+	 */
+	return initiator != target;
+}
+
+bool vfio_pci_find_p2p_pair(struct vfio_pci_device **devices, int nr_devices,
+			    u64 min_bar_size, struct vfio_pci_p2p_pair *pair)
+{
+	struct vfio_pci_mem_bar mem_bar;
+	int i, j;
+
+	for (i = 0; i < nr_devices; i++) {
+		struct vfio_pci_device *initiator = devices[i];
+		const struct vfio_pci_driver_ops *ops = initiator->driver.ops;
+
+		if (!ops || !ops->memcpy_start || !ops->memcpy_wait)
+			continue;
+
+		for (j = 0; j < nr_devices; j++) {
+			struct vfio_pci_device *target = devices[j];
+
+			if (i == j)
+				continue;
+
+			if (!vfio_pci_has_p2p_path(initiator, target))
+				continue;
+
+			if (!vfio_pci_find_mem_bar(target, min_bar_size,
+						   &mem_bar))
+				continue;
+
+			*pair = (struct vfio_pci_p2p_pair){
+				.initiator = initiator,
+				.target = target,
+				.mem_bar = mem_bar,
+			};
+			return true;
+		}
+	}
+
+	return false;
+}
+
 void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 			    size_t config, size_t size, void *data)
 {
-- 
2.56.0.567.gdb80ae8cd5-goog

