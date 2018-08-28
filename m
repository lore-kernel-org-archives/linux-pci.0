Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Punit Agrawal <punit.agrawal@arm.com>
To: bhelgaas@google.com
Subject: [PATCH 2/2] x86/PCI: Remove node-local allocation when initialising
 host controller
Date: Tue, 28 Aug 2018 16:05:13 +0100
Message-Id: <20180828150513.32458-3-punit.agrawal@arm.com>
In-Reply-To: <20180828150513.32458-1-punit.agrawal@arm.com>
References: <20180828150513.32458-1-punit.agrawal@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-pci@vger.kernel.org,
 x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 lorenzo.pieralisi@arm.com, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Memory for host controller data structures is allocated local to the
node to which the controller is associated with. This has been the
behaviour since 965cd0e4a5e5 ("x86, PCI, ACPI: Use kmalloc_node() to
optimize for performance") where the node local allocation was added
without additional context.

Drop the node local allocation as there is no benefit from doing so -
the usage of these structures is independent from where the controller
is located.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/pci/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 5559dcaddd5e..948656069cdd 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -356,7 +356,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	} else {
 		struct pci_root_info *info;
 
-		info = kzalloc_node(sizeof(*info), GFP_KERNEL, node);
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info)
 			dev_err(&root->device->dev,
 				"pci_bus %04x:%02x: ignored (out of memory)\n",
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
