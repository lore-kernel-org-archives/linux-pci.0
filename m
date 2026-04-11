Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823FA13D8B1;
	Sat, 11 Apr 2026 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894595; cv=none; b=epRu0O+PtXdARY2xJISoiWROZ4kEZPRMjApVGdUbpnFb9RsgOu6QS10vDXUkJggoSPUCcT7r4/Wh5U1Pt2AMuNrb8vmbqeZu46/lltsWOgHjPtwknoqRZrfl7H3Kw3x4R59rYFObRvq432FjNLpqQHLip1ucZXaG3h+st/Y8/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894595; c=relaxed/simple;
	bh=sNnp692p4qKWeGiZ0UH/s8tal6B2Ryz48LNe7BhqBHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecC9dhRR4LyFo2SZ3MomgcU2PTIshBukNGD8SYbtTi29lHcyX1BpjjV0b9auoNXHwvTX1FKvb6gOlihrB5dhOCsaBaNey67xVEyaH+G7FO1fqGWm0R2AY7eAgwK9OfWF+jQzOFMWwuYC9lvE7dmnwFwKAD4tW3xicITGM8A/gCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot3DZkFR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot3DZkFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0559C2BCB0;
	Sat, 11 Apr 2026 08:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894595;
	bh=sNnp692p4qKWeGiZ0UH/s8tal6B2Ryz48LNe7BhqBHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ot3DZkFRoShImQaLy/0C0YsgmrGBQFgEV6pZu9+6MVytozPj/Sue0EYw04p3taGPH
	 aR8u75Y8Nza5wX4pXnxRmvZdLWByshFYJsYrpAA4jn5Pnuh5+JsBtkUX32mxDVpLVx
	 rJTsi2G9CWBp3IK6eOXNPHYD5rXSm8NQHcsQhR5hyNBRrt6yironV6OXwx68SQALo2
	 gnEIaNbtBf8pIEtDcBTRtQPZ4Ft3yThzGmZGIxQCNp78BTqiLnFV0AGWcCzcbZArBy
	 7ESk9C0IQrl5SmSm2MIGjH734T3+xTnP0A4G4BUSPLcmUWxJKc/9fpxzj5RkivCz+4
	 4geA3wrE1h+EQ==
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
Subject: [PATCH v4 23/24] PCI/sysfs: Convert legacy I/O and memory attributes to static definitions
Date: Sat, 11 Apr 2026 08:01:47 +0000
Message-ID: <20260411080148.471335-24-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, legacy_io and legacy_mem are dynamically allocated and
created by pci_create_legacy_files(), with pci_adjust_legacy_attr()
updating the attributes at runtime on Alpha to rename them and shift
the size for sparse addressing.

Convert to four static const attributes (legacy_io, legacy_io_sparse,
legacy_mem, legacy_mem_sparse) with is_bin_visible() callbacks that
use pci_legacy_has_sparse() to select the appropriate variant per bus.
The sizes are compile-time constants and .size is set directly on
each attribute.

Register the groups in pcibus_groups[] under a HAVE_PCI_LEGACY guard
so the driver model handles creation and removal automatically.

Stub out pci_create_legacy_files() and pci_remove_legacy_files() as
the dynamic creation is no longer needed.  Remove the __weak
pci_adjust_legacy_attr(), Alpha's override, and its declaration from
both Alpha and PowerPC asm/pci.h headers.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/include/asm/pci.h   |   2 -
 arch/alpha/kernel/pci-sysfs.c  |  24 ----
 arch/powerpc/include/asm/pci.h |   2 -
 drivers/pci/pci-sysfs.c        | 200 ++++++++++++++++++++-------------
 4 files changed, 120 insertions(+), 108 deletions(-)

diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
index 95de7ffd59e8..ad5d1391e1fa 100644
--- a/arch/alpha/include/asm/pci.h
+++ b/arch/alpha/include/asm/pci.h
@@ -84,8 +84,6 @@ extern int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val,
 extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 				      struct vm_area_struct *vma,
 				      enum pci_mmap_state mmap_state);
-extern void pci_adjust_legacy_attr(struct pci_bus *bus,
-				   enum pci_mmap_state mmap_type);
 extern bool pci_legacy_has_sparse(struct pci_bus *bus,
 				  enum pci_mmap_state type);
 #define HAVE_PCI_LEGACY	1
diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index ea51f6b20458..7f052e05cbae 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -198,30 +198,6 @@ bool pci_legacy_has_sparse(struct pci_bus *bus, enum pci_mmap_state type)
 	return has_sparse(hose, type);
 }
 
