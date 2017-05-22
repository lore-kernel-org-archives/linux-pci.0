Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM64: PCI: Fix struct acpi_pci_root_ops allocation failure
 path
Date: Mon, 22 May 2017 16:48:28 +0100
Message-Id: <20170522154828.10872-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, Timmy Li <lixiaoping3@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Tomasz Nowicki <tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Timmy Li <lixiaoping3@huawei.com>

Commit 093d24a20442 ("arm64: PCI: Manage controller-specific data on
per-controller basis") added code to allocate ACPI PCI root_ops
dynamically on a per host bridge basis but failed to update the
corresponding memory allocation failure path in pci_acpi_scan_root()
leading to a potential memory leakage.

Fix it by adding the required kfree call.

Fixes: 093d24a20442 ("arm64: PCI: Manage controller-specific data on per-controller basis")
Signed-off-by: Timmy Li <lixiaoping3@huawei.com>
[lorenzo.pieralisi@arm.com: refactored code, rewrote commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 arch/arm64/kernel/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 4f0e3eb..c7e3e63 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -191,8 +191,10 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		return NULL;
 
 	root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
-	if (!root_ops)
+	if (!root_ops) {
+		kfree(ri);
 		return NULL;
+	}
 
 	ri->cfg = pci_acpi_setup_ecam_mapping(root);
 	if (!ri->cfg) {
-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
