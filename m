Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:37098 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753097AbdHOF4K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2017 01:56:10 -0400
Received: by mail-wr0-f171.google.com with SMTP id o62so99130wrc.4
        for <linux-pci@vger.kernel.org>; Mon, 14 Aug 2017 22:56:10 -0700 (PDT)
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH v2 2/3] Documentation/devicetree: Add PCIe hotplug property
Date: Tue, 15 Aug 2017 11:25:46 +0530
Message-Id: <1502776547-30542-3-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1502776547-30542-1-git-send-email-oza.oza@broadcom.com>
References: <1502776547-30542-1-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Host drivers have the requirement of implementing PCI hotplug
based on the how their SOC supports PCI hotplug.

Couple of properties have been added. the one to enable
the hotplug feature itself, and the other caters to
the PCI hotplug implementation with the use of gpios.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

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
