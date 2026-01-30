Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4447080E;
	Fri, 30 Jan 2026 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769772740; cv=none; b=Xz8SH++KMU7IR0JTjl/djdy9UKgUmyYX/8vWWfEwzPBMb0znioJJVcVkfauxwFVuYNFNwvnDDeMmMXI4DdCJBdY0XA/KvirozgmGppG5XZQRSsNxaF61k/hCBilJwjdV7WTA+IIH/Tc2hLGPgxsfb+XB3ZdD4jqoLarxzrydt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769772740; c=relaxed/simple;
	bh=x8QiWewuBIKCnSF4w/prPydUCF3G3iJdESwqF/Ev3+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQO0uHdcCIfdlPN8gYoiOiek6bHsNnDO0koQB8d4Wfm3r8ucasVNyXj3nEd3+YoClikUsftOg4r2U9qF4G19M458NFnq8Pg00lHKjnbC3Qkp7eOzUcBEcY7yJ7tWRUVUjsSicpoDOVET1YP5Xp5RYDoneuPpcEPEE9KLctIrskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWsYBnXm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWsYBnXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F99C4CEF7;
	Fri, 30 Jan 2026 11:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769772739;
	bh=x8QiWewuBIKCnSF4w/prPydUCF3G3iJdESwqF/Ev3+M=;
	h=From:To:Cc:Subject:Date:From;
	b=cWsYBnXmhC4/HrHZzGqtCx3sZWsVBpNAQHfycCAJaeaiz648vIH5+ASk1fMO6cQR4
	 Pv1+bZ3bcIR4D/24Lv3D1TiPjVZMtnDJeWcb4vXxCby68mKZtDNNRQsN5LlDqcypBr
	 JNpViVH/G8frSY4BmUSDpbsntxd+xgcyMrXYY1kkpZ+ubBwYKXoJmgBed8YMgXLdjs
	 acoGLpFmPG8dOPDHZd/krEech+sr/V289x5PKYqox/v7zbdKSkzbNsolfdTku7NwWj
	 7tBRSGY8IrL1ygr9TH0L0dFtVW9tv0RgMkQh0uMIF+7h66lEze3bW6n6uRJTaTa8QP
	 6KYCrXGWP+UIw==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Frank.Li@nxp.com,
	dlemoal@kernel.org,
	Koichiro Den <den@valinux.co.jp>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5] PCI: endpoint: pci-epf-test: Allow overriding default BAR sizes
Date: Fri, 30 Jan 2026 12:30:39 +0100
Message-ID: <20260130113038.2143947-2-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7711; i=cassel@kernel.org; h=from:subject; bh=x8QiWewuBIKCnSF4w/prPydUCF3G3iJdESwqF/Ev3+M=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJrpsXJRCilnHi/OvBL5VTLlZMNnrgfOVxywUTh15X3f YoLBa/wd5SyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAijScZGX6855q77IXF4WcV M3v/sqXN36XSzZrl5J3p9pezOK5g/SNGhuUZK3dXeCnNN120ouChtm59z5SzLgoCq+21pxy/JiK kwg4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add bar{0,1,2,3,4,5}_size attributes in configfs, so that the user is not
restricted to run pci-epf-test with the hardcoded BAR size values defined
in pci-epf-test.c.

This code is shamelessly more or less copy pasted from pci-epf-vntb.c

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since V4:
-Declare variables on same line.
-Improved code comment.
-Picked up tags.

 Documentation/PCI/endpoint/pci-test-howto.rst | 19 ++++
 drivers/pci/endpoint/functions/pci-epf-test.c | 99 ++++++++++++++++++-
 2 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-test-howto.rst b/Documentation/PCI/endpoint/pci-test-howto.rst
index dd66858cde46..cf38daa512ea 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.rst
+++ b/Documentation/PCI/endpoint/pci-test-howto.rst
@@ -84,6 +84,25 @@ device, the following commands can be used::
 	# echo 32 > functions/pci_epf_test/func1/msi_interrupts
 	# echo 2048 > functions/pci_epf_test/func1/msix_interrupts
 
