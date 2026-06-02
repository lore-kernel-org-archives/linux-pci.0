Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB67337F006
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397775; cv=none; b=W8OCpTDVjaj7C1r9GMXnCrqFZiZjWKF656lXdhSMVUjGHTit62qKoFkz69oBXgipzDUbKNBNpS3ci3qbiHv1Djh/dNZTPNcOr86z9plwuw3CzbAqext1Iffrn3M1P0IaRzn6RD2YYY3T+QQoxRim3njTl+B2s/H3VMIBd04+fPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397775; c=relaxed/simple;
	bh=wLCKuc5QOnzLCacTJEBWqxb1EStcrRKg3HvJvzZAG5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkKfUQmc4nrleEVWr0pyhXdxY6AScAC/944Q5m1IJL/MsPf/He6Qrcf8euSnE1Dfx9gAqKX3c1RMaq/pgCkVDMYxi2Q49saORhKR+FlMNGNQIrpMIPOH7d2i81BiWAlPSnPl3kNlbUAuJq5vpLwbyQw5OUXLYuDDEaP9ytX3Vn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=UKXYoY9S; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UKXYoY9S"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1363fe80fe8so13446127c88.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 03:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1780397773; x=1781002573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipygvPfGvh511pGoc1WDj9e8ajT/yuZPoVIK2+0UFTI=;
        b=UKXYoY9SKQWepUbI+JTUVgWgZezXpMkZgowB2GX1/1L1pDkGj2Ww9sEstnb2XBz14s
         A2YcC3rR8PagfWWv7+U4Bi44CyNYsw89lswvF83p9jjpOq0O7KXkrs1Ty0jJNbh7V8nQ
         Wk2LIpsnt98H40+3EXa08BLK39IqdXOmrXdyyU/a645j/Sf94D4mw8GpekgynJMQ9M7F
         tGHdl8bITnadZav7zfpHJwlO28iczUPf7FyZrEdh8PT/8SwERZjXt9p3jqaM/7P//dWq
         y4v556ymmdhHP7HYFiA56QYR9lOaQRY3GEWxO4SHVRaCy3Z39vCsDuVcLuHxFAMlfDGF
         sbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780397773; x=1781002573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ipygvPfGvh511pGoc1WDj9e8ajT/yuZPoVIK2+0UFTI=;
        b=OIOG7khMe/GZ56SIIzC02OZf3fYNlf5LYiV13Q850mOgU38V+nSW47Yd2Q+SWqLyV7
         Fl5fHhfguOxKTyggqq482vjfQNPPjguHlFvpK/ZoVxCVMOfTucvyra1niDyujxBPMMM9
         C/0326zy6jPOOsWgwNY5goasLMVu6hpkW1Uw8WnriE6qZ0HqUt3whqudzFsrqCRZBQcZ
         UoWeFHHHPptaHshHYPH7Pt3F7bsTiIVWI8Gm05QWSS7fbG11+70sERd8/w3xlK5XLg/u
         9oHc+10g7eirgkFrDqJoM7A90txN04nVPqPGmynCvRsecxThfWJWpQZ0bFStGkgpOZk2
         5eQg==
X-Forwarded-Encrypted: i=1; AFNElJ8/mfdWpYPM1cZ8w/SAHx0Z15h8b/hQLKbyAcZsx2GzvmEk76soySuXudmee7OREs85D4MqVmy9y1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YynqLD4XlfzdC+1RqSwsNa2pgA6ZgSuCMGFCRTMY0Cw5qcF5H4H
	4DJObYgcFqNFwTjbDcYS/0Ivl6LJ0HiOR5ur5NiKcBkG1sDxAoR33nmOXlr5IZFL+A==
