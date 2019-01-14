Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD08C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A37920656
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MnarZvli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfANLSR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:18:17 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45852 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfANLSQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 06:18:16 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EBGQCi112768;
        Mon, 14 Jan 2019 05:16:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547464586;
        bh=2uDrXrY9NBnXdAPSRPaCNiNMbVveMwv8owns43GbBkk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MnarZvlipwvByteR3HR6kltcgVuYCM0wZpb5rzGs4pZVXqEnEZBpmj1sk9kt2QyF4
         POUlhOGDIdZ2IpMJHyexPlsRBF9xR64X1xu08d98srBPQvUZ4mSDpDC3vV33FKErrk
         Hkmr5VYlTuIxOxMrjwC0UdeXhHXDpTVPOgQCbPiM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EBGQAU024080
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 05:16:26 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 05:16:25 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 05:16:25 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EBFd1d011560;
        Mon, 14 Jan 2019 05:16:22 -0600
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
Subject: [PATCH v2 11/15] PCI: pci-epf-test: Use pci_epc_get_features to get EPC features
Date:   Mon, 14 Jan 2019 16:45:09 +0530
Message-ID: <20190114111513.21618-12-kishon@ti.com>
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

Use pci_epc_get_features to get EPC features such as linkup
notifier support, MSI/MSIX capable, BAR configuration etc and use it
for configuring pci-epf-test. Since these features are now obtained
directly from EPC driver, remove pci_epf_test_data which was initially
added to have EPC features in endpoint function driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 87 ++++++++++++-------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ade296180383..2e0fb231ce0c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -47,9 +47,8 @@ struct pci_epf_test {
 	void			*reg[6];
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
-	bool			linkup_notifier;
-	bool			msix_available;
 	struct delayed_work	cmd_handler;
+	const struct pci_epc_features *epc_features;
 };
 
 struct pci_epf_test_reg {
@@ -71,11 +70,6 @@ static struct pci_epf_header test_header = {
 	.interrupt_pin	= PCI_INTERRUPT_INTA,
 };
 
-struct pci_epf_test_data {
-	enum pci_barno	test_reg_bar;
-	bool		linkup_notifier;
-};
-
 static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 
 static int pci_epf_test_copy(struct pci_epf_test *epf_test)
@@ -402,10 +396,16 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	struct device *dev = &epf->dev;
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	const struct pci_epc_features *epc_features;
+
+	epc_features = epf_test->epc_features;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
 		epf_bar = &epf->bar[bar];
 
+		if (!!(epc_features->reserved_bar & (1 << bar)))
+			continue;
+
 		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
@@ -433,6 +433,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	void *base;
 	int bar;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	const struct pci_epc_features *epc_features;
+
+	epc_features = epf_test->epc_features;
 
 	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
 				   test_reg_bar);
@@ -446,6 +449,10 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		epf_bar = &epf->bar[bar];
 		if (bar == test_reg_bar)
 			continue;
+
+		if (!!(epc_features->reserved_bar & (1 << bar)))
+			continue;
+
 		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
 		if (!base)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
@@ -458,25 +465,50 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
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
+	if (epc_features) {
+		linkup_notifier = epc_features->linkup_notifier;
+		msix_capable = epc_features->msix_capable;
+		msi_capable = epc_features->msi_capable;
+		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
+		pci_epf_configure_bar(epf, epc_features);
+	}
 
-	epf_test->test_reg_bar = EPC_FEATURE_GET_BAR(epc->features);
+	epf_test->test_reg_bar = test_reg_bar;
+	epf_test->epc_features = epc_features;
 
 	ret = pci_epc_write_header(epc, epf->func_no, header);
 	if (ret) {
@@ -492,13 +524,15 @@ static int pci_epf_test_bind(struct pci_epf *epf)
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
@@ -506,7 +540,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		}
 	}
 
-	if (!epf_test->linkup_notifier)
+	if (!linkup_notifier)
 		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
 
 	return 0;
@@ -523,17 +557,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
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
@@ -541,8 +564,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 
 	epf->header = &test_header;
 	epf_test->epf = epf;
-	epf_test->test_reg_bar = test_reg_bar;
-	epf_test->linkup_notifier = linkup_notifier;
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
-- 
2.17.1

