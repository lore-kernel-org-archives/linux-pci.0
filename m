Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:24532 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751348Ab3LLLi5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 06:38:57 -0500
From: Jagannadha Sutradharudu Teki
	<jagannadha.sutradharudu-teki@xilinx.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Rob Landley <rob@landley.net>, <linux-pci@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Subject: [PATCH v2 1/2] Documentation: pci: Minor cleanup
Date: Thu, 12 Dec 2013 17:08:44 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ce61b66d-a2e9-4b0d-8000-852f27606294@TX2EHSMHS027.ehs.local>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

- Used small letters for file names
- Renamed few pcie txt files
- Re-arranged file names in 00-INDEX
- Removed PCI-DMA-mapping.txt from 00-INDEX

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
---
Changes for v2:
	- none

 Documentation/PCI/00-INDEX                         | 22 +++++++++++-----------
 .../PCI/{pcieaer-howto.txt => pcie-aer-howto.txt}  |  0
 .../PCI/{pci-iov-howto.txt => pcie-iov-howto.txt}  |  0
 .../{PCIEBUS-HOWTO.txt => pcie-portbus-howto.txt}  |  0
 4 files changed, 11 insertions(+), 11 deletions(-)
 rename Documentation/PCI/{pcieaer-howto.txt => pcie-aer-howto.txt} (100%)
 rename Documentation/PCI/{pci-iov-howto.txt => pcie-iov-howto.txt} (100%)
 rename Documentation/PCI/{PCIEBUS-HOWTO.txt => pcie-portbus-howto.txt} (100%)

diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
index 812b17f..b8b7721 100644
--- a/Documentation/PCI/00-INDEX
+++ b/Documentation/PCI/00-INDEX
@@ -1,14 +1,14 @@
 00-INDEX
 	- this file
-MSI-HOWTO.txt
-	- the Message Signaled Interrupts (MSI) Driver Guide HOWTO and FAQ.
-PCI-DMA-mapping.txt
-	- info for PCI drivers using DMA portably across all platforms
-PCIEBUS-HOWTO.txt
-	- a guide describing the PCI Express Port Bus driver
-pci-error-recovery.txt
-	- info on PCI error recovery
 pci.txt
-	- info on the PCI subsystem for device driver authors
-pcieaer-howto.txt
-	- the PCI Express Advanced Error Reporting Driver Guide HOWTO
+	- Info on the PCI subsystem for device driver authors
+pci-error-recovery.txt
+	- Info on PCI error recovery
+MSI-HOWTO.txt
+	- The Message Signaled Interrupts (MSI) Driver Guide HOWTO and FAQ
+pcie-portbus-howto.txt
+	- A guide describing the PCI Express Port Bus driver
+pcie-aer-howto.txt
+	- The PCI Express Advanced Error Reporting Driver Guide HOWTO
+pcie-iov-howto.txt
+	- Info on PCI Express I/O Virtualization
diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcie-aer-howto.txt
similarity index 100%
rename from Documentation/PCI/pcieaer-howto.txt
rename to Documentation/PCI/pcie-aer-howto.txt
diff --git a/Documentation/PCI/pci-iov-howto.txt b/Documentation/PCI/pcie-iov-howto.txt
similarity index 100%
rename from Documentation/PCI/pci-iov-howto.txt
rename to Documentation/PCI/pcie-iov-howto.txt
diff --git a/Documentation/PCI/PCIEBUS-HOWTO.txt b/Documentation/PCI/pcie-portbus-howto.txt
similarity index 100%
rename from Documentation/PCI/PCIEBUS-HOWTO.txt
rename to Documentation/PCI/pcie-portbus-howto.txt
-- 
1.8.3


