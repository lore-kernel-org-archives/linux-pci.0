Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD6D37F756
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397779; cv=none; b=SYg2EuxR36qvPiSPdafYEbW5M6hQZpJ+XLb75NINwqOD4hhKh61k3gqrVWLvK38oHc7xdsA835UykpFzicU/K29WafX/hEV7cnIfxA/gCyeIBSlwHcwwulGtcLNw+G5GazsdVDtbJEfiIs/FxgE4Kl9fmi0oK31fiVcq2JGyHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397779; c=relaxed/simple;
	bh=5kgCPvMKVNlkmlG9q2DP0TEUkvLsW+2Hf7nUpTdyoiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dc/bwmuiJqj9fS/FtzCoC0cgOkip2d2blvD3qXiIZJ71vZEhwPrbARDLrgR0l1IBRAxMKZwFggPo9f+gehKUvzQIVdvNUiM+oYofiwAaXKJhehQ3bLtAPBFUWoKo1cu6NUi/2KVmQ++x+HLcqNmHAzNjP+Xh80+DL7W/ILe7tP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Z8VdALqm; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Z8VdALqm"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-137dd51129bso282475c88.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 03:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1780397777; x=1781002577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vw7pTGbZv180hnfPtEbYCTGSUppqGH0HzAhdLQBYrc=;
        b=Z8VdALqmHDCN8HRb1ozO0r6HGMaUce/9c+y3zGgGikPUxDezFCmrpBPm1srpf2qmHa
         6pfsjWGf0W2Ku+uowumMKOlmoZHnA4PODVvGYIjzqXflyOLF8F+ZLgijOJVw7NNSdCRB
         G+0363fmwLNjegRE5BtGE3lLEVcLP/ouCiVGDl9H6MV0aWPV85FspTteCjtib77qtDdy
         6RLv/nIVXZEMvBtMAHwjh9G+w8EB/gSE/w8/pDh5BLFXrlU9DZ6yYQsLRA3fwDijuxEo
         jZ01eySoXQHXOYM2DXJ0xLvUbQlxq5HfoJ5yxlwqfLN1Sd7hPifg8BQhe83SGP2AnV8r
         gXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780397777; x=1781002577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vw7pTGbZv180hnfPtEbYCTGSUppqGH0HzAhdLQBYrc=;
        b=nBSa76u69lPsyNkH9jRvi3Mpm0xuEM3MH11Q6uRHQ4G6c4vPaPgarITn1esgbERdsD
         aJUorqKFJMNHhDshbENpfAxwQjmuSmi+loYyULgR4Q3H51e/xkAuI6gDjt7hTx3axaZo
         Dxick7xNVb60cBmGr0lkwcJ3JZHML+oD8mpwuinY+zIcgnFsxzCx8GGBGZG0TPjaaSLi
         KXkzmVBTk4f98X6LfEQ7mAkRg1f74OnG3zQWnXtMp7lJm2e8/f3kW+GuW7LOeTy5REav
         hJWH1mW+jqMCFGVX2ZLAEUTj9JPTVbtnRfdobHNP0ZFVaCWgXRA89GN7T7W++lutOTbw
         waMA==
X-Forwarded-Encrypted: i=1; AFNElJ8GGGXzSjxiKHX9XZ6+9cyQB5oMS8Tb69szWPrOWFMm6bGW8sEc1aRG3XNtfVoZIDbr2c3zdVDAp1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ51xN4PKxg8HQVGJN92fvuUiDJZepkT3Ase2WTBrHzf4AMGC7
	08TdW7y3r0tMcyU8EVSW8qreIAGZIL7HcMEA1QKgPOoLJw333eLDjLiuw1sQSF8PRQ==
X-Gm-Gg: Acq92OEg+AdLTdGYWmztAEtRa2/jSB+YrUY2lNth+epSWcV1PHulf28Yn3f2Y2cNr/3
	6StuH42MgxoekQyRfwOEe4WKsuuiH1oF9oQWnbiHie3QZLhENc1IOb2YTnU5Geqkzl0l2+jnPbT
	bCAk6deZ5eGGKxscm3ZPWJtmvO7vVM7KOhaVvuf2/w+VNVISA3EJ63ufxULWfnGbi/3MCqNNwfU
	PdQi/zMFlkc7zRzFFFdRdETShddwOfiNJCBUu9WcNFf0mEMCvsVixR4If53Ji7y7XP3sD6Hkjlm
	pRazHBcweadlEELClZVlvqpVTLXMgZXot3X+kcmAHtI+CRixURyiOjb/qnX9xpgr4eiS6+saPVX
	ZiURqETKMGQSOnrx1ivrrhj8OhptaxcIZmH6A+Aj4p0WwFjLPzL0qSaeuyuJybaOPk/s9wx4DTN
	QLRadhLIhnlH6tKw4cNGmhtJyeyDqVS2MXna9XiMFuf1Apb2RikU+A/B2JkHRmPIAFRA==
