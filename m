Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284421;
	b=oEYuX+uWJGhYDbO30425uxRcOkSLj3NKB4JmiIBykon9BJk82dhKASzquGmTvq94xl7u
	 bz6GBh/iMs6hyM2CaOaTPML2Mw1x/CkXcDMKUF2lidZCs1toKfUC8OkQ/ZsmJO3+cm0FQ
	 vMc38Xx0XuE7Ce9+in1kFF3xrdWlUAvVStWYHwp+qcWk04CSvjCGwHu+KfmxDoRWKN6fX
	 qx4Z2tFlkEtW7vDrTqnA52n//iIEA0OIkcPwjQrkGYU76BPSHtGv93LujZVE1JBmOWNOC
	 OE6qJ2TT8wL6bwROt4cBovM5OhseaKWqg4mdh9Ys1Pbu45TwibafWb6JuSJVxGUgMdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kIMdMW0vli7k7kSrLT2WE+OKV4xntGT1c/66y0oxHRM=;
	b=R1/g3nJHFXdxY9/zd0Sxe1NU7nzGCKRzz+NAwa8uHslGhiU91OW6lX34XuK+ay7h1Sf4
	 UDZvocnFuKIcrbLptHakqppWdqYTSjuXUgOhXmPqA2MGlhl1CaUSqv4bXlZHqIuj9EcNf
	 YLM4+8+BVoJEH1ATDo1RM6dXKzdDXqe21rv2WiaTvUv7UkupE6YWmdNE4sdG6x6acyUOa
	 zfEreYxVlt/WEt9ZVhMF0vd3PsMJ/5YDxIRkt4ssROPu5H6TO8v8BAwnD+6ndKyfgO3N6
	 wSXkNKe1ECLPvcS3hNX446XTd2xnab0Ws+z99kmCf9P5qxi20UI2erQi7t6knrewMpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H3gRAh+r;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5C606A33D
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9A5C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H3gRAh+r
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3ada81853so1361110c88.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 20:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284419; x=1794889219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kIMdMW0vli7k7kSrLT2WE+OKV4xntGT1c/66y0oxHRM=;
        b=H3gRAh+r18TE707CSqjuK1h3DVQyK2y2bi+BBucxACouqIL7nqDLt5+t2FHkoA/Oj+
         2x68kiswyOrkZFkhRSBtpaKTmz1dn/paxZ8Yt5y94Z0H2K4Hiy9qVxgEYiGjbp+Kiqu1
         qp/XYwAyjfV9VKsDeqyaAOAO/qVFQvftlxFz+bEsLbDjeAf2JOWwkWgCK38fRRC9VXv7
         JuUv1QHe63szAMI1x5qSdEKzjazn7ygWMwoQVkk+r7l205JmHKIFUHXgYBF/8Q9RXqdd
         p3hH8er8DhAsfe3sSnXd2TdAoEBqv1ZdM5aiHefPtpO1Stw/xkDrBnRM2viVvHPnPLJJ
         axSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284419; x=1794889219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kIMdMW0vli7k7kSrLT2WE+OKV4xntGT1c/66y0oxHRM=;
        b=qDBIg0ZH1gBL/V7uIBwh6cqFqX3xa6ospyZ6j1psi4Fgi1l2okl3go//s0YyDJfkHV
         FWUCItqPSFpciRHKceq3Q3ocQTZbMlVNInAR/hhmqxcYhLyIgHKEnSpNxSgXjgbi1N8x
         hWqSJ9Br7+EW97VmeONs/0ZY74Q0Z2J5xtIo42WCfkn4koqhNj6rXA7MABSFO8/IfKod
         jz5afFHPattpBvUe3hEM9Ukm/0x8RggwC/xIY7tEG7KQvU1ZRuAuZclpAaoQN+zC1G/l
         Za9LjkJRKq9+CYDHXtbYYOvfIn2iCe/pMLD9l2CO5jLHz5S1LTAnoVN5yNDMZEbpU4qY
         I5Sw==
