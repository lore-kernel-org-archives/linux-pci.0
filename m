Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:38171 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbdHHEoe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2017 00:44:34 -0400
Received: by mail-qk0-f174.google.com with SMTP id x191so13694283qka.5
        for <linux-pci@vger.kernel.org>; Mon, 07 Aug 2017 21:44:34 -0700 (PDT)
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH 2/2] PCI: iproc: Add optional brcm,pci-hotplug
Date: Tue,  8 Aug 2017 10:14:15 +0530
Message-Id: <1502167455-10516-3-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1502167455-10516-1-git-send-email-oza.oza@broadcom.com>
References: <1502167455-10516-1-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add description for optional device tree property
'brcm,pci-hotplug' for PCI hotplug feature.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index b8e48b4..a3bad24 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -72,6 +72,29 @@ Optional properties:
 - brcm,pcie-msi-inten: Needs to be present for some older iProc platforms that
 require the interrupt enable registers to be set explicitly to enable MSI
 
+Optional properties:
+- brcm,pci-hotplug: PCI hotplug feature is supported.
+
+If the brcm,pcie-hotplug property is present, the following properties become
+effective:
+
+- brcm,prsnt-gpio: Array of gpios, needs to be present if Hotplug is supported.
+
+PCI hotplug implementation is SOC/Board specific, and also it depends on
+how add-in card is designed (e.g. how many present pins are implemented).
+
+If x8 card is connected, then it might be possible that all the
+3 present pins could go low, or at least one pin goes low.
+
+If x4 card is connected, then it might be possible that 2 present
+pins go low, or at least one pin goes low.
+
+Example:
+brcm,prsnt-gpio: <&pca9505 32 1>, <&pca9505 33 1>;
+This is x4 connector: monitoring max 2 present lines.
+brcm,prsnt-gpio: <&pca9505 32 1>, <&pca9505 33 1>, <&pca9505 34 1>;
+This is x8 connector: monitoring max 3 present lines.
+
 Example:
 	pcie0: pcie@18012000 {
 		compatible = "brcm,iproc-pcie";
-- 
1.9.1
