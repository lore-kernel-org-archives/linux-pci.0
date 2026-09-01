Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99EE39A073
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224740; cv=none; b=RudcrwIE6KQVzKEMe4DdEHU/OdxLFMFtqxYXtv3gSoBDzxYLU7U0AY3vWyW/00fuHsOh/sZMfau/rqEmkN+4LCWEu9R68pCHlRtR8uPXgZpp7CclQeR9P9t1W9SIfrTn5ka+ARMvRHv2LrltT6b/CX7DkX8+DT9fGou3EeV8SLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224740; c=relaxed/simple;
	bh=rgSGcz893ueiGfuyqqAZO9aqjoYjmJCcUYsDt8Smdf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqrCoMg/yZUmQepM/bQ2LvspxxfF7WlFvz0TXoY/IHgkTwPKQOmp51Erip0gW7jNC7NdI9heTXtsC/c9/bqQXLxaNtZKRZ6tHjuU3Uu/NC6VF5czfuWRF7OLR8lmcVvc8NWHjAY+YsPh599icGE5Oj31xIHYKxM7nuNtTtR+GJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8glTBsD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8glTBsD"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3964e76d0f4so4467237a91.3
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224738; x=1788829538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ff32pYrLV2ye5SVxDkfabWfzjV5v7+4FFXbfOmJ02c=;
        b=L8glTBsD2eZPsa9Bsqm/7U6mmZLOULwyxhxwu27MzKsFaw4L11SYnTN8z1lkANN297
         n9X00+e56uyVYOA8e/kuwOA8xuyddIFmiBaUF4nbYBHYQQETG09i2QxveAPAABrFPLIX
         IqcClt9/tCP8Wg7MvYJGq2VKC/ilt2i6TWV0z3qX/Aq/+GGCQog8MR61sjGChm0x6oMD
         AbcH5lrUyLxFUmm8f1/H/QSXltH7x4NG3Y5nPIajoIztg8NcDzTNxA3d7eYTUfYU+rLU
         URLGe+EZSBX1WTJcbpIE6+mnisB6fvaMJW4QvrlJjoINEwknM3RDswdIUwsB/sfgsgvm
         zO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224738; x=1788829538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ff32pYrLV2ye5SVxDkfabWfzjV5v7+4FFXbfOmJ02c=;
        b=XFYO0D/MO9AkwHkjEJcUHxsSGtMbGzJrrK8YgmlS51a8LFRhhdpVkI+HzAcBrbRIIk
         fAPFslZ4q1fEx8q592km1uhK/6hrA4DPQGNztsd0XHxF99omZMm/GB5Ue+JEeDtktudM
         1sg3ocbpY3sy/T4n16Jrl8L9XkAzaGl5cZwId30giHTPMS9DtqKMJypFIVsFyOXkFY9s
         825cmFv3CooBpu5iZkn8hkx0Wid+a7FJImhRuijuOs3v235xwYaVfdpfgfUSCVdcQl6o
         9HsyX7qYtRhnrHI29AvKMeqRVvt0Mk6LT7ClQ/tPfmAwywDq6OOkU6an50Arql71kmtJ
         eKmQ==
X-Gm-Message-State: AFuF++kh2QYFlH3FlXn9Hyxi6YX6DgPp1mQfcMFXDycoF9sH/Alo5JCq
	slnUY3MDLdFnapJGnVhbkNxTtcuNi4n/BsIfGehjxii558KHKU+6o0Js2oWRTA==
X-Gm-Gg: AYBFou3frn0fIy9rwVP1SdOoBkyLmzT/WIbfrKPs3Bp5LEr5sAvsz74XyqfWhCfjWwJ
	P6tyI4WUvvlN1Ss5zkZAbfXRGTN09vnqhmNoPDSdM36cPhaaEP0WN2FifBk/BD4VDYf0NqX4CRd
	rKwyDZeSrEEvZDq1FDjwGhoEKgfIht5A9MqAVKNsk+290zKEWUJPQAn42HlCanvR9snw4i3BMb4
	fF/5AWgfgkpDMu4dxcx5NxfshFxx66XdTHaqnt4wsNJD7hARrIqUKK5pETCUv4niw27OCHWcvS1
	MoolkwFZPYxELt3W2MwyuoepT0CdCg3LOk3oN0jxXygZfvfGftnYe33NkT8e2+yAunh3/zsmLZB
	o/fvI60FRs5DhWFnMp2daMlgbRRVKcP3w513U1CnES5SzCjzb6jfTXukvijjTXUdkdHLmWS81yg
	IzqxePElBX7QBdIvY1b/ZWLty/0m0iOe4V5kHnIRFZT/AWDTNs71PJkMoegBW7+PzudqZBccHnq
	67tqiNnFfGi2zKz