X-Forwarded-Encrypted: i=1; AL+hErGKgXKA5lWTUs/Q24W9OV5jfzTgWdGnQGkkqG8ZIYAqUTZVTVaVhaZFWpXyYE80/4wJMFHX/KX8ijU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FEhsEMxXfbdc3KSCXCuOzOpEr5VyGW2LvwvVYu8jT6Qx2IEK6
	pYlzS4U0M1yyU4pF3IV7mJ8VpUtx2isToHlMGrJ5JMDkK1tVzNpGUM+o
X-Gm-Gg: AYBFou3x84q0JQrI8zhiM8xG2TAVt96V6/AaZV539xe9vEk37+vRie4pOI/jf+++xuR
	ewFny3vNplG8OqxzN3S1dqubSsT/8zuTV4EQEZ1RYhKAEoad6UXjFL1TAaaKjmAHVP2i0s5FX+o
	cl9MHgTny3Ajen9DNSb5S0Emj0sfWaTUH8t75jB0680aNnPOnETqwsJFaQqPtwVZPDJFJg/x2/3
	/9nA9Ol8U5WRkb44rYXmtiw2bsRr6hF0baQVfhaAYKUmulWdvOlDVMtLphBPlqPb9lMhHByTzMU
	bAgHkqbcMLMXu8m6KxDpiO13/p2/ZHSbQq/s0BMjquwOOgDi75hJ0BJFWqwCx1aoTPx6qkJKadB
	gU/wVIPkz3T7s84xXDeA6UaWYHPBcAu4bBujYWP/jrA6XdX846TpvbCJsSsaz1zqsSD4tspHHPZ
	lPGlWqkmGzoGPI9JgedmGOWKOJIAvCp2wfRPvyttwp/SDTXyvhf132kPbuohq6Y0W1ncbimVJk3
	gsPR9yMSCW3hTJgpABo9js0a2MIqQzM+IzuOISXzAyIDBfqTbfCAk3HAU1PBvzYOZo2ZxMQDZRi
	t3zt8GaMCtTuMeVwv2YsAX0+4ocLu/lPjQe7HzslXy7VkK8=
X-Received: by 2002:a05:7022:7f01:b0:1b2:43ac:d3a3 with SMTP id a92af1059eb24-1b3b5fee2aamr1980191c88.24.1794284418835;
        Mon, 09 Nov 2026 20:20:18 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:20:18 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	bvanassche@acm.org,
	linux-pci@vger.kernel.org,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	rust-for-linux@vger.kernel.org,
	jgg@nvidia.com,
	akpm@linux-foundation.org
Cc: gary@garyguo.net,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	boqun.feng@gmail.com,
	alistair23@gmail.com,
	gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 11/25] PCI/TSM: Support connecting to PCIe CMA devices
Date: Tue, 10 Nov 2026 14:18:18 +1000
Message-ID: <20261110041832.1730924-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110041832.1730924-1-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
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
 drivers/crypto/ccp/sev-dev-tsm.c |   4 +-
 drivers/pci/doe.c                |   3 +
 drivers/pci/tsm.c                | 107 +++++++++++++++++++++++--------
 include/linux/pci-tsm.h          |  32 ++++++++-
 include/linux/pci.h              |   1 +
 5 files changed, 115 insertions(+), 32 deletions(-)

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
index 10c9c6696624d..170e53ae4a0a0 100644
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
@@ -221,8 +224,13 @@ static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 	 * is the ultimate arbiter of security state relative to a given
 	 * interface id, and if it says it can manage TDISP state of a function,
 	 * let it.
+	 *
+	 * Only a function in a valid DSM position (function0 or upstream
+	 * port) with TEE capability manages subordinate functions. A plain
+	 * CMA host manages only itself, leaving sibling functions available
+	 * to be connected independently.
 	 */
-	if (has_tee(pdev))
+	if (has_tee(pdev) && is_pci_tsm_dsm(pdev))
 		pci_tsm_walk_fns(pdev, probe_fn, pdev);
 	return 0;
 }
