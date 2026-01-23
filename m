Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCE019C553;
	Fri, 23 Jan 2026 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191677; cv=none; b=pwhTBGTVLG6jxD/IxiDqCGO2VlKQVq+PqkyIleYJUw2tBXhjsrITfh/sLau6cAM07k9yGTpQmHtvReu05qLDlUEtstq6BcH07/vFp0Yuxkrv3we//o+POk8xYqdTiOAGP9HnBf9D59mvf9n5FLidZG+CdIjYWhR77xjWzuGnRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191677; c=relaxed/simple;
	bh=/r6lygopbUnU7cK5yAYRsR5j1o88MtW9PB5XGJEBn64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eF79lC0fQGnEvcw5v22mQE8Iv68ywUiFHxIhkDCehwupFmZtkVXBwqY7eWmuYCqTu1pXDvqDxVe/4RxJEgXQnhY6PEhTATxvVDj2KDnB/JeJibRZxAkIIOifYHlYl4Y44jxUdZO+hy52NacHCmikO2GFzPhMxZaYnv5a//VMZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+2AUX4l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+2AUX4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3A9C4CEF1;
	Fri, 23 Jan 2026 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769191676;
	bh=/r6lygopbUnU7cK5yAYRsR5j1o88MtW9PB5XGJEBn64=;
	h=From:To:Cc:Subject:Date:From;
	b=L+2AUX4lkjr5sx9DnNiikD1yohr+5BLa0YKlgfnUBVX0GZguSesu+Gcrq6t1jXobh
	 tZyYkgigLJDrzkZLHRumRZr5I074g8tg/Jj1h14TYabXO3MGjA9POmoE6wWBrZRW+6
	 EgwSRJCBWmfAdhXV8wxrbKhNMCJ+rRqwXomceO+e2vAaVePBgZe/8u7gjmENPlWVZC
	 EflTDBCWFBILncgO/UVsaei0WMRUydSeifitGPc4vsZs8KNJrYNJmDwiD9VKXbpMdF
	 MhnMi0lQ5lPuICvP5d5rnmnJNv+OY4UgHv32C2Oz9keX5EADrOW3W+aAW5CplX6hNB
	 NLwRGjnq8b7Pg==
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
Subject: [PATCH] PCI: endpoint: pci-epf-test: Allow overriding default BAR sizes
Date: Fri, 23 Jan 2026 19:07:48 +0100
Message-ID: <20260123180747.827357-2-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7140; i=cassel@kernel.org; h=from:subject; bh=/r6lygopbUnU7cK5yAYRsR5j1o88MtW9PB5XGJEBn64=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKLd3x+fUF5mUbbwv1V+899/zNNT7tCqqKkJLllRojOV j+N/3GLOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRU9MZ/ntyz1i2+twRnVOM 3bX3EkNWPA58ybFM6bbKmWmX1AtNQlwY/hkH/3+37titGvalbU8NNfYeY3gmVHd/1+41mksVN02 tmccEAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add bar{0,1,2,3,4,5}_size attributes in configfs, so that the user is not
restricted to run pci-epf-test with the hardcoded BAR size values defined
in pci-epf-test.c.

This code is shamelessly more or less copy pasted from pci-epf-vntb.c

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 Documentation/PCI/endpoint/pci-test-howto.rst | 16 ++++
 drivers/pci/endpoint/functions/pci-epf-test.c | 92 ++++++++++++++++++-
 2 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-test-howto.rst b/Documentation/PCI/endpoint/pci-test-howto.rst
index dd66858cde46..71975721cfd5 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.rst
+++ b/Documentation/PCI/endpoint/pci-test-howto.rst
@@ -84,6 +84,22 @@ device, the following commands can be used::
 	# echo 32 > functions/pci_epf_test/func1/msi_interrupts
 	# echo 2048 > functions/pci_epf_test/func1/msix_interrupts
 
