Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Punit Agrawal <punit.agrawal@arm.com>
To: bhelgaas@google.com
Cc: Punit Agrawal <punit.agrawal@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        will.deacon@arm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 1/2] arm64: PCI: Remove node-local allocations when initialising host controller
Date: Tue, 28 Aug 2018 16:05:12 +0100
Message-Id: <20180828150513.32458-2-punit.agrawal@arm.com>
In-Reply-To: <20180828150513.32458-1-punit.agrawal@arm.com>
References: <20180828150513.32458-1-punit.agrawal@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Memory for host controller data structures is allocated local to the
node to which the controller is associated with. This has been the
behaviour since support for ACPI was added in
commit 0cb0786bac15 ("ARM64: PCI: Support ACPI-based PCI host controller").

Drop the node local allocation as there is no benefit from doing so -
the usage of these structures is independent from where the controller
is located.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kernel/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 0e2ea1c78542..bb85e2f4603f 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -165,16 +165,15 @@ static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
 /* Interface called from ACPI code to setup PCI host controller */
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 {
-	int node = acpi_get_node(root->device->handle);
 	struct acpi_pci_generic_root_info *ri;
 	struct pci_bus *bus, *child;
 	struct acpi_pci_root_ops *root_ops;
 
-	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
+	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
 	if (!ri)
 		return NULL;
 
-	root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
+	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
 	if (!root_ops) {
 		kfree(ri);
 		return NULL;
-- 
2.18.0