X-Received: by 2002:a05:7022:41a4:b0:136:e639:9c17 with SMTP id a92af1059eb24-137d42615b3mr6583398c88.23.1780397776746;
        Tue, 02 Jun 2026 03:56:16 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b36c6700sm8875678c88.6.2026.06.02.03.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:56:15 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Murashka <yurypm@arista.com>
Subject: [PATCH 2/2] PCI: Add pci=nodpc kernel boot option
Date: Tue,  2 Jun 2026 10:55:58 +0000
Message-ID: <20260602105558.1799563-3-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260602105558.1799563-1-yurypm@arista.com>
References: <20260602105558.1799563-1-yurypm@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI DPC (Downstream Port Containment) support can be advertised by PCIe
devices, but it might not be fully supported in the firmware. On large
modular systems with a complex PCIe tree, enabling DPC could cause
unexpected behavior and side effects. Sometimes it would be nice to have
the option to keep the system in an unmodified state and be able to
handle PCIe errors from userspace.

Add pci=nodpc kernel boot option to disable PCI DPC. When this option
is set, DPC initialization, state save/restore, and recovery are all
skipped.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 drivers/pci/pci.c                               |  2 ++
 drivers/pci/pci.h                               |  2 ++
 drivers/pci/pcie/dpc.c                          | 16 +++++++++++++---
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cfec12d37677..46a993c26dc0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5065,6 +5065,9 @@ Kernel parameters
 				through ports 0xC000-0xCFFF).
 				See http://wiki.osdev.org/PCI for more info
 				on the configuration access mechanisms.
+		nodpc		[PCIE] If the PCIE_DPC kernel config parameter is
+				enabled, this kernel boot option can be used to
+				disable the use of PCIE DPC.
 		noaer		[PCIE] If the PCIEAER kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of PCIE advanced error reporting.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1f71f9c773c4..2882c7bbb358 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6723,6 +6723,8 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "noats", 5)) {
 				pr_info("PCIe: ATS is disabled\n");
 				pcie_ats_disabled = true;
+			} else if (!strcmp(str, "nodpc")) {
+				pci_no_dpc();
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
 			} else if (!strcmp(str, "noaer_recovery")) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7a79df0ae712..1b6f17dddf21 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -887,6 +887,7 @@ struct rcec_ea {
 #endif
 
 #ifdef CONFIG_PCIE_DPC
+void pci_no_dpc(void);
 void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
@@ -895,6 +896,7 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
 unsigned int dpc_tlp_log_len(struct pci_dev *dev);
 #else
+static inline void pci_no_dpc(void) { }
 static inline void pci_save_dpc_state(struct pci_dev *dev) { }
 static inline void pci_restore_dpc_state(struct pci_dev *dev) { }
 static inline void pci_dpc_init(struct pci_dev *pdev) { }
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..10d1a0e026d7 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -43,12 +43,19 @@ static const char * const rp_pio_error_string[] = {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
+static int pcie_dpc_disable;
+
+void pci_no_dpc(void)
+{
+	pcie_dpc_disable = 1;
+}
+
 void pci_save_dpc_state(struct pci_dev *dev)
 {
 	struct pci_cap_saved_state *save_state;
 	u16 *cap;
 
-	if (!pci_is_pcie(dev))
+	if (pcie_dpc_disable || !pci_is_pcie(dev))
 		return;
 
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
@@ -64,7 +71,7 @@ void pci_restore_dpc_state(struct pci_dev *dev)
 	struct pci_cap_saved_state *save_state;
 	u16 *cap;
 
-	if (!pci_is_pcie(dev))
+	if (pcie_dpc_disable || !pci_is_pcie(dev))
 		return;
 
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
@@ -104,7 +111,7 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *host;
 
-	if (!pdev->dpc_cap)
+	if (pcie_dpc_disable || !pdev->dpc_cap)
 		return false;
 
 	/*
@@ -404,6 +411,9 @@ void pci_dpc_init(struct pci_dev *pdev)
 {
 	u16 cap;
 
+	if (pcie_dpc_disable)
+		return;
+
 	pdev->dpc_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
 	if (!pdev->dpc_cap)
 		return;
-- 
2.51.0

