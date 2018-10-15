Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60E3C28CF8
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 05:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7918204FD
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 05:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7918204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJON2w (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:28:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15915 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726663AbeJON2v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 09:28:51 -0400
X-UUID: f457e6d1e0234f75a2ca186a799dc132-20181015
X-UUID: f457e6d1e0234f75a2ca186a799dc132-20181015
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1005407080; Mon, 15 Oct 2018 13:44:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 15 Oct 2018 13:44:50 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 15 Oct 2018 13:44:50 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>
CC:     <ulf.hansson@linaro.org>, <marc.zyngier@arm.com>,
        <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>,
        <yt.shen@mediatek.com>, <jianjun.wang@mediatek.com>
Subject: [PATCH v7 1/9] PCI: mediatek: Using slot's devfn for compare to fix mtk_pcie_find_port logic
Date:   Mon, 15 Oct 2018 13:44:39 +0800
Message-ID: <1539582287-9171-2-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1539582287-9171-1-git-send-email-honghui.zhang@mediatek.com>
References: <1539582287-9171-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The Mediatek's host controller has two slots, each with it's own control
registers. The host driver need to identify which slot was connected
in order to access the device's configuration space. There's problem
for current host driver to find out which slot was connected to for
a given EP device.

Assuming each slot have connect with one EP device as below:

                host bridge
  bus 0 --> __________|_______
           |                  |
           |                  |
         slot 0             slot 1
  bus 1 -->|        bus 2 --> |
           |                  |
         EP 0               EP 1

During PCI enumeration, system software will scan all the PCI device
starting from devfn 0. So it will get the proper port for slot0 and
slot1 device when using PCI_SLOT(devfn) for match. But it will get
the wrong slot for EP1: The devfn will be start from 0 when scanning
EP1 behind slot1, it will get port0 since the PCI_SLOT(EP1) is match
for port0's slot value. So the host driver should not using EP's devfn
but the slot's devfn(the slot which EP was connected to) for match.

This patch fix the mtk_pcie_find_port's logic by using the slot's
devfn for match if finding device connected to the subordinate bus.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 9999dae..288b8e2 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -337,6 +337,17 @@ static struct mtk_pcie_port *mtk_pcie_find_port(struct pci_bus *bus,
 {
 	struct mtk_pcie *pcie = bus->sysdata;
 	struct mtk_pcie_port *port;
+	struct pci_dev *dev = NULL;
+
+	/*
+	 * Walk the bus hierarchy to get the devfn value
+	 * of the port in the root bus.
+	 */
+	while (bus && bus->number) {
+		dev = bus->self;
+		bus = dev->bus;
+		devfn = dev->devfn;
+	}
 
 	list_for_each_entry(port, &pcie->ports, list)
 		if (port->slot == PCI_SLOT(devfn))
-- 
2.6.4