+By default, pci-epf-test uses the following BAR sizes::
+
+	# grep . functions/pci_epf_test/func1/pci_epf_test.0/bar?_size
+	  functions/pci_epf_test/func1/pci_epf_test.0/bar0_size:131072
+	  functions/pci_epf_test/func1/pci_epf_test.0/bar1_size:131072
+	  functions/pci_epf_test/func1/pci_epf_test.0/bar2_size:131072
+	  functions/pci_epf_test/func1/pci_epf_test.0/bar3_size:131072
+	  functions/pci_epf_test/func1/pci_epf_test.0/bar4_size:131072
+	  functions/pci_epf_test/func1/pci_epf_test.0/bar5_size:1048576
+
+The user can override a default value using e.g.::
+	# echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar1_size
+
+Overriding the default BAR sizes can only be done before binding the
+pci-epf-test device to a PCI endpoint controller driver.
+
+Note: Some endpoint controllers might have fixed size BARs, or reserved BARs,
+for such controllers, the corresponding BAR size in configfs will be ignored.
+
 
 Binding pci-epf-test Device to EP Controller
 --------------------------------------------
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 1cc630a2ee75..98a9c3176b48 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -72,6 +72,7 @@ static struct workqueue_struct *kpcitest_workqueue;
 struct pci_epf_test {
 	void			*reg[PCI_STD_NUM_BARS];
 	struct pci_epf		*epf;
+	struct config_group	group;
 	enum pci_barno		test_reg_bar;
 	size_t			msix_table_offset;
 	struct delayed_work	cmd_handler;
@@ -85,6 +86,7 @@ struct pci_epf_test {
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
+	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
 struct pci_epf_test_reg {
@@ -111,7 +113,8 @@ static struct pci_epf_header test_header = {
 	.interrupt_pin	= PCI_INTERRUPT_INTA,
 };
 
-static size_t bar_size[] = { 131072, 131072, 131072, 131072, 131072, 1048576 };
+/* default BAR sizes, can be overridden by the user using configfs */
+static size_t default_bar_size[] = { 131072, 131072, 131072, 131072, 131072, 1048576 };
 
 static void pci_epf_test_dma_callback(void *param)
 {
@@ -1240,7 +1243,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		if (epc_features->bar[bar].type == BAR_FIXED)
 			test_reg_size = epc_features->bar[bar].fixed_size;
 		else
-			test_reg_size = bar_size[bar];
+			test_reg_size = epf_test->bar_size[bar];
 
 		base = pci_epf_alloc_space(epf, test_reg_size, bar,
 					   epc_features, PRIMARY_INTERFACE);
@@ -1312,6 +1315,94 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 	pci_epf_test_free_space(epf);
 }
 
+#define PCI_EPF_TEST_BAR_SIZE_R(_name, _id)				\
+static ssize_t pci_epf_test_##_name##_show(struct config_item *item,	\
+					   char *page)			\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct pci_epf_test *epf_test =					\
+		container_of(group, struct pci_epf_test, group);	\
+									\
+	return sysfs_emit(page, "%zu\n", epf_test->bar_size[_id]);	\
+}
+
+#define PCI_EPF_TEST_BAR_SIZE_W(_name, _id)				\
+static ssize_t pci_epf_test_##_name##_store(struct config_item *item,	\
+					    const char *page,		\
+					    size_t len)			\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct pci_epf_test *epf_test =					\
+		container_of(group, struct pci_epf_test, group);	\
+	int val, ret;							\
+									\
+	/*								\
+	 * BAR sizes can only be modified before binding to an EPC,	\
+	 * because pci_epf_test_alloc_space() is called in .bind().	\
+	 */								\
+	if (epf_test->epf->epc)						\
+		return -EINVAL;						\
+									\
+	ret = kstrtouint(page, 0, &val);				\
+	if (ret)							\
+		return ret;						\
+									\
+	if (!is_power_of_2(val))					\
+		return -EINVAL;						\
+									\
+	epf_test->bar_size[_id] = val;					\
+									\
+	return len;							\
+}
+
+PCI_EPF_TEST_BAR_SIZE_R(bar0_size, BAR_0)
+PCI_EPF_TEST_BAR_SIZE_W(bar0_size, BAR_0)
+PCI_EPF_TEST_BAR_SIZE_R(bar1_size, BAR_1)
+PCI_EPF_TEST_BAR_SIZE_W(bar1_size, BAR_1)
+PCI_EPF_TEST_BAR_SIZE_R(bar2_size, BAR_2)
+PCI_EPF_TEST_BAR_SIZE_W(bar2_size, BAR_2)
+PCI_EPF_TEST_BAR_SIZE_R(bar3_size, BAR_3)
+PCI_EPF_TEST_BAR_SIZE_W(bar3_size, BAR_3)
+PCI_EPF_TEST_BAR_SIZE_R(bar4_size, BAR_4)
+PCI_EPF_TEST_BAR_SIZE_W(bar4_size, BAR_4)
+PCI_EPF_TEST_BAR_SIZE_R(bar5_size, BAR_5)
+PCI_EPF_TEST_BAR_SIZE_W(bar5_size, BAR_5)
+
+CONFIGFS_ATTR(pci_epf_test_, bar0_size);
+CONFIGFS_ATTR(pci_epf_test_, bar1_size);
+CONFIGFS_ATTR(pci_epf_test_, bar2_size);
+CONFIGFS_ATTR(pci_epf_test_, bar3_size);
+CONFIGFS_ATTR(pci_epf_test_, bar4_size);
+CONFIGFS_ATTR(pci_epf_test_, bar5_size);
+
+static struct configfs_attribute *pci_epf_test_attrs[] = {
+	&pci_epf_test_attr_bar0_size,
+	&pci_epf_test_attr_bar1_size,
+	&pci_epf_test_attr_bar2_size,
+	&pci_epf_test_attr_bar3_size,
+	&pci_epf_test_attr_bar4_size,
+	&pci_epf_test_attr_bar5_size,
+	NULL,
+};
+
+static const struct config_item_type pci_epf_test_group_type = {
+	.ct_attrs	= pci_epf_test_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *pci_epf_test_add_cfs(struct pci_epf *epf,
+						 struct config_group *group)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	struct config_group *epf_group = &epf_test->group;
+	struct device *dev = &epf->dev;
+
+	config_group_init_type_name(epf_group, dev_name(dev),
+				    &pci_epf_test_group_type);
+
+	return epf_group;
+}
+
 static const struct pci_epf_device_id pci_epf_test_ids[] = {
 	{
 		.name = "pci_epf_test",
@@ -1324,6 +1415,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
 {
 	struct pci_epf_test *epf_test;
 	struct device *dev = &epf->dev;
+	enum pci_barno bar;
 
 	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
 	if (!epf_test)
@@ -1331,6 +1423,8 @@ static int pci_epf_test_probe(struct pci_epf *epf,
 
 	epf->header = &test_header;
 	epf_test->epf = epf;
+	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++)
+		epf_test->bar_size[bar] = default_bar_size[bar];
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
@@ -1343,6 +1437,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
 static const struct pci_epf_ops ops = {
 	.unbind	= pci_epf_test_unbind,
 	.bind	= pci_epf_test_bind,
+	.add_cfs = pci_epf_test_add_cfs,
 };
 
 static struct pci_epf_driver test_driver = {
-- 
2.52.0

