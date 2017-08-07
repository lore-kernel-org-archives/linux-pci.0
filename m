Return-Path: <SRS0=ZMnZ=7J=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=ZMnZ=7J=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Keith Busch <keith.busch@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	David Fugate <david.fugate@intel.com>,
	<linux-kernel@vger.kernel.org>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 1/3] MAINTAINERS: Add Jonathan Derrick as VMD maintainer
Date: Mon,  7 Aug 2017 13:57:11 -0600
Message-Id: <20170807195713.10963-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Add myself as VMD maintainer

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f66488d..3ec39df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10090,6 +10090,7 @@ F:	drivers/pci/dwc/*imx6*
 
 PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
 M:	Keith Busch <keith.busch@intel.com>
+M:	Jonathan Derrick <jonathan.derrick@intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	drivers/pci/host/vmd.c
-- 
2.9.4
