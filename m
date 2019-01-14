Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AA5C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA2520873
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P7XFzsI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfANLRE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:17:04 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46922 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfANLRC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 06:17:02 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EBGMva065556;
        Mon, 14 Jan 2019 05:16:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547464582;
        bh=9uy7oBAgopBKXmOWf1Xu6i0EmqFED+atLS7+JVzPan8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=P7XFzsI5AoIR5lwIf7kdytlIcvYG00NuEKVT4PSzp9QW8AhQvxBUBmmb2XZYz8W8b
         GKgjjaaZ/1uHaeqpM/3tdbWaQwPnmby9LN5zD/X6UYTmmxqapNrzQcC+UYaDcXkRbv
         Im82/pbFYLEuc3n10X216xnTWvR7ImNq0PACzjiM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EBGMVu024049
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 05:16:22 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 05:16:21 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 05:16:21 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EBFd1c011560;
        Mon, 14 Jan 2019 05:16:18 -0600
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
Subject: [PATCH v2 10/15] PCI: pci-epf-test: Do not allocate next BARs memory if current BAR is 64Bit
Date:   Mon, 14 Jan 2019 16:45:08 +0530
Message-ID: <20190114111513.21618-11-kishon@ti.com>
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

It's useless to allocate memory for next BAR if the current BAR is a
64Bit BAR. Stop allocating memory for the next BAR, if the current
BARs flag indicates this is a 64Bit BAR.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 44cc31343a80..ade296180383 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -429,6 +429,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct device *dev = &epf->dev;
+	struct pci_epf_bar *epf_bar;
 	void *base;
 	int bar;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
@@ -442,6 +443,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	epf_test->reg[test_reg_bar] = base;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
+		epf_bar = &epf->bar[bar];
 		if (bar == test_reg_bar)
 			continue;
 		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
@@ -449,6 +451,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
 		epf_test->reg[bar] = base;
+		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
+			bar++;
 	}
 
 	return 0;
-- 
2.17.1

