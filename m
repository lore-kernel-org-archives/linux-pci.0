Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC54322FC
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533233; cv=none; b=qWf4EXTEjuGpKGUy0sHP+0i3lJoxFzgOA1uXFBcukokuPalElAucrJGG3MJEWAOnFt2EyN8jEhke87bqD88WmZ/Ct58qsVdp/47N5WRubBdD0GFaD+GjAna2WaSG1v+khyFHBtMyC5jEEylgBw4i7a+oNVWUCiBJ6cLhvmyq0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533233; c=relaxed/simple;
	bh=XSQC/81m+2NGyN2HF+46o8gTXzhtxgDYUbfAyk7YscA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT1Hgy7C1EIyUQLTFkm/zIf7mTfOZrB4g0SLZ8TfcN+sUNMYoiKCnNngPxwZwpGKrZL3lzl3NrfJh2/87CxfPNvuWsm0y1JHddXx9SyBsX8zXzghssLmv9KEnZPslEhiJOMjzQOMokzHzEUpAtPCPhsH+WUqUnb+pSibKKWliVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNrHDuve; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNrHDuve"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ce364488dso6283935e9.0
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790533228; x=1791138028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/YmLfvNYngEdzxR1cneHvQxjYljmSjSjM29lfe3X1Ew=;
        b=cNrHDuveTyopJykNGriqrXFu837JfyfWhl512Q7CQRiQItEdra57RewQJ0t2EaMHLR
         YXBmaxI2fdEsNTtq9XxSBTWwRssyw3QBddaMzw8MtI/zxEHfoxB5jhlA/ZSQ3KvPynhu
         zuA1Cuab6oO0jBZmp4Pe0ku3PSeW9Em/k+PQAWGHWb2SnLv/nGnJRhVRMegJd+LRzx5K
         mey1OpLP7nIXarJI+cE5UqEelCGCYIZaNcyg89ZTDyHM/9/eod+C9l/3JpHEXM9xhrA9
         xk4HHdfFJ8OnpQSBdSi/gJ2gJraxmyQDzoJc9QeGJlZZ8dIlrIaqw7wM7orLenQudtA1
         sW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790533228; x=1791138028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/YmLfvNYngEdzxR1cneHvQxjYljmSjSjM29lfe3X1Ew=;
        b=NN4NiDpVXSBQPBGTydd7jtxQnNN7gi/xud3oqDri3oLsrNb9bJDKT9lMM6wXfKtzry
         ZfURKgcXaO9gpGlKppCBp/w4kCcSMDzWLmaYL7VOdXR9+y0U1GMP93liLluxNLOJWh0h
         Ucrr461Yep2ZK0GKBfQhn3oJDrBaxKkGWtSj8je/ovketHGlV5A37eyDTubZiKXPWNSJ
         Q02Ei25qjh07T83DfTcM2nCICS0B11iauGeekNVV83fFkK/2Eq3ZtNic6TV8ICIYIWSg
         KOLW7LJ3z24nNjk1Iq+wiJQ+OgwXYyMI5zcE6MwCE34+96idm2vn80/APT0kfKaFujd7
         ZR4Q==
X-Forwarded-Encrypted: i=1; AKwUvBz1RmiPq0n50DnBcver3wITGI3Ruc7fxUoYLrzZfY5H/kUZxVyo0AZjS+ytuwKUM/Fc2zNd7LjCOak=@vger.kernel.org
X-Gm-Message-State: AFuF++lssxszygqGr8ip18QRIwqB47pl3Cm20tRn9txy8d/6VRgE7gKn
	i8wZev5egOATlSU8ZvYquNuZsH+wF3JLEWf/hiKQmK3z0+dHaz4XyltI
X-Gm-Gg: AYBFou2w+58wnLFKrLxq6Z21plSIuZGwiqtjuy+f3mw8tPvBniEyFtIgLdKVBOeEFDs
	6vJ9weVGi280wjCyBuPmIDvqxVmm21HVe3fMKDZlj3YgZxAeL1fS8wKq+SRw+cH8+xnNUcAutBM
	+TyXElT2xLgFpk9zK9nXCJj5SZB9phGx5ithJRBzsEQukQTFM6vAeEkO6YYZ+yVodwhINcCbmEI
	slhiKcribTlYngk2+c7p7MRR6CC5kDUL/VyvmI7XlQ7veWy+F4lNvQajUbwnuptoWA5iCCn7nTq
	xrb6LVy7cRsY+oEpjRQ3cM57oNh433UAJkryt2s2E/prEvAnLJwuFi864gL1DCs3VRasXDjrruv
	mhfoppIkAw5JIlRY9loXTj76PSmSGzL5CKRh4XIfsUAPVNcX5F8xh5u1FeE+yThKHaJ3/uOwPaq
	mrWTcRwQzft/cHB9HbCOSgqxnLVFGXaPjwx4o5YPVR2hZ8LMS+wEkn97lQmEXAS1dx3vO8eGxop
	xic4W2U/zfTUIjzLz14uLS7npvt27mnm4oc2lT4TushvSCGV5qzccxGZ2484VxJHsk=
