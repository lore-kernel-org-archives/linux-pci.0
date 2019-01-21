Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ED3C7112F
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 11:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF2920870
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 11:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfAULLV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:11:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:5528 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727952AbfAULLT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 06:11:19 -0500
X-UUID: 3d81629e11554b87868775bfd4d5c329-20190121
X-UUID: 3d81629e11554b87868775bfd4d5c329-20190121
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1272964923; Mon, 21 Jan 2019 19:11:08 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 19:11:05 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 21 Jan 2019 19:11:05 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <ryder.lee@mediatek.com>,
        <mark.rutland@arm.com>
CC:     <matthias.bgg@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>
Subject: [v1,0/2] PCI: mediatek: Add support for MT7629
Date:   Mon, 21 Jan 2019 19:11:00 +0800
Message-ID: <1548069062-12430-1-git-send-email-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5DFE0749629CF7BC59300F4245CE0912A0AC500BE817643A7EEFFEA0D9E8C2632000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These series patches modify pcie-mediatek.c and dt-bindings compatible
string to support MT7629 PCIe host.

Jianjun Wang (2):
  dt-bindings: PCI: Add support for MT7629
  PCI: mediatek: Add controller support for MT7629

 .../devicetree/bindings/pci/mediatek-pcie.txt |  1 +
 drivers/pci/controller/pcie-mediatek.c        | 28 +++++++++++++++++++
 include/linux/pci_ids.h                       |  1 +
 3 files changed, 30 insertions(+)

-- 
2.20.1

