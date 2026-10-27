Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078822;
	b=bFXgkp0s6j/ke8zXubpjWeRmFIjFVSgsFJBirR0Yot9oAIimg+b5ilPn+5W8nHjhwi9L
	 073tZo4d5zYwI8uKQVZy4DRwhAPNYzjplvaefbP09diMfgWo0ZsekxzgFK9jZzjLvTvFN
	 THv32uu4v1cbiykDihsN/0S3O10tWE9AxIJCwarJHoMR3GYBBdvYRr5LZTDm/iprdfb4J
	 KwlkdvvXoWqunMNJeujL5lTRH/0Ts9g1QtMhFnzJAb7lHfj/hvN2PEdMjdgVZdYiMq2Pb
	 /EBcuxfdThH7eBDpD/pMVW2bcGOfPzxZG6LkcgNBQFD9vk2RyLAMJZNrLJ+GhBXOuyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fCfsZ5gVb41Wz9jN9lzm8Kqs7XyEi/INOv6bo1Lw1Qk=;
	b=dmk3vxIH2OHCNId/5y1nWmtnuJZQKOhI456PmpjFAf8Ef7uhlkBeCp9xK1gSToEknT5p
	 IvLY8Vtqdc9jZSzIQHlTB/tZkj3AVDzJU2t0dhqBgjXn+NupPymUQk35GJR6GT721tMNR
	 fKIrHBfnL4+nB4er/L0gqTdEAK6OGkT45ggfNKpXNNbS7wzpSNiYImY0qaprl/BimfNO/
	 kPWDVAUKhmICxkzcicXEed4ZHDPelcEciOiBtzqV8WajMOJpyuVYjOdC2wLN97AoMx/4W
	 +K+mqoI1g2fcKlBXj6l64SrGycCdITEmMgZSFseuOdpaq+v+34Dy6kcJawXERGSQkxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g6TYH8OH;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E3606A31F
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF5E3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g6TYH8OH
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e98798cbddso14728465ad.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078821; x=1793683621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fCfsZ5gVb41Wz9jN9lzm8Kqs7XyEi/INOv6bo1Lw1Qk=;
        b=g6TYH8OHROwT7o7965IuGDUEiOIIsCk5Uzj4zj662W6e0D9uWResIJFB19E0L0SFzJ
         ywOCRz/nBfowjduF8ewqZ2sWLaerDrSWPKir/b8wBWT+9CIF3hYXZcdDaFDqN4FrMSMS
         mC1WCKKQ+WztEdXezhQ3Wsrcx9Rlkx7pMysdFbkWU2MluoDhnXfDfzcXfJO3A0AUGaOd
         j436A776lCaNUTPXVxjgeOZxZ+t4kCpIWmwSDN55oMwPAwAXK/I4x312CltSGDqTvok6
         2eYumfGCbs7k6Unhwwgq5uzQT1+lhHxCATA3OgUqmMeqmqspjTi3XQWpeWsMwRc1R2BL
         Y5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078821; x=1793683621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fCfsZ5gVb41Wz9jN9lzm8Kqs7XyEi/INOv6bo1Lw1Qk=;
        b=IK9twOSSwhCaYEOG6LPZ2r/uF/9Z3CiE9pOQ5BHKoXkhTy/ACZdO0ncADg2tRrofJ4
         6gqCRpH7McN5+YfINTHg4MWxl1RkGN32iKLKv9ZZBPINbfWmwk/VVgf26C6Ngv/gUFjz
         dp2VlScKBPZC21mu3Kz9G/my6y7D4Vg8lkJ5cAaGh1DNtEaU08go1A1jGvPoN/Z+M94w
         vAD+NXwEXhLiLlN2kVoLwyDDEsg4royXxwotpGNxXlz8ESNW6C0ZVMX/qhG0o0j+vBCt
         67Se99l6wbdRr2msCodsa9RhMZ0caPdyUxFFo1PM7uCoBDI6kRWERRFUtc+rbJxY/gfJ
         p/rQ==
