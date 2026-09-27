Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3FE2D5937
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790528125; cv=none; b=j5NuAl8/4i5efVDCIMLgV1uOW1Qq+Mhs0DY9y4Dgpk3Ayey1aN4nh6yYt1UK5P/xKQm/X+GwXiTvkHbdGkv+RBVwzNhpqRoVb8qcBA4Z9pfYJtqrBI36RSm4tnpG57CtKpAU7b9MCB/XCOAFTqN9i+ERSTW34w6lfEGfkpD6eRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790528125; c=relaxed/simple;
	bh=cA8/DvTbO0ExzpBzzco0L48mFYDdMD6XjFWWGSpnSpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5ueQwkNoyed3yfD7AKQg0G+RizKTfPoxS7SxAo4JRZ7WlfNabYZ5Ljx9tsUs42t2x1kdiHEePs32aWQOKOtEM57MISBm5EZgUSPVkVrpTA/MeGm/N3PrpD6EOhQW/NJ7fq28ipf78b9A8DMsMmwZapfHiA73kvxjzJoQMjxa5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxG7uswb; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxG7uswb"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so4475755e9.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 09:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790528122; x=1791132922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NTuSGrduqyu3DK4wAPJF2MCmGI7vblXuBOgLU0bscZM=;
        b=XxG7uswbxJu5C8n4x5Xl6aVafRRlup+6UCx6FgPpRrRa0prTvjlGVgPzf0fY9Kcvp9
         MDgJmPCVJClSE/rrrU+teVccPIAdnWJa39PrHYVbUc7TQUslx6X0TYNN3Yf423EuD/ly
         X2v2bLUREsNNpI8GpTb7nt4jTWvp++b8pSrecPkfZ8yb06UQFCexVu60FvkHpu1MCkAc
         ZMuaxv78h+MgLk4IYaNeinSnmbsfhxgOkdQFF/gZNRfi6s0GOhnGUOtsZw3F4GbSbjg7
         zLLCaWhcfRNIF4/J6QEuBSUHnm6PFBZKnOp5BFjCwTInZOGnFw7+oFG/INZmWzvcizGJ
         FAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790528122; x=1791132922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NTuSGrduqyu3DK4wAPJF2MCmGI7vblXuBOgLU0bscZM=;
        b=zFdBrEEq8vpmPt25Zz86p9EHXQQ1SoQGudFsmcaW1kHhxnsOgWurdgZ3yvNtKwM1Di
         1xVURUvQ3VexvVkrwV2n96W5v9sZToOvNTpRgQ6XrnLwlbe3dQwEcsFEH4ODvxshnItM
         mL3DYhGjhM1ZvrvIhNxKgwEFqUo3890cfeFiUnYQuALynsUEBh+GYq4xX/y6I5AwzTc/
         xyddk5THPyym4+V2gCZ+4GE+n+FInGDqqtY9+wAEpHFdTUCoZgkQwkMyJtLsmcps/wNl
         PNxqmXvZDZ5d+KeVdydEgivSBoNyuXIyeUDyDqcrPWflrceJwuyM6hqJXuWlXdaUanQf
         IEhQ==
X-Forwarded-Encrypted: i=1; AKwUvByCLP5DagHLdSZ+vsw+j50q4okEOVRyMm3boRUPUU8Z1myZczm1kOUFUi1zVKplmIIJbZWF6oAeKBY=@vger.kernel.org
X-Gm-Message-State: AFuF++l7Vu8IREAuHGDbME3hETWFhd0kSjo9pyOkjCfydh0tdiKC3nJ7
	JiSKvqPgZQYOgULU8R9fJPuEQMXFkOf6A2eN6KVnXVEnrm4eGHIdBGgn
X-Gm-Gg: AYBFou1ch0Aa4Yu7ottI0uU/B87B5lRJNVKaE5fhKbYdQCJ7yG6KiQZnGXw47m51wUI
	OLB1AG8MWuEhAh408emsqYsBsH6PazVFuUoOHHTnnjowBFSZBZ5bq9rzTMSuQbL5Q7IarWU5w9N
	Xno1y1Nx6a71JXSCmHYB/2qoS6f/CbRc4yKaQ1urZ2o40iJKxPJEoC5zltxwhMCVctxFzVKK3uT
	2kAozd5AlgDZZb9N608RIBmpyrQA9ePUju7dLvoWYSmwwkyKPNQ2GkTpqG2+qhRKfhpCV5ksP9+
	tFVG/y9EjKd5dy12UUtinBwNkfEw0XsJAC7jPUsejTYR4n61iEZAHirD3zO6VVSZ0z6HtfFK3b2
	3guo1E1qFQaJADm3DSHK8l8a2pvVVk+a1RTHg6JS9JTAw7oBcqQHdaOzPoseiELWDKWk43vw9MB
	uFIFSQfRaaSPvnt2zlmXsZvuXLl1JEB/qtJoAdO37C6zsjXZSPyIQ+/uUoKiPwGnn/LQsMppunl
	WnRJ0EYJu42hJJ1NeaveO+0AJgAWMxlqwqQ0wffEw1JcFZ+syvjfai/hbY/oXpFg2WtPBbc//Nc
	Gg==
X-Received: by 2002:a05:600c:34d4:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49fe66d07c9mr170308515e9.12.1790528121995;
        Sun, 27 Sep 2026 09:55:21 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00178bebasm76167695e9.11.2026.09.27.09.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:55:21 -0700 (PDT)
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
Subject: [PATCH RFC v2 3/5] PCI/DPC: Add pci_dpc_wait_recovery()
Date: Sun, 27 Sep 2026 16:54:56 +0000
Message-ID: <20260927165459.829900-4-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927165459.829900-1-abhinjoses@gmail.com>
References: <20260927165459.829900-1-abhinjoses@gmail.com>
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
index 2e113806f9f95..ad98e2d9289ea 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -940,12 +940,14 @@ void pci_restore_dpc_state(struct pci_dev *dev);
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

