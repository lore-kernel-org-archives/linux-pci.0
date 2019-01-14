Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCE4C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAE820656
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EMhX8BCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfANLRV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:17:21 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45618 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfANLRV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 06:17:21 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EBGIQi112750;
        Mon, 14 Jan 2019 05:16:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547464578;
        bh=DS7GtGkD91osbAa6RekCVW+2i6NQKOGWzWvT8VJgdzc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EMhX8BCerUESkfaCvKZY5pB58iOub+MoqmPkn9jLeIHBgBJzBsT4i5w534+SQqSMG
         MMOBv5tuuwVL/HS/oZX5JbdsKcVYGk+Syd7ygKCqMGZx8lmRrkrp439QZQ7CfZ+UX9
         Jv39IRtGP3HIvhwQ/kmstYXtatsREnFZca2qh0XM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EBGIA7024008
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 05:16:18 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 05:16:17 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 05:16:18 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EBFd1b011560;
        Mon, 14 Jan 2019 05:16:14 -0600
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
Subject: [PATCH v2 09/15] PCI: pci-epf-test: Remove setting epf_bar flags in function driver
Date:   Mon, 14 Jan 2019 16:45:07 +0530
Message-ID: <20190114111513.21618-10-kishon@ti.com>
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

Now that pci_epf_alloc_space() sets BAR MEM TYPE flags as 64Bit or
32Bit based on size, remove setting it in function driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 3e86fa3c7da3..44cc31343a80 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -406,10 +406,6 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
 		epf_bar = &epf->bar[bar];
 
-		epf_bar->flags |= upper_32_bits(epf_bar->size) ?
-			PCI_BASE_ADDRESS_MEM_TYPE_64 :
-			PCI_BASE_ADDRESS_MEM_TYPE_32;
-
 		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
-- 
2.17.1

