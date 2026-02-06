Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48885335547;
	Fri,  6 Feb 2026 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770402227; cv=none; b=HgV3aRsVP8YcBIkUget7cgdpr9LKiq8lLGJoCYT986IgrVuy3QSc1ehpUF4aEbjFuSw4PhRv+9Hp1en7lc93hAMPDRFftWZrZjhGuhk5MXbAay0w2RdmmOTcK/BNKgY9JAsNjsMVrn98bUNb/eMMu7+IJO/rlKIP6aE5fc6jLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770402227; c=relaxed/simple;
	bh=NLJTjdEuvXlzEMjjb/lVm25SG7TTpAM8I0Xs7X9vCA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UvT9elSkVnZwaQehwWURG/3gSSQX4FZEtc/mFagM0cFvpJRrj2fm80z2bH3XeChC8SjVmefBvlUB+M51pK7QhbsiJ/ubexNeppLtBymYVHKbqldy/JeE+WNJrtyDtYX4bbHcZifTwZsCybDikLed/BWzikY3mf+E5Q/81htJOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fJO4rH2R; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="fJO4rH2R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=jebKBLlng7MbRbI0s5SEHj0gh6mnYIB+0HCeDj0VqTY=; b=fJO4rH2R+e5i0VFDa6OrJXhSLZ
	Fdj4gfb+RzHTNX2B6kx4Mu1n9vC0HmYS4J5n/HNw53/qkN/3zySwNlKYZJMCwXEjFFRiRUaQ57zLb
	dKu364fhMg9f5LzKC5rnKeWbLbFKteijmEXG+vIkYYu/kNNZ/GWWPZ+mIyMEua5rLbLWz8ieRzBE1
	CCgL5/XjLSveN89Fy54iKsoIQPpbfM3zfxK/zuUuKLSz7+gYbZIXtYZLnf6nCTyo8SL+MJsCuixO8
	+iF4rtxOYJHVz16dG+jMNRVhNENEmyGbjSWW6SVyQqhsP2AsRRSB6RgyOCOx7PdWXbOgTP3X59cbs
	fBbcfHpQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1voQUU-007LhV-AP; Fri, 06 Feb 2026 18:23:38 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 06 Feb 2026 10:23:11 -0800
Subject: [PATCH] PCI/AER: Add option to panic on unrecoverable errors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-pci-v1-1-85160f02d956@debian.org>
X-B4-Tracking: v=1; b=H4sIAI8xhmkC/yXMQQqDMBBG4asM/9pAMkIsuYq40DhppwsriYog3
 r2oy7f43oEiWaUg0IEsmxb9TQjkKkL89NNbjI4IBLbsLVtv5qim9hyTa9i9moSKMGdJut+Xtnu
 6rMNX4nJRnOcffHyyZmcAAAA=
X-Change-ID: 20260206-pci-362cf172187f
To: Jonathan Corbet <corbet@lwn.net>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 kbusch@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 dcostantino@meta.com, rneu@meta.com, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=3984; i=leitao@debian.org;
 h=from:subject:message-id; bh=NLJTjdEuvXlzEMjjb/lVm25SG7TTpAM8I0Xs7X9vCA0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBphjGhnLQnqdXoF2/wZy8uYIo7655acHbzSapTJ
 it+KU0GEWiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYYxoQAKCRA1o5Of/Hh3
 bQygD/kBDTqiGWi3gm2/bDdHYTUCBcqeHDi7jQez7MTGnt1g9W/1Cv2Yu5najPwWVGrUOZv/lq/
 jYdFkcA2PqYjVEIVk90cZ3mlqubBqO+lfD4OFquwitnNmG0NkZzMEjtGASg+RX6oeQtszylOPyg
 0Ti2Lefc1n20VyZqmDPX9vkwO9FYvb7uvXi3oftRJdKKOycOnOnrl0osLrCo8+0zLXrz40G3qql
 m/0NSwC6Cx/SoGcWI4vp0hZsxDrEf/R9nLAGDPw8bcsN2/0+h5g8FMVnZkCUHV0QL//Zkkmnd8M
 Cjf/8UAqFb9JPPwLAJ7BTdMVliWzAylGKfZYdJkv3Grrw8eVdsljSGI3rQHCOpO3T1X4sKc7maL
 zyYajMRfBZHzOevoriGkYeWAZjx+81ILFhUdSkTsQ66lcmE4X8u/arGnCMsghjSCHy92ccmIPdx
 DdYULlPuLVmRaiegaY1ZycTdz8+3ZxHXmdHXlF3cY4ULkfzPyfsXeSRn653fvzKmytJSBPTVrKi
 ODHjN/2BRfT67+p2JP5jju7ubTnTRIg5o4pubruVvJjz59Jpiev/1G1prB+Kioy4KVVrIboF80m
 T+fOQrdsldIFOmmekCb9aVUZ6aMJJhyHGJoD4IFt/aqAOU++5iDwuZVCMO9vSlGMJOT3KBycUJS
 HtwwkGmXljjtpBA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

