Return-Path: <ray.jui@broadcom.com>
Return-Path: <ray.jui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Alex Barba <alex.barba@broadcom.com>,
	Oza Oza <oza.oza@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 09/12] PCI: iproc: Update iProc PCIe DT binding
Date: Mon, 24 Oct 2016 15:17:09 -0700
Message-Id: <1477347432-17656-10-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1477347432-17656-1-git-send-email-ray.jui@broadcom.com>
References: <1477347432-17656-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

Add description for optional device tree property 'dma-ranges' for
inbound mapping

Signed-off-by: Oza Oza <oza.oza@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index f827b8d..62a0ab9 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -25,6 +25,9 @@ Optional properties:
 - phys: phandle of the PCIe PHY device
 - phy-names: must be "pcie-phy"
 - dma-coherent: present if DMA operations are coherent
+- dma-ranges: Some PAXB based root complexes do not have inbound mapping done
+  by the ASIC after power on reset. In this case, SW is required to configure
+the mapping, based on inbound memory regions specified by this property
 
 - brcm,pcie-ob: Some iProc SoCs do not have the outbound address mapping done
 by the ASIC after power on reset. In this case, SW needs to configure it
-- 
2.1.4