X-Gm-Gg: Acq92OGrdgvVBbw30omLrePlOqx40t3uVZSGXditMPNvd5d9q0dTtifZuMtbAIpjbrM
	ksLBogGNPY5Us/xciFOvsfzTEq1mFrCbS8zas1k6VNyHi5s9NGE/lg0v+BS84Cd+MNMsfpriwY/
	/B9NnnQRbTpiWGawiTfE34KdVu5A1/rECLXyY5ygadM6RK+7SMmsNF5HVnwoy4KzHLFaBUxA1Cd
	7dKPauhc3j9C1dp73rDO6LtTSFd1hTex6o5rqcNXibJXrelY3dfmXytrhAaByYjIQYNQxU4Xwp3
	6g1x3yg9lcRK5eScQ73j2S5B3YiDejZgfGCn3WJEtdsvYLpzRue3Z8pKy7Ugokvosj3HrAUg4cB
	gSPWuytCutrJaj/uwgTBPPaAxfcITi+/WPiytLJJ7zl9mOotGK+C8G+/KrDEbxLAlafyGlgO3gV
	LUg+GvdmW0khQOR9DI6EoLnllaRbADgvIhg4OYWkX6WI/9+uf5fC1s+8ZRoP6CDODF/g==
X-Received: by 2002:a05:7022:2228:b0:12c:6e85:505c with SMTP id a92af1059eb24-137d3bf6159mr6165635c88.4.1780397773132;
        Tue, 02 Jun 2026 03:56:13 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b36c6700sm8875678c88.6.2026.06.02.03.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:56:11 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Murashka <yurypm@arista.com>
Subject: [PATCH 1/2] PCI: Add pci=noaer_recovery kernel boot option
Date: Tue,  2 Jun 2026 10:55:57 +0000
Message-ID: <20260602105558.1799563-2-yurypm@arista.com>
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

AER error recovery is part of the AER error handling subsystem in the
Linux kernel. On large modular systems with a complex PCIe tree, AER
recovery could cause unexpected behavior and side effects. Sometimes it
would be nice to have the option to keep the system in an unmodified
state and be able to handle PCIe errors from userspace.

Add pci=noaer_recovery kernel boot option to disable AER error recovery
when an uncorrectable error is reported. When this option is set, the
error status bits are still cleared, but no recovery actions are taken.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 drivers/pci/pci.c                               |  2 ++
 drivers/pci/pci.h                               |  2 ++
 drivers/pci/pcie/err.c                          | 15 +++++++++++++++
 4 files changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 97007f4f69d4..cfec12d37677 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5068,6 +5068,10 @@ Kernel parameters
 		noaer		[PCIE] If the PCIEAER kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of PCIE advanced error reporting.
+		noaer_recovery	[PCIE] If the PCIEAER kernel config parameter is
+				enabled, this kernel boot option can be used to
+				disable AER error recovery when an uncorrectable
+				error is reported.
 		nodomains	[PCI] Disable support for multiple PCI
 				root domains (aka PCI segments, in ACPI-speak).
 		nommconf	[X86] Disable use of MMCONFIG for PCI
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d34266651ad0..1f71f9c773c4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6725,6 +6725,8 @@ static int __init pci_setup(char *str)
 				pcie_ats_disabled = true;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+			} else if (!strcmp(str, "noaer_recovery")) {
+				pci_no_aer_recovery();
 			} else if (!strcmp(str, "earlydump")) {
 				pci_early_dump = true;
 			} else if (!strncmp(str, "realloc=", 8)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..7a79df0ae712 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1283,6 +1283,7 @@ static inline void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge
 
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
+void pci_no_aer_recovery(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
@@ -1294,6 +1295,7 @@ void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
+static inline void pci_no_aer_recovery(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index bebe4bc111d7..c022cfd85b93 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -21,6 +21,13 @@
 #include "portdrv.h"
 #include "../pci.h"
 
+static int pcie_aer_recovery_disable;
+
+void pci_no_aer_recovery(void)
+{
+	pcie_aer_recovery_disable = 1;
+}
+
 static pci_ers_result_t merge_result(enum pci_ers_result orig,
 				  enum pci_ers_result new)
 {
@@ -216,6 +223,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
+	if (pcie_aer_recovery_disable) {
+		if (host->native_aer || pcie_ports_native) {
+			pcie_clear_device_status(dev);
+			pci_aer_clear_nonfatal_status(dev);
+		}
+		return status;
+	}
+
 	/*
 	 * If the error was detected by a Root Port, Downstream Port, RCEC,
 	 * or RCiEP, recovery runs on the device itself.  For Ports, that
-- 
2.51.0

