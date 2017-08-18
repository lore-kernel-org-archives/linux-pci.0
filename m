Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH 07/18] PCI: endpoint: functions/pci-epf-test: Add support to use _any_ BAR's to map PCI_ENDPOINT_TEST regs
Date: Fri, 18 Aug 2017 20:27:59 +0530
Message-ID: <20170818145810.17649-8-kishon@ti.com>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_epf_test always maps the PCI_ENDPOINT_TEST registers to BAR_0. But if
BAR_0 is reserved for some other purpose (like in TI's K2G BAR_0 is
mapped to application registers and cannot be used to map any other
regions), PCI_ENDPOINT_TEST registers cannot be mapped making pci_epf_test
unusable. Add support to use any BAR's to map PCI_ENDPOINT_TEST registers.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 60 +++++++++++++++++++--------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 1a27d7950f2c..e378dae9e510 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -54,6 +54,7 @@ static struct workqueue_struct *kpcitest_workqueue;
 struct pci_epf_test {
 	void			*reg[6];
 	struct pci_epf		*epf;
+	enum pci_barno		test_reg_bar;
 	struct delayed_work	cmd_handler;
 };
 
@@ -74,7 +75,11 @@ static struct pci_epf_header test_header = {
 	.interrupt_pin	= PCI_INTERRUPT_INTA,
 };
 
-static int bar_size[] = { 512, 1024, 16384, 131072, 1048576 };
+struct pci_epf_test_data {
+	enum pci_barno	test_reg_bar;
+};
+
+static int bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 
 static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 {
@@ -86,7 +91,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
-	struct pci_epf_test_reg *reg = epf_test->reg[0];
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
 	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
 	if (!src_addr) {
@@ -145,7 +151,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
-	struct pci_epf_test_reg *reg = epf_test->reg[0];
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
 	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!src_addr) {
@@ -195,7 +202,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
-	struct pci_epf_test_reg *reg = epf_test->reg[0];
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
 	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!dst_addr) {
@@ -247,7 +255,8 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test)
 	u8 msi_count;
 	struct pci_epf *epf = epf_test->epf;
 	struct pci_epc *epc = epf->epc;
-	struct pci_epf_test_reg *reg = epf_test->reg[0];
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
 	reg->status |= STATUS_IRQ_RAISED;
 	msi_count = pci_epc_get_msi(epc);
@@ -268,13 +277,15 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 						     cmd_handler.work);
 	struct pci_epf *epf = epf_test->epf;
 	struct pci_epc *epc = epf->epc;
-	volatile struct pci_epf_test_reg *reg = epf_test->reg[0];
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
 	command = reg->command;
 	if (!command)
 		goto reset_handler;
 
 	reg->command = 0;
+	reg->status = 0;
 
 	if (command & COMMAND_RAISE_LEGACY_IRQ) {
 		reg->status = STATUS_IRQ_RAISED;
@@ -360,6 +371,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 
 	flags = PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32;
 	if (sizeof(dma_addr_t) == 0x8)
@@ -372,7 +384,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
 			dev_err(dev, "failed to set BAR%d\n", bar);
-			if (bar == BAR_0)
+			if (bar == test_reg_bar)
 				return ret;
 		}
 	}
@@ -386,17 +398,20 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	struct device *dev = &epf->dev;
 	void *base;
 	int bar;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 
 	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
-				   BAR_0);
+				   test_reg_bar);
 	if (!base) {
 		dev_err(dev, "failed to allocated register space\n");
 		return -ENOMEM;
 	}
-	epf_test->reg[0] = base;
+	epf_test->reg[test_reg_bar] = base;
 
-	for (bar = BAR_1; bar <= BAR_5; bar++) {
-		base = pci_epf_alloc_space(epf, bar_size[bar - 1], bar);
+	for (bar = BAR_0; bar <= BAR_5; bar++) {
+		if (bar == test_reg_bar)
+			continue;
+		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
 		if (!base)
 			dev_err(dev, "failed to allocate space for BAR%d\n",
 				bar);
@@ -437,10 +452,25 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	return 0;
 }
 
+static const struct pci_epf_device_id pci_epf_test_ids[] = {
+	{
+		.name = "pci_epf_test",
+	},
+	{},
+};
+
 static int pci_epf_test_probe(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test;
 	struct device *dev = &epf->dev;
+	const struct pci_epf_device_id *match;
+	struct pci_epf_test_data *data;
+	enum pci_barno test_reg_bar = BAR_0;
+
+	match = pci_epf_match_device(pci_epf_test_ids, epf);
+	data = (struct pci_epf_test_data *)match->driver_data;
+	if (data)
+		test_reg_bar = data->test_reg_bar;
 
 	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
 	if (!epf_test)
@@ -448,6 +478,7 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 
 	epf->header = &test_header;
 	epf_test->epf = epf;
+	epf_test->test_reg_bar = test_reg_bar;
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
@@ -469,13 +500,6 @@ static struct pci_epf_ops ops = {
 	.linkup = pci_epf_test_linkup,
 };
 
-static const struct pci_epf_device_id pci_epf_test_ids[] = {
-	{
-		.name = "pci_epf_test",
-	},
-	{},
-};
-
 static struct pci_epf_driver test_driver = {
 	.driver.name	= "pci_epf_test",
 	.probe		= pci_epf_test_probe,
-- 
2.11.0
