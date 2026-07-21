Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79135DA77
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 02:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599476; cv=none; b=ct7cX2Ltx6jvJ3yEwgxHUElIeE7rMqCI/Qtd4TEmIPiVpKzpBbFqqP4CLbJV3+UOkMxzVZ7gFoSgzWbboe1+bhfnkHQhfum+hMnl40xdxk+wkI7ASRVNhp0VmrqqrmZTE+AHZzMPtKqlewv6nPRfg3bmTRlaXidOl19cz2/fAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599476; c=relaxed/simple;
	bh=b2QWIV19EG4ahdPfumLNJU4wMdbRPrFuYEiKJPZy+2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMYoRvYMMr3gM7VGoIWN84UH0KpPt//H0RG1e4xc1/jnbQHVtwbnuaylgvEOKEqb6V6MAvdztTw01+GAUIznLrVzejVbKuq2QrATOR2y25swRN1qe2jljUIntZ0A8Op/NYd3EzesZZm4EIQQhXOrAqDVkx5wGSGAPcfi/r1N/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXck797d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXck797d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B930E1F000E9;
	Tue, 21 Jul 2026 02:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784599474;
	bh=ZC4vqH6yOCFH5l0QTlGN09+EfgpnKIUf76qyNUzZvSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VXck797dOaDg6jexQ015QNf0o+Fn/wghd166o4OkF3pBMoOnMMfrMhdXpnlL+pCNu
	 U9CNe/UX46rAMPdVMqn7R9coXHuQPFzuR/mV8eMwVCU16oslLgkeLv+LkAvoJ+BaNM
	 8EdUp8cok++qZ8yH/kluNo0kFwjmTHEBgI9+BxeemUF3x4Jazv2lSzxXSdF9ZlXBYe
	 xqQqXjSRMMqNct2TkIHSFkOM3NsZsWezXpZpOjKpWhSwpoFvMghkx3iNJZCHIBAqu1
	 lAagdbvOtpDm7WH/yx4pgAeGNOmbXFKJjy6QMv+yTufVBDGM96OPk390iZjHsPFVzL
	 LKmb7EMFhnaNg==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI/sysfs: Add legacy I/O and memory attribute macros
Date: Tue, 21 Jul 2026 02:04:26 +0000
Message-ID: <20260721020427.1541197-4-kwilczynski@kernel.org>
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

Currently, the static binary attributes for the PCI legacy I/O port
and ISA memory space files (legacy_io, legacy_io_sparse, legacy_mem and
legacy_mem_sparse) are open-coded, with each definition repeating the
same set of properties and callbacks.

Thus, add two macros for declaring such attributes:

  - pci_legacy_resource_io_attr(),  for legacy I/O port space (read/write)
  - pci_legacy_resource_mem_attr(), for legacy memory space (mmap)

Each macro takes the fixed attribute size as a parameter.

Then, replace the open-coded definitions with the newly added macros.

No functional changes intended.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 59 +++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index cb7a121e5988..26a10984a843 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -871,6 +871,27 @@ static const struct attribute_group pci_dev_config_attr_group = {
 };
 
 #ifdef HAVE_PCI_LEGACY
+
+#define pci_legacy_resource_io_attr(_suffix, _size)				\
+static const struct bin_attribute pci_legacy_io##_suffix##_attr = {		\
+	.attr = { .name = "legacy_io" __stringify(_suffix), .mode = 0600 },	\
+	.size = (_size),							\
+	.read = pci_read_legacy_io,						\
+	.write = pci_write_legacy_io,						\
+	.f_mapping = iomem_get_mapping,						\
+	.llseek = pci_llseek_resource_legacy,					\
+	.mmap = pci_mmap_legacy_io,						\
+}
+
+#define pci_legacy_resource_mem_attr(_suffix, _size)				\
+static const struct bin_attribute pci_legacy_mem##_suffix##_attr = {		\
+	.attr = { .name = "legacy_mem" __stringify(_suffix), .mode = 0600 },	\
+	.size = (_size),							\
+	.f_mapping = iomem_get_mapping,						\
+	.llseek = pci_llseek_resource_legacy,					\
+	.mmap = pci_mmap_legacy_mem,						\
+}
+
 /**
  * pci_read_legacy_io - read byte(s) from legacy I/O port space
  * @filp: open sysfs file
@@ -1014,41 +1035,11 @@ static loff_t pci_llseek_resource_legacy(struct file *filep,
 	return fixed_size_llseek(filep, offset, whence, attr->size);
 }
 
-static const struct bin_attribute pci_legacy_io_attr = {
-	.attr = { .name = "legacy_io", .mode = 0600 },
-	.size = PCI_LEGACY_IO_SIZE,
-	.read = pci_read_legacy_io,
-	.write = pci_write_legacy_io,
-	.mmap = pci_mmap_legacy_io,
-	.llseek = pci_llseek_resource_legacy,
-	.f_mapping = iomem_get_mapping,
-};
+pci_legacy_resource_io_attr(, PCI_LEGACY_IO_SIZE);
+pci_legacy_resource_io_attr(_sparse, PCI_LEGACY_IO_SIZE << 5);
 
-static const struct bin_attribute pci_legacy_io_sparse_attr = {
-	.attr = { .name = "legacy_io_sparse", .mode = 0600 },
-	.size = PCI_LEGACY_IO_SIZE << 5,
-	.read = pci_read_legacy_io,
-	.write = pci_write_legacy_io,
-	.mmap = pci_mmap_legacy_io,
-	.llseek = pci_llseek_resource_legacy,
-	.f_mapping = iomem_get_mapping,
-};
-
-static const struct bin_attribute pci_legacy_mem_attr = {
-	.attr = { .name = "legacy_mem", .mode = 0600 },
-	.size = PCI_LEGACY_MEM_SIZE,
-	.mmap = pci_mmap_legacy_mem,
-	.llseek = pci_llseek_resource_legacy,
-	.f_mapping = iomem_get_mapping,
-};
-
-static const struct bin_attribute pci_legacy_mem_sparse_attr = {
-	.attr = { .name = "legacy_mem_sparse", .mode = 0600 },
-	.size = PCI_LEGACY_MEM_SIZE << 5,
-	.mmap = pci_mmap_legacy_mem,
-	.llseek = pci_llseek_resource_legacy,
-	.f_mapping = iomem_get_mapping,
-};
+pci_legacy_resource_mem_attr(, PCI_LEGACY_MEM_SIZE);
+pci_legacy_resource_mem_attr(_sparse, PCI_LEGACY_MEM_SIZE << 5);
 
 static const struct bin_attribute *const pci_legacy_io_attrs[] = {
 	&pci_legacy_io_attr,
-- 
2.55.0

