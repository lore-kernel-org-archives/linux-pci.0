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
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 11/12] PCI: iproc: Add PAXBv2 binding info
Date: Mon, 31 Oct 2016 17:38:40 -0700
Message-Id: <1477960721-17649-12-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1477960721-17649-1-git-send-email-ray.jui@broadcom.com>
References: <1477960721-17649-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

Add new compatible string 'brcm,iproc-pcie-paxb-v2', for the next
generation of the iProc PAXB PCIe host controller

Signed-off-by: Oza Oza <oza.oza@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index 62a0ab9..c8d8c1c 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -4,6 +4,8 @@ Required properties:
 - compatible:
       "brcm,iproc-pcie" for the first generation of PAXB based controller,
 used in SoCs including NSP, Cygnus, NS2, and Pegasus
+      "brcm,iproc-pcie-paxb-v2" for the second generation of PAXB based
+controller, used in Stingray
       "brcm,iproc-pcie-paxc" for the first generation of PAXC based
 controller, used in NS2
       "brcm,iproc-pcie-paxc-v2" for the second generation of PAXC based
-- 
2.1.4
