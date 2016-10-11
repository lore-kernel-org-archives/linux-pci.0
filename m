Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:34630 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbcJKEU7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2016 00:20:59 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v6 1/3] Documentation/devicetree: Add new property to specify the max link speed
Date: Tue, 11 Oct 2016 12:26:25 +0800
Message-Id: <1476159987-31372-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some of the host drivers have the requirement of knowing whether the
EP would never train at some link speed at all. For instance, on some
boards, the link won't train at 5 GT/s but the host driver still sacrifice
some cycle to wait for the resule of training at 5 GT/s as the host could
actually support 5 GT/s. So we could parse this new property and make the
host drivers be aware of these cases.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 08dcfad..e7d97a3 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -18,3 +18,9 @@ driver implementation may support the following properties:
    host bridges in the system, otherwise potentially conflicting domain numbers
    may be assigned to root buses behind different host bridges.  The domain
    number for each host bridge in the system must be unique.
+- max-link-speed:
+   If present this property specifies PCI gen for link capability. The host drivers
+   could add this as a strategy to avoid unnecessary operation for unsupported
+   link speed, for instance, trying to do training for unsupported link speed, etc.
+   Must be '4' for gen4, '3' for gen3, '2' for gen2, and '1' for gen1. Any other
+   values are invalid.
-- 
2.3.7


