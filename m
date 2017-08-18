Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:19592 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbdHRO6u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2017 10:58:50 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH 08/18] PCI: endpoint: functions/pci-epf-test: Add support to poll early for host commands
Date: Fri, 18 Aug 2017 20:28:00 +0530
Message-ID: <20170818145810.17649-9-kishon@ti.com>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Certain platforms like TI's K2G doesn't support link-up notification. Add
support to poll early (without waiting for the linkup notification)
for commands from the host.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index e378dae9e510..a0aea2500690 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -55,6 +55,7 @@ struct pci_epf_test {
 	void			*reg[6];
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
+	bool			linkup_notifier;
 	struct delayed_work	cmd_handler;
 };
 
@@ -77,6 +78,7 @@ static struct pci_epf_header test_header = {
 
 struct pci_epf_test_data {
 	enum pci_barno	test_reg_bar;
+	bool		linkup_notifier;
 };
 
 static int bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
@@ -424,6 +426,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 static int pci_epf_test_bind(struct pci_epf *epf)
 {
 	int ret;
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct pci_epf_header *header = epf->header;
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
@@ -449,6 +452,9 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
+	if (!epf_test->linkup_notifier)
+		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
+
 	return 0;
 }
 
@@ -466,11 +472,14 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 	const struct pci_epf_device_id *match;
 	struct pci_epf_test_data *data;
 	enum pci_barno test_reg_bar = BAR_0;
+	bool linkup_notifier = true;
 
 	match = pci_epf_match_device(pci_epf_test_ids, epf);
 	data = (struct pci_epf_test_data *)match->driver_data;
-	if (data)
+	if (data) {
 		test_reg_bar = data->test_reg_bar;
+		linkup_notifier = data->linkup_notifier;
+	}
 
 	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
 	if (!epf_test)
@@ -479,6 +488,7 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 	epf->header = &test_header;
 	epf_test->epf = epf;
 	epf_test->test_reg_bar = test_reg_bar;
+	epf_test->linkup_notifier = linkup_notifier;
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
-- 
2.11.0
