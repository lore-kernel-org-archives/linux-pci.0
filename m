Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE44C28CF8
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 08:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2987B20890
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 08:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2987B20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeJOPxa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:53:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5739 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726541AbeJOPx3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 11:53:29 -0400
X-UUID: eb559fd023654af18dd01ec0cff9cea7-20181015
X-UUID: eb559fd023654af18dd01ec0cff9cea7-20181015
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2098282582; Mon, 15 Oct 2018 16:09:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 15 Oct 2018 16:09:04 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 15 Oct 2018 16:09:03 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>
CC:     <ulf.hansson@linaro.org>, <marc.zyngier@arm.com>,
        <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>,
        <yt.shen@mediatek.com>, <jianjun.wang@mediatek.com>,
        <yong.wu@mediatek.com>
Subject: [PATCH v8 2/9] PCI: mediatek: Fix class type for MT7622 as PCI_CLASS_BRIDGE_PCI
Date:   Mon, 15 Oct 2018 16:08:53 +0800
Message-ID: <1539590940-13355-3-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1539590940-13355-1-git-send-email-honghui.zhang@mediatek.com>
References: <1539590940-13355-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 728839C9B44E609B6062AB040177C67E0A3995E05C615B527F71B1440D4657B62000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The commit 101c92dc80c8 ("PCI: mediatek: Set up vendor ID and class
type for MT7622") have set the class type for MT7622 as un-properly
value of PCI_CLASS_BRIDGE_HOST.

The PCIe controller of MT7622 is complexed with Root Port and PCI-to-PCI
bridge, the bridge has type 1 configuration space header and related bridge
windows. The HW default value of this bridge's class type is invalid. Fix
its class type as PCI_CLASS_BRIDGE_PCI since it is HW defines.

Making the bridge visiable to PCI framework by setting its class type
properly will get its bridge windows configurated during PCI device
enumerate.

Fixes: 101c92dc80c8 ("PCI: mediatek: Set up vendor ID and class type for MT7622")
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 288b8e2..bcdac9b 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -432,7 +432,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		val = PCI_VENDOR_ID_MEDIATEK;
 		writew(val, port->base + PCIE_CONF_VEND_ID);
 
-		val = PCI_CLASS_BRIDGE_HOST;
+		val = PCI_CLASS_BRIDGE_PCI;
 		writew(val, port->base + PCIE_CONF_CLASS_ID);
 	}
 
-- 
2.6.4

