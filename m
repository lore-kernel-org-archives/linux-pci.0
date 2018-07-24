Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v2 1/2] PCI: Export pcie_has_flr()
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Date: Mon, 23 Jul 2018 18:13:02 -0600
Message-ID: <20180724001302.7671.55571.stgit@gimli.home>
In-Reply-To: <20180724000944.7671.64284.stgit@gimli.home>
References: <20180724000944.7671.64284.stgit@gimli.home>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

pcie_flr() suggests pcie_has_flr() to ensure that PCIe FLR support is
present prior to calling.  pcie_flr() is exported while pcie_has_flr()
is not.  Resolve this.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.c   |    3 ++-
 include/linux/pci.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2bec76c9d9a7..52fe2d72a99c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4071,7 +4071,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
  * Returns true if the device advertises support for PCIe function level
  * resets.
  */
-static bool pcie_has_flr(struct pci_dev *dev)
+bool pcie_has_flr(struct pci_dev *dev)
 {
 	u32 cap;
 
@@ -4081,6 +4081,7 @@ static bool pcie_has_flr(struct pci_dev *dev)
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
 	return cap & PCI_EXP_DEVCAP_FLR;
 }
+EXPORT_SYMBOL_GPL(pcie_has_flr);
 
 /**
  * pcie_flr - initiate a PCIe function level reset
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 04c7ea6ed67b..bbe030d7814f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1092,6 +1092,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
 void pcie_print_link_status(struct pci_dev *dev);
+bool pcie_has_flr(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