@@ -287,6 +295,19 @@ static DEVICE_ATTR_RW(connect);
 
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
@@ -299,6 +320,7 @@ static int remove_fn(struct pci_dev *pdev, void *data)
  */
 static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
 {
+	struct pci_dev *host = data;
 	struct pci_tdi *tdi;
 	struct pci_tsm_host *tsm_host;
 
@@ -307,6 +329,14 @@ static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
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
 
@@ -437,7 +467,7 @@ EXPORT_SYMBOL_GPL(pci_tsm_guest_req);
 
 static void pci_tsm_unbind_all(struct pci_dev *pdev)
 {
-	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
+	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, pdev);
 	__pci_tsm_unbind(pdev, NULL);
 }
 
@@ -451,12 +481,13 @@ static void __pci_tsm_disconnect(struct pci_dev *pdev)
 
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
 
@@ -587,8 +618,17 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
 
 		if (attr == &dev_attr_connect.attr ||
 		    attr == &dev_attr_disconnect.attr) {
-			if (is_pci_tsm_host(pdev))
+			if (is_pci_tsm_host(pdev)) {
+				/*
+				 * Hide while the function is managed by
+				 * another DSM, so userspace cannot connect()
+				 * it independently or disconnect() a context
+				 * that connect() never established.
+				 */
+				if (pdev->tsm && !is_dsm(pdev))
+					return 0;
 				return attr->mode;
+			}
 		}
 	}
 
@@ -662,14 +702,15 @@ static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
 	struct device *grandparent;
 	struct pci_dev *uport;
 
-	if (is_pci_tsm_host(pdev))
-		return pdev;
-
 	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
-	if (!pf0)
-		return NULL;
 
-	if (is_dsm(pf0))
+	/*
+	 * Functions subordinate to an active DSM are managed by that DSM,
+	 * even if the function itself has a CMA DOE mailbox. Check for the
+	 * DSM context before considering this function to be its own TSM
+	 * host.
+	 */
+	if (pf0 && pf0 != pdev && is_dsm(pf0))
 		return pf0;
 
 	/*
@@ -677,20 +718,24 @@ static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
 	 * downstream devices, check the first upstream port relative to this
 	 * endpoint.
 	 */
-	if (!pdev->dev.parent)
-		return NULL;
-	grandparent = pdev->dev.parent->parent;
-	if (!grandparent)
-		return NULL;
-	if (!dev_is_pci(grandparent))
-		return NULL;
-	uport = to_pci_dev(grandparent);
-	if (!pci_is_pcie(uport) ||
-	    pci_pcie_type(uport) != PCI_EXP_TYPE_UPSTREAM)
-		return NULL;
+	if (pdev->dev.parent) {
+		grandparent = pdev->dev.parent->parent;
+		if (grandparent && dev_is_pci(grandparent)) {
+			uport = to_pci_dev(grandparent);
+			if (pci_is_pcie(uport) &&
+			    pci_pcie_type(uport) == PCI_EXP_TYPE_UPSTREAM &&
+			    is_dsm(uport))
+				return uport;
+		}
+	}
+
+	/*
+	 * With no DSM context above it, a TSM host capable function (e.g.
+	 * one with a CMA DOE mailbox) is its own host.
+	 */
+	if (is_pci_tsm_host(pdev))
+		return pdev;
 
-	if (is_dsm(uport))
-		return uport;
 	return NULL;
 }
 
@@ -828,7 +873,13 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 	else if (tsm_dev != tsm->tsm_dev)
 		return;
 
-	if (is_link_tsm(tsm_dev) && is_pci_tsm_host(pdev))
+	/*
+	 * Only a device that is actually acting as a DSM (self-hosted,
+	 * connected context) goes through the disconnect() path. A function
+	 * that merely has a CMA mailbox but belongs to another DSM is a
+	 * plain subordinate.
+	 */
+	if (is_link_tsm(tsm_dev) && is_dsm(pdev))
 		pci_tsm_disconnect(pdev);
 	else
 		pci_tsm_fn_exit(pdev);
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
index aa3765a20a96c..5e9887873bc41 100644
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

