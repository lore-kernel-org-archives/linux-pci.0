Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934334AbcIFWUF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Sep 2016 18:20:05 -0400
Subject: [PATCH 1/2] PCI/AER: Remove aerdriver.nosourceid kernel parameter
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lance Ortiz <lance.ortiz@hpe.com>, Betty Dall <betty.dall@hpe.com>,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Chen Gong <gong.chen@linux.intel.com>,
        KeithBuschkeith.busch@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
        Huang Ying <ying.huang@intel.com>,
        Vijay Mohan Pandarathil <vijaymohan.pandarathil@hpe.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Date: Tue, 06 Sep 2016 17:19:42 -0500
Message-ID: <20160906221942.23655.87117.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160906221522.23655.66321.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160906221522.23655.66321.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The aerdriver.nosourceid kernel parameter was intended for working around
broken chipsets don't supply the source ID for AER events.  We recently
added PCI_BUS_FLAGS_NO_AERSID, which can be set by quirks for the same
purpose.

Remove the aerdriver.nosourceid kernel parameter.  For anything other than
debugging, asking users to find and use kernel parameters is a poor user
experience.  Instead, we should add PCI_BUS_FLAGS_NO_AERSID quirks for any
hardware that needs it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/pcieaer-howto.txt |    4 ----
 drivers/pci/pcie/aer/aerdrv_core.c  |   12 ++++--------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.txt
index b4987c0..4956df3 100644
--- a/Documentation/PCI/pcieaer-howto.txt
+++ b/Documentation/PCI/pcieaer-howto.txt
@@ -61,10 +61,6 @@ be initiated although firmwares have no _OSC support. To enable the
 walkaround, pls. add aerdriver.forceload=y to kernel boot parameter line
 when booting kernel. Note that forceload=n by default.
 
-nosourceid, another parameter of type bool, can be used when broken
-hardware (mostly chipsets) has root ports that cannot obtain the reporting
-source ID. nosourceid=n by default.
-
 2.3 AER error output
 When a PCI-E AER error is captured, an error message will be outputted to
 console. If it's a correctable error, it is outputted as a warning.
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 8f5e14c..f8a9b17 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -28,9 +28,7 @@
 #include "aerdrv.h"
 
 static bool forceload;
-static bool nosourceid;
 module_param(forceload, bool, 0);
-module_param(nosourceid, bool, 0);
 
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
@@ -132,8 +130,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	 * When bus id is equal to 0, it might be a bad id
 	 * reported by root port.
 	 */
-	if (!nosourceid &&
-	    (PCI_BUS_NUM(e_info->id) != 0) &&
+	if ((PCI_BUS_NUM(e_info->id) != 0) &&
 	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
 		/* Device ID match? */
 		if (e_info->id == ((dev->bus->number << 8) | dev->devfn))
@@ -146,11 +143,10 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 
 	/*
 	 * When either
-	 *      1) nosourceid==y;
-	 *      2) bus id is equal to 0. Some ports might lose the bus
+	 *      1) bus id is equal to 0. Some ports might lose the bus
 	 *              id of error source id;
-	 *      3) bus flag PCI_BUS_FLAGS_NO_AERSID is set
-	 *      4) There are multiple errors and prior ID comparing fails;
+	 *      2) bus flag PCI_BUS_FLAGS_NO_AERSID is set
+	 *      3) There are multiple errors and prior ID comparing fails;
 	 * We check AER status registers to find possible reporter.
 	 */
 	if (atomic_read(&dev->enable_cnt) == 0)

