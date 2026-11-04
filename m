Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760606;
	b=pBxKpQKzRG9QyqOH3+EMew4rE2nW2MciwB7KqUP+5P1kHQVsR3OePp7atvD68+YRL+Qb
	 JMRFGfvLGhPIb0ZF+aNT3YPn6R867Iq+ySDlbm2ki9bwHfOOTLtPjYWIO09VCJb47tE1S
	 cIbH7NqMZIZXzx1/0L0yYxLLEbJn+d7NxdlA/Xpn7P9hO4iazRUmE/qF7evzmFkYwlWtI
	 cz1WvYkHAgKC4tFIDbd0GDXl7x6Jegxz+sSbmakg+A2jRZoycnCcKHTwh0m0VnIFp6+nt
	 jdbYzW7/vZTTVCYXJL6/GZ5mB42V3qSZt6lXu6Lfa1DES9nUvNJ9kkxUX3VGL1aC6SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760606;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ivUjJKza71DMj26sDapQGk8WGo8ycmnKvwGsZ0OQ/fo=;
	b=YLG4djg2CGEUD37NGtUuWDx+zFANz9ODNJ/jC5psYKO7mt7qHGlzZEBzZ3eHzczELmTE
	 rM4XKKcXXE3HkJJ6hxh4QBAZbOE6fqSjmaSFWRO6/3Z+OcD+9YkEiQN5PSZCIkuhkQlVB
	 xTpM7lk3PwggpTEsXNsiQ3kTA7diwINrLiww7nlCZXqvtt+VnFzNxMYdMM/O1E7qlKmjC
	 LnD3iIbMn8LCfQo/Ls1JzLxB0Pd2IsYnJgDIIH58zMew6Ck69nNcu3O3velMgm9RnaR6E
	 qx3nQS8czUhWk8Cv+HCYfi1iF0LfCM9TUF2rqkJzF4XXX7ev/5q2kjKTxxTnBKfT9oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwuhIKYk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC283606A33F;
	Wed,  4 Nov 2026 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwuhIKYk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760605;
	b=dwY3aetUN9Rnp9aKjXD5ngsYixamULwFL0zAnvmT22jLEwkNIZZSfCcs+E9J20FDaK7p
	 z9JxuvMC4YfOP+j6KfIhUBKHT/RKygLvoBOak1Q51RCRBLIeMAy9rNBCDHsOeq/BOG2D3
	 SRVCwUmXMY0uRgYYp8It+BVQ3Jq1dTjgIm+RplbjK+TADXxLX6vo0iZHS1kjXUexe/tf3
	 IC73byYOMGO93zrs/jGXQIsUqb78kJG/BZzopb2N/289FTFwqMFq9Ii6wZv63LMemIblJ
	 OmjfDax3b2E5HnsLP0HI9OErOhtgMkUedB2YO0ieajRuvpeF1BUO9GSj1sg0bRpimzg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760605;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ivUjJKza71DMj26sDapQGk8WGo8ycmnKvwGsZ0OQ/fo=;
	b=wYq+wWgQ8QrsBT9pHqpqltk47ayP3ZaS+4VABmL9zB8j0MDrA++eQJrL9c2Z4T8mjBLG
	 AkezRkirac1FkZqjWOst7DzRfusbEooeFl5i2xQeSrar0IEMPjqH5lZ89arCLypXl8UA4
	 y/PEBsmryjuUWtp1cXkhHrNr+YEp2S+UIsiwO/cSAfYhF7R19U4csydk8X7Zv0hoU0CqR
	 DDLZTva4O8LTJjhctvF7LiXgwBwSrY5KqmhBTJ6BC++VoUdUcAvcplHXvcDjKL2xkmYN8
	 kFJ1IAC+Iss+7ZfhIC91N7NC8NLep5ZUen1FJ2m2/6M2ze42pgDERyUTNvlA18YKRkg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 197861F00A16;
	Wed,  4 Nov 2026 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760605;
	bh=ivUjJKza71DMj26sDapQGk8WGo8ycmnKvwGsZ0OQ/fo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FwuhIKYkUHMW5koyX3Clj0ZxgFWBr7fQrC88MZjqMA8I/8OLnRPpK6aaDwgCCYvgB
	 ghe+NXqtWNa9i38K/clJS+AZtVUjkzmEjMjOZMPcTHX+DWPivW614sPu3yhpVJxTyt
	 C4PXHS973AXtSTKqAlj0Y/Rg7WyEKbLrDVEjHO86QhvWWz4N9qVqpNoBylK2geFfAS
	 lU9GtL/NbU/utlPPRuGNdRtrvebSGkKptXwiuy5sspic0SI7W4WCqgO3oDBzWuHbl2
	 Rh0uaBLbdsHDPR/vrLyMNRYeyJKnW+n9gsLCF1csg1CdqclCl4OkmmadIjuIMwVgfG
	 7fA+KSJQGAbTw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 72F1C46C07;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:46 -0600
