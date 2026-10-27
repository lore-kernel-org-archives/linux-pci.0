Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078829;
	b=L1OmOlhd4sVNibgkGS8P+/7eiecwrvfUHI7acukM10OaEOLiAPM5bK4AmidynIUqD+2h
	 Ef0PY/oMkhfdrHyiPZHHaqG6AiO59+czett0H7EQLen0Du18TqDigjq0K0poKujHAWyA4
	 2IJakOVg3kSWTiRvxcEgKTE2f2nBXkn+TxlETAYJXjJueJf4pGU2fnrPJaXv2wW9S89nk
	 KYDO7FUa+KpqQr+wuHMEZa4mMPU7OAKFGwKWemehOuGndudySNnBJC+db3tIwDS/XMeHw
	 yGleusGIIuoatkFxak6q3wZg8tYT1YBf4d4hkxTDRpKwRfw+MXLK4WSKiG/RDmcNbfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Och6f2ZEGT6g3BOEgcBpc50xNVpdk7rmIE2DR7kHuog=;
	b=vHlXJQIv5lww2ZoFSVTAQbhsUWbpsYJkKkepFajZ3tS6XVEoKx3LXSMVYTPGsZm6C+BR
	 tp1zPlmsqStImi8QEYUzYBrRzO1KMIyggpQ+if92t5Y94VX9eeRkN1pFL8Lojzu6GdQmE
	 x+PHz+KW7jLny7u+uF1xPqXRdZdivWMxZ1iodBZCpwnCjUO0GauGIAQbeFeSXME6PB4hB
	 vtRIcp5WFpEgp1vR3s5g4ln1j/sHd5moeIPj/mnF6gWGh0YCvCdC/bEISLYtigjf/oVZR
	 /3A/KF6IuRyRibvPYslc1V5CA0WrTRJkNtf8ml7WZHaNUJ8J3gBmqN+jrHy8pN4CSCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MAMyseuA;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAB606A323
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12AAB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MAMyseuA
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8246b13cbso33031035ad.2
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078828; x=1793683628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Och6f2ZEGT6g3BOEgcBpc50xNVpdk7rmIE2DR7kHuog=;
        b=MAMyseuA+Th5zBTXBY0Dqw1j+NIctBMKLsophxTIQ61PXElEkbr2Y7RRJqWiatrWVO
         C9TtAPVa3wE8cfRdlRMzme38r8CNt64SSjMJnah53zc1VoLCBp9EzdpiuYegRAUrNel3
         IPZRPzGy4oECllZl0j91EIm8PxHXxH4iz+dtt9Ve1jTiIm7k0FJdEkqkjELilHVqlAGu
         VjQskAngk7fqMwv+XD8yGdDKhJoZbDja2N+bcQPxTmz2fzVQWMmzgDLxS7uuwdhLO3YL
         kFECLHLNqj2KpeJkLDHsm+phmvsY8qVWaY5ftEPumk5wmwrLPwBOeKOj2XYSmiQKdF4t
         Gc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078828; x=1793683628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Och6f2ZEGT6g3BOEgcBpc50xNVpdk7rmIE2DR7kHuog=;
        b=iRT+AeS4Xrxl2HYt7w4oQvpUTfW2p68BegJtTRfCmokx7k3B6S8+VMTJ5Wf95vdZOo
         Pcrye3Q3sUTjI1PzK8UxZtGxT1Q7SjDrw361fclXLL+cvAvXJSP/LFz1iiYxIJqw2n+Q
         JCmDAdhxaQs17mFTVRPHkvuUyz6WsBkA0aFLcoJERUKPdSqdGId2gNkx5ocEQ6IZWt0m
         2V5fcTIAIhR/Vo9mnCqmP3QnWEJGpavQMynb7eAfO5H81tLmNEEUD8K5FE+GrAWozjc+
         wIscLGtG6iZAAS/Xc4TFHgHZX+HoJzcmSzuKGN0qm8pROqkobImJy9D/eDe86Eq7TMs1
         viCw==
X-Forwarded-Encrypted: i=1; AKwUvByKrs1TIB9sXYL9U5AegN5gGsl0QCABYNSotcMGFvYjiWr0w5TGD8Wevud9YGYbgnGQy8PVA9KVmr0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgsm6nUIXvgw7McbXHUPA8WTH7nor5+pZQxf2df6RYwA5xi51x
	TDGnJEqzndu+TKLJP49NSRYaWHY9HPDEchjFaMw7YvWuDAiSvUK4P/sY
