Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B8BC43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73C42086D
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MNyt1hEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfANLRA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:17:00 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45532 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfANLQ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 06:16:59 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EBGELg112733;
        Mon, 14 Jan 2019 05:16:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547464574;
        bh=bomR0TElheZ70a4424n4+PZQ1RpTa9f7juuhG35IGxY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MNyt1hEx/sd+05mnHce4k7ZLAqhX05iEv7WPS3DZbrh9QcOI5VEiksPADW94LA7km
         d9lG+mwGo5hZ0ecJLxYddj4+dijpp9vqItQyvNHB9AYP2uMZNVRTkJVbh0lHfyA9D0
         QGIlnBxLzdhc/EVSIYHC8/oPux1E+N7pElAOVrJM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EBGEAO067802
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 05:16:14 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 05:16:14 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 05:16:14 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EBFd1a011560;
        Mon, 14 Jan 2019 05:16:10 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 08/15] PCI: endpoint: Fix pci_epf_alloc_space to set correct MEM TYPE flags
Date:   Mon, 14 Jan 2019 16:45:06 +0530
Message-ID: <20190114111513.21618-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
References: <20190114111513.21618-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_epf_alloc_space() sets the MEM TYPE flags to indicate a 32-bit
Base Address Register irrespective of the size. Fix it here to indicate
64-bit BAR if the size is > 2GB.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 825fa24427a3..8bfdcd291196 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -131,7 +131,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
 	epf->bar[bar].phys_addr = phys_addr;
 	epf->bar[bar].size = size;
 	epf->bar[bar].barno = bar;
-	epf->bar[bar].flags = PCI_BASE_ADDRESS_SPACE_MEMORY;
+	epf->bar[bar].flags |= upper_32_bits(size) ?
+				PCI_BASE_ADDRESS_MEM_TYPE_64 :
+				PCI_BASE_ADDRESS_MEM_TYPE_32;
 
 	return space;
 }
-- 
2.17.1

