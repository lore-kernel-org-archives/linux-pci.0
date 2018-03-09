Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932074AbeCITAu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Mar 2018 14:00:50 -0500
Subject: [PATCH v2 11/13] PCI/portdrv: Remove unnecessary "pcie_ports=auto"
 parameter
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>
Date: Fri, 09 Mar 2018 13:00:49 -0600
Message-ID: <152062204910.77693.7950471630136609237.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The "pcie_ports=auto" parameter set pcie_ports_disabled and pcie_ports_auto
to their compiled-in defaults, so specifying the parameter is the same as
not using it at all.

Remove the "pcie_ports=auto" parameter and update the documentation.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt |   15 +++++++--------
 drivers/pci/pcie/portdrv_pci.c                  |    3 ---
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 761749562165..26565794a573 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3130,14 +3130,13 @@
 		force	Enable ASPM even on devices that claim not to support it.
 			WARNING: Forcing ASPM on may cause system lockups.
 
-	pcie_ports=	[PCIE] PCIe ports handling:
-		auto	Ask the BIOS whether or not to use native PCIe services
-			associated with PCIe ports (PME, hot-plug, AER).  Use
-			them only if that is allowed by the BIOS.
-		native	Use native PCIe services associated with PCIe ports
-			unconditionally.
-		compat	Treat PCIe ports as PCI-to-PCI bridges, disable the PCIe
-			ports driver.
+	pcie_ports=	[PCIE] PCIe port services handling:
+		native	Use native PCIe services (PME, AER, DPC, PCIe hotplug)
+			even if the platform doesn't give the OS permission to
+			use them.  This may cause conflicts if the platform
+			also tries to use these services.
+		compat	Disable native PCIe services (PME, AER, DPC, PCIe
+			hotplug).
 
 	pcie_port_pm=	[PCIE] PCIe port power management handling:
 		off	Disable power management of all PCIe ports
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 1997d9f2743e..8b62192342ac 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -37,9 +37,6 @@ static int __init pcie_port_setup(char *str)
 	} else if (!strncmp(str, "native", 6)) {
 		pcie_ports_disabled = false;
 		pcie_ports_auto = false;
-	} else if (!strncmp(str, "auto", 4)) {
-		pcie_ports_disabled = false;
-		pcie_ports_auto = true;
 	}
 
 	return 1;