X-Gm-Gg: AYBFou0WLRwQH3T4pGObNDSQb2CiS6S+3uy1W1dpl2xOOI8UdVf49dyCUGE6h3SFS72
	JaEftfRDgMvxSjDqCdE/UHGHceiH974XOIoakw8tispwLXfmtBboP3SV8bN9c7xP9rVimroMy6R
	Shp4SZLBOlV+VP/KxEMgnwehVYUGSMs4tfTp5L+KXfjZrlLwg21etHbY/nmXvAr/6D1HFwPByuK
	+yn2y8H3obw+MGtdED2WHuMMFVeK58dKw2GG/gdPiIoqvX6+C9z+l5pqrNXbZssIltMs//F4lqe
	wGGEdxTR3R9P0O26IC0V6b4zSqeJzcx1Hvmo2NBqIluVu8Pc1y384ejGxRYBGeaV+TvF6Wpg/tZ
	mn31nYXSzY0c7W6OdOiVuO/S2A1aVadebBKNgnFbjALP2AvXqylojhvg6LvSm0ypyD08IIIzr8R
	zUMCQuP1j3gXLtGaTOZbojbGJ/VI/Ez2/xHZ7OuYUIMBA+/EHKmFpHqZRPcv0NGJ/tZZKoFsCJY
	xjhVev0TW7PumHUNEb1kqhui38CloAUu5h+dpk7uQLFnwv0aI5oRWcIDny77O2iAPCGeJZWumo=
X-Received: by 2002:a17:903:2c0e:b0:2e6:1c21:158d with SMTP id d9443c01a7336-2ea9c80fc23mr87111855ad.50.1793078828351;
        Mon, 26 Oct 2026 22:27:08 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:27:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	alistair@alistair23.me,
	rust-for-linux@vger.kernel.org,
	jic23@kernel.org
Cc: ojeda@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	bjorn3_gh@protonmail.com,
	gregkh@linuxfoundation.org,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	tmgross@umich.edu,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 11/23] PCI/TSM: Support connecting to PCIe CMA devices
Date: Tue, 27 Oct 2026 15:25:24 +1000
Message-ID: <20261027052536.1722081-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027052536.1722081-1-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

In the next patch we are going to add a PCIe CMA TSM driver, as such we
need to ensure that is_pci_tsm_host() will allow us to connect to CMA
capable devices. These devices don't necessarily has DEVCAP_TEE or IDE
support.

To avoid calling pci_find_doe_mailbox() everytime is_pci_tsm_host() is
called we can cache the CMA support in struct pci_dev and just check
against that.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/crypto/ccp/sev-dev-tsm.c |  4 ++--
 drivers/pci/doe.c                |  3 +++
 drivers/pci/tsm.c                | 38 +++++++++++++++++++++++++++-----
 include/linux/pci-tsm.h          | 32 +++++++++++++++++++++++++--
 include/linux/pci.h              |  1 +
 5 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-dev-tsm.c
index 1d2561628f432..22f2855f397bd 100644
--- a/drivers/crypto/ccp/sev-dev-tsm.c
+++ b/drivers/crypto/ccp/sev-dev-tsm.c
@@ -226,7 +226,7 @@ static struct pci_tsm *dsm_probe(struct tsm_dev *tsmdev, struct pci_dev *pdev)
 {
 	struct sev_device *sev = tsm_dev_to_sev(tsmdev);
 
-	if (is_pci_tsm_host(pdev))
+	if (is_pci_tsm_dsm(pdev))
 		return tio_host_probe(pdev, sev);
 	return NULL;
 }
@@ -237,7 +237,7 @@ static void dsm_remove(struct pci_tsm *tsm)
 
 	pci_dbg(pdev, "TSM disabled\n");
 
-	if (is_pci_tsm_host(pdev)) {
+	if (is_pci_tsm_dsm(pdev)) {
 		struct tio_dsm *dsm = container_of(tsm, struct tio_dsm, tsm.base_tsm);
 
 		pci_tsm_host_destructor(&dsm->tsm);
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 6b5d9ba8e9697..365634fb0df7a 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -871,6 +871,9 @@ void pci_doe_init(struct pci_dev *pdev)
 			pci_doe_destroy_mb(doe_mb);
 		}
 	}
+
+	pdev->doe_cma = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+					     PCI_DOE_FEATURE_CMA);
 }
 
 void pci_doe_destroy(struct pci_dev *pdev)
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 10c9c6696624d..03a84630bd69d 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -88,8 +88,8 @@ static void pci_tsm_walk_fns(struct pci_dev *pdev,
 		if (!pf)
 			continue;
 
-		/* on entry function 0 has already run @cb */
-		if (i > 0)
+		/* the caller is responsible for running @cb on the host itself */
+		if (pf != pdev)
 			cb(pf, data);
 
 		/* walk virtual functions of each pf */
@@ -145,8 +145,8 @@ static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
 			cb(vf, data);
 		}
 
