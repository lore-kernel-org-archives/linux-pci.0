Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF464499A5
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623300; cv=none; b=Z1KayOgXFLCBAU2RLs8eTJIg/YwbZt6u5clMT48gANMKX2zZSYlfTGCegEHR0Pw/Jt8JZ4SE9WcniG4yMJ/sHTbMCVRtUUgpnVRqVwBZukS/9j+efZq5EYlIJ9H48yWdhF6bTQdJmYZtA3o0HUcX9A1lgM3LDU8/D+kz49MS/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623300; c=relaxed/simple;
	bh=Xe0qcogsm2YZnaR0h+bmqGMtWjxvFYQPjJnSm9wWzZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJr+/KBtERHxFKR1d92J8wMGVWY4xBnrlXvuv8Hsr7W0J5uI04nIYkOcw4iyZk61/UB+KTUN5XdeQfzITwOvCrMFlRY31uEpnpBoKBcZa9bgsaaJE7CwoqcwVnQoMPX6j5jrhY++xS7vwdH+UwAzElVogbrRF9JZ5NZxy6fqwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=JlVssc3/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JlVssc3/"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so141839a12.1
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1783623297; x=1784228097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A9Chc45VPQT8BR3yqBtnHCzkEUtEngJlnmusVVJ44F8=;
        b=JlVssc3/5pbRdXguF9k+4NTu4/ASIJ0iwP/ZPdPO+Ytr8TgyLFl9BFdRJ7+zpKEjYx
         1//qnmLPQKUKsEnqR0kMHYxeRjJd3m8U2Retq+IHkq5Y2kzY3qF5w/gE65MY0FPpGKSx
         ky8Uqx/E701ENrQJR8soIp/WeyoDdl2JISr5C41CqDprSwPXMhzVXnsQdbnB9VtZfu0z
         U1AS+nmnY39XU46B/CeK6HINwkp0HUBTpOkQuy/PhwDCJgwSWDaygAdk5qrMr4d0exev
         Qrz0Fg/GhRHzF29XoXIIYnU4IDbzRxHJnroYlTuUSi8Ex0iEghsY+YiPllaQVa185Rvk
         fB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623297; x=1784228097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A9Chc45VPQT8BR3yqBtnHCzkEUtEngJlnmusVVJ44F8=;
        b=WFYtIwWMF9eONc20wZkBiDV6wqBEBILG+jFvtZQ5Jr2tk9+Atn12cbPOZQsc45JdpN
         6HxbGID02tBjy7qSCzegeRVSqXUJWSzoksfVn56DK+ovs+3YaeKIDs/qLvg8eHnz5llE
         Ge47DnDj6ixCbugGaDVpfX1kLuOS/gLxuYpK4lWOVAohN0MxRFmgx5GY2aYYL5+8EXAz
         zZtfJFAMYWkwjzs1mxPqhHQqCamulzJ6DFkFZNuoc97T7Co9ayhn5dtd0PYmguaTLyFJ
         lvMzg17FS0YwLpjkY60fOAAXXcfzVTCVhfAU9EEfsPmrK6Q43S+hg/5p4yYP+Ry/rX8c
         JYVg==
X-Forwarded-Encrypted: i=1; AHgh+RoqcbHgpBJVSqiByHTS2K0O1kXSj8v/3dkHDl5gu1WOLfDTuZfu8C2q/OQjVsUm9YbQxT+d+BagD0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwygtRT9hkQRnWxTuvEFLipWu2p7af8qYE1+Buw8uwwPai/cBou
	k/+xKhhIM/tIhI2WZ3IHXv5SRanRnkTY+2ACwgfbiTBQbUX4MSe9DiX0YRz02WV69A==
X-Gm-Gg: AfdE7cnoxlqWcTp4iEQ7sh+4k3iVJon34Lqrl9XMxlFB2/Xkn9GABpJEU59FR7yXogZ
	7Gll3vJpmZMhc5om8im4q/R/TqXczel27vVr6fW/O2e6W0cY6C2ZHmyqGuLZr7C8EdYbL0HEGvN
	VRemcioMF6qJE0Xq/KNHgNP6ZY+kdbmihwAENEPA49WINQ+nOwbk4MFxqIpX1DFvMgleSsRNWNt
	z2QXTAMn7pkPLzmy+ysKrNrGVzH40x0QRoH/m/RXXI0eC1ziyogXmR93s/ZyqPHs5PBnyPzv238
	JppPNBb+l1DF/jWCRu+/lutd0b4awdLwdFzNityJZfxto+GKPRpxT284qAWtsmgs6246pjTIbXp
	PUarFDUhn5X+PHWkepmggC7Fks4os8OwvqyWklW2o1RyFUpfHJWblQdTENShPtgHI26Lei/Imfx
	xWowah4kDpKJjVKXN1VsT788LDVuFkj26TajeG7jLHqJWYij7xrg7w7/A=
X-Received: by 2002:a05:6a21:700b:b0:3c0:9c1b:d0bf with SMTP id adf61e73a8af0-3c0bd332198mr10404800637.74.1783623297316;
        Thu, 09 Jul 2026 11:54:57 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm31297642eec.4.2026.07.09.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:54:56 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Yury Murashka <yurypm@arista.com>
Subject: [PATCH v2 2/2] PCI: Add pci=nodpc kernel boot option
Date: Thu,  9 Jul 2026 18:54:29 +0000
Message-ID: <20260709185429.627968-3-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260709185429.627968-1-yurypm@arista.com>
References: <20260709185429.627968-1-yurypm@arista.com>
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
is set, DPC initialization, state save/restore, recovery, and driver
registration are all skipped.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +++
 drivers/pci/pci.c                             |  2 ++
 drivers/pci/pci.h                             |  2 ++
 drivers/pci/pcie/dpc.c                        | 19 ++++++++++++++++---
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 13c6b53bb9ee..ccc26849a1ae 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5050,6 +5050,9 @@ Kernel parameters
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
index a215dd567d5d..6cd06a872ba0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6754,6 +6754,8 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "noats", 5)) {
 				pr_info("PCIe: ATS is disabled\n");
 				pcie_ats_disabled = true;
+			} else if (!strcmp(str, "nodpc")) {
+				pci_no_dpc();
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
 			} else if (!strcmp(str, "noaer_recovery")) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c4a42bbc277b..146cd5df985a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -880,6 +880,7 @@ struct rcec_ea {
 #endif
 
 #ifdef CONFIG_PCIE_DPC
+void pci_no_dpc(void);
 void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
@@ -888,6 +889,7 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
 unsigned int dpc_tlp_log_len(struct pci_dev *dev);
 #else
+static inline void pci_no_dpc(void) { }
 static inline void pci_save_dpc_state(struct pci_dev *dev) { }
 static inline void pci_restore_dpc_state(struct pci_dev *dev) { }
 static inline void pci_dpc_init(struct pci_dev *pdev) { }
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..759d9f18812e 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -43,12 +43,19 @@ static const char * const rp_pio_error_string[] = {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
+static bool pcie_dpc_disable;
+
+void pci_no_dpc(void)
+{
+	pcie_dpc_disable = true;
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
@@ -532,5 +542,8 @@ static struct pcie_port_service_driver dpcdriver = {
 
 int __init pcie_dpc_init(void)
 {
+	if (pcie_dpc_disable)
+		return 0;
+
 	return pcie_port_service_register(&dpcdriver);
 }
-- 
2.51.0

