Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D05FC433E0
	for <linux-pci@archiver.kernel.org>; Mon, 22 Feb 2021 11:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D86564E27
	for <linux-pci@archiver.kernel.org>; Mon, 22 Feb 2021 11:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhBVLlh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Feb 2021 06:41:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60568 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhBVLlg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Feb 2021 06:41:36 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11MBecwP012521;
        Mon, 22 Feb 2021 05:40:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1613994038;
        bh=sv41bFmsIQ5l8K6JKG3/WVdhmrOx55wRVtUJF/MisCU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hhCGoSFH0+iO87IOP56zIXEKRM+LXuM2ytWrcY2wPhf5YnG9yJQeTyi9LGQGrDI83
         Hm0nQlGSQgv5rKDk6UdfsV0bSj1OaJ0sJnCJqbSvEDS5rLxqrDzG9s35zKnLhCTPys
         HE4pzz4i3WWD8VMulxZzsQcyljLZGDjv3aFE8CUs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11MBec8E062286
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Feb 2021 05:40:38 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 22
 Feb 2021 05:40:37 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 22 Feb 2021 05:40:37 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11MBeVjn105473;
        Mon, 22 Feb 2021 05:40:34 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/4] dt-bindings: PCI: ti,j721e: Add binding to represent refclk to the connector
Date:   Mon, 22 Feb 2021 17:10:27 +0530
Message-ID: <20210222114030.26445-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222114030.26445-1-kishon@ti.com>
References: <20210222114030.26445-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add binding to represent refclk to the PCIe connector.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml        | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 0880a613ece6..50dc99ac35d9 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -46,12 +46,16 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
-    description: clock-specifier to represent input to the PCIe
+    minItems: 1
+    maxItems: 2
+    description: clock-specifier to represent input to the PCIe for 1 item.
+      2nd item if present represents reference clock to the connector.
 
   clock-names:
+    minItems: 1
     items:
       - const: fck
+      - const: pcie_refclk
 
   vendor-id:
     const: 0x104c
-- 
2.17.1

