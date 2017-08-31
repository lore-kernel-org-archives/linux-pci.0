Return-Path: <SRS0=0re9=AB=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=0re9=AB=broadcom.com=oza.oza@kernel.org>
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	<helgaas@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Oza Pawandeep <oza.oza@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH v5 1/3] dt-bindings: PCI: Add PCI hotplug property
Date: Thu, 31 Aug 2017 10:14:28 +0530
Message-Id: <1504154670-24608-2-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1504154670-24608-1-git-send-email-oza.oza@broadcom.com>
References: <1504154670-24608-1-git-send-email-oza.oza@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

Host drivers have the requirement of implementing PCI hotplug
based on the how their SOC supports it.

Couple of properties have been added. the one to enable
the hotplug feature itself, and the other caters to
the PCI hotplug implementation with the use of gpios.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
Acked-by: Rob Herring <robh@kernel.org>

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 50f9e2c..0bf25a1 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -24,3 +24,18 @@ driver implementation may support the following properties:
    unsupported link speed, for instance, trying to do training for
    unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
    for gen2, and '1' for gen1. Any other values are invalid.
+
+- slot-pluggable:
+   PCI hotplug feature is supported.
+   PCI hotplug implementation is SOC/Board specific, and also it depends on
+   how add-in card is designed (e.g. how many present pins are implemented).
+   If the slot-pluggable property is present, the following propertey could
+   become effective.
+   - prsnt-gpios:
+      Array of gpios, could be present if hotplug is supported.
+      This property defines gpio based hotplug implementation.
+      Example:
+      If x8 card is connected, then it might be possible that all the
+      3 present pins could go low, or at least one pin goes low.
+      If x4 card is connected, then it might be possible that 2 present
+      pins go low, or at least one pin goes low.
-- 
1.9.1
