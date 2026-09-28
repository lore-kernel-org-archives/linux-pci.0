Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08092328B5E
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557982; cv=none; b=CYKcI0f/uNrbR6OFKZ1BBFKCV8XKsKLCiYsh564ubGMn7gZKdxvWcI+OKgKkQhpMXoQQiyoCMYeraBwfGFwJhso7/3Ep/LZQ52Yg7D0thstRGuwU0pGwP9WZsIGAIFtEVFWyTABj3RrNXg0baOBCoXGm9occnIintT7/NZNVgFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557982; c=relaxed/simple;
	bh=dgC7dHfjofLQlW1awkxyiX6kADLJw0apUEL8vcJoq7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiBoruT1KE6ZlMaXwU72dN3n7XeA80eRcCFykV3g/kT4lUia3QYtd5WafWCuvEfP/tCLd538Hm4g1KBs1pIUK8IUfK48xepHP9poN/f8j4XpqmyLH8KwEWMYofjSXx22mLASSQgNzdN/g3tNgEPAaXDkNCj/2yteDPz1typp9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mf8lUqmS; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf8lUqmS"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a147688bso1817271a91.1
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557980; x=1791162780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L0zlHs2DBh4YLV9wwkwNee3kdbegkG/dhFOoXnALpfQ=;
        b=Mf8lUqmSaklTEvVCpVYaYM83lTcwF89XXzHpSLgHu8Su8d9CVsKD5pYFH0Lq1POeYY
         PKZeJwaP4pE3iN/WDBxrfI/C39+eVTMZ25R9hwXXmbwRhX7oWRnLTTibIiV0aKCpSqv5
         vlAXoDTFfzNMh6XjhbkPZ5dOCGUlYXml3RSNxxtfoxgnPglgJh2TTR6r9HeRdTppRVr7
         mdTYOfkIhSDlRhuFt0t/ZxOuXWFZr7OCaBBR1x1uVmNER1uMeKz7BgXu5Rq5zK3gsRwy
         koLpI/WEtXgW5K1K0F+yYvGV+We/lW0umY5gm3lekOdOtqA/K8Y+o7/C7YRzqcDa1t83
         s34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557980; x=1791162780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0zlHs2DBh4YLV9wwkwNee3kdbegkG/dhFOoXnALpfQ=;
        b=TK7jbMWVWmzuUTrAHH7E1stz3nmjuT/Sfi/gTqIhdC7ukWt9/qIa3zERaCVqbLCwtm
         /1XbV4FfzFOrvy7ft/HnK24L+207rspWeBx/1G7AhkphFo37Mf/mKiKPnzqLct//PJ6i
         /cJlg9oqbnevBDOSgpawddN5ikccUvyRktiV5dcLYIzFPJd3s1elCuZAyhekJUvRsQEM
         BT3jeAjN3FtV/mReeIbebapTo8sKc5749sgxEXxB4q9hXuDvg2mCPCBwWLAsA3XoSSQs
         N3DSk4zOdZoQZ6124y7fll/ng2hzvtLdcCjBoaG0Peymeho8aG1Igmv5WPecDk5kRqsG
         38jA==
X-Forwarded-Encrypted: i=1; AKwUvBxrw+mcSVOUT+7a7XV52F1e5lsjsVHrqlxiX7muuaqpuUL2Q9FISs1S4RymYhnF2GmarRkVFcUMOng=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbnCWNzRsm4sQ0WKKy8HeSM0mZxivEXVSQjYi94kNDiZsJRVFt
	4NXCFLs8kVL1zQquVulK7y58VJkLQwX2gDUWbndYog8ys3U9PzRPyPRF
X-Gm-Gg: AYBFou2+ESm03GJkuKPXd1p96pDDD2ex76DszHQhopRAVzn8jpX1YoATrdfiTMGpNmD
	NxLI6ZL1Mosx7JygUQVZRwx/h1FdzNGTGyz3Q5akyDjeEKhAEV1xivWSW3lR29SVCBkES66PpCp
	w2zDohzofytE6rx3EPjSyL8rdV29FBuKfeMbupg17xC29ArWXJIdGU1sP6tMqVPlZS8OQY20iLt
	RgskQjZV4joV041wk1OlsUsl/XyyS9l5RKvFvqbfpXX7AG5ix2v08ubVVZBe+U/qWSZJW0TakDs
	FYh8i3gL/J69qilwC6pCkIBAvlOtFioq4Lx2+SlzgaBGPSBDqrqbBe+xkCHMnIX7gsaKi24I0NH
	FEBRATZrFykd9r4+jC0cJahiMJ9XvoRUpBvBaaWkXp138sLpDaSZV/+bBWwtbCf/Zho4TqyD+3l
	GwnpVMLBMlT72droBjZm42xUk9kGF7yCbb0Ysm5a5bXtpSu23NDwiD3oERqCezJuofz7RsfVVKl
	x9CvL4AO6RslXvF
X-Received: by 2002:a17:90a:ec83:b0:39e:21a7:5dff with SMTP id 98e67ed59e1d1-3a098d453aamr9114828a91.11.1790557980356;
        Sun, 27 Sep 2026 18:13:00 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:12:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: lukas@wunner.de,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	alistair@alistair23.me,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: wilfred.mallawa@wdc.com,
	a.hindborg@kernel.org,
	gregkh@linuxfoundation.org,
	alex.gaynor@gmail.com,
	alistair23@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	gary@garyguo.net,
	ojeda@kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 12/22] PCI/TSM: Support connecting to PCIe CMA devices
Date: Mon, 28 Sep 2026 11:11:13 +1000
Message-ID: <20260928011123.450800-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
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
index 1d2561628f43..22f2855f397b 100644
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
index ac95b1d2d999..6a59969bd52f 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -870,6 +870,9 @@ void pci_doe_init(struct pci_dev *pdev)
 			pci_doe_destroy_mb(doe_mb);
 		}
 	}
+
+	pdev->doe_cma = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+					     PCI_DOE_FEATURE_CMA);
 }
 
 void pci_doe_destroy(struct pci_dev *pdev)
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 10c9c6696624..03a84630bd69 100644
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
index 950e2c36a4ca..ddaec2168c7e 100644
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
index d31a8d107b1e..cb13b40952b4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -565,6 +565,7 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
+	bool		doe_cma;	/* A CMA/SPDM DOE mailbox is present */
 #endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
-- 
2.55.0