Subject: [PATCH v4 05/25] dmaengine: sdxi: Feature discovery and initial
 configuration
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
Message-Id: <20261103-sdxi-base-v4-5-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=5209;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=PsmUsZs0rNQf6wIHSDpbWCqhqZyz/6uJ047WgkPg8tU=;
 b=Xkxmtc1dtrM14A8i1cg86RtBzBtEWRONyy8sA+RTYDxtj2j7XjmnqEGTcep95SweU5R5+4P1V
 Er+rwx4lzfVCjnN84BtxqN9Fp1HNXEj0RAGIdSvHCOcSqslhcmycq6E
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Discover the stopped function's version, doorbell stride, supported
operation groups, and context and buffer limits. Apply the driver
configuration to MMIO_CTL2 after function preparation has removed
inherited state.

Add capability fields and device bookkeeping. Report the SDXI version implemented by the function.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/dma/sdxi/mmio.h   | 13 +++++++++++++
 drivers/dma/sdxi/sdxi.h   |  6 ++++++
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 23a75beb6912..c03af5833414 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -8,9 +8,13 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/iopoll.h>
 #include <linux/jiffies.h>
+#include <linux/limits.h>
+#include <linux/minmax.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 
@@ -275,6 +279,43 @@ static int sdxi_fn_prepare(struct sdxi_dev *sdxi)
 	return 0;
 }
 
+/*
+ * See SDXI 1.0 4.1.8 Activation of the SDXI Function by Software.
+ */
+static int sdxi_fn_activate(struct sdxi_dev *sdxi)
+{
+	u64 version, cap0, cap1, ctl2;
+
+	version = sdxi_read64(sdxi, SDXI_MMIO_VERSION);
+	dev_info(sdxi->dev, "SDXI %llu.%llu device found\n",
+		  FIELD_GET(SDXI_MMIO_VERSION_MAJOR, version),
+		  FIELD_GET(SDXI_MMIO_VERSION_MINOR, version));
+
+	/* Read capabilities and features. */
+	cap0 = sdxi_read64(sdxi, SDXI_MMIO_CAP0);
+	sdxi->db_stride = SZ_4K;
+	sdxi->db_stride *= 1U << FIELD_GET(SDXI_MMIO_CAP0_DB_STRIDE, cap0);
+
+	cap1 = sdxi_read64(sdxi, SDXI_MMIO_CAP1);
+	sdxi->op_grp_cap = FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1);
+	sdxi->max_buffer = FIELD_GET(SDXI_MMIO_CAP1_MAX_BUFFER, cap1);
+	dma_set_max_seg_size(sdxi->dev,
+			     min((u64)SZ_2M << sdxi->max_buffer, U32_MAX));
+	sdxi->max_cxtid = FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1);
+
+	/* Apply our configuration. */
+	ctl2 = FIELD_PREP(SDXI_MMIO_CTL2_MAX_CXT, sdxi->max_cxtid);
+	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_MAX_BUFFER,
+			   sdxi->max_buffer);
+	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_MAX_AKEY_SZ,
+			   FIELD_GET(SDXI_MMIO_CAP1_MAX_AKEY_SZ, cap1));
+	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_OPB_000_AVL,
+			   FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1));
+	sdxi_write64(sdxi, SDXI_MMIO_CTL2, ctl2);
+
+	return 0;
+}
+
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 {
 	struct sdxi_dev *sdxi;
@@ -292,7 +333,11 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 	if (err)
 		return err;
 
-	return sdxi_fn_prepare(sdxi);
+	err = sdxi_fn_prepare(sdxi);
+	if (err)
+		return err;
+
+	return sdxi_fn_activate(sdxi);
 }
 EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
 
