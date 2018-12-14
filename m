Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EACC65BAE
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 01:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5282720989
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 01:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5282720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeLNBZx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:25:53 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:15773 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727654AbeLNBZx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 20:25:53 -0500
X-UUID: 5a06c75e63ee41db859d3f73d931be55-20181214
X-UUID: 5a06c75e63ee41db859d3f73d931be55-20181214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1727383666; Fri, 14 Dec 2018 09:25:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 09:25:45 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 09:25:43 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>, <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>
Subject: [PATCH 0/4] Cleanup un-used variant and un-used property for MediaTek PCIe 
Date:   Fri, 14 Dec 2018 09:25:38 +0800
Message-ID: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EAA9556F6C6A7C33BC083D76A32E4F7269B8A2BE5AB2803531C071382EC9CB602000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The "num-lanes" property in MediaTek's PCIe device node is not used by
its driver or anyone else, cleanup those related code.

Honghui Zhang (4):
  PCI: mediatek: Remove un-used variant in struct mtk_pcie_port
  dt-bindings: PCI: MediaTek: Remove un-used property
  arm: dts: mt7623: Remove un-used property for PCIe
  arm64: dts: mt7622: Remove un-used property for PCIe

 Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 8 --------
 arch/arm/boot/dts/mt7623.dtsi                           | 3 ---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                | 2 --
 drivers/pci/controller/pcie-mediatek.c                  | 8 --------
 4 files changed, 21 deletions(-)

-- 
2.6.4

