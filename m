Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V4 25/26] i7300_idle: remove unused file
Date: Tue, 19 Dec 2017 00:38:01 -0500
Message-Id: <1513661883-28662-26-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-msm@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

i7300_idle.h is not being called by any source file and contains calls to
pci_get_bus_and_slot() that we are trying to deprecate. Remove unused file.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/linux/i7300_idle.h | 84 ----------------------------------------------
 1 file changed, 84 deletions(-)
 delete mode 100644 include/linux/i7300_idle.h

diff --git a/include/linux/i7300_idle.h b/include/linux/i7300_idle.h
deleted file mode 100644
index 4dbe651..0000000
--- a/include/linux/i7300_idle.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef I7300_IDLE_H
-#define I7300_IDLE_H
-
-#include <linux/pci.h>
-
-/*
- * I/O AT controls (PCI bus 0 device 8 function 0)
- * DIMM controls (PCI bus 0 device 16 function 1)
- */
-#define IOAT_BUS 0
-#define IOAT_DEVFN PCI_DEVFN(8, 0)
-#define MEMCTL_BUS 0
-#define MEMCTL_DEVFN PCI_DEVFN(16, 1)
-
-struct fbd_ioat {
-	unsigned int vendor;
-	unsigned int ioat_dev;
-	unsigned int enabled;
-};
-
-/*
- * The i5000 chip-set has the same hooks as the i7300
- * but it is not enabled by default and must be manually
- * manually enabled with "forceload=1" because it is
- * only lightly validated.
- */
-
-static const struct fbd_ioat fbd_ioat_list[] = {
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT_CNB, 1},
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT, 0},
-	{0, 0}
-};
-
-/* table of devices that work with this driver */
-static const struct pci_device_id pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_FBD_CNB) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
-	{ } /* Terminating entry */
-};
-
-/* Check for known platforms with I/O-AT */
-static inline int i7300_idle_platform_probe(struct pci_dev **fbd_dev,
-						struct pci_dev **ioat_dev,
-						int enable_all)
-{
-	int i;
-	struct pci_dev *memdev, *dmadev;
-
-	memdev = pci_get_bus_and_slot(MEMCTL_BUS, MEMCTL_DEVFN);
-	if (!memdev)
-		return -ENODEV;
-
-	for (i = 0; pci_tbl[i].vendor != 0; i++) {
-		if (memdev->vendor == pci_tbl[i].vendor &&
-		    memdev->device == pci_tbl[i].device) {
-			break;
-		}
-	}
-	if (pci_tbl[i].vendor == 0)
-		return -ENODEV;
-
-	dmadev = pci_get_bus_and_slot(IOAT_BUS, IOAT_DEVFN);
-	if (!dmadev)
-		return -ENODEV;
-
-	for (i = 0; fbd_ioat_list[i].vendor != 0; i++) {
-		if (dmadev->vendor == fbd_ioat_list[i].vendor &&
-		    dmadev->device == fbd_ioat_list[i].ioat_dev) {
-			if (!(fbd_ioat_list[i].enabled || enable_all))
-				continue;
-			if (fbd_dev)
-				*fbd_dev = memdev;
-			if (ioat_dev)
-				*ioat_dev = dmadev;
-
-			return 0;
-		}
-	}
-	return -ENODEV;
-}
-
-#endif
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
