Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH] PCI: Add pci=safemode option
Date: Tue, 29 May 2018 23:19:41 -0400
Message-Id: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Keith Busch <keith.busch@intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Ingo Molnar <mingo@kernel.org>,
 Christoffer Dall <cdall@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Dongdong Liu <liudongdong3@huawei.com>, David Rientjes <rientjes@google.com>,
 Thymo van Beers <thymovanbeers@gmail.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Frederick Lawler <fred@fredlawl.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Sinan Kaya <okaya@codeaurora.org>, Oza Pawandeep <poza@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Adding pci=safemode kernel command line parameter to turn off all PCI
Express service driver as well as all optional PCIe features such as LTR,
Extended tags, Relaxed Ordering etc.

Also setting MPS configuration to PCIE_BUS_SAFE so that MPS and MRRS can be
reconfigured with by the kernel in case BIOS hands off a broken
configuration.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 drivers/pci/pci.c                               | 7 +++++++
 drivers/pci/pci.h                               | 2 ++
 drivers/pci/pcie/portdrv_core.c                 | 2 +-
 drivers/pci/probe.c                             | 6 ++++++
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 641ec9c..247adbb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3153,6 +3153,8 @@
 		noari		do not use PCIe ARI.
 		noats		[PCIE, Intel-IOMMU, AMD-IOMMU]
 				do not use PCIe ATS (and IOMMU device IOTLB).
+		safemode	turns of all optinal PCI features. Useful
+				for bringup/troubleshooting.
 		pcie_scan_all	Scan all possible PCIe devices.  Otherwise we
 				only look for one device below a PCIe downstream
 				port.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d27f771..11f0282 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -115,6 +115,9 @@ static bool pcie_ari_disabled;
 /* If set, the PCIe ATS capability will not be used. */
 static bool pcie_ats_disabled;
 
+/* If set, disables most of the optional PCI features */
+bool pci_safe_mode;
+
 bool pci_ats_disabled(void)
 {
 	return pcie_ats_disabled;
@@ -5845,6 +5848,10 @@ static int __init pci_setup(char *str)
 		if (*str && (str = pcibios_setup(str)) && *str) {
 			if (!strcmp(str, "nomsi")) {
 				pci_no_msi();
+			} else if (!strncmp(str, "safemode", 8)) {
+				pr_info("PCI: safe mode with minimum features\n");
+				pci_safe_mode = true;
+				pcie_bus_config = PCIE_BUS_SAFE;
 			} else if (!strncmp(str, "noats", 5)) {
 				pr_info("PCIe: ATS is disabled\n");
 				pcie_ats_disabled = true;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a0..4517bcd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -8,6 +8,8 @@
 
 extern const unsigned char pcie_link_speed[];
 
+extern bool pci_safe_mode;
+
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 
 /* Functions internal to the PCI core code */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index a5b3b3a..9fe4ed6 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -311,7 +311,7 @@ int pcie_port_device_register(struct pci_dev *dev)
 
 	/* Get and check PCI Express port services */
 	capabilities = get_port_device_capability(dev);
-	if (!capabilities)
+	if (!capabilities || pci_safe_mode)
 		return 0;
 
 	pci_set_master(dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3840207..295b79c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2047,6 +2047,9 @@ static void pci_configure_device(struct pci_dev *dev)
 	struct hotplug_params hpp;
 	int ret;
 
+	if (pci_safe_mode)
+		return;
+
 	pci_configure_mps(dev);
 	pci_configure_extended_tags(dev, NULL);
 	pci_configure_relaxed_ordering(dev);
@@ -2213,6 +2216,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Setup MSI caps & disable MSI/MSI-X interrupts */
 	pci_msi_setup_pci_dev(dev);
 
+	if (pci_safe_mode)
+		return;
+
 	/* Buffers for saving PCIe and PCI-X capabilities */
 	pci_allocate_cap_save_buffers(dev);
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
