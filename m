Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793760605;
	b=4Mp8iWxzmnjfNT5rK5mQL7v8GMI0fgDKz16uUiznxutNN+Ixv211WitcxtqSmqEMWpH2
	 5x+iuY60qL17Q2vfOtlBog/q9hedKL2zlChX0kjM9nyFuT6B8uZDa/dYYiZZJL6UFQkEt
	 BoQHqSkRWYXMgPjqCs5Jnp4ma3LdEMKwhImlC/MpSLGST4ZAW9LsKWKKz/aufj2whjuvA
	 F2zwlRfrdoD+Zmbu+4WJLs/jCWneaw5aIUhls0p4YAJ09WXMJUXNXvEXRex0gw2goCVj8
	 Xt8Nf1HCFwuTP9tuKWG4UegE+mG29jvqtzkwLsgwXhtJGX7FV4mf8BQBaaaRYIB0gcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760605;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3yD+dcKqmuww3hA1uEpiASBnnVLgbgkRAyQqTjdD8Uc=;
	b=JGqMfalEk7vbw8UwCQpRvloixrXKlxIlOCIIgEBU2am5vcYkv12nK03PpFIA/shD+4/F
	 C71wHLhkWEKx9g6/8CZLDmfykcrhRZs2v1p300zZpUFj/rdjo0aoF/2ejNffMS+/TcsF8
	 BQfXzqab5MuolRMUumGVufWuHdCHwNpoiOPNpeJ/pc7iLkSs/Bzs/eePWSLUGMocGWiFw
	 IU/KNmvK47q5hvBJpK+PgLlKpmcR/eQDPsHRh2iRiSrhbGB6cAHQXznJ9FGz/afxVbbek
	 BThVXBhm2e1YsqbAB21IZdtadNOVpLweQ4DzB+TvGGGH/7uHvk16Z5KXqX6vENcFdYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPwsZCgl;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185BA606A331;
	Wed,  4 Nov 2026 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPwsZCgl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760604;
	b=25UuyUrLPlrfXqBmTJZgcBV07VI5kKKUWUBVAmULlkJQRKfs17vPsc7E2cgYylB2Y8AD
	 ohkFTQ+YKNBiVX9dllOLF1LQC6hjZ2K78sBGPa+Jx+3bI8PZCz9bNtQgTudJboNsrM76n
	 IFsuY7UvvMkr26dhOLwgpIeA7Tus4sVklAG3ouskobdNw9JdXHcQkyhSoMR5Vouo/BbQv
	 IZUu57qzCVQG3XXcmkorak7TLvmoTTmBc+yX3UurcJNSlnhjyrk5x1hV0Ks76dDNJvr+Z
	 AshBaJgWx5NYRv62wrMdKteUnV7EavTKP9xtCxzt2UqQv3CXrmeiBU20dNAh5/wcICg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760604;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3yD+dcKqmuww3hA1uEpiASBnnVLgbgkRAyQqTjdD8Uc=;
	b=z2tyiroUz95jWWNbrgkF38ly85GQSoPX+UgSeDlf4W1cnHTelUPce5+/+Ml86ucGTXqG
	 iXF3VttTRqlFvEnyDqPi+81x4Y0DTCGDJTw8ZPy/hwM2XQ/jRYQ+8Yt0Y0qxUNQIG6Gux
	 CdfmboaGrULZjI5++ALWwIdJz9HNjtKwrz/24Hc5RZ0AICXXuYZU38Sa32nzp1QnZHM9r
	 vKrYwG1V3hp7PE66kaKxwXRyXV2qIAnzEWY8mTCTmKzId8lffZcmEb6X6/QynRRAX9WyI
	 FyO8mZcOz3H5WUl1xbA3vLZuW6oApTnjH8xkHxVZxxVN899zkDAaPdJ2RxzPCeKX+Og==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D57C71F00A02;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760604;
	bh=3yD+dcKqmuww3hA1uEpiASBnnVLgbgkRAyQqTjdD8Uc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HPwsZCglWe7QBZB00ww+0NUHwOIsFUZSg5CuGIY4gshpiw1456G2Qr589eV2D983R
	 JxE9r2OGIBuPcUDbgXgpDECNDEd7dfwM/6B2l0E7mUNtxPQNn2Qn2o+9Etk748KnlF
	 tSEbOEh57kCA6Igkjlb2HB2ar+9H0MBhQQPq+qYTrhm3HuasJK63BRuHa+ghRiVOmz
	 BPS4/hiw1B9JmVggUwDxEkAxR3NNXBfP7u+b31v0L3AX5bEqWzINFgVwP9BULY/wQU
	 Y4E1l5X8JZ7Qt2nEaQ0wG2tReEeN6DhaquVjtxDWrPRXdLU7AhZTdXBnHhG608Ffx2
	 EbX/7bDith4RA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 586F746BFF;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:44 -0600