-/**
- * pci_adjust_legacy_attr - adjustment of legacy file attributes
- * @bus: bus to create files under
- * @mmap_type: I/O port or memory
- *
- * Adjust file name and size for sparse mappings.
- */
-void pci_adjust_legacy_attr(struct pci_bus *bus, enum pci_mmap_state mmap_type)
-{
-	struct pci_controller *hose = bus->sysdata;
-
-	if (!has_sparse(hose, mmap_type))
-		return;
-
-	if (mmap_type == pci_mmap_mem) {
-		bus->legacy_mem->attr.name = "legacy_mem_sparse";
-		bus->legacy_mem->size <<= 5;
-	} else {
-		bus->legacy_io->attr.name = "legacy_io_sparse";
-		bus->legacy_io->size <<= 5;
-	}
-	return;
-}
-
 /* Legacy I/O bus read/write functions */
 int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val, size_t size)
 {
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 46a9c4491ed0..72f286e74786 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -82,8 +82,6 @@ extern int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val,
 extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 				      struct vm_area_struct *vma,
 				      enum pci_mmap_state mmap_state);
-extern void pci_adjust_legacy_attr(struct pci_bus *bus,
-				   enum pci_mmap_state mmap_type);
 #define HAVE_PCI_LEGACY	1
 
 extern void pcibios_claim_one_bus(struct pci_bus *b);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ce004b349594..c81d3964cfa4 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -702,11 +702,6 @@ static const struct attribute_group pcibus_group = {
 	.attrs = pcibus_attrs,
 };
 
-const struct attribute_group *pcibus_groups[] = {
-	&pcibus_group,
-	NULL,
-};
-
 static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -1025,91 +1020,136 @@ bool __weak pci_legacy_has_sparse(struct pci_bus *bus,
 	return false;
 }
 
-/**
- * pci_adjust_legacy_attr - adjustment of legacy file attributes
- * @b: bus to create files under
- * @mmap_type: I/O port or memory
- *
- * Stub implementation. Can be overridden by arch if necessary.
- */
-void __weak pci_adjust_legacy_attr(struct pci_bus *b,
-				   enum pci_mmap_state mmap_type)
+static inline umode_t __pci_legacy_is_visible(struct kobject *kobj,
+					      const struct bin_attribute *a,
+					      enum pci_mmap_state type,
+					      bool sparse)
 {
+	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
+
+	if (pci_legacy_has_sparse(bus, type) != sparse)
+		return 0;
+
+	return a->attr.mode;
 }
 
-/**
- * pci_create_legacy_files - create legacy I/O port and memory files
- * @b: bus to create files under
- *
- * Some platforms allow access to legacy I/O port and ISA memory space on
- * a per-bus basis.  This routine creates the files and ties them into
- * their associated read, write and mmap files from pci-sysfs.c
- *
- * On error unwind, but don't propagate the error to the caller
- * as it is ok to set up the PCI bus without these files.
- */
-void pci_create_legacy_files(struct pci_bus *b)
+static umode_t pci_legacy_io_is_visible(struct kobject *kobj,
+					const struct bin_attribute *a, int n)
 {
-	int error;
-
-	if (!sysfs_initialized)
-		return;
-
-	b->legacy_io = kzalloc_objs(struct bin_attribute, 2, GFP_ATOMIC);
-	if (!b->legacy_io)
-		goto kzalloc_err;
-
-	sysfs_bin_attr_init(b->legacy_io);
-	b->legacy_io->attr.name = "legacy_io";
-	b->legacy_io->size = 0xffff;
-	b->legacy_io->attr.mode = 0600;
-	b->legacy_io->read = pci_read_legacy_io;
-	b->legacy_io->write = pci_write_legacy_io;
-	/* See pci_create_attr() for motivation */
-	b->legacy_io->llseek = pci_llseek_resource;
-	b->legacy_io->mmap = pci_mmap_legacy_io;
-	b->legacy_io->f_mapping = iomem_get_mapping;
-	pci_adjust_legacy_attr(b, pci_mmap_io);
-	error = device_create_bin_file(&b->dev, b->legacy_io);
-	if (error)
-		goto legacy_io_err;
-
-	/* Allocated above after the legacy_io struct */
-	b->legacy_mem = b->legacy_io + 1;
-	sysfs_bin_attr_init(b->legacy_mem);
-	b->legacy_mem->attr.name = "legacy_mem";
-	b->legacy_mem->size = 1024*1024;
-	b->legacy_mem->attr.mode = 0600;
-	b->legacy_mem->mmap = pci_mmap_legacy_mem;
-	/* See pci_create_attr() for motivation */
-	b->legacy_mem->llseek = pci_llseek_resource;
-	b->legacy_mem->f_mapping = iomem_get_mapping;
-	pci_adjust_legacy_attr(b, pci_mmap_mem);
-	error = device_create_bin_file(&b->dev, b->legacy_mem);
-	if (error)
-		goto legacy_mem_err;
-
-	return;
-
-legacy_mem_err:
-	device_remove_bin_file(&b->dev, b->legacy_io);
-legacy_io_err:
-	kfree(b->legacy_io);
-	b->legacy_io = NULL;
-kzalloc_err:
-	dev_warn(&b->dev, "could not create legacy I/O port and ISA memory resources in sysfs\n");
+	return __pci_legacy_is_visible(kobj, a, pci_mmap_io, false);
 }
 