X-Received: by 2002:a05:600c:1908:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-49fffa2221emr59153925e9.11.1790533227271;
        Sun, 27 Sep 2026 11:20:27 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a002d1d8d5sm38371585e9.0.2026.09.27.11.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:20:26 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Kees Cook <kees@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC v4 3/5] PCI/DPC: Add pci_dpc_wait_recovery()
Date: Sun, 27 Sep 2026 18:20:14 +0000
Message-ID: <20260927182017.938565-4-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927182017.938565-1-abhinjoses@gmail.com>
References: <20260927182017.938565-1-abhinjoses@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_dpc_recovered() awaits completion of DPC recovery and then tells
whether DPC recovered successfully, using test_and_clear_bit() on
PCI_DPC_RECOVERED. The answer is one-shot: only the first caller sees
true.

Split pci_dpc_recovered() into:

 - pci_dpc_hp_sync_supported(), the check whether hotplug can
   synchronize with DPC at all.
 - dpc_wait_completed(), the wait for recovery with its 4 second
   timeout;
 - the final test_and_clear_bit().

Add pci_dpc_wait_recovery(), which does the check and the wait but
leaves PCI_DPC_RECOVERED alone. No functional change intended.

Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
Assisted-by: LLM
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/dpc.c | 54 ++++++++++++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index cfa0202bf610b..b1d9df904c625 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -941,12 +941,14 @@ void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
 void dpc_process_error(struct pci_dev *pdev);
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
+void pci_dpc_wait_recovery(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
 unsigned int dpc_tlp_log_len(struct pci_dev *dev);
 #else
 static inline void pci_save_dpc_state(struct pci_dev *dev) { }
 static inline void pci_restore_dpc_state(struct pci_dev *dev) { }
 static inline void pci_dpc_init(struct pci_dev *pdev) { }
+static inline void pci_dpc_wait_recovery(struct pci_dev *pdev) { }
 static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
 #endif
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861b..a6438a7e3d9c7 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -92,15 +92,7 @@ static bool dpc_completed(struct pci_dev *pdev)
 	return true;
 }
 
-/**
- * pci_dpc_recovered - whether DPC triggered and has recovered successfully
- * @pdev: PCI device
- *
- * Return true if DPC was triggered for @pdev and has recovered successfully.
- * Wait for recovery if it hasn't completed yet.  Called from the PCIe hotplug
- * driver to recognize and ignore Link Down/Up events caused by DPC.
- */
-bool pci_dpc_recovered(struct pci_dev *pdev)
+static bool pci_dpc_hp_sync_supported(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *host;
 
@@ -108,13 +100,18 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
 		return false;
 
 	/*
-	 * Synchronization between hotplug and DPC is not supported
-	 * if DPC is owned by firmware and EDR is not enabled.
-	 */
+	* Synchronization between hotplug and DPC is only supported if DPC is owned
+	* by the OS, or by firmware with EDR enabled.
+	*/
 	host = pci_find_host_bridge(pdev->bus);
 	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
 		return false;
 
+	return true;
+}
+
+static void dpc_wait_completed(struct pci_dev *pdev)
+{
 	/*
 	 * Need a timeout in case DPC never completes due to failure of
 	 * dpc_wait_rp_inactive().  The spec doesn't mandate a time limit,
@@ -122,6 +119,39 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
 	 */
 	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
 			   msecs_to_jiffies(4000));
+}
+
+/**
+ * pci_dpc_wait_recovery - await completion of DPC recovery
+ * @pdev: PCI device
+ *
+ * Wait for recovery if DPC was triggered for @pdev and recovery hasn't
+ * completed yet.  Unlike pci_dpc_recovered(), leave the record of a
+ * successful recovery in place.  Called from the PCIe hotplug driver where
+ * it needs the link to have settled, but not the cause of a link change.
+ * Nothing is awaited if synchronization between hotplug and DPC is not
+ * supported for @pdev.
+ */
+void pci_dpc_wait_recovery(struct pci_dev *pdev)
+{
+	if (pci_dpc_hp_sync_supported(pdev))
+		dpc_wait_completed(pdev);
+}
+
+/**
+ * pci_dpc_recovered - whether DPC triggered and has recovered successfully
+ * @pdev: PCI device
+ *
+ * Return true if DPC was triggered for @pdev and has recovered successfully.
+ * Wait for recovery if it hasn't completed yet.  Called from the PCIe hotplug
+ * driver to recognize and ignore Link Down/Up events caused by DPC.
+ */
+bool pci_dpc_recovered(struct pci_dev *pdev)
+{
+	if (!pci_dpc_hp_sync_supported(pdev))
+		return false;
+
+	dpc_wait_completed(pdev);
 
 	return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
 }
-- 
2.51.1

