Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF44C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 08:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C59B2184C
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 08:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R7WNJlIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfAXIao (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:30:44 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60098 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfAXIan (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 03:30:43 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0O8UaL6105748;
        Thu, 24 Jan 2019 02:30:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548318636;
        bh=7o28m+/NAIlkSFG9m4hVjE2FfGGUC44quTmybqP8VWs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=R7WNJlIVYjc//BqL/Cdm/8oIuvZ18miyLIyIHsP3fdBbejqVRBGsBls5m8YyDiZII
         GzAocrFEM15EGSK/oz+YQhIyolVXGs5UGvdZr6iamVp/F4KtSXiZpquYTqrosA74qG
         ebPjR5XyB9jlk0jfZ5RVNYGbBN7FjpfJNcFT4M0o=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0O8UZDJ121658
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 02:30:36 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 24
 Jan 2019 02:30:35 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 24 Jan 2019 02:30:35 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0O8UTbZ012320;
        Thu, 24 Jan 2019 02:30:32 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v3 1/3] dt-bindings: PCI: dra7xx: Add SoC specific compatible strings
Date:   Thu, 24 Jan 2019 13:59:55 +0530
Message-ID: <20190124082957.29077-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190124082957.29077-1-kishon@ti.com>
References: <20190124082957.29077-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add new compatible strings for dra74x SoC (also used by dra76x) and
dra72x. This can be used to perform SoC specific configuration
(like configuring PCIe in x2 lane mode).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 452fe48c4fdd..e03d23631f5b 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -1,8 +1,12 @@
 TI PCI Controllers
 
 PCIe DesignWare Controller
- - compatible: Should be "ti,dra7-pcie" for RC
-	       Should be "ti,dra7-pcie-ep" for EP
+ - compatible: Should be "ti,dra7-pcie" for RC (deprecated)
+	       Should be "ti,dra7-pcie-ep" for EP (deprecated)
+	       Should be "ti,dra746-pcie-rc" for dra74x/dra76 in RC mode
+	       Should be "ti,dra746-pcie-ep" for dra74x/dra76 in EP mode
+	       Should be "ti,dra726-pcie-rc" for dra72x in RC mode
+	       Should be "ti,dra726-pcie-ep" for dra72x in EP mode
  - phys : list of PHY specifiers (used by generic PHY framework)
  - phy-names : must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
 	       number of PHYs as specified in *phys* property.
-- 
2.17.1

