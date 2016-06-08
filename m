Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/4] PCI: host-generic: claim bus resources on
 PCI_PROBE_ONLY set-ups
Date: Wed,  8 Jun 2016 12:04:48 +0100
Message-Id: <1465383890-13538-3-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1465383890-13538-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465383890-13538-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 David Daney <david.daney@cavium.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The PCI host generic driver does not reassign bus resources on systems
that require the BARs set-up to be immutable (ie PCI_PROBE_ONLY) since
that would trigger system failures. Nonetheless, PCI bus resources
allocated to PCI bridge and devices must be claimed in order to be
validated and inserted in the kernel resource tree, but the current
driver omits the resources claiming and relies on arch specific kludges
to prevent probing failure (ie preventing resources enablement on
PCI_PROBE_ONLY systems).

Add code to the PCI host generic driver that correctly claims bus
resources upon probe on systems that are required to prevent
reassignment after bus enumeration, so that the allocated resources
can be enabled successfully upon PCI device drivers probing, without
resorting to arch back-ends workarounds.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Daney <david.daney@cavium.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-host-common.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index 8cba7ab..1684882 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -154,8 +154,31 @@ int pci_host_common_probe(struct platform_device *pdev,
 	}
 
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
-
-	if (!pci_has_flag(PCI_PROBE_ONLY)) {
+	/*
+	 * For PCI bridges and PCI devices to be fully set-up, their
+	 * resources must be initialized and inserted in the kernel
+	 * resource tree, which implicitly means that the resources
+	 * are correctly inserted in the kernel resource tree and are
+	 * assigned a parent pointer to create the resource hierarchy.
+	 *
+	 * On PCI_PROBE_ONLY systems, the pci_bus_claim_resource()
+	 * API claims the resources as set-up by firmware, which takes
+	 * care of inserting them in the resource tree and setting their
+	 * parent pointers accordingly.
+	 *
+	 * On !PCI_PROBE_ONLY systems, the firmware set-up is discarded,
+	 * and resource assignment and insertion in the resource tree is
+	 * carried out through the PCI resources API:
+	 *
+	 * (ie pci_bus_size_bridges() and pci_bus_assign_resources())
+	 *
+	 * that sizes the bridges and assigns and inserts resources in the
+	 * kernel resource tree (which also implies setting up their parent
+	 * pointers), completing the resources set-up.
+	 */
+	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_claim_resources(bus);
+	} else {
 		pci_bus_size_bridges(bus);
 		pci_bus_assign_resources(bus);
 
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