+By default, pci-epf-test uses the following BAR sizes::
+
+	# grep . functions/pci_epf_test/func1/pci_epf_test.0/bar?_size
+	  functions/pci_epf_test/func1/pci_epf_test.0/bar0_size:512
+	  functions/pci_epf_test/func1/pci_epf_test.0/bar1_size:512
+	  functions/pci_epf_test/func1/pci_epf_test.0/bar2_size:1024
+	  functions/pci_epf_test/func1/pci_epf_test.0/bar3_size:16384
+	  functions/pci_epf_test/func1/pci_epf_test.0/bar4_size:131072
+	  functions/pci_epf_test/func1/pci_epf_test.0/bar5_size:1048576
+
+The user can override a default value using e.g.::
+	# echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar1_size
+
+Note: Some endpoint controllers might have fixed size BARs, or reserved BARs,
+for such controllers, the corresponding BAR size in configfs will be ignored.
+
 
 Binding pci-epf-test Device to EP Controller
 --------------------------------------------
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index b785d488c284..fda257e46920 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -63,6 +63,7 @@ static struct workqueue_struct *kpcitest_workqueue;
 struct pci_epf_test {
 	void			*reg[PCI_STD_NUM_BARS];
 	struct pci_epf		*epf;
+	struct config_group	group;
 	enum pci_barno		test_reg_bar;
 	size_t			msix_table_offset;
 	struct delayed_work	cmd_handler;
@@ -76,6 +77,7 @@ struct pci_epf_test {
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
+	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
 struct pci_epf_test_reg {
@@ -102,7 +104,8 @@ static struct pci_epf_header test_header = {
 	.interrupt_pin	= PCI_INTERRUPT_INTA,
 };
 
-static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
+/* default BAR sizes, can be overridden by the user using configfs */
+static size_t default_bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 
 static void pci_epf_test_dma_callback(void *param)
 {
@@ -1070,7 +1073,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		if (epc_features->bar[bar].type == BAR_FIXED)
 			test_reg_size = epc_features->bar[bar].fixed_size;
 		else
-			test_reg_size = bar_size[bar];
+			test_reg_size = epf_test->bar_size[bar];
 
 		base = pci_epf_alloc_space(epf, test_reg_size, bar,
 					   epc_features, PRIMARY_INTERFACE);
@@ -1142,6 +1145,87 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 	pci_epf_test_free_space(epf);
 }
 
+#define PCI_EPF_TEST_BAR_SIZE_R(_name, _id)				\
+	static ssize_t pci_epf_test_##_name##_show(struct config_item *item,	\
+						   char *page)		\
+	{								\
+		struct config_group *group = to_config_group(item);	\
+		struct pci_epf_test *epf_test = container_of(group,	\
+					struct pci_epf_test, group);	\
+									\
+		return sprintf(page, "%zu\n", epf_test->bar_size[_id]);	\
+	}
+
+#define PCI_EPF_TEST_BAR_SIZE_W(_name, _id)				\
+	static ssize_t pci_epf_test_##_name##_store(struct config_item *item, \
+						    const char *page, size_t len) \
+	{								\
+		struct config_group *group = to_config_group(item);	\
+		struct pci_epf_test *epf_test = container_of(group,	\
+					struct pci_epf_test, group);	\
+		int val;						\
+		int ret;						\
+									\
+		ret = kstrtouint(page, 0, &val);			\
+		if (ret)						\
+			return ret;					\
+									\
+		if (!is_power_of_2(val))				\
+			return -EINVAL;					\
+									\
+		epf_test->bar_size[_id] = val;				\
+									\
+		return len;						\
+	}
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
@@ -1154,6 +1238,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
 {
 	struct pci_epf_test *epf_test;
 	struct device *dev = &epf->dev;
+	enum pci_barno bar;
 
 	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
 	if (!epf_test)
@@ -1161,6 +1246,8 @@ static int pci_epf_test_probe(struct pci_epf *epf,
 
 	epf->header = &test_header;
 	epf_test->epf = epf;
+	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++)
+		epf_test->bar_size[bar] = default_bar_size[bar];
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
@@ -1173,6 +1260,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
 static const struct pci_epf_ops ops = {
 	.unbind	= pci_epf_test_unbind,
 	.bind	= pci_epf_test_bind,
+	.add_cfs = pci_epf_test_add_cfs,
 };
 
 static struct pci_epf_driver test_driver = {

base-commit: c0dbaab0524adbc90d693aa15ab84354dd71acb2
-- 
2.52.0

