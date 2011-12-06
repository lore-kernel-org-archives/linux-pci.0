Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [62.1.205.36] ([62.1.205.36]:43285 "EHLO igloo.linux.gr"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab1LFTDv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 6 Dec 2011 14:03:51 -0500
Subject: [PATCH] kconfig: English typo in pci/pcie/Kconfig
From: "P. Christeas" <xrg@linux.gr>
Date: Tue, 6 Dec 2011 20:48:35 +0200
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Matthew Garrett <mjg@redhat.com>
Cc: linux-pci@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201112062048.37576.xrg@linux.gr>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just fix this help text.

Signed-off-by: P. Christeas <xrg@linux.gr>
---
 drivers/pci/pcie/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index dc29348..72962cc 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -39,7 +39,7 @@ config PCIEASPM
 	  Power Management) and Clock Power Management. ASPM supports
 	  state L0/L0s/L1.
 
-	  ASPM is initially set up the the firmware. With this option enabled,
+	  ASPM is initially set up by the firmware. With this option enabled,
 	  Linux can modify this state in order to disable ASPM on known-bad
 	  hardware or configurations and enable it when known-safe.
 
-- 
1.7.4.4