X-Forwarded-Encrypted: i=1; AKwUvByyO8VuEucGCUAhzzdQ420YkgNYo6iUKEGuEHJQqzo3gqnmn2NCNGCwDTwX3lxcT6ZIFpkSCP7AeC4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0dDZIwTm3RX/YEhrwoQUkMfXiA+QjnynSEE/92Y8CjzmK3CRh
	uWFFi6AAs3hs2ofAxzHsuHOwaMyDTsrJUN7WFjeSdlDNGiGy7unKr3A0
X-Gm-Gg: AYBFou3Hesoo+r9haetK2T3jhb2xxyaqsFInujAhK8smyiHY2DHraPXMebSvUzbrR87
	0o8OMo9eRrxbYFgGJ0ZRUqp/boQTw4UKOnNrh6bjEXFZOQht5PT9beeXw1iQPAJ28tcyi6IL/Y0
	guYQS/j8Y+dv1qoD5nEG2/Yqht47v6rRSFvrX1MTtzpNJCjMXTnwymrN0DDkhM4ifjYrc0E3w0p
	XYmHozoOEppstZSLza9AB5trr3xhOYZbApfe6pojga6enxfIyisSHMNoCyV1Pz79ykMzljCTVox
	6CZM93FiwT++MCY6k3E6/5GXnI2odGoEunx767k0PtIaWHeDueQLdDOYYkYaDZ39QJd2BfK4oCP
	Yra1bn36DXCXnYsmLK0lD7nbRuaZURUbYyu2S+JTF+iE3FUthuJ22EgGh0vmIu2FdkkPrcdOLOz
	5/3ggzM0WDPZ8KakQobeMyDTZLkK/4gWYWS38eTxPpOG9Y0RpprlCewJHMOah4qp+xcpnNZFpqV
	zW4Ph1qUckZJ36cVt/emmXlBoICTAhfntMC3wISZWy9x0BUknajvwjM3vSHrtIyC7gKRQ18Fw==
X-Received: by 2002:a17:902:dad0:b0:2e5:3451:565 with SMTP id d9443c01a7336-2ea9c840814mr75035045ad.33.1793078821207;
        Mon, 26 Oct 2026 22:27:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:27:00 -0700 (PDT)
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
Subject: [PATCH v5 10/23] PCI/TSM: Rename pf0 to host
Date: Tue, 27 Oct 2026 15:25:23 +1000
Message-ID: <20261027052536.1722081-11-alistair.francis@wdc.com>
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

Rename pci_tsm_pf0 to pci_tsm_host (and rename variables and function
names from pf0 to host) as part of converting pci_tsm_host
to be any device that knows how to speak any of CMA, IDE, or
TDISP.

This commit just renames the functions and provides no functional
change. That will happen in the next commit.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/crypto/ccp/sev-dev-tio.h |  4 +-
 drivers/crypto/ccp/sev-dev-tsm.c | 12 ++---
 drivers/pci/tsm.c                | 84 ++++++++++++++++----------------
 include/linux/pci-tsm.h          | 18 ++++---
 4 files changed, 61 insertions(+), 57 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev-tio.h b/drivers/crypto/ccp/sev-dev-tio.h
index 67512b3dbc538..78d598686487f 100644
--- a/drivers/crypto/ccp/sev-dev-tio.h
+++ b/drivers/crypto/ccp/sev-dev-tio.h
@@ -53,9 +53,9 @@ struct tsm_dsm_tio {
 	struct pci_ide *ide[TIO_IDE_MAX_TC];
 };
 
-/* Describes TSM structure for PF0 pointed by pci_dev->tsm */
+/* Describes TSM structure for the link host pointed by pci_dev->tsm */
 struct tio_dsm {
-	struct pci_tsm_pf0 tsm;
+	struct pci_tsm_host tsm;
 	struct tsm_dsm_tio data;
 	struct sev_device *sev;
 };
diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-dev-tsm.c
index 48df8c579c74d..1d2561628f432 100644
--- a/drivers/crypto/ccp/sev-dev-tsm.c
+++ b/drivers/crypto/ccp/sev-dev-tsm.c
@@ -205,7 +205,7 @@ static int stream_alloc(struct pci_dev *pdev, struct pci_ide **ide,
 	return 0;
 }
 
-static struct pci_tsm *tio_pf0_probe(struct pci_dev *pdev, struct sev_device *sev)
+static struct pci_tsm *tio_host_probe(struct pci_dev *pdev, struct sev_device *sev)
 {
 	struct tio_dsm *dsm __free(kfree) = kzalloc_obj(*dsm);
 	int rc;
@@ -213,7 +213,7 @@ static struct pci_tsm *tio_pf0_probe(struct pci_dev *pdev, struct sev_device *se
 	if (!dsm)
 		return NULL;
 
-	rc = pci_tsm_pf0_constructor(pdev, &dsm->tsm, sev->tsmdev);
+	rc = pci_tsm_host_constructor(pdev, &dsm->tsm, sev->tsmdev);
 	if (rc)
 		return NULL;
 
@@ -226,8 +226,8 @@ static struct pci_tsm *dsm_probe(struct tsm_dev *tsmdev, struct pci_dev *pdev)
 {
 	struct sev_device *sev = tsm_dev_to_sev(tsmdev);
 
-	if (is_pci_tsm_pf0(pdev))
-		return tio_pf0_probe(pdev, sev);
+	if (is_pci_tsm_host(pdev))
+		return tio_host_probe(pdev, sev);
 	return NULL;
 }
 
@@ -237,10 +237,10 @@ static void dsm_remove(struct pci_tsm *tsm)
 
 	pci_dbg(pdev, "TSM disabled\n");
 
-	if (is_pci_tsm_pf0(pdev)) {
+	if (is_pci_tsm_host(pdev)) {
 		struct tio_dsm *dsm = container_of(tsm, struct tio_dsm, tsm.base_tsm);
 
-		pci_tsm_pf0_destructor(&dsm->tsm);
+		pci_tsm_host_destructor(&dsm->tsm);
 		kfree(dsm);
 	}
 }
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 5fdcd7f2e8207..10c9c6696624d 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -45,22 +45,22 @@ static inline bool has_tee(struct pci_dev *pdev)
 	return pdev->devcap & PCI_EXP_DEVCAP_TEE;
 }
 
-/* 'struct pci_tsm_pf0' wraps 'struct pci_tsm' when ->dsm_dev == ->pdev (self) */
-static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *tsm)
+/* 'struct pci_tsm_host' wraps 'struct pci_tsm' when ->dsm_dev == ->pdev (self) */
+static struct pci_tsm_host *to_pci_tsm_host(struct pci_tsm *tsm)
 {
 	/*
 	 * All "link" TSM contexts reference the device that hosts the DSM
 	 * interface for a set of devices. Walk to the DSM device and cast its
-	 * ->tsm context to a 'struct pci_tsm_pf0 *'.
+	 * ->tsm context to a 'struct pci_tsm_host *'.
 	 */
-	struct pci_dev *pf0 = tsm->dsm_dev;
+	struct pci_dev *host = tsm->dsm_dev;
 
-	if (!is_pci_tsm_pf0(pf0) || !is_dsm(pf0)) {
+	if (!is_pci_tsm_host(host) || !is_dsm(host)) {
 		pci_WARN_ONCE(tsm->pdev, 1, "invalid context object\n");
 		return NULL;
 	}
 
-	return container_of(pf0->tsm, struct pci_tsm_pf0, base_tsm);
+	return container_of(host->tsm, struct pci_tsm_host, base_tsm);
 }
 
 static void tsm_remove(struct pci_tsm *tsm)
@@ -186,7 +186,7 @@ static int probe_fn(struct pci_dev *pdev, void *dsm)
 static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 {
 	int rc;
-	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tsm_host *tsm_host;
 	const struct pci_tsm_ops *ops = tsm_dev->pci_ops;
 	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(tsm_dev, pdev);
 
@@ -197,10 +197,10 @@ static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 		return -ENXIO;
 
 	pdev->tsm = pci_tsm;
-	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+	tsm_host = to_pci_tsm_host(pdev->tsm);
 
 	/* mutex_intr assumes connect() is always sysfs/user driven */
-	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
+	ACQUIRE(mutex_intr, lock)(&tsm_host->lock);
 	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
 		return rc;
 
@@ -300,15 +300,15 @@ static int remove_fn(struct pci_dev *pdev, void *data)
 static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
 {
 	struct pci_tdi *tdi;
-	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tsm_host *tsm_host;
 
 	lockdep_assert_held(&pci_tsm_rwsem);
 
 	if (!pdev->tsm)
 		return 0;
 
-	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
-	guard(mutex)(&tsm_pf0->lock);
+	tsm_host = to_pci_tsm_host(pdev->tsm);
+	guard(mutex)(&tsm_host->lock);
 
 	tdi = pdev->tsm->tdi;
 	if (!tdi)
@@ -341,7 +341,7 @@ EXPORT_SYMBOL_GPL(pci_tsm_unbind);
  */
 int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
 {
-	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tsm_host *tsm_host;
 	struct pci_tdi *tdi;
 
 	if (!kvm)
@@ -355,8 +355,8 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
 	if (!is_link_tsm(pdev->tsm->tsm_dev))
 		return -ENXIO;
 
-	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
-	guard(mutex)(&tsm_pf0->lock);
+	tsm_host = to_pci_tsm_host(pdev->tsm);
+	guard(mutex)(&tsm_host->lock);
 
 	/* Resolve races to bind a TDI */
 	if (pdev->tsm->tdi) {
@@ -404,7 +404,7 @@ ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
 			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
 			  size_t out_len, u64 *tsm_code)
 {
-	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tsm_host *tsm_host;
 	struct pci_tdi *tdi;
 	int rc;
 
@@ -422,8 +422,8 @@ ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
 	if (!is_link_tsm(pdev->tsm->tsm_dev))
 		return -ENXIO;
 
-	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
-	ACQUIRE(mutex_intr, ops_lock)(&tsm_pf0->lock);
+	tsm_host = to_pci_tsm_host(pdev->tsm);
+	ACQUIRE(mutex_intr, ops_lock)(&tsm_host->lock);
 	if ((rc = ACQUIRE_ERR(mutex_intr, &ops_lock)))
 		return rc;
 
@@ -443,7 +443,7 @@ static void pci_tsm_unbind_all(struct pci_dev *pdev)
 
 static void __pci_tsm_disconnect(struct pci_dev *pdev)
 {
-	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+	struct pci_tsm_host *tsm_host = to_pci_tsm_host(pdev->tsm);
 	const struct pci_tsm_ops *ops = to_pci_tsm_ops(pdev->tsm);
 
 	/* disconnect() mutually exclusive with subfunction pci_tsm_init() */
@@ -455,7 +455,7 @@ static void __pci_tsm_disconnect(struct pci_dev *pdev)
 	 * disconnect() is uninterruptible as it may be called for device
 	 * teardown
 	 */
-	guard(mutex)(&tsm_pf0->lock);
+	guard(mutex)(&tsm_host->lock);
 	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
 	ops->disconnect(pdev);
 }
@@ -494,7 +494,7 @@ static ssize_t bound_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tsm_host *tsm_host;
 	struct pci_tsm *tsm;
 	int rc;
 
@@ -505,9 +505,9 @@ static ssize_t bound_show(struct device *dev,
 	tsm = pdev->tsm;
 	if (!tsm)
 		return sysfs_emit(buf, "\n");
-	tsm_pf0 = to_pci_tsm_pf0(tsm);
+	tsm_host = to_pci_tsm_host(tsm);
 
-	ACQUIRE(mutex_intr, ops_lock)(&tsm_pf0->lock);
+	ACQUIRE(mutex_intr, ops_lock)(&tsm_host->lock);
 	if ((rc = ACQUIRE_ERR(mutex_intr, &ops_lock)))
 		return rc;
 
@@ -547,7 +547,7 @@ static bool pci_tsm_link_group_visible(struct kobject *kobj)
 	if (!pci_is_pcie(pdev))
 		return false;
 
-	if (is_pci_tsm_pf0(pdev))
+	if (is_pci_tsm_host(pdev))
 		return true;
 
 	/*
@@ -572,14 +572,14 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
 		struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
 		if (attr == &dev_attr_bound.attr) {
-			if (is_pci_tsm_pf0(pdev) && has_tee(pdev))
+			if (is_pci_tsm_host(pdev) && has_tee(pdev))
 				return attr->mode;
 			if (pdev->tsm && has_tee(pdev->tsm->dsm_dev))
 				return attr->mode;
 		}
 
 		if (attr == &dev_attr_dsm.attr) {
-			if (is_pci_tsm_pf0(pdev))
+			if (is_pci_tsm_host(pdev))
 				return attr->mode;
 			if (pdev->tsm && has_tee(pdev->tsm->dsm_dev))
 				return attr->mode;
@@ -587,7 +587,7 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
 
 		if (attr == &dev_attr_connect.attr ||
 		    attr == &dev_attr_disconnect.attr) {
-			if (is_pci_tsm_pf0(pdev))
+			if (is_pci_tsm_host(pdev))
 				return attr->mode;
 		}
 	}
@@ -662,7 +662,7 @@ static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
 	struct device *grandparent;
 	struct pci_dev *uport;
 
-	if (is_pci_tsm_pf0(pdev))
+	if (is_pci_tsm_host(pdev))
 		return pdev;
 
 	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
@@ -735,13 +735,13 @@ int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
 EXPORT_SYMBOL_GPL(pci_tsm_link_constructor);
 
 /**
- * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' (DSM) initialization
- * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
+ * pci_tsm_host_constructor() - common 'struct pci_tsm_host' (DSM) initialization
+ * @pdev: TSM host PCI device (as indicated by is_pci_tsm_host())
  * @tsm: context to initialize
  * @tsm_dev: Platform TEE Security Manager, initiator of security operations
  */
-int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
-			    struct tsm_dev *tsm_dev)
+int pci_tsm_host_constructor(struct pci_dev *pdev, struct pci_tsm_host *tsm,
+			     struct tsm_dev *tsm_dev)
 {
 	mutex_init(&tsm->lock);
 	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
@@ -753,13 +753,13 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
 
 	return pci_tsm_link_constructor(pdev, &tsm->base_tsm, tsm_dev);
 }
-EXPORT_SYMBOL_GPL(pci_tsm_pf0_constructor);
+EXPORT_SYMBOL_GPL(pci_tsm_host_constructor);
 
-void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *pf0_tsm)
+void pci_tsm_host_destructor(struct pci_tsm_host *host_tsm)
 {
-	mutex_destroy(&pf0_tsm->lock);
+	mutex_destroy(&host_tsm->lock);
 }
-EXPORT_SYMBOL_GPL(pci_tsm_pf0_destructor);
+EXPORT_SYMBOL_GPL(pci_tsm_host_destructor);
 
 int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
@@ -780,7 +780,7 @@ int pci_tsm_register(struct tsm_dev *tsm_dev)
 	/* On first enable, update sysfs groups */
 	if (is_link_tsm(tsm_dev) && pci_tsm_link_count++ == 0) {
 		for_each_pci_dev(pdev)
-			if (is_pci_tsm_pf0(pdev))
+			if (is_pci_tsm_host(pdev))
 				link_sysfs_enable(pdev);
 	} else if (is_devsec_tsm(tsm_dev)) {
 		pci_tsm_devsec_count++;
@@ -815,7 +815,7 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 	 * skipped if the device itself is being removed since sysfs goes away
 	 * naturally at that point
 	 */
-	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev) && !pci_tsm_link_count)
+	if (is_link_tsm(tsm_dev) && is_pci_tsm_host(pdev) && !pci_tsm_link_count)
 		link_sysfs_disable(pdev);
 
 	/* Nothing else to do if this device never attached to the departing TSM */
@@ -828,7 +828,7 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 	else if (tsm_dev != tsm->tsm_dev)
 		return;
 
-	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev))
+	if (is_link_tsm(tsm_dev) && is_pci_tsm_host(pdev))
 		pci_tsm_disconnect(pdev);
 	else
 		pci_tsm_fn_exit(pdev);
@@ -885,12 +885,12 @@ void pci_tsm_unregister(struct tsm_dev *tsm_dev)
 int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 			 size_t req_sz, void *resp, size_t resp_sz)
 {
-	struct pci_tsm_pf0 *tsm;
+	struct pci_tsm_host *tsm;
 
-	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
+	if (!pdev->tsm || !is_pci_tsm_host(pdev))
 		return -ENXIO;
 
-	tsm = to_pci_tsm_pf0(pdev->tsm);
+	tsm = to_pci_tsm_host(pdev->tsm);
 	if (!tsm->doe_mb)
 		return -ENXIO;
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index a6435aba03f9b..950e2c36a4cae 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -40,7 +40,7 @@ struct pci_tsm_ops {
 	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
 	 * mutual exclusion of @connect and @disconnect. @connect and
 	 * @disconnect additionally run under the DSM lock (struct
-	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
+	 * pci_tsm_host::lock) as well as @probe and @remove of the subfunctions.
 	 * @bind, @unbind, and @guest_req run under pci_tsm_rwsem held for read
 	 * and the DSM lock.
 	 */
@@ -115,19 +115,23 @@ struct pci_tsm {
 };
 
 /**
- * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
+ * struct pci_tsm_host - TSM host link context (CMA, IDE, or TDISP)
  * @base_tsm: generic core "tsm" context
  * @lock: mutual exclustion for pci_tsm_ops invocation
  * @doe_mb: PCIe Data Object Exchange mailbox
+ *
+ * The host of a TSM link is the device that knows how to speak
+ * CMA, IDE, or TDISP. For TDISP / IDE that is a Physical Function 0.
+ * For CMA-only it is a CMA DOE mailbox.
  */
-struct pci_tsm_pf0 {
+struct pci_tsm_host {
 	struct pci_tsm base_tsm;
 	struct mutex lock;
 	struct pci_doe_mb *doe_mb;
 };
 
 /* physical function0 and capable of 'connect' */
-static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
+static inline bool is_pci_tsm_host(struct pci_dev *pdev)
 {
 	if (!pdev)
 		return false;
@@ -204,9 +208,9 @@ int pci_tsm_register(struct tsm_dev *tsm_dev);
 void pci_tsm_unregister(struct tsm_dev *tsm_dev);
 int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
 			     struct tsm_dev *tsm_dev);
-int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
-			    struct tsm_dev *tsm_dev);
-void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
+int pci_tsm_host_constructor(struct pci_dev *pdev, struct pci_tsm_host *tsm,
+			     struct tsm_dev *tsm_dev);
+void pci_tsm_host_destructor(struct pci_tsm_host *tsm);
 int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 			 size_t req_sz, void *resp, size_t resp_sz);
 int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
-- 
2.56.0