X-Received: by 2002:a17:90a:e7cf:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-396d0fccec0mr43056859a91.12.1788224738038;
        Mon, 31 Aug 2026 18:05:38 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:05:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	djbw@kernel.org,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	alistair@alistair23.me,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	bhelgaas@google.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: gary@garyguo.net,
	ojeda@kernel.org,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 11/21] PCI/TSM: Support connecting to PCIe CMA devices
Date: Tue,  1 Sep 2026 11:03:37 +1000
Message-ID: <20260901010347.2614656-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901010347.2614656-1-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
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
 drivers/pci/doe.c       |  3 +++
 drivers/pci/tsm.c       | 31 +++++++++++++++++++++++++------
 include/linux/pci-tsm.h | 12 +++++++++++-
 include/linux/pci.h     |  1 +
 4 files changed, 40 insertions(+), 7 deletions(-)

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
index 10c9c6696624..440f818ac569 100644
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
@@ -287,6 +287,16 @@ static DEVICE_ATTR_RW(connect);
 
 static int remove_fn(struct pci_dev *pdev, void *data)
 {
+	struct pci_dev *host = data;
+
+	/*
+	 * Only teardown the security context of functions that belong to the
+	 * DSM being disconnected, leaving any sibling DSM in the same slot
+	 * untouched.
+	 */
+	if (!pdev->tsm || pdev->tsm->dsm_dev != host)
+		return 0;
+
 	tsm_remove(pdev->tsm);
 	link_sysfs_disable(pdev);
 	return 0;
@@ -299,6 +309,7 @@ static int remove_fn(struct pci_dev *pdev, void *data)
  */
 static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
 {
+	struct pci_dev *host = data;
 	struct pci_tdi *tdi;
 	struct pci_tsm_host *tsm_host;
 
@@ -307,6 +318,14 @@ static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
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
 
@@ -437,7 +456,7 @@ EXPORT_SYMBOL_GPL(pci_tsm_guest_req);
 
 static void pci_tsm_unbind_all(struct pci_dev *pdev)
 {
-	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
+	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, pdev);
 	__pci_tsm_unbind(pdev, NULL);
 }
 
@@ -456,7 +475,7 @@ static void __pci_tsm_disconnect(struct pci_dev *pdev)
 	 * teardown
 	 */
 	guard(mutex)(&tsm_host->lock);
-	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
+	pci_tsm_walk_fns_reverse(pdev, remove_fn, pdev);
 	ops->disconnect(pdev);
 }
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 950e2c36a4ca..f504fa680315 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -3,6 +3,7 @@
 #define __PCI_TSM_H
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/sockptr.h>
 
 struct pci_tsm;
@@ -130,7 +131,7 @@ struct pci_tsm_host {
 	struct pci_doe_mb *doe_mb;
 };
 
-/* physical function0 and capable of 'connect' */
+/* device is a TSM host and capable of 'connect' */
 static inline bool is_pci_tsm_host(struct pci_dev *pdev)
 {
 	if (!pdev)
@@ -142,6 +143,15 @@ static inline bool is_pci_tsm_host(struct pci_dev *pdev)
 	if (pdev->is_virtfn)
 		return false;
 
+	/*
+	 * Report capable if CMA is supported, which can be supported on any PCIe
+	 * device.
+	 */
+#ifdef CONFIG_PCI_DOE
+	if (pdev->doe_cma)
+		return true;
+#endif
+
 	/*
 	 * Allow for a Device Security Manager (DSM) associated with function0
 	 * of an Endpoint to coordinate TDISP requests for other functions
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

