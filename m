Return-Path: <SRS0=NXC0=7T=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=NXC0=7T=intel.com=jonathan.derrick@kernel.org>
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
Subject: [PATCH v2 1/4] MAINTAINERS: Add Jonathan Derrick as VMD maintainer
Date: Thu, 17 Aug 2017 12:10:11 -0600
Message-Id: <20170817181014.1257-2-jonathan.derrick@intel.com>
In-Reply-To: <20170817181014.1257-1-jonathan.derrick@intel.com>
References: <20170817181014.1257-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Add myself as VMD maintainer

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
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
