Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1E5C282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 05:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0BB20863
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 05:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfBAFgT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:36:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54535 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726364AbfBAFgT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2019 00:36:19 -0500
X-UUID: bcd6862de16d4191bbe410022a95e6d9-20190201
X-UUID: bcd6862de16d4191bbe410022a95e6d9-20190201
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 130163740; Fri, 01 Feb 2019 13:36:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 13:36:10 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 13:36:09 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>
CC:     <rafael.j.wysocki@intel.com>, <fred@fredlawl.com>,
        <poza@codeaurora.org>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>
Subject: [PATCH v3 0/2] PCI: mediatek: enable whole MMIO range and enlarge the PCIe2AHB window size
Date:   Fri, 1 Feb 2019 13:36:05 +0800
Message-ID: <1548999367-11733-1-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Two patches:
patch 1 enable whole MMIO range which also fix the complain of scripts/coccinelle/api/resource_size.cocci
patch 2 enlarge the PCIe2AHB window size to support fully access of 4GB DRAM from EP DMA.

v3:
 - update the changlog title for patch1 and update commit message following Bjorn's suggestion
 - move the "|" into the previous line.

v2:
 - Fix the checkpatch complains for patch 1.
 - update the commit message and change title of patch 1 for changelog conventions.
 - Add patch 2.

Honghui Zhang (2):
  PCI: mediatek: Enable the whole memory mapped IO range
  PCI: mediatek: Enlarge PCIe2AHB window size to support 4GB DRAM

 drivers/pci/controller/pcie-mediatek.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.6.4

