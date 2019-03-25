Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C563C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D170020870
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NFgd8o1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfCYJnU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:43:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37520 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbfCYJnQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 05:43:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P9gv4X013137;
        Mon, 25 Mar 2019 04:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553506977;
        bh=95/DYa4qnYNzMEil6XiXEr+BPjzSPAwq2VRbXlmcz/o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NFgd8o1HVBRKyL7JXcEmjqVVHmMcfhKC0LcjOGcZ9s70k5UPpuGS5tmkfPwOTXyF/
         SVveisId7Kyhl2J7lT1JouvaIAdRpWukD7BoA3lry/vrFxDHHOj0j2/enNIr7VK4JA
         xKa3fCLE2U4bQm6jchvsDpfdjSp3087MdJVVdXDY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P9gvDd109997
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 04:42:57 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 04:42:56 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 04:42:56 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P9feaS028077;
        Mon, 25 Mar 2019 04:42:51 -0500
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
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-kernel@axis.com>, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: [PATCH v3 13/26] dt-bindings: PCI: Add PCI RC dt binding documentation for AM654
Date:   Mon, 25 Mar 2019 15:09:34 +0530
Message-ID: <20190325093947.32633-14-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325093947.32633-1-kishon@ti.com>
References: <20190325093947.32633-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add devicetree binding documentation for PCIe in RC mode present in
AM654 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/pci-keystone.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index 8ee07197a063..5c60e911b8b1 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -11,7 +11,8 @@ described here as well as properties that are not applicable.
 
 Required Properties:-
 
-compatibility: "ti,keystone-pcie"
+compatibility: Should be "ti,keystone-pcie" for RC on Keystone2 SoC
+	       Should be "ti,am654-pcie-rc" for RC on AM654x SoC
 reg: Three register ranges as listed in the reg-names property
 reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
 	   TI specific application registers, "config" for the
@@ -20,6 +21,9 @@ reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
 pcie_msi_intc : Interrupt controller device node for MSI IRQ chip
 	interrupt-cells: should be set to 1
 	interrupts: GIC interrupt lines connected to PCI MSI interrupt lines
+	(required if the compatible is "ti,keystone-pcie")
+msi-map: As specified in Documentation/devicetree/bindings/pci/pci-msi.txt
+	 (required if the compatible is "ti,am654-pcie-rc".
 
 ti,syscon-pcie-id : phandle to the device control module required to set device
 		    id and vendor id.
-- 
2.17.1

