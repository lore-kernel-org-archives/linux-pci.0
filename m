Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 12/13] PCI/portdrv: Encapsulate pcie_ports_auto inside
 the port driver
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>
Date: Fri, 09 Mar 2018 13:00:54 -0600
Message-ID: <152062205448.77693.17566179285103522183.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

"pcie_ports_auto" is only used inside the PCIe port driver itself, so
move it from include/linux/pci.h to portdrv.h so it's not visible to the
whole kernel.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv.h |    2 ++
 include/linux/pci.h        |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 86368f9341d7..62e28b5afa51 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -12,6 +12,8 @@
 
 #include <linux/compiler.h>
 
+extern bool pcie_ports_auto;
+
 /* Service Type */
 #define PCIE_PORT_SERVICE_PME_SHIFT	0	/* Power Management Event */
 #define PCIE_PORT_SERVICE_PME		(1 << PCIE_PORT_SERVICE_PME_SHIFT)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 40aec7a6fdd9..2c0e5d929fd2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1449,10 +1449,8 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 
 #ifdef CONFIG_PCIEPORTBUS
 extern bool pcie_ports_disabled;
-extern bool pcie_ports_auto;
 #else
 #define pcie_ports_disabled	true
-#define pcie_ports_auto		false
 #endif
 
 #ifdef CONFIG_PCIEASPM
