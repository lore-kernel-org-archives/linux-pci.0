Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Darren Hart <dvhart@linux.intel.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, peter.p.waskiewicz.jr@intel.com,
	andriy.shevchenko@linux.intel.com, danders@circuitco.com,
	vishal.l.verma@intel.com, dvhart@linux.intel.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 7/8] pci: Add CircuitCo VENDOR ID and MinnowBoard DEVICE ID
Date: Tue, 25 Jun 2013 18:53:27 -0700
Message-Id: <83879b07cd4ce95f086420d1faa926c1692d63b4.1372211451.git.dvhart@linux.intel.com>
In-Reply-To: <cover.1372211451.git.dvhart@linux.intel.com>
References: <cover.1372211451.git.dvhart@linux.intel.com>
In-Reply-To: <cover.1372211451.git.dvhart@linux.intel.com>
References: <cover.1372211451.git.dvhart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add CircuitCo's newly created VENDOR ID and their first board subsystem
ID for the MinnowBoard.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Anders <danders@circuitco.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Waskiewicz <peter.p.waskiewicz.jr@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org
---
 include/linux/pci_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c129162..b2879ce 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -149,6 +149,9 @@
 #define PCI_DEVICE_ID_BERKOM_A4T		0xffa4
 #define PCI_DEVICE_ID_BERKOM_SCITEL_QUADRO	0xffa8
 
+#define PCI_VENDOR_ID_CIRCUITCO			0x1cc8
+#define PCI_DEVICE_ID_CIRCUITCO_MINNOWBOARD	0x0001
+
 #define PCI_VENDOR_ID_COMPAQ		0x0e11
 #define PCI_DEVICE_ID_COMPAQ_TOKENRING	0x0508
 #define PCI_DEVICE_ID_COMPAQ_TACHYON	0xa0fc
-- 
1.8.1.2