-void pci_remove_legacy_files(struct pci_bus *b)
+static umode_t pci_legacy_io_sparse_is_visible(struct kobject *kobj,
+					       const struct bin_attribute *a,
+					       int n)
 {
-	if (b->legacy_io) {
-		device_remove_bin_file(&b->dev, b->legacy_io);
-		device_remove_bin_file(&b->dev, b->legacy_mem);
-		kfree(b->legacy_io); /* both are allocated here */
-	}
+	return __pci_legacy_is_visible(kobj, a, pci_mmap_io, true);
 }
+
+static umode_t pci_legacy_mem_is_visible(struct kobject *kobj,
+					 const struct bin_attribute *a, int n)
+{
+	return __pci_legacy_is_visible(kobj, a, pci_mmap_mem, false);
+}
+
+static umode_t pci_legacy_mem_sparse_is_visible(struct kobject *kobj,
+						const struct bin_attribute *a,
+						int n)
+{
+	return __pci_legacy_is_visible(kobj, a, pci_mmap_mem, true);
+}
+
+static const struct bin_attribute pci_legacy_io_attr = {
+	.attr = { .name = "legacy_io", .mode = 0600 },
+	.size = PCI_LEGACY_IO_SIZE,
+	.read = pci_read_legacy_io,
+	.write = pci_write_legacy_io,
+	.mmap = pci_mmap_legacy_io,
+	.llseek = pci_llseek_resource,
+	.f_mapping = iomem_get_mapping,
+};
+
+static const struct bin_attribute pci_legacy_io_sparse_attr = {
+	.attr = { .name = "legacy_io_sparse", .mode = 0600 },
+	.size = PCI_LEGACY_IO_SIZE << 5,
+	.read = pci_read_legacy_io,
+	.write = pci_write_legacy_io,
+	.mmap = pci_mmap_legacy_io,
+	.llseek = pci_llseek_resource,
+	.f_mapping = iomem_get_mapping,
+};
+
+static const struct bin_attribute pci_legacy_mem_attr = {
+	.attr = { .name = "legacy_mem", .mode = 0600 },
+	.size = PCI_LEGACY_MEM_SIZE,
+	.mmap = pci_mmap_legacy_mem,
+	.llseek = pci_llseek_resource,
+	.f_mapping = iomem_get_mapping,
+};
+
+static const struct bin_attribute pci_legacy_mem_sparse_attr = {
+	.attr = { .name = "legacy_mem_sparse", .mode = 0600 },
+	.size = PCI_LEGACY_MEM_SIZE << 5,
+	.mmap = pci_mmap_legacy_mem,
+	.llseek = pci_llseek_resource,
+	.f_mapping = iomem_get_mapping,
+};
+
+static const struct bin_attribute *const pci_legacy_io_attrs[] = {
+	&pci_legacy_io_attr,
+	NULL,
+};
+
+static const struct bin_attribute *const pci_legacy_io_sparse_attrs[] = {
+	&pci_legacy_io_sparse_attr,
+	NULL,
+};
+
+static const struct bin_attribute *const pci_legacy_mem_attrs[] = {
+	&pci_legacy_mem_attr,
+	NULL,
+};
+
+static const struct bin_attribute *const pci_legacy_mem_sparse_attrs[] = {
+	&pci_legacy_mem_sparse_attr,
+	NULL,
+};
+
+static const struct attribute_group pci_legacy_io_group = {
+	.bin_attrs = pci_legacy_io_attrs,
+	.is_bin_visible = pci_legacy_io_is_visible,
+};
+
+static const struct attribute_group pci_legacy_io_sparse_group = {
+	.bin_attrs = pci_legacy_io_sparse_attrs,
+	.is_bin_visible = pci_legacy_io_sparse_is_visible,
+};
+
+static const struct attribute_group pci_legacy_mem_group = {
+	.bin_attrs = pci_legacy_mem_attrs,
+	.is_bin_visible = pci_legacy_mem_is_visible,
+};
+
+static const struct attribute_group pci_legacy_mem_sparse_group = {
+	.bin_attrs = pci_legacy_mem_sparse_attrs,
+	.is_bin_visible = pci_legacy_mem_sparse_is_visible,
+};
+
+void pci_create_legacy_files(struct pci_bus *b) { }
+void pci_remove_legacy_files(struct pci_bus *b) { }
 #endif /* HAVE_PCI_LEGACY */
 
+const struct attribute_group *pcibus_groups[] = {
+	&pcibus_group,
+#ifdef HAVE_PCI_LEGACY
+	&pci_legacy_io_group,
+	&pci_legacy_io_sparse_group,
+	&pci_legacy_mem_group,
+	&pci_legacy_mem_sparse_group,
+#endif
+	NULL,
+};
+
 #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 /**
  * pci_mmap_resource - map a PCI resource into user memory space
-- 
2.53.0

