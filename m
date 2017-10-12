Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/3] Documentation/devicetree: Add pcie-reset-suspend property
Date: Thu, 12 Oct 2017 13:52:18 -0700
Message-Id: <20171012205220.130048-2-briannorris@chromium.org>
In-Reply-To: <20171012205220.130048-1-briannorris@chromium.org>
References: <20171012205220.130048-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch is self-descriptive. I've found that we may need
platform-specific behavior for the PERST# signal in system suspend,
depending on the type of PCIe endpoints are attached.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 Documentation/devicetree/bindings/pci/pci.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index c77981c5dd18..91339b6d0652 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -24,3 +24,14 @@ driver implementation may support the following properties:
    unsupported link speed, for instance, trying to do training for
    unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
    for gen2, and '1' for gen1. Any other values are invalid.
+- pcie-reset-suspend:
+   If present this property defines whether the PCIe Reset signal (referred to
+   as PERST#) should be asserted when the system enters low-power suspend modes
+   (e.g., S3). Depending on the form factor, the associated PCIe
+   electromechanical specification may specify a particular behavior (e.g.,
+   "PERST# is asserted in advance of the power being switched off in a
+   power-managed state like S3") or it may be less clear. The net result is
+   that some endpoints perform better (e.g., lower power consumption) with
+   PERST# asserted, and others prefer PERST# deasserted. The value must be '0'
+   or '1', where '0' means do not assert PERST# and '1' means assert PERST#.
+   When absent, behavior may be platform-specific.
-- 
2.15.0.rc0.271.g36b669edcc-goog
