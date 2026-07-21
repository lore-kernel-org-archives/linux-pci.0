Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F2D3FE650
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599473; cv=none; b=g8WHZ1Z1EM72TrJz09uT2iw4l2lPFspjJpw+Q3aS9cO/NPGkPn3u/cziw7uYDg4MwC9DQ0M/K8UELXkBclt2KfTd+ssLH06uNdY6ABkGom33HQoR66Z9nJDfPDe9EZuyZ2NXpHK6Q/6TLQq8D+gGSAovEDrIoQtyoH5R4ea2HGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599473; c=relaxed/simple;
	bh=SxSDFbIc1gVeXEtLrm3H/BYq3Pmc9NfuuCdXijj/Vs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ua9CnO46LRgNdP3XiMGcSjKBbyK+WyC9j5v1PK0xEkelSVsbC9wZ7iq54LNXP5DhD9QX5n3Rs6HHQ5Vkiuk6pLdz1QmjoiV8q3oftuMVm21QXWK+UzYUpC6r852JZhJQlxLZis9XMtWGyZptgOBLBxdWtS7ixzwj3+Dcb4Yoctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqvErgY9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqvErgY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DBB1F000E9;
	Tue, 21 Jul 2026 02:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784599471;
	bh=/mRxMG4tPmh2PZi21HfgNLK73ENIMPLiI1ES1J8oi84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RqvErgY9n2MqKq5typhZ2MY288jWV7AeDhTECnFMMU1iIE01kUm5tE/oVX7N3/Jyy
	 mYchup2HdOhVfyM6vNQif+pcNxrFchJMsBeuVe2GGMaWFzGZdf3l1So+o57Mc2nlk2
	 WmS8H2QZJWTUTIBM25uIKw+GjYOXAqc4erE1X9ybMCOlWAzsW2wry45LdU0eyyveM4
	 bSlycbDKrWJgV7YTm0ZsH0YNojIF2lFOrW0MONNiVoYMfp+jn1ZwAtBsAxItK4VBvD
	 iNdht+/rXAPxe68mWe3PFKxJwc/14iKXr6rFpOcu6JGPOQDic+hbRY5XzqdI8qUa6e
	 /d3EY30a01oIw==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI/sysfs: Add pci_ prefix to static PCI resource attribute names
Date: Tue, 21 Jul 2026 02:04:24 +0000
Message-ID: <20260721020427.1541197-2-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721020427.1541197-1-kwilczynski@kernel.org>
References: <20260721020427.1541197-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, the static binary attributes for the PCI resource files are
generated with the names dev_resource<N>_io_attr, dev_resource<N>_uc_attr
and dev_resource<N>_wc_attr.

The macros that generate these attributes and the arrays that collect
them already carry the pci_ prefix, as do the sibling legacy I/O and
memory attributes, such as pci_legacy_io_attr.  Only the generated
variable names lack it.

Thus, rename the generated variables to pci_dev_resource<N>_io_attr,
pci_dev_resource<N>_uc_attr and pci_dev_resource<N>_wc_attr, and update
the attribute pointer arrays to match.

While at it, re-align the continuation backslashes in the resource
attribute macros to match.

No functional changes intended.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 60 ++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5ec0b245a69b..cb7a121e5988 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1239,16 +1239,16 @@ static loff_t pci_llseek_resource(struct file *filep,
  * attribute, it's not going to work, so override it as well.
  */
 #if arch_can_pci_mmap_io()
-# define __PCI_RESOURCE_IO_MMAP_ATTRS		\
-	.f_mapping = iomem_get_mapping,		\
-	.llseek = pci_llseek_resource,		\
+# define __PCI_RESOURCE_IO_MMAP_ATTRS	\
+	.f_mapping = iomem_get_mapping,	\
+	.llseek = pci_llseek_resource,	\
 	.mmap = pci_mmap_resource_uc,
 #else
 # define __PCI_RESOURCE_IO_MMAP_ATTRS
 #endif
 
 #define pci_dev_resource_io_attr(_bar)					\
-static const struct bin_attribute dev_resource##_bar##_io_attr = {	\
+static const struct bin_attribute pci_dev_resource##_bar##_io_attr = {	\
 	.attr = { .name = "resource" __stringify(_bar), .mode = 0600 },	\
 	.private = (void *)(unsigned long)(_bar),			\
 	.read = pci_read_resource,					\
@@ -1257,7 +1257,7 @@ static const struct bin_attribute dev_resource##_bar##_io_attr = {	\
 }
 
 #define pci_dev_resource_uc_attr(_bar)					\
