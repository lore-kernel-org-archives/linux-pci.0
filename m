Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4573C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 18:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F802133F
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 18:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfCRSYp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:24:45 -0400
Received: from foss.arm.com ([217.140.101.70]:39494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfCRSYo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 14:24:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72170165C;
        Mon, 18 Mar 2019 11:24:44 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C94783F614;
        Mon, 18 Mar 2019 11:24:42 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Grant.Likely@arm.com,
        Jeremy.Linton@arm.com, Robin.Murphy@arm.com
Subject: [PATCH 1/2] dt-bindings: Add external-facing PCIe port property
Date:   Mon, 18 Mar 2019 18:21:23 +0000
Message-Id: <20190318182124.53859-2-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318182124.53859-1-jean-philippe.brucker@arm.com>
References: <20190318182124.53859-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide a way for the firmware to tell the OS which devices are external
to the machine and therefore untrusted. The property can describe for
example thunderbolt and other hot-pluggable ports, which should always
have the strongest IOMMU protection.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 Documentation/devicetree/bindings/pci/pci.txt | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index c77981c5dd18..55cdbc5d2804 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -24,3 +24,50 @@ driver implementation may support the following properties:
    unsupported link speed, for instance, trying to do training for
    unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
    for gen2, and '1' for gen1. Any other values are invalid.
+
+PCI-PCI Bridge properties
+-------------------------
+
+Root ports and switch ports may be described explicitly in the device
+tree, as children of the host bridge node. Even though those devices are
+discoverable by probing, it might be necessary to describe properties that
+aren't provided by standard PCIe capabilities.
+
+Required properties:
+
+- reg:
+   Identifies the PCI-PCI bridge. As defined in the IEEE Std 1275-1994
+   document, it is a five-cell address encoded as (phys.hi phys.mid
+   phys.lo size.hi size.lo). phys.hi should contain the device's BDF as
+   0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be zero.
+
+   The bus number is defined by firmware, through the standard bridge
+   configuration mechanism. If this port is a switch port, then firmware
+   allocates the bus number and writes it into the Secondary Bus Number
+   register of the bridge directly above this port. Otherwise, the bus
+   number of a root port is the first number in the bus-range property,
+   defaulting to zero.
+
+   If firmware leaves the ARI Forwarding Enable bit set in the bridge
+   above this port, then phys.hi contains the 8-bit function number as
+   0b00000000 bbbbbbbb ffffffff 00000000. Note that the PCIe specification
+   recommends that firmware only leaves ARI enabled when it knows that the
+   OS is ARI-aware.
+
+Optional properties:
+
+- external-facing:
+   When present, the port is external facing. All bridges and endpoints
+   downstream of this port are external to the machine.
+
+Example:
+
+pcie@10000000 {
+	compatible = "pci-host-ecam-generic";
+	...
+	pcie@0008 {
+		/* Root port 00:01.0 is external-facing */
+		reg = <0x00000800 0 0 0 0>;
+		external-facing;
+	};
+};
-- 
2.21.0

