Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
	linux-pci@vger.kernel.org,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/3] vmd: Use x86_vector_domain as parent domain
Date: Mon, 20 Jun 2016 09:39:52 -0600
Message-Id: <1466437193-17043-3-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1466437193-17043-1-git-send-email-jonathan.derrick@intel.com>
References: <1466437193-17043-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

From: Keith Busch <keith.busch@intel.com>

Otherwise apic code assumes vmd's irq domain can be managed by the apic,
resulting in an invalid cast of irq_data during irq_force_complete_move.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 arch/x86/pci/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index bd81393..a651eb0 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -599,7 +599,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
 	vmd->irq_domain = pci_msi_create_irq_domain(NULL, &vmd_msi_domain_info,
-						    NULL);
+						    x86_vector_domain);
 	if (!vmd->irq_domain)
 		return -ENODEV;
 
-- 
1.8.3.1