Subject: [PATCH v4 03/25] dmaengine: sdxi: Add PCI initialization
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-sdxi-base-v4-3-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
In-Reply-To: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=8624;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=G3UCYR9DSPW94dK47Tyi0Neumr+9wr3rIczfk03MNHk=;
 b=/OUsknNso5/Vp5Yk26z/FP7pgHYopjFoulaaOvxGn6RFkuh5ZsY26xMyks8yrDUrwcEPwj9KD
 l5w7Dv3T6WoAYp0F5ixGp3Vq7E1QU4IIKe6vIZkCDL+NyZOhIyb23Ux
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Add enough code to bind a SDXI device via the class code and map its
control registers and doorbell region.

Keep PCI resource setup in pci.c and register devices with the SDXI core
through bus operations.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/Kconfig       |   2 +
 drivers/dma/Makefile      |   1 +
 drivers/dma/sdxi/Kconfig  |  28 +++++++++++++
 drivers/dma/sdxi/Makefile |   6 +++
 drivers/dma/sdxi/device.c |  33 +++++++++++++++
 drivers/dma/sdxi/mmio.h   |  22 ++++++++++
 drivers/dma/sdxi/pci.c    | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/sdxi.h   |  38 ++++++++++++++++++
 8 files changed, 230 insertions(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 01f96a8257e5..3e3b685895fd 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -772,6 +772,8 @@ source "drivers/dma/lgm/Kconfig"
 
 source "drivers/dma/loongson/Kconfig"
 
+source "drivers/dma/sdxi/Kconfig"
+
 source "drivers/dma/stm32/Kconfig"
 
 # clients
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index f62d12b08e15..b375f9df9588 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
 obj-$(CONFIG_INTEL_LDMA) += lgm/
+obj-$(CONFIG_SDXI_CORE) += sdxi/
 
 obj-y += amd/
 obj-y += loongson/
diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
new file mode 100644
index 000000000000..b91b44231a04
--- /dev/null
+++ b/drivers/dma/sdxi/Kconfig
@@ -0,0 +1,28 @@
+config SDXI_CORE
+	tristate "SDXI (Smart Data Accelerator Interface) support"
+	# Doorbell updates require naturally-aligned 64-bit writes, per
+	# SDXI 1.0 9 MMIO Control Registers.
+	depends on 64BIT
+	select DMA_ENGINE
+	help
+	  Enable support for Smart Data Accelerator Interface (SDXI)
+	  Platform Data Mover devices. SDXI is a vendor-neutral
+	  standard for a memory-to-memory data mover and acceleration
+	  interface.
+
+	  This option is automatically selected by the SDXI PCI driver.
+	  Enable it manually if you want to build the SDXI core for unit
+	  testing without enabling the PCI driver.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be named "sdxi-core".
+
+config SDXI_PCI
+	tristate "SDXI (Smart Data Accelerator Interface) PCI driver"
+	depends on PCI_MSI && 64BIT
+	select SDXI_CORE
+	help
+	  Enable support for PCI-hosted SDXI devices.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be named "sdxi-pci".
diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
new file mode 100644
index 000000000000..0006edf74d86
--- /dev/null
+++ b/drivers/dma/sdxi/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SDXI_CORE) += sdxi-core.o
+sdxi-core-y := device.o
+
+obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
+sdxi-pci-y := pci.o
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
new file mode 100644
index 000000000000..0974a83bb45c
--- /dev/null
+++ b/drivers/dma/sdxi/device.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI hardware device driver
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+
+#include "sdxi.h"
+
+int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
+{
+	struct sdxi_dev *sdxi;
+
+	sdxi = devm_kzalloc(dev, sizeof(*sdxi), GFP_KERNEL);
+	if (!sdxi)
+		return -ENOMEM;
+
+	sdxi->dev = dev;
+	sdxi->bus_ops = ops;
+	dev_set_drvdata(dev, sdxi);
+
+	return sdxi->bus_ops->init(sdxi);
+}
+EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
+
+MODULE_AUTHOR("Wei Huang");
+MODULE_AUTHOR("Nathan Lynch");
+MODULE_DESCRIPTION("SDXI core");
+MODULE_LICENSE("GPL");
diff --git a/drivers/dma/sdxi/mmio.h b/drivers/dma/sdxi/mmio.h
new file mode 100644
index 000000000000..2676736f3998
--- /dev/null
+++ b/drivers/dma/sdxi/mmio.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * SDXI MMIO register offsets and layouts.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_MMIO_H
+#define DMA_SDXI_MMIO_H
+
+#include <linux/bits.h>
+
+enum sdxi_reg {
+	/* SDXI 1.0 9.1 General Control and Status Registers */
+	SDXI_MMIO_CAP1       = 0x00208,
+};
+
+/* SDXI 1.0 Table 9-7: MMIO_CAP1 */
+#define SDXI_MMIO_CAP1_MMIO64 BIT_ULL(6)
+
+#endif  /* DMA_SDXI_MMIO_H */
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
new file mode 100644
index 000000000000..0778cde31f14
--- /dev/null
+++ b/drivers/dma/sdxi/pci.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI PCI device code
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/dev_printk.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iomap.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "mmio.h"
+#include "sdxi.h"
+
+enum sdxi_mmio_bars {
+	SDXI_PCI_BAR_CTL_REGS = 0,
+	SDXI_PCI_BAR_DOORBELL = 2,
+};
+
+static struct pci_dev *sdxi_to_pci_dev(const struct sdxi_dev *sdxi)
+{
+	return to_pci_dev(sdxi->dev);
+}
+
+static int sdxi_pci_init(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
+	struct device *dev = &pdev->dev;
+	u64 cap1;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable device\n");
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set DMA mask\n");
+
+	sdxi->ctrl_regs = pcim_iomap_region(pdev, SDXI_PCI_BAR_CTL_REGS,
+					    KBUILD_MODNAME);
+	if (IS_ERR(sdxi->ctrl_regs))
+		return dev_err_probe(dev, PTR_ERR(sdxi->ctrl_regs),
+				     "failed to map control registers\n");
+
+	cap1 = readq(sdxi->ctrl_regs + SDXI_MMIO_CAP1);
+	if (!FIELD_GET(SDXI_MMIO_CAP1_MMIO64, cap1))
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "64-bit atomic MMIO access required\n");
+
+	sdxi->dbs = pcim_iomap_region(pdev, SDXI_PCI_BAR_DOORBELL,
+				      KBUILD_MODNAME);
+	if (IS_ERR(sdxi->dbs))
+		return dev_err_probe(dev, PTR_ERR(sdxi->dbs),
+				     "failed to map doorbell region\n");
+
+	pci_set_master(pdev);
+	return 0;
+}
+
+static const struct sdxi_bus_ops sdxi_pci_ops = {
+	.init = sdxi_pci_init,
+};
+
+static int sdxi_pci_probe(struct pci_dev *pdev,
+			  const struct pci_device_id *id)
+{
+	return sdxi_register(&pdev->dev, &sdxi_pci_ops);
+}
+
+static void sdxi_pci_remove(struct pci_dev *pdev)
+{
+	pci_disable_sriov(pdev);
+}
+
+static const struct pci_device_id sdxi_id_table[] = {
+	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, sdxi_id_table);
+
+static struct pci_driver sdxi_driver = {
+	.name = "sdxi",
+	.id_table = sdxi_id_table,
+	.probe = sdxi_pci_probe,
+	.remove = sdxi_pci_remove,
+	.sriov_configure = pci_sriov_configure_simple,
+};
+
+MODULE_IMPORT_NS("SDXI");
+MODULE_AUTHOR("Wei Huang");
+MODULE_AUTHOR("Nathan Lynch");
+MODULE_DESCRIPTION("SDXI PCIe interface driver");
+MODULE_LICENSE("GPL");
+module_pci_driver(sdxi_driver);
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
new file mode 100644
index 000000000000..d4c61ca2f875
--- /dev/null
+++ b/drivers/dma/sdxi/sdxi.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI device driver header
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_H
+#define DMA_SDXI_H
+
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+
+struct sdxi_dev;
+
+/**
+ * struct sdxi_bus_ops - Bus-specific methods for SDXI devices.
+ */
+struct sdxi_bus_ops {
+	/**
+	 * @init: Map control registers and doorbell region, allocate
+	 *        IRQ ranges. Invoked before bus-agnostic SDXI
+	 *        function initialization.
+	 */
+	int (*init)(struct sdxi_dev *sdxi);
+};
+
+struct sdxi_dev {
+	struct device *dev;
+	void __iomem *ctrl_regs;	/* virt addr of ctrl registers */
+	void __iomem *dbs;		/* virt addr of doorbells */
+
+	const struct sdxi_bus_ops *bus_ops;
+};
+
+int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
+
+#endif /* DMA_SDXI_H */

-- 
2.56.0


