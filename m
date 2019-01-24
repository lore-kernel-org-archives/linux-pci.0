Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4ADC282C5
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 08:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9540C218A2
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 08:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qYV6/qqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfAXIat (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:30:49 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60108 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfAXIao (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 03:30:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0O8UdtK105758;
        Thu, 24 Jan 2019 02:30:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548318639;
        bh=XnfyeGW1v4D2eDSHApIAzFhxoc97wNFzDGMLYwbE8AA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qYV6/qqBVU4mNSDUcDoz+6pw+Cka+Od55yRoNYrx3snR583MA18l9EVPck2w18Kuo
         l1buNn7RUoBVggtsNPYBDDKr8hgR9zuoZsT009fCDesJELAVEtqYpKgwreg7Et6uCO
         tyRL2ViwNfx5nDdzlHQYF9pimpNKi+fbt4XLs5hw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0O8UdIB127939
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 02:30:39 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 24
 Jan 2019 02:30:38 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 24 Jan 2019 02:30:39 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0O8UTba012320;
        Thu, 24 Jan 2019 02:30:36 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v3 2/3] dt-bindings: PCI: dra7xx: Add properties to enable x2 lane in dra7
Date:   Thu, 24 Jan 2019 13:59:56 +0530
Message-ID: <20190124082957.29077-3-kishon@ti.com>
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

Add syscon properties required for configuring PCIe in x2 lane mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index e03d23631f5b..d5cbfe6b0d89 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -13,6 +13,9 @@ PCIe DesignWare Controller
  - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
 	       where <X> is the instance number of the pcie from the HW spec.
  - num-lanes as specified in ../designware-pcie.txt
+ - ti,syscon-lane-sel : phandle/offset pair. Phandle to the system control
+			module and the register offset to specify lane
+			selection.
 
 HOST MODE
 =========
-- 
2.17.1