diff --git a/drivers/dma/sdxi/mmio.h b/drivers/dma/sdxi/mmio.h
index a9c1fbb404d5..7c416de9f874 100644
--- a/drivers/dma/sdxi/mmio.h
+++ b/drivers/dma/sdxi/mmio.h
@@ -16,7 +16,9 @@ enum sdxi_reg {
 	SDXI_MMIO_CTL0       = 0x00000,
 	SDXI_MMIO_CTL2       = 0x00010,
 	SDXI_MMIO_STS0       = 0x00100,
+	SDXI_MMIO_CAP0       = 0x00200,
 	SDXI_MMIO_CAP1       = 0x00208,
+	SDXI_MMIO_VERSION    = 0x00210,
 
 	/* SDXI 1.0 9.2 Context and RKey Table Registers */
 	SDXI_MMIO_CXT_L2     = 0x10000,
@@ -48,6 +50,11 @@ enum sdxi_reg {
 /* SDXI 1.0 Table 9-5: MMIO_STS0 */
 #define SDXI_MMIO_STS0_FN_GSV GENMASK_ULL(2, 0)
 
+/* SDXI 1.0 Table 9-6: MMIO_CAP0 */
+#define SDXI_MMIO_CAP0_SFUNC          GENMASK_ULL(15, 0)
+#define SDXI_MMIO_CAP0_DB_STRIDE      GENMASK_ULL(22, 20)
+#define SDXI_MMIO_CAP0_MAX_DS_RING_SZ GENMASK_ULL(28, 24)
+
 /* SDXI 1.0 Table 9-7: MMIO_CAP1 */
 #define SDXI_MMIO_CAP1_MAX_BUFFER  GENMASK_ULL(3, 0)
 #define SDXI_MMIO_CAP1_RKEY_CAP    BIT_ULL(4)
@@ -55,6 +62,12 @@ enum sdxi_reg {
 #define SDXI_MMIO_CAP1_MAX_AKEY_SZ GENMASK_ULL(15, 12)
 #define SDXI_MMIO_CAP1_MAX_CXT     GENMASK_ULL(31, 16)
 
+#define SDXI_MMIO_CAP1_OPB_000_CAP GENMASK_ULL(63, 32)
+
+/* SDXI 1.0 Table 9-8: MMIO_VERSION */
+#define SDXI_MMIO_VERSION_MINOR GENMASK_ULL(7, 0)
+#define SDXI_MMIO_VERSION_MAJOR GENMASK_ULL(23, 16)
+
 /* SDXI 1.0 Table 9-10: MMIO_RKEY */
 #define SDXI_MMIO_RKEY_EN BIT_ULL(0)
 
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index bb0d2165d495..7569b8395ce1 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -38,6 +38,12 @@ struct sdxi_dev {
 	void __iomem *ctrl_regs;	/* virt addr of ctrl registers */
 	void __iomem *dbs;		/* virt addr of doorbells */
 
+	/* hardware capabilities (from cap0 & cap1) */
+	u32 db_stride;			/* doorbell stride in bytes */
+	u16 max_cxtid;			/* Maximum context ID allowed. */
+	u8 max_buffer;			/* Configured log2 buffer size minus 21. */
+	u32 op_grp_cap;			/* supported operation group cap */
+
 	bool has_mailbox;
 
 	const struct sdxi_bus_ops *bus_ops;

-- 
2.56.0


