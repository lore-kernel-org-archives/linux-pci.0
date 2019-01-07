Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D4FC43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 06:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C28B20881
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 06:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JZsfIhRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfAGGoD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 01:44:03 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41094 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfAGGoA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2019 01:44:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x076hZRx059042;
        Mon, 7 Jan 2019 00:43:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546843415;
        bh=I1BEPEyj0/HrX7NYKrqEJYA/4rslF5P7456ZRPE0ths=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JZsfIhRr3LWz1cdE8NnKTtVCTFa/Z0B6e7mbtVJKhniihvqefOIVHBYaKQXTxZRei
         U3ZP8hHfDc/R7vciQ1B7JPO6um3dqh78LKcPMvsEit7Cu44LEBT1iH4Y70GlxFCAzw
         2VY2MSm2U7XSF6e1ieXTpDTNhdodLYo7oEEnFGYs=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x076hZKg071461
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 00:43:35 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 00:43:34 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 00:43:35 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x076gfo8002672;
        Mon, 7 Jan 2019 00:43:31 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <kishon@ti.com>
Subject: [PATCH 11/15] PCI: pci-epf-test: Use pci_epc_get_features to get EPC features
Date:   Mon, 7 Jan 2019 12:11:44 +0530
Message-ID: <20190107064148.10152-12-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pci_epc_get_features to get EPC features such as linkup
notifier support, MSI/MSIX capable, BAR configuration etc and use it
for configuring pci-epf-test. Since these features are now obtained
directly from EPC driver, remove pci_epf_test_data which was initially
added to have EPC features in endpoint function driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 72 ++++++++++---------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ade296180383..a26f6ccaa322 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -47,8 +47,6 @@ struct pci_epf_test {
 	void			*reg[6];
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
-	bool			linkup_notifier;
-	bool			msix_available;
 	struct delayed_work	cmd_handler;
 };
 
@@ -71,11 +69,6 @@ static struct pci_epf_header test_header = {
 	.interrupt_pin	= PCI_INTERRUPT_INTA,
 };
 
-struct pci_epf_test_data {
-	enum pci_barno	test_reg_bar;
-	bool		linkup_notifier;
-};
-
 static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 
 static int pci_epf_test_copy(struct pci_epf_test *epf_test)
@@ -458,25 +451,49 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	return 0;
 }
 
+static void pci_epf_configure_bar(struct pci_epf *epf,
+				  const struct pci_epc_features *epc_features)
+{
+	struct pci_epf_bar *epf_bar;
+	bool bar_fixed_64bit;
+	int i;
+
+	for (i = BAR_0; i <= BAR_5; i++) {
+		epf_bar = &epf->bar[i];
+		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
+		if (bar_fixed_64bit)
+			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+		if (epc_features->bar_fixed_size[i])
+			bar_size[i] = epc_features->bar_fixed_size[i];
+	}
+}
+
 static int pci_epf_test_bind(struct pci_epf *epf)
 {
 	int ret;
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct pci_epf_header *header = epf->header;
+	const struct pci_epc_features *epc_features;
+	enum pci_barno test_reg_bar = BAR_0;
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
+	bool linkup_notifier = false;
+	bool msix_capable = false;
+	bool msi_capable = true;
 
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
 
-	if (epc->features & EPC_FEATURE_NO_LINKUP_NOTIFIER)
-		epf_test->linkup_notifier = false;
-	else
-		epf_test->linkup_notifier = true;
-
-	epf_test->msix_available = epc->features & EPC_FEATURE_MSIX_AVAILABLE;
+	epc_features = pci_epc_get_features(epc, epf->func_no);
+	if (!epc_features) {
+		linkup_notifier = epc_features->linkup_notifier;
+		msix_capable = epc_features->msix_capable;
+		msi_capable = epc_features->msi_capable;
+		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
+		pci_epf_configure_bar(epf, epc_features);
+	}
 
-	epf_test->test_reg_bar = EPC_FEATURE_GET_BAR(epc->features);
+	epf_test->test_reg_bar = test_reg_bar;
 
 	ret = pci_epc_write_header(epc, epf->func_no, header);
 	if (ret) {
@@ -492,13 +509,15 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
-	ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
-	if (ret) {
-		dev_err(dev, "MSI configuration failed\n");
-		return ret;
+	if (msi_capable) {
+		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
+		if (ret) {
+			dev_err(dev, "MSI configuration failed\n");
+			return ret;
+		}
 	}
 
-	if (epf_test->msix_available) {
+	if (msix_capable) {
 		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
 		if (ret) {
 			dev_err(dev, "MSI-X configuration failed\n");
@@ -506,7 +525,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		}
 	}
 
-	if (!epf_test->linkup_notifier)
+	if (!linkup_notifier)
 		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
 
 	return 0;
@@ -523,17 +542,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test;
 	struct device *dev = &epf->dev;
-	const struct pci_epf_device_id *match;
-	struct pci_epf_test_data *data;
-	enum pci_barno test_reg_bar = BAR_0;
-	bool linkup_notifier = true;
-
-	match = pci_epf_match_device(pci_epf_test_ids, epf);
-	data = (struct pci_epf_test_data *)match->driver_data;
-	if (data) {
-		test_reg_bar = data->test_reg_bar;
-		linkup_notifier = data->linkup_notifier;
-	}
 
 	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
 	if (!epf_test)
@@ -541,8 +549,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 
 	epf->header = &test_header;
 	epf_test->epf = epf;
-	epf_test->test_reg_bar = test_reg_bar;
-	epf_test->linkup_notifier = linkup_notifier;
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
-- 
2.17.1