When a device lacks an error_detected callback, AER recovery fails and
the device is left in a disconnected state. This can mask serious
hardware issues during development and testing.

Add a module parameter 'aer_unrecoverable_fatal' that panics the kernel
instead, making such failures immediately visible. The parameter
defaults to false to preserve existing behavior.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
In environments where all hardware must be fully operational, silently
leaving a device in a disconnected state after an AER recovery failure
is unacceptable. This is common in high-reliability systems, production
servers, and testing infrastructure where a degraded system should not
continue running.

This patch adds a module parameter that allows administrators to enforce
a strict policy: if a device cannot recover from an AER error, the
kernel panics instead of continuing with degraded hardware. This ensures
that hardware failures are immediately visible and can trigger
appropriate remediation (restart, failover, alerting).
---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
 drivers/pci/pcie/err.c                          | 3 +++
 drivers/pci/pcie/portdrv.c                      | 7 +++++++
 drivers/pci/pcie/portdrv.h                      | 1 +
 4 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1058f2a6d6a8c..ff95c24280e3c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5240,6 +5240,15 @@ Kernel parameters
 		nomsi	Do not use MSI for native PCIe PME signaling (this makes
 			all PCIe root ports use INTx for all services).
 
+	pcieportdrv.aer_unrecoverable_fatal=
+			[PCIE] Panic on unrecoverable AER errors:
+		0	Log the error and leave the device in a disconnected
+			state (default).
+		1	Panic the kernel when a device cannot recover from an
+			AER error (no error_detected callback). Useful for
+			high-reliability systems where degraded hardware is
+			unacceptable.
+
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
 	pd_ignore_unused
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index bebe4bc111d75..788484791902e 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -73,6 +73,9 @@ static int report_error_detected(struct pci_dev *dev,
 		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
 			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
 			pci_info(dev, "can't recover (no error_detected callback)\n");
+			if (aer_unrecoverable_fatal)
+				panic("AER: %s: no error_detected callback\n",
+				      pci_name(dev));
 		} else {
 			vote = PCI_ERS_RESULT_NONE;
 		}
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 38a41ccf79b9a..a411f60ff50ce 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -22,6 +22,13 @@
 #include "../pci.h"
 #include "portdrv.h"
 
+#ifdef CONFIG_PCIEAER
+bool aer_unrecoverable_fatal;
+module_param(aer_unrecoverable_fatal, bool, 0644);
+MODULE_PARM_DESC(aer_unrecoverable_fatal,
+		 "Panic if a device cannot recover from an AER error (default: false)");
+#endif
+
 /*
  * The PCIe Capability Interrupt Message Number (PCIe r3.1, sec 7.8.2) must
  * be one of the first 32 MSI-X entries.  Per PCI r3.0, sec 6.8.3.1, MSI
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index bd29d1cc7b8bd..6c67b18de93c9 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -29,6 +29,7 @@ extern bool pcie_ports_dpc_native;
 
 #ifdef CONFIG_PCIEAER
 int pcie_aer_init(void);
+extern bool aer_unrecoverable_fatal;
 #else
 static inline int pcie_aer_init(void) { return 0; }
 #endif

---
base-commit: 6bd9ed02871f22beb0e50690b0c3caf457104f7c
change-id: 20260206-pci-362cf172187f

Best regards,
--  
Breno Leitao <leitao@debian.org>

