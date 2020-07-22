Return-Path: <SRS0=NVP0=BB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DCFC433EB
	for <linux-pci@archiver.kernel.org>; Wed, 22 Jul 2020 11:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49916207CD
	for <linux-pci@archiver.kernel.org>; Wed, 22 Jul 2020 11:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n5Nd/cdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGVLEg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:04:36 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56330 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732274AbgGVLEe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2020 07:04:34 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06MB4KRQ072692;
        Wed, 22 Jul 2020 06:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595415860;
        bh=DtJwoqJOryWTFyHfyKQF/gJr0EGo+ETG/evSupvzR8s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=n5Nd/cdiJ1Lx/nqL7VNyBrlwj5KxpsYEkT8v0sogqIrstaEmv5s/gMcHrwQXHFrlw
         Z0kC9YqHQfwP5H5IaDdukNzjVP68m4bTq3cBZx7UBx/6XC2KvLvW10QEzq1iLR58qG
         FRoyUQhZRrMU/CjQilyjMmM3+hkzzP2aQoW2Rcjo=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06MB4KdP020667
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 06:04:20 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 22
 Jul 2020 06:04:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 22 Jul 2020 06:04:20 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06MB3IFn078616;
        Wed, 22 Jul 2020 06:04:17 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v8 15/15] MAINTAINERS: Add Kishon Vijay Abraham I for TI J721E SoC PCIe
Date:   Wed, 22 Jul 2020 16:33:17 +0530
Message-ID: <20200722110317.4744-16-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722110317.4744-1-kishon@ti.com>
References: <20200722110317.4744-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Kishon Vijay Abraham I as MAINTAINER for TI J721E SoC PCIe.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..6df9b54d3003 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13149,12 +13149,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
 F:	drivers/pci/controller/dwc/*designware*
 
-PCI DRIVER FOR TI DRA7XX
+PCI DRIVER FOR TI DRA7XX/J721E
 M:	Kishon Vijay Abraham I <kishon@ti.com>
 L:	linux-omap@vger.kernel.org
 L:	linux-pci@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/ti-pci.txt
+F:	drivers/pci/controller/cadence/pci-j721e.c
 F:	drivers/pci/controller/dwc/pci-dra7xx.c
 
 PCI DRIVER FOR TI KEYSTONE
-- 
2.17.1

