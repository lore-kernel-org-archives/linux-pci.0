Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414F4C433E1
	for <linux-pci@archiver.kernel.org>; Wed, 24 Mar 2021 03:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D69619E1
	for <linux-pci@archiver.kernel.org>; Wed, 24 Mar 2021 03:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhCXDGL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Mar 2021 23:06:11 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47519 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235014AbhCXDFv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 23:05:51 -0400
X-UUID: fc9c46d0dfd844419121620cd14fc58b-20210324
X-UUID: fc9c46d0dfd844419121620cd14fc58b-20210324
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 205850110; Wed, 24 Mar 2021 11:05:47 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Mar 2021 11:05:46 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Mar 2021 11:05:44 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        <anson.chuang@mediatek.com>, Krzysztof Wilczyski <kw@linux.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [v9,2/7] PCI: Export pci_pio_to_address() for module use
Date:   Wed, 24 Mar 2021 11:05:05 +0800
Message-ID: <20210324030510.29177-3-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210324030510.29177-1-jianjun.wang@mediatek.com>
References: <20210324030510.29177-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This interface will be used by PCI host drivers for PIO translation,
export it to support compiling those drivers as kernel modules.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16a17215f633..12bba221c9f2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4052,6 +4052,7 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
 
 	return address;
 }
+EXPORT_SYMBOL(pci_pio_to_address);
 
 unsigned long __weak pci_address_to_pio(phys_addr_t address)
 {
-- 
2.25.1

