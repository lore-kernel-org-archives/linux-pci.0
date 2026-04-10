Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDECB30F52A;
	Fri, 10 Apr 2026 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800263; cv=none; b=J51YN9n6+jPOWTtqiKrcI6o1RLy2MTlg845LhS7eZJZfkAGbEr/g5t5lXTH7ZXgZ8lEtn0DSN7MUSxmsGml+MPliaXgIjiA3YyVWKoeJ3kTzD3T209eKji98Hnee3JMAATbX+US5j3FD+SKlTZmY9pcw/0JGJ+QrjqPg0bbU7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800263; c=relaxed/simple;
	bh=Jl/CqRDCeCLI+hvaYW9X7cU2GJJVSRyyY/vEVWNYR6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lN7JqPtdYmmQbs2+0ugTQjccSvtdxoZRRAwmxSnzWIJNIAOX31nZtmYt86ICZDLxhn4VphXaykfD4SPrwp88vu0F+j3SSRZ8KQ7zSlvhMbWdbG5fMdYhsq1f9fVfn7HNr8QvD9dtkhVdPH55PAoiGilkgc5EV+nHpMoZkxxT6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9ryeqGM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9ryeqGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B023C19424;
	Fri, 10 Apr 2026 05:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800262;
	bh=Jl/CqRDCeCLI+hvaYW9X7cU2GJJVSRyyY/vEVWNYR6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9ryeqGMhfUQt6iNjkMXN+tFxZqVheQae+upre/T2m6AjawDlXhjV6HYvVyaI7EGo
	 2ZpxrTWLNwAHa+rQVcfyucCEuha+govFmDAe3UCLb6/X4E3egZmibWhGz+1sIuZis0
	 dyp/xArjE2f8Nvtq2b05CuE/K5gPJ9BaNvMidTC81SacrhQvO8poGWvEIiUoSKjAow
	 +Obvt2GnVRLgz/5LB/wWnlcyy72zk/Kfr865EYjx5Oq6vpqexLv85znTJYrpFdJ0s5
	 nwAGUXr6W43glUhueOuPgN/KMgcr426lM+dlQQnzJkTaREBQ58GRjfejEaZh4FdqB/
	 Xyxicu/sDHRsA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH 05/20] PCI/sysfs: Add static PCI resource attribute macros
Date: Fri, 10 Apr 2026 05:50:25 +0000
Message-ID: <20260410055040.39233-6-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410055040.39233-1-kwilczynski@kernel.org>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
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

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6b8c8e62f68a..d29d79be8ee5 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1220,6 +1220,47 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
+/*
+ * generic_file_llseek() consults f_mapping->host to determine
+ * the file size. As iomem_inode knows nothing about the
+ * attribute, it's not going to work, so override it as well.
+ */
+#if arch_can_pci_mmap_io()
+# define __PCI_RESOURCE_IO_MMAP_ATTRS		\
+	.f_mapping = iomem_get_mapping,		\
+	.llseek = pci_llseek_resource,		\
+	.mmap = pci_mmap_resource_uc,
+#else
+# define __PCI_RESOURCE_IO_MMAP_ATTRS
+#endif
+
+#define pci_dev_resource_io_attr(_bar)					\
+static const struct bin_attribute dev_resource##_bar##_io_attr = {	\
+	.attr = { .name = "resource" __stringify(_bar), .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),			\
+	.read = pci_read_resource,					\
+	.write = pci_write_resource,					\
+	__PCI_RESOURCE_IO_MMAP_ATTRS					\
+}
+
+#define pci_dev_resource_uc_attr(_bar)					\
+static const struct bin_attribute dev_resource##_bar##_uc_attr = {	\
+	.attr = { .name = "resource" __stringify(_bar), .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),			\
+	.f_mapping = iomem_get_mapping,					\
+	.llseek = pci_llseek_resource,					\
+	.mmap = pci_mmap_resource_uc,					\
+}
+
+#define pci_dev_resource_wc_attr(_bar)						\
+static const struct bin_attribute dev_resource##_bar##_wc_attr = {		\
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
2.53.0

