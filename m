Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F377C67839
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 20:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2C82086D
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 20:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2C82086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeLMUVs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:21:48 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:2262 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbeLMUVs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 15:21:48 -0500
X-IronPort-AV: E=Sophos;i="5.56,349,1539615600"; 
   d="scan'208";a="2765902"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2018 05:21:45 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.37.69])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4363B4072C4F;
        Fri, 14 Dec 2018 05:21:43 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: rcar: Add device tree support for r8a774c0
Date:   Thu, 13 Dec 2018 20:21:40 +0000
Message-Id: <1544732500-6866-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe support for the RZ/G2E (a.k.a. R8A774C0).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 976ef7b..bb89fed 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -3,6 +3,7 @@
 Required properties:
 compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
 	    "renesas,pcie-r8a7744" for the R8A7744 SoC;
+	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
 	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
 	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
 	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
@@ -13,7 +14,8 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
 	    "renesas,pcie-r8a77990" for the R8A77990 SoC;
 	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
 				     RZ/G1 compatible device.
-	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
+	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 or
+				     RZ/G2 compatible device.
 
 	    When compatible with the generic version, nodes must list the
 	    SoC-specific version corresponding to the platform first
@@ -37,7 +39,8 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
 
 Optional properties:
 - phys: from common PHY binding: PHY phandle and specifier (only make sense
-	for R-Car gen3 SoCs where the PCIe PHYs have their own register blocks).
+	for R-Car gen3 and RZ/G2 SoCs where the PCIe PHYs have their own
+	register blocks).
 - phy-names: from common PHY binding: should be "pcie".
 
 Example:
-- 
2.7.4

