Return-Path: <SRS0=Jg1T=2U=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6934EC2D0D3
	for <linux-pci@archiver.kernel.org>; Mon, 30 Dec 2019 12:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C742080A
	for <linux-pci@archiver.kernel.org>; Mon, 30 Dec 2019 12:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p3v1n3V/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfL3Mbg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 30 Dec 2019 07:31:36 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60356 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfL3Mbf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Dec 2019 07:31:35 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVNG2039076;
        Mon, 30 Dec 2019 06:31:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577709083;
        bh=VtEJU4ab4RUM55E/wEo6hBdB5joL/ciHyw3e3snZOGA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=p3v1n3V/stbuvljQe057ss2Mwvxj5i79vjEypcFk0EyzIHD7NBUW4+y9KWLwfEDQo
         b3Bs2M5oi1n2pckCLyy5jqEK8mX9tv76zk0rnYswClftBWtA6wadG9TPTPgycJu20d
         lxjkls/+od90aKMRnR6mnzC2WJWGwgNSl9Aku9kE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBUCVNUp058554
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Dec 2019 06:31:23 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Dec 2019 06:31:23 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Dec 2019 06:31:22 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVEhO002491;
        Mon, 30 Dec 2019 06:31:20 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] misc: pci_endpoint_test: Do not request or allocate IRQs in probe
Date:   Mon, 30 Dec 2019 18:03:10 +0530
Message-ID: <20191230123315.31037-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230123315.31037-1-kishon@ti.com>
References: <20191230123315.31037-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allocation of IRQ vectors and requesting IRQ is done as part of
PCITEST_SET_IRQTYPE. Do not request or allocate IRQs in probe for
AM654 and J721E so that the user space test script has better control
of the devices for which the IRQs are configured.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 743ff4dcb3f0..04505890eae9 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -70,6 +70,9 @@
 #define is_am654_pci_dev(pdev)		\
 		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
 
+#define is_j721e_pci_dev(pdev)         \
+		((pdev)->device == PCI_DEVICE_ID_TI_J721E)
+
 static DEFINE_IDA(pci_endpoint_test_ida);
 
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
@@ -688,11 +691,13 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type))
-		goto err_disable_irq;
+	if (!(is_am654_pci_dev(pdev) || is_j721e_pci_dev(pdev))) {
+		if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type))
+			goto err_disable_irq;
 
-	if (!pci_endpoint_test_request_irq(test))
-		goto err_disable_irq;
+		if (!pci_endpoint_test_request_irq(test))
+			goto err_disable_irq;
+	}
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
-- 
2.17.1

