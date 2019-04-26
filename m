Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CE9C43219
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 12:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E7A206C1
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 12:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rzOqZ3PA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfDZMrh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:47:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36732 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZMrh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2019 08:47:37 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3QClV0e044677;
        Fri, 26 Apr 2019 07:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556282851;
        bh=6LF5OdRDuHCfc0cyukVkeI8LwRs9rG+hXGHWyOb3aUg=;
        h=From:To:CC:Subject:Date;
        b=rzOqZ3PAVPkDu0DLCzjeq67B1qQOiVSe4c0bmI7mbIGQNJR4ZBxRUpX9Fz/9YwRx4
         JV/LvwK3t4sluB20KAirZyh9rKeqNY9zYnpYb5V4EPSZ7XMOLgmiCWYk0Zcnitx9U+
         dcY3hVGMDkFax2e7Bs1MIjc7cYZ2ljVwDtKXtH5I=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3QClVlY078721
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Apr 2019 07:47:31 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 26
 Apr 2019 07:47:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 26 Apr 2019 07:47:31 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3QClSk7108115;
        Fri, 26 Apr 2019 07:47:28 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] dt-bindings: PCI: Add PCI EP DT binding documentation for AM654
Date:   Fri, 26 Apr 2019 18:16:20 +0530
Message-ID: <20190426124620.28881-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add devicetree binding documentation for PCIe in EP mode present in
AM654 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/pci-keystone.txt  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index 5c60e911b8b1..358f9adf95ad 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -69,3 +69,47 @@ Optional properties:-
 DesignWare DT Properties not applicable for Keystone PCI
 
 1. pcie_bus clock-names not used.  Instead, a phandle to phys is used.
+
+AM654 PCIe Endpoint
+===================
+
+Required Properties:-
+
+compatibility: Should be "ti,am654-pcie-ep" for EP on AM654x SoC
+reg: Four register ranges as listed in the reg-names property
+reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
+	   TI specific application registers, "atu" for the
+	   Address Translation Unit configuration registers and
+	   "addr_space" used to map remote RC address space
+num-ib-windows: As specified in
+		Documentation/devicetree/bindings/pci/designware-pcie.txt
+num-ob-windows: As specified in
+		Documentation/devicetree/bindings/pci/designware-pcie.txt
+num-lanes: As specified in
+	   Documentation/devicetree/bindings/pci/designware-pcie.txt
+power-domains: As documented by the generic PM domain bindings in
+	       Documentation/devicetree/bindings/power/power_domain.txt.
+ti,syscon-pcie-mode: phandle to the device control module required to configure
+		      PCI in either RC mode or EP mode.
+
+Optional properties:-
+
+phys: list of PHY specifiers (used by generic PHY framework)
+phy-names: must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
+               number of lanes as specified in *num-lanes* property.
+("phys" and "phy-names" DT bindings are specified in
+Documentation/devicetree/bindings/phy/phy-bindings.txt)
+interrupts: platform interrupt for error interrupts.
+
+pcie-ep {
+	compatible = "ti,am654-pcie-ep";
+	reg =  <0x5500000 0x1000>, <0x5501000 0x1000>,
+	       <0x10000000 0x8000000>, <0x5506000 0x1000>;
+	reg-names = "app", "dbics", "addr_space", "atu";
+	power-domains = <&k3_pds 120>;
+	ti,syscon-pcie-mode = <&pcie0_mode>;
+	num-lanes = <1>;
+	num-ib-windows = <16>;
+	num-ob-windows = <16>;
+	interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+};
-- 
2.17.1

