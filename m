Return-Path: <SRS0=Qtyg=23=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47984C2D0DA
	for <linux-pci@archiver.kernel.org>; Mon,  6 Jan 2020 10:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A142072C
	for <linux-pci@archiver.kernel.org>; Mon,  6 Jan 2020 10:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yjXzH0OE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgAFKUI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:20:08 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53676 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgAFKUI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2020 05:20:08 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 006AJuP5107871;
        Mon, 6 Jan 2020 04:19:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578305996;
        bh=8W4c5imqrF7QowsJacFr1QjJhJIkYTKy/E8u2hZV+h0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yjXzH0OEpfNausnDA1EClVjN+w7ZC2ILvCDSfbuMKXnQhZAfbXM0wncfwbZ4TKAUO
         d8nKJJH2kIEkkpSxW5RS3I/hDvUpnPmc2hb8oAJquKaGN+rqAuBGkGqClHbKqR4AHp
         QJ9IDgdZzl33WqR7xPJ1SrDSs9LMWjmvorRs8ba0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 006AJuoD103157
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jan 2020 04:19:56 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 04:19:55 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 04:19:55 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006AIqY6118652;
        Mon, 6 Jan 2020 04:19:52 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 14/14] MAINTAINERS: Add Kishon Vijay Abraham I for TI J721E SoC PCIe
Date:   Mon, 6 Jan 2020 15:50:58 +0530
Message-ID: <20200106102058.19183-15-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106102058.19183-1-kishon@ti.com>
References: <20200106102058.19183-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Kishon Vijay Abraham I as MAINTAINER for TI J721E SoC PCIe.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e802de..84bff97851fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12691,13 +12691,15 @@ S:	Maintained
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
 F:	drivers/pci/controller/dwc/pci-dra7xx.c
+F:	drivers/pci/controller/cadence/pci-j721e.c
 
 PCI DRIVER FOR TI KEYSTONE
 M:	Murali Karicheri <m-karicheri2@ti.com>
-- 
2.17.1

