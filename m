Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@sisk.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCHv2 5/5] ACPI / pcie: suppress compiler warning in portdrv_acpi.c
Date: Mon, 11 Mar 2013 11:17:08 +0200
Message-Id: <1362993428-14823-5-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch fixes following compiler warning when build via make W=1:

drivers/pci/pcie/portdrv_acpi.c:34:5: warning: no previous prototype for ‘pcie_port_acpi_setup’ [-Wmissing-prototypes]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pcie/portdrv_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
index a86b56e..b4d2894 100644
--- a/drivers/pci/pcie/portdrv_acpi.c
+++ b/drivers/pci/pcie/portdrv_acpi.c
@@ -17,6 +17,7 @@
 
 #include "aer/aerdrv.h"
 #include "../pci.h"
+#include "portdrv.h"
 
 /**
  * pcie_port_acpi_setup - Request the BIOS to release control of PCIe services.
-- 
1.8.2.rc0.22.gb3600c3

