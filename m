Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 3/9] PCI/AER: Remove unused version macros
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Date: Mon, 21 Nov 2016 15:45:34 -0600
Message-ID: <20161121214533.21036.70162.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the unused DRIVER_VERSION, DRIVER_AUTHOR, and DRIVER_DESC macros.
The author information is already included in a comment above.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 139150b..1c189e6 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -30,13 +30,6 @@
 #include "aerdrv.h"
 #include "../../pci.h"
 
-/*
- * Version Information
- */
-#define DRIVER_VERSION "v1.0"
-#define DRIVER_AUTHOR "tom.l.nguyen@intel.com"
-#define DRIVER_DESC "Root Port Advanced Error Reporting Driver"
-
 static int aer_probe(struct pcie_device *dev);
 static void aer_remove(struct pcie_device *dev);
 static pci_ers_result_t aer_error_detected(struct pci_dev *dev,
