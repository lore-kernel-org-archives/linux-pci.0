Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/4] ARM64/PCI: remove arch specific pcibios_enable_device()
Date: Wed,  8 Jun 2016 12:04:49 +0100
Message-Id: <1465383890-13538-4-git-send-email-lorenzo.pieralisi@arm.com>
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

The arm64 pcibios_enable_device() implementation exists solely
to prevent enabling PCI resources on PCI_PROBE_ONLY systems, since
on those systems the PCI resources are currently not claimed (ie
inserted in the PCI resource tree - which means their parent
pointer is not correctly set-up) therefore they can not be enabled
since this would trigger PCI set-ups failures.

By introducing resources claiming in the PCI host controllers set-ups
that have PCI_PROBE_ONLY as a probe option, there is no need for arch
specific pcibios_enable_device() implementations anymore in that the
kernel can rely on the generic pcibios_enable_device() implementation
without resorting to arch specific code to work around the missing
resources claiming enumeration step.

On !PCI_PROBE_ONLY PCI bus set-ups, resources are always assigned
in the PCI host controllers drivers; since the PCI resource assignment
API takes care of inserting the assigned resources in the resource tree,
the resources parent pointer is correctly set-up, which means that this
patch leaves behaviour unchanged for all arm64 PCI set-ups that do not
set the PCI_PROBE_ONLY flag.

Remove the pcibios_enable_device() function from the arm64 arch
back-end so that the kernel now uses its generic implementation.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/pci.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 3c4e308..39cfa03 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -36,19 +36,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return res->start;
 }
 
-/**
- * pcibios_enable_device - Enable I/O and memory.
- * @dev: PCI device to be enabled
- * @mask: bitmask of BARs to enable
- */
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	if (pci_has_flag(PCI_PROBE_ONLY))
-		return 0;
-
-	return pci_enable_resources(dev, mask);
-}
-
 /*
  * Try to assign the IRQ number from DT when adding a new device
  */
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