-static const struct bin_attribute dev_resource##_bar##_uc_attr = {	\
+static const struct bin_attribute pci_dev_resource##_bar##_uc_attr = {	\
 	.attr = { .name = "resource" __stringify(_bar), .mode = 0600 },	\
 	.private = (void *)(unsigned long)(_bar),			\
 	.f_mapping = iomem_get_mapping,					\
@@ -1265,13 +1265,13 @@ static const struct bin_attribute dev_resource##_bar##_uc_attr = {	\
 	.mmap = pci_mmap_resource_uc,					\
 }
 
-#define pci_dev_resource_wc_attr(_bar)					      \
-static const struct bin_attribute dev_resource##_bar##_wc_attr = {	      \
-	.attr = { .name = "resource" __stringify(_bar) "_wc", .mode = 0600 }, \
-	.private = (void *)(unsigned long)(_bar),			      \
-	.f_mapping = iomem_get_mapping,					      \
-	.llseek = pci_llseek_resource,					      \
-	.mmap = pci_mmap_resource_wc,					      \
+#define pci_dev_resource_wc_attr(_bar)						\
+static const struct bin_attribute pci_dev_resource##_bar##_wc_attr = {		\
+	.attr = { .name = "resource" __stringify(_bar) "_wc", .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),				\
+	.f_mapping = iomem_get_mapping,						\
+	.llseek = pci_llseek_resource,						\
+	.mmap = pci_mmap_resource_wc,						\
 }
 
 static inline umode_t
@@ -1352,32 +1352,32 @@ pci_dev_resource_wc_attr(4);
 pci_dev_resource_wc_attr(5);
 
 static const struct bin_attribute *const pci_dev_resource_io_attrs[] = {
-	&dev_resource0_io_attr,
-	&dev_resource1_io_attr,
-	&dev_resource2_io_attr,
-	&dev_resource3_io_attr,
-	&dev_resource4_io_attr,
-	&dev_resource5_io_attr,
+	&pci_dev_resource0_io_attr,
+	&pci_dev_resource1_io_attr,
+	&pci_dev_resource2_io_attr,
+	&pci_dev_resource3_io_attr,
+	&pci_dev_resource4_io_attr,
+	&pci_dev_resource5_io_attr,
 	NULL,
 };
 
 static const struct bin_attribute *const pci_dev_resource_uc_attrs[] = {
-	&dev_resource0_uc_attr,
-	&dev_resource1_uc_attr,
-	&dev_resource2_uc_attr,
-	&dev_resource3_uc_attr,
-	&dev_resource4_uc_attr,
-	&dev_resource5_uc_attr,
+	&pci_dev_resource0_uc_attr,
+	&pci_dev_resource1_uc_attr,
+	&pci_dev_resource2_uc_attr,
+	&pci_dev_resource3_uc_attr,
+	&pci_dev_resource4_uc_attr,
+	&pci_dev_resource5_uc_attr,
 	NULL,
 };
 
 static const struct bin_attribute *const pci_dev_resource_wc_attrs[] = {
-	&dev_resource0_wc_attr,
-	&dev_resource1_wc_attr,
-	&dev_resource2_wc_attr,
-	&dev_resource3_wc_attr,
-	&dev_resource4_wc_attr,
-	&dev_resource5_wc_attr,
+	&pci_dev_resource0_wc_attr,
+	&pci_dev_resource1_wc_attr,
+	&pci_dev_resource2_wc_attr,
+	&pci_dev_resource3_wc_attr,
+	&pci_dev_resource4_wc_attr,
+	&pci_dev_resource5_wc_attr,
 	NULL,
 };
 
-- 
2.55.0

