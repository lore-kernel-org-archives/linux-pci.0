Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	helgaas@kernel.org
Cc: jose.abreu@synopsys.com, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] pci: pcie-designware-plat: changing maintainer
Date: Fri, 14 Oct 2016 17:01:21 +0100
Message-Id: <0c901c49ad655165e5f72245e9d260f43968cf9e.1476460342.git.jpinto@synopsys.com>
List-ID: <linux-pci.vger.kernel.org>

I am going to leave Synopsys and so this patch changes the Maintainer
for PCIe Designware Platform driver to my colleague Jose Abreu.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01bff8e..5ac91d8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9052,7 +9052,7 @@ S:	Maintained
 F:	drivers/pci/host/*designware*
 
 PCI DRIVER FOR SYNOPSYS PROTOTYPING DEVICE
-M:	Joao Pinto <jpinto@synopsys.com>
+M:	Jose Abreu <Jose.Abreu@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
-- 
1.8.1.5
