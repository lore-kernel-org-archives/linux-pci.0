Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0932C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DE02085A
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P5FDO7ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfCYIhB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:37:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52258 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfCYIhB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:37:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P8ab0K106388;
        Mon, 25 Mar 2019 03:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553502997;
        bh=7srJLFU2H5APGDHmyq9l+0rZG+OkuO025oUKh/xV4Ug=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=P5FDO7ixK/ZidFm/LkD0EnItekQH+ko+Ag552y514XucNDawR9+E1aUwGSeCk6k0m
         E6RhvvvPUxp9sd2q+2kSLz5+iQYVRFmmhaiTkh2R70qjSn9fCkYuXPNQwkNEO1giH3
         uJhu8KjOItFtqFu7AE880/zuUrnAS19dm/CCUb38=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P8abtU091951
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 03:36:37 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 03:36:36 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 03:36:36 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P8ZsFp006534;
        Mon, 25 Mar 2019 03:36:33 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-arm-kernel@axis.com>
Subject: [PATCH v2 09/26] dt-bindings: PCI: Document "atu" reg-names
Date:   Mon, 25 Mar 2019 14:04:44 +0530
Message-ID: <20190325083501.8088-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document "atu" reg-names required to get the register space for ATU in
Synopsys designware core version >= 4.80.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/designware-pcie.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index c124f9bc11f3..5561a1c060d0 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -4,8 +4,11 @@ Required properties:
 - compatible:
 	"snps,dw-pcie" for RC mode;
 	"snps,dw-pcie-ep" for EP mode;
-- reg: Should contain the configuration address space.
-- reg-names: Must be "config" for the PCIe configuration space.
+- reg: For designware cores version < 4.80 contains the configuration
+       address space. For designware core version >= 4.80, contains
+       the configuration and ATU address space
+- reg-names: Must be "config" for the PCIe configuration space and "atu" for
+	     the ATU address space.
     (The old way of getting the configuration address space from "ranges"
     is deprecated and should be avoided.)
 - num-lanes: number of lanes to use
-- 
2.17.1