-		/* on exit, caller will run @cb on function 0 */
-		if (i > 0)
+		/* the caller is responsible for running @cb on the host itself */
+		if (pf != pdev)
 			cb(pf, data);
 	}
 }
@@ -175,6 +175,9 @@ static int probe_fn(struct pci_dev *pdev, void *dsm)
 	struct pci_dev *dsm_dev = dsm;
 	const struct pci_tsm_ops *ops = to_pci_tsm_ops(dsm_dev->tsm);
 
+	if (pdev->tsm)
+		return 0;
+
 	pdev->tsm = ops->probe(dsm_dev->tsm->tsm_dev, pdev);
 	pci_dbg(pdev, "setup TSM context: DSM: %s status: %s\n",
 		pci_name(dsm_dev), pdev->tsm ? "success" : "failed");
@@ -287,6 +290,19 @@ static DEVICE_ATTR_RW(connect);
 
 static int remove_fn(struct pci_dev *pdev, void *data)
 {
+	struct pci_dev *host = data;
+	struct pci_tsm_host *tsm_host;
+
+	/*
+	 * Only teardown the security context of functions that belong to the
+	 * DSM being disconnected, leaving any sibling DSM in the same slot
+	 * untouched.
+	 */
+	if (!pdev->tsm || pdev->tsm->dsm_dev != host)
+		return 0;
+
+	tsm_host = to_pci_tsm_host(pdev->tsm);
+	guard(mutex)(&tsm_host->lock);
 	tsm_remove(pdev->tsm);
 	link_sysfs_disable(pdev);
 	return 0;
@@ -299,6 +315,7 @@ static int remove_fn(struct pci_dev *pdev, void *data)
  */
 static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
 {
+	struct pci_dev *host = data;
 	struct pci_tdi *tdi;
 	struct pci_tsm_host *tsm_host;
 
@@ -307,6 +324,14 @@ static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
 	if (!pdev->tsm)
 		return 0;
 
+	/*
+	 * When walking a DSM's dependent functions skip any that belong to a
+	 * different DSM in the same slot. A NULL @host is a direct unbind of
+	 * @pdev itself.
+	 */
+	if (host && pdev->tsm->dsm_dev != host)
+		return 0;
+
 	tsm_host = to_pci_tsm_host(pdev->tsm);
 	guard(mutex)(&tsm_host->lock);
 
@@ -437,7 +462,7 @@ EXPORT_SYMBOL_GPL(pci_tsm_guest_req);
 
 static void pci_tsm_unbind_all(struct pci_dev *pdev)
 {
-	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
+	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, pdev);
 	__pci_tsm_unbind(pdev, NULL);
 }
 
@@ -451,12 +476,13 @@ static void __pci_tsm_disconnect(struct pci_dev *pdev)
 
 	pci_tsm_unbind_all(pdev);
 
+	pci_tsm_walk_fns_reverse(pdev, remove_fn, pdev);
+
 	/*
 	 * disconnect() is uninterruptible as it may be called for device
 	 * teardown
 	 */
 	guard(mutex)(&tsm_host->lock);
-	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
 	ops->disconnect(pdev);
 }
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 950e2c36a4cae..ddaec2168c7e9 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -3,6 +3,7 @@
 #define __PCI_TSM_H
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/sockptr.h>
 
 struct pci_tsm;
@@ -130,8 +131,11 @@ struct pci_tsm_host {
 	struct pci_doe_mb *doe_mb;
 };
 
-/* physical function0 and capable of 'connect' */
-static inline bool is_pci_tsm_host(struct pci_dev *pdev)
+
+/* device is a Device Security Manager (DSM), similar to
+ * is_pci_tsm_host() but doesnt' support CMA
+ */
+static inline bool is_pci_tsm_dsm(struct pci_dev *pdev)
 {
 	if (!pdev)
 		return false;
@@ -163,6 +167,30 @@ static inline bool is_pci_tsm_host(struct pci_dev *pdev)
 	return PCI_FUNC(pdev->devfn) == 0;
 }
 
+/* device is a TSM host and capable of 'connect' */
+static inline bool is_pci_tsm_host(struct pci_dev *pdev)
+{
+	if (!pdev)
+		return false;
+
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	if (pdev->is_virtfn)
+		return false;
+
+	/*
+	 * Report capable if CMA is supported, which can be supported on any PCIe
+	 * device.
+	 */
+#ifdef CONFIG_PCI_DOE
+	if (pdev->doe_cma)
+		return true;
+#endif
+
+	return is_pci_tsm_dsm(pdev);
+}
+
 /**
  * enum pci_tsm_req_scope - Scope of guest requests to be validated by TSM
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 97a1096d5a8ac..26eeb43e34a12 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -566,6 +566,7 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
+	bool		doe_cma;	/* A CMA/SPDM DOE mailbox is present */
 #endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
-- 
2.56.0

