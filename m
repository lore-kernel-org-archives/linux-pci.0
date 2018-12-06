Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E37EC65BB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 01:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C65214E0
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 01:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C65214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeLFBJf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:09:35 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:26859 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728823AbeLFBJe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2018 20:09:34 -0500
X-UUID: d6e4c802dcf040748714df57c4112ed2-20181206
X-UUID: d6e4c802dcf040748714df57c4112ed2-20181206
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1218673436; Thu, 06 Dec 2018 09:09:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 6 Dec 2018 09:09:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 6 Dec 2018 09:09:16 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     <ryder.lee@mediatek.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <matthias.bgg@gmail.com>, <linux-pci@vger.kernel.org>
CC:     <mark.rutland@arm.com>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Subject: [PATCH 0/2] PCI: mediatek: Add support for MT7629
Date:   Thu, 6 Dec 2018 09:09:11 +0800
Message-ID: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 03E617F56C26719AEA8BAD6583948FE1D4910ECDA128FC7A0B304A2845C2D2D02000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These series patches modify pcie-mediatek.c and dt-bindings compatible
string to support MT7629 PCIe host.

There was something wrong with the mail server's permission setting, sorry
for sent these mails repeatedly.

Jianjun Wang (2):
  dt-bindings: PCI: Add support for MT7629
  PCI: mediatek: Add controller support for MT7629

 .../devicetree/bindings/pci/mediatek-pcie.txt |  1 +
 drivers/pci/controller/pcie-mediatek.c        | 26 +++++++++++++++++++
 include/linux/pci_ids.h                       |  1 +
 3 files changed, 28 insertions(+)

-- 
2.19.1

