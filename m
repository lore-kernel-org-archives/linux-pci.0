Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E89C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A0620883
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lk0jUiMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfCYJoE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:44:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33588 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfCYJoD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 05:44:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P9hZ77011109;
        Mon, 25 Mar 2019 04:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553507016;
        bh=F1vNw6974A4SxeLsowTyiNZ0yV33iVQDSJNdrli8b/8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lk0jUiMTO3bL980SrgGsvlkPHcorS0hl3VaUCKbJoAfkqj6xXOv+du67c1KxSu2dV
         /S4+iDcjCrq1XoaWiAtkq+h/swtVcOfHVJ8wGj5BwllEPUDJgU9tf8W4z+l6xKO6J5
         sZe2RPj+Sxe/EXMW5My1ycpdTsk3F5XBe3d+7DtQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P9hZRt054894
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 04:43:35 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 04:43:35 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 04:43:35 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P9feaZ028077;
        Mon, 25 Mar 2019 04:43:30 -0500
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
Subject: [PATCH v3 20/26] PCI: dwc: Fix dw_pcie_ep_find_capability to return correct capability offset
Date:   Mon, 25 Mar 2019 15:09:41 +0530
Message-ID: <20190325093947.32633-21-kishon@ti.com>
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

commit beb4641a787df79a ("PCI: dwc: Add MSI-X callbacks handler") while
adding MSI-X callback handler, introduced dw_pcie_ep_find_capability and
__dw_pcie_ep_find_next_cap for finding the MSI and MSIX capability.

However if MSI or MSIX capability is the last capability (i.e there are
no additional items in the capabilities list and the Next Capability
Pointer is set to '0'), __dw_pcie_ep_find_next_cap will return '0'
even though MSI or MSIX capability may be present. This is because of
incorrect ordering of "next_cap_ptr" check. Fix it here.

Fixes: beb4641a787df79a142 ("PCI: dwc: Add MSI-X callbacks handler")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index dc6a4bbd3ace..74477ad7467f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -46,16 +46,19 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
 	u8 cap_id, next_cap_ptr;
 	u16 reg;
 
+	if (!cap_ptr)
+		return 0;
+
 	reg = dw_pcie_readw_dbi(pci, cap_ptr);
-	next_cap_ptr = (reg & 0xff00) >> 8;
 	cap_id = (reg & 0x00ff);
 
-	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
+	if (cap_id > PCI_CAP_ID_MAX)
 		return 0;
 
 	if (cap_id == cap)
 		return cap_ptr;
 
+	next_cap_ptr = (reg & 0xff00) >> 8;
 	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
 }
 
@@ -67,9 +70,6 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
 	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
 	next_cap_ptr = (reg & 0x00ff);
 
-	if (!next_cap_ptr)
-		return 0;
-
 	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
 }
 
-- 
2.17.1

