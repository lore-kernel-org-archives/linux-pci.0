Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C7EC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A4120880
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nABhlNPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfCYIif (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:38:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52578 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbfCYIie (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:38:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P8bjR9106850;
        Mon, 25 Mar 2019 03:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553503065;
        bh=ecY/+Ui4SK2VPooZ8MRoP5X7hto+xBrP5+SVRZo/EkI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nABhlNPlJTLJIek0kqbIX0W+S3oBUO3cAcPsNZUZVPfQ57qIktE++39teT61zXVN8
         KWKNtK5DZDVCtwasK5BGkDJpRttCU96MFyTKnlO1upOzTrkVNV3n2gw9hx5Kzw47XY
         hiLzDsLZvuKif3++DBuVYdGbXRmxA0DqQ3qL9zb0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P8bjsM018060
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 03:37:45 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 03:37:45 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 03:37:45 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P8ZsG7006534;
        Mon, 25 Mar 2019 03:37:41 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-arm-kernel@axis.com>
Subject: [PATCH v2 25/26] misc: pci_endpoint_test: Add support to test PCI EP in AM654x
Date:   Mon, 25 Mar 2019 14:05:00 +0530
Message-ID: <20190325083501.8088-26-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TI's AM654x PCIe EP has a restriction that BAR_0 is mapped to
application registers. "PCIe Inbound Address Translation" section in
AM65x Sitara Processors TRM (SPRUID7 – April 2018) describes BAR0 is
reserved. Configure pci_endpoint_test to use BAR_2 instead.
Also set alignment to 64K since "PCIe Subsystem Address Translation"
section in TRM indicates minimum ATU window size is 64K.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 29582fe57151..e015e8fa9bd3 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -75,6 +75,11 @@
 #define PCI_ENDPOINT_TEST_IRQ_TYPE		0x24
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
+#define PCI_DEVICE_ID_TI_AM654			0xb00c
+
+#define is_am654_pci_dev(pdev)		\
+		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
+
 static DEFINE_IDA(pci_endpoint_test_ida);
 
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
@@ -588,6 +593,7 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	int ret = -EINVAL;
 	enum pci_barno bar;
 	struct pci_endpoint_test *test = to_endpoint_test(file->private_data);
+	struct pci_dev *pdev = test->pdev;
 
 	mutex_lock(&test->mutex);
 	switch (cmd) {
@@ -595,6 +601,8 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 		bar = arg;
 		if (bar < 0 || bar > 5)
 			goto ret;
+		if (is_am654_pci_dev(pdev) && bar == BAR_0)
+			goto ret;
 		ret = pci_endpoint_test_bar(test, bar);
 		break;
 	case PCITEST_LEGACY_IRQ:
@@ -785,11 +793,20 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static const struct pci_endpoint_test_data am654_data = {
+	.test_reg_bar = BAR_2,
+	.alignment = SZ_64K,
+	.irq_type = IRQ_TYPE_MSI,
+};
+
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
+	  .driver_data = (kernel_ulong_t)&am654_data
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.17.1

