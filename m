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
Subject: [PATCH 07/12] PCI: iproc: Update iProc PCIe DT binding
Date: Mon, 24 Oct 2016 15:17:07 -0700
Message-Id: <1477347432-17656-8-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1477347432-17656-1-git-send-email-ray.jui@broadcom.com>
References: <1477347432-17656-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

Remove the following outbound related device tree properties:
brcm,pcie-ob-window-size
brcm,pcie-ob-oarr-size

The above two prperties are a bit duplicated in functions. In addition,
the next generation iProc PCIe controller has outbound mapping window that
supports more than just two sizes, which cannot be properly supported by
these properties

A better solution is to make the driver outbound mapping logic slightly
more inteligent so it can figure out how to configure the outbound mapping
based on the 'ranges' specified in device tree and the number and sizes
of the outbound mapping windows that a particular revision of the iProc
PCIe controller can support

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index 071bbc2..f827b8d 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -35,11 +35,6 @@ effective:
 Required:
 - brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
 address used by the iProc PCIe core (not the PCIe address)
-- brcm,pcie-ob-window-size: The outbound address mapping window size (in MB)
-
-Optional:
-- brcm,pcie-ob-oarr-size: Some iProc SoCs need the OARR size bit to be set to
-increase the outbound window size
 
 MSI support (optional):
 
@@ -95,9 +90,7 @@ Example:
 		phy-names = "pcie-phy";
 
 		brcm,pcie-ob;
-		brcm,pcie-ob-oarr-size;
 		brcm,pcie-ob-axi-offset = <0x00000000>;
-		brcm,pcie-ob-window-size = <256>;
 
 		msi-parent = <&msi0>;
 
-- 
2.1.4
