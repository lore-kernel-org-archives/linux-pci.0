Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186AA18FDBD;
	Fri, 19 Jun 2026 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859148; cv=none; b=uFShPgaLTfrtKUkEUbfZHESCcqGcXtUwa3ibE87F4v8fZyIbUd8gRzk4GDcSSVq3+koOHfWxEJ3W9pFTFGiGx02NkvJRG4TbIHR2bYAqry1YErkDmn2+HUDqKT0Q/xgrX/8tBdNiXrlb1pAJQP+7eIk1XzeK3v7YNXgndIHgirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859148; c=relaxed/simple;
	bh=xh394xl6hj009oj73Jh1qdPVRKa2+d8UCyUyXbiBWdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hV2b0hrCKM+2v4CNr7PC/JOe1OE2zD21I5mgWcp3tMzQNTYIzPXSAbO465b8y7ECvdhNSQvWJCEFVpxJ/3xUvhlwOxz54n80aZxxNWkqONPixSpiDFaa97HgAgyPYsqpKhIoaUuI8ZYHBFUDQQm1/WgK9pJhHwxqN1CLjkDyaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvaIjJfN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvaIjJfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B550C1F00AC4;
	Fri, 19 Jun 2026 08:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859147;
	bh=hM5qeklrD0x72qjMI/3h7So0yMxuHIlhjvDyGB7qa5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nvaIjJfN2Ud7W9XBDfbFiawTVjdU0u66V5RNDenUSGB7lCgfuRrQVUQ/J9BpFmtNf
	 GvlCbqjpPahlafmTz9U7oCg7ZOxqO4/lJnitOOOqihQ2mOyohQcaXkLZdQNxHCcu2b
	 PtBN41cCVYRHsmeMN+5017AU/L1B0rI9HLkOgTTy6fiuVWbWUfLlsbZv20nSEg9r6B
	 rTwkBjHDI6mEuL7p3zlGd8NuiUIPp3IVDaRmrKbVLcVjW1bBq6upZO2xRYYe/0Xk5Y
	 jyPZsv0VNibSO6ZbSw/y2K0SknIsgz1ViUZU9O0PvuLEqeYYZd+s4rFoTuoAITwKm7
	 /rwxYk8tUKIkA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 06/25] PCI/sysfs: Add static PCI resource attribute macros
Date: Fri, 19 Jun 2026 08:51:41 +0000
Message-ID: <20260619085200.3729431-7-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add three macros for declaring static binary attributes for PCI
resource files:

  - pci_dev_resource_io_attr(), for I/O BAR resources (read/write)
  - pci_dev_resource_uc_attr(), for memory BAR resources (mmap uncached)
  - pci_dev_resource_wc_attr(), for write-combine resources (mmap WC)

Each macro only sets the callbacks its resource type needs.  The I/O
macro conditionally includes mmap support via __PCI_RESOURCE_IO_MMAP_ATTRS
on architectures where arch_can_pci_mmap_io() is true at compile time
(such as PowerPC, SPARC, and Xtensa).

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index dac780597727..793d149fe157 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1197,6 +1197,47 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
+/*
+ * generic_file_llseek() consults f_mapping->host to determine
+ * the file size. As iomem_inode knows nothing about the
+ * attribute, it's not going to work, so override it as well.
+ */
+#if arch_can_pci_mmap_io()
+# define __PCI_RESOURCE_IO_MMAP_ATTRS	\
+	.f_mapping = iomem_get_mapping,	\
+	.llseek = pci_llseek_resource,	\
+	.mmap = pci_mmap_resource_uc,
+#else
+# define __PCI_RESOURCE_IO_MMAP_ATTRS
+#endif
+
+#define pci_dev_resource_io_attr(_bar)					\
+static const struct bin_attribute pci_dev_resource##_bar##_io_attr = {	\
+	.attr = { .name = "resource" __stringify(_bar), .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),			\
+	.read = pci_read_resource_io,					\
+	.write = pci_write_resource_io,					\
+	__PCI_RESOURCE_IO_MMAP_ATTRS					\
+}
+
+#define pci_dev_resource_uc_attr(_bar)					\
+static const struct bin_attribute pci_dev_resource##_bar##_uc_attr = {	\
+	.attr = { .name = "resource" __stringify(_bar), .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),			\
+	.f_mapping = iomem_get_mapping,					\
+	.llseek = pci_llseek_resource,					\
+	.mmap = pci_mmap_resource_uc,					\
+}
+
+#define pci_dev_resource_wc_attr(_bar)						\
+static const struct bin_attribute pci_dev_resource##_bar##_wc_attr = {		\
+	.attr = { .name = "resource" __stringify(_bar) "_wc", .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),				\
+	.f_mapping = iomem_get_mapping,						\
+	.llseek = pci_llseek_resource,						\
+	.mmap = pci_mmap_resource_wc,						\
+}
+
 /**
  * pci_remove_resource_files - cleanup resource files
  * @pdev: dev to cleanup
-- 
2.54.0

