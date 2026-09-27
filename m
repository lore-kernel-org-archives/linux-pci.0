Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE93BB9E1
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531537; cv=none; b=LH33c62/EHKTqpXMVx5FDowmpde5Oe7lDRHJ1obDdSwICYi4VMuISYKNtR2dyG59UD8QP4EXCOB5j+wRiCTRhJblLfsClWpB1quqFZgXj6jgtxfhTiC+5Q0bsO8ivx+tQSi01moUuczg4BablV+FMIxl3r/PTdRNz1O6kFoGdW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531537; c=relaxed/simple;
	bh=XSQC/81m+2NGyN2HF+46o8gTXzhtxgDYUbfAyk7YscA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+4fjEExDJnQ7HZFwtqvNlTGgFCF/gqZiLRDwbpsVR5xW/UpYXnHxR8m7Yv7nqRU5FjdPZBlbPFTqiTcXhFVEVAzqo5rdL+RJffAm9TJ+fImWSxNujgEz07JhcsfVobiGA3Jlaky02C6cxsbQWdaN8mHAw98qmy5qfIfTuXGHkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0bhMz9H; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0bhMz9H"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so1314562f8f.1
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790531533; x=1791136333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/YmLfvNYngEdzxR1cneHvQxjYljmSjSjM29lfe3X1Ew=;
        b=C0bhMz9HjNzjPLDdYarMqRhGc6e0crr4KxNWG89p9AbkVW9F698rVzImgG1L3cJ2je
         ucIwZApj//5n39lwrk2N35hSEkUuTgjWv+QWb0C2ueFmqoNMf+UCRU5kpTLCvu416WOu
         ufwJpgoTsX5BW+LAmignUNJWSG267ygsgmfC5VAUNv2FIRYIHl9Ckibef5cOcLhCvAKK
         NHivJi2qCO4Y54V5uWBhHQhBbAgzvfatoDYs9TlMyEM/3a5IryS/BSE6bYNweMdYVFJn
         OTMrwJNazIj5lK7OC7tIKnR6l8j9tKA4PL3PLMJOUuBJz2GKh1Pim8Ff4kSGYQfLbYuY
         WgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531533; x=1791136333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/YmLfvNYngEdzxR1cneHvQxjYljmSjSjM29lfe3X1Ew=;
        b=UFnxKabSuz8s2r7tbsZyGH1DOTT7rPk+SO1nxjrG9kqEqV9Rhsxyirhjs+HpHGIKDM
         hGq3ATFI/Q0KpcPaRV/WFg2YkBzJJOK+iOgamUwAJGjUbyf8OQWvgRMz8WZg1RPhWchs
         Vkko7zg/3DX7rxt84WPVx6p0l+2X2Ti7DpAU39EW0Vrweaij38i62SIOHANiFeqTFFc7
         O4I8tlCFRzInbcNcYWmQznNG3IRUM3XR//OxdPxV1Wn2bNG0bHCybrX5Vwrr6OUxxA7K
         HPROFFUiPm+VFbOOY71ACzbprpngEd3JhvI73FB0ZCOY2F0ZtwXlWkZrKw0SmzSXgtl9
         ThjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcR7qG7G3SP/swd0PshursL1nuDcXXH6Usd9TMjt1NsdkRyj79xgcEoOPFWwGH/2dWF6+5LvAni68=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuknNMt9K2kzKgK6jJ6lJFxK78VpRXatCvQVbMHOzCNuHhBoUI
	ufLwjOQlif7boAEWRUBfrq55TmfrXMr9Na2x6bRkMsvS0sVP7t0C2MwD
X-Gm-Gg: AYBFou39i2kuRj2Pic+Tk6g4Zg2xGtCh8M1QZuqD9n3YB8IXZQabaB+GEkTihi0J6Z9
	f82vxUHphnVP70zC+752Yki/PxTyEIkJRacXPngGxI8qkRpSaEqPIV+mmpcCQvgicrTv8llol1J
	hee/a5TFF/qY/khf6SAf6Pg9owZiMr85Ti9lZoRwGilGXsLtc3TAeyGn5OC4ALyWIkN024gmnRP
	hi1Rw6UKLzxRYVXI5geUwfqkm7auDiwrg68nD1kt1/o5XK8tdkirltgYwVEkDpWwDH4kyb+X2Fk
	RknEfiaDYpnDgl+9nfahCjuCP/xrSi5I87VRi7PANbOiPQeKSOS6ZMUX7b332GgebqRyYrns3Jd
	WUdVZzTOrU2gux6ZzpP6NpxIDPNUcY7kzam3Yez7pogodQzDDGQe1jpLxfrvPAWEMQuc3gsCj/M
	/ZiHOEsjed6wEQiammW6cOER3rVeMeT5PH8ZvQ79I5epUcZRu8om21L8I8doS6vzYFaNXPavish
	swk0Ms+uWFb/fpaCQkDlP+4WH2PV1++4JfyQTmEI+vz20S8f4Fn8XPcNUwQ3SnGN4Q=
X-Received: by 2002:a05:6000:2010:b0:488:7803:c1ef with SMTP id ffacd0b85a97d-4887db496acmr14370762f8f.48.1790531532912;
        Sun, 27 Sep 2026 10:52:12 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcc4sm22563923f8f.1.2026.09.27.10.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:52:12 -0700 (PDT)
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
Subject: [PATCH RFC v3 3/5] PCI/DPC: Add pci_dpc_wait_recovery()
Date: Sun, 27 Sep 2026 17:52:00 +0000
Message-ID: <20260927175203.928270-4-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927175203.928270-1-abhinjoses@gmail.com>
References: <20260927175203.928270-1-abhinjoses@gmail.com>
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

