Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08B9154425;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704143; cv=none; b=W5T+tAVDBA5E4hcbRASs4kLh77KYQ2pXwoQa5wqGI6IPW5CE1ScZfFeyNqiUcLB0xM5cSWJ2EjKPet/BBHrvNVMgAuciHqSQctDImCc/MxAt86WH4HMHxxJgOBTtqZA4nxcelq1EV6sIwdrIP2qE9IP+KgNpbPCOsr05JXPvVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704143; c=relaxed/simple;
	bh=4jf1UX/kSCkf0OQBB0DxszHloA/SowK1pgTk2RU4hwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iAYQNc6X4JZYnjmRtWab4wTHx5Hg8Dm0SC8xf9C5sIS9BsDxiW/07tuNAXndz7J0r7pgyrlvUX5akryXQ6ARgogucRaPOdJaKeOG6n8bGAL5jg7AX4h1dHxiUmyCDXAq1uCpNRsRjguHFSpbpzitmBde2YeFT3lQtMks7gpsbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrOGVHy3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrOGVHy3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E63BC32781;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704142;
	bh=4jf1UX/kSCkf0OQBB0DxszHloA/SowK1pgTk2RU4hwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IrOGVHy3v5J2nlwtTS7oToqDXuXoNUMUMtnRKoX5cwGqrOZKqZU8NICJa1HzQtLVR
	 o42JEM840izpVWRN7JIvdhqQCxHPL8F9HDQRQNCsFi16cuhrJzQ1WhZW/+FSGYM7DG
	 Xw1tt/m6vr3TKegnB+3HcStK0iXGfgadijN8j1CgKlWYWu7ESS1uXT/HIaCFevTG3f
	 OMoMw/cslV6sb0vHzFDUnB/jj+fahgISPNsYMdKdrrvhK1+7i83kzts2ZZARsZRBPq
	 MW45n9LvqqiAy7nc9tKGi69CLJFLvRhNEBNri29CuuDWmiJliAqqzmrhFmoKP6BZ7U
	 YiQ76cbo498hA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9526ACD6E7E;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:09 -0500
Subject: [PATCH v3 06/23] dmaengine: sdxi: Allocate DMA pools
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-6-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
In-Reply-To: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=4685;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=C3P80ebpeZVbhaM52K32rkyImUcW6/pnNndyzw2BApk=;
 b=eBgu/TlZHlz5S4js5ndxtiZ1V+vTaWnm2PtsPowTHIqBsZduHsS0V1fvrlis/Ke1p5UcMO4ug
 Rok/hobCIAlBpCyfzAxGttsldsPisJA63qMLJeWtUhVAsIYptIjNzag
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Each SDXI context consists of several control structures in system
memory:

* Descriptor ring
* Access key (AKey) table
* Context control block (CXT_CTL)
* Context status block (CXT_STS)
* Write index

Of these, the write index, context control and context status blocks
are small enough to justify DMA pools.

SDXI descriptors also may have 32-byte completion status
blocks (CST_BLK) associated with them that software can poll for
completion.

Introduce the C structures for context control, context status, and
completion status blocks. Create a DMA pool for each of these objects
as well as write indexes during SDXI function initialization, ensuring
that potentially frequently-updated objects are aligned to avoid
cacheline sharing.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 drivers/dma/sdxi/hw.h     | 28 ++++++++++++++++++++++++++++
 drivers/dma/sdxi/sdxi.h   |  5 +++++
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index fa5e27a4190e..7aa62a989bac 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -6,13 +6,16 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cache.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
 #include <linux/export.h>
 #include <linux/iopoll.h>
 #include <linux/jiffies.h>
 #include <linux/log2.h>
+#include <linux/minmax.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 
@@ -218,6 +221,43 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	return 0;
 }
 
+static int sdxi_device_init(struct sdxi_dev *sdxi)
+{
+	struct device *dev = sdxi->dev;
+	size_t size, align;
+	int err;
+
+	size = sizeof(__le64);
+	align = max(size, SMP_CACHE_BYTES);
+	sdxi->write_index_pool = dmam_pool_create("Write_Index", dev, size,
+						  align, 0);
+	if (!sdxi->write_index_pool)
+		return -ENOMEM;
+
+	size = sizeof(struct sdxi_cxt_sts);
+	align = max(size, SMP_CACHE_BYTES);
+	sdxi->cxt_sts_pool = dmam_pool_create("CXT_STS", dev, size, align, 0);
+	if (!sdxi->cxt_sts_pool)
+		return -ENOMEM;
+
+	size = align = sizeof(struct sdxi_cxt_ctl);
+	sdxi->cxt_ctl_pool = dmam_pool_create("CXT_CTL", dev, size, align, 0);
+	if (!sdxi->cxt_ctl_pool)
+		return -ENOMEM;
+
+	size = sizeof(struct sdxi_cst_blk);
+	align = max(size, SMP_CACHE_BYTES);
+	sdxi->cst_blk_pool = dmam_pool_create("CST_BLK", dev, size, align, 0);
+	if (!sdxi->cst_blk_pool)
+		return -ENOMEM;
+
+	err = sdxi_fn_activate(sdxi);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 {
 	struct sdxi_dev *sdxi;
@@ -235,7 +275,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 	if (err)
 		return err;
 
-	return sdxi_fn_activate(sdxi);
+	return sdxi_device_init(sdxi);
 }
 EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
 
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index 00324f45b729..b3fd3587ccf8 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -58,4 +58,32 @@ struct sdxi_cxt_L1_table {
 };
 static_assert(sizeof(struct sdxi_cxt_L1_table) == 4096);
 
+/* SDXI 1.0 Table 3-4: Context Control (CXT_CTL) */
+struct sdxi_cxt_ctl {
+	__le64 ds_ring_ptr;
+	__le32 ds_ring_sz;
+	__u8 rsvd_0[4];
+	__le64 cxt_sts_ptr;
+	__le64 write_index_ptr;
+	__u8 rsvd_1[32];
+} __packed __aligned(64);
+static_assert(sizeof(struct sdxi_cxt_ctl) == 64);
+
+/* SDXI 1.0 Table 3-5: Context Status (CXT_STS) */
+struct sdxi_cxt_sts {
+	__u8 state;
+	__u8 misc0;
+	__u8 rsvd_0[6];
+	__le64 read_index;
+} __packed __aligned(16);
+static_assert(sizeof(struct sdxi_cxt_sts) == 16);
+
+/* SDXI 1.0 Table 6-4: CST_BLK (Completion Status Block) */
+struct sdxi_cst_blk {
+	__le64 signal;
+	__le32 flags;
+	__u8 rsvd_0[20];
+} __packed __aligned(32);
+static_assert(sizeof(struct sdxi_cst_blk) == 32);
+
 #endif /* DMA_SDXI_HW_H */
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 913292463eee..ade702b6bec5 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -44,6 +44,11 @@ struct sdxi_dev {
 	struct sdxi_cxt_L1_table *L1_table;
 	dma_addr_t L1_dma;
 
+	struct dma_pool *write_index_pool;
+	struct dma_pool *cxt_sts_pool;
+	struct dma_pool *cxt_ctl_pool;
+	struct dma_pool *cst_blk_pool;
+
 	const struct sdxi_bus_ops *bus_ops;
 };
 

-- 
2.54.0


