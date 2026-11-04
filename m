Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760612;
	b=hw4qmCSG+aUlip6QFZuOrY8nZQWGsPosyIFGRS7j9pdEChGMphrTjWi60CPnJFL49zlq
	 2b59o6nzxPa5n/8PF1vlpGwaU/y97+PUkyPXER6g6eqrNuSNAKX91QXRyyrWETzAeM462
	 3emHqw1QK9M/kIW6errDn2Oxy7E5IR6kl/iAzCIfMQE7XIFhA5/xH5qpPmnV/cX0Uhu5P
	 1F2NFYZRwlhBr9s75i6b0xbr9ONbCntDYQgK1Nyozs53GOa2e5ym2A32rV9aoS3Dv6Rb9
	 t9C6BBZK0gY0QKIAMfheybJt9M2kZ+C2xf/hObRwl2YVRvrB+1TSufV6fck9Sgj71ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760612;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LJOIxfJLv0sJAdXcclidi4MfburOXblVLonzNGoSoik=;
	b=XZlxIlg7lYoPomvTleLph/x2alAfXIlwsP3xOho/TUKe9ABLerp/jLikwhqwsdzY/U5i
	 fv6b6FsjJBC6XSy1PQU5IGMhYRWGk1pHwTFBwK1u8q4tasoWxbyILHY3TcOTVW1e78FG6
	 KCDcxYRXBwYIRNMfjzgfpFfMYhJnuqFM3r5WvDWVuBrkskO4YNrhHIhk2DoaWtsbwdlJr
	 uPiUi08P2kc2vCW14TrzdjkpVc5F0MFO1mUWz5UEW+uWCKJtDExam/PWrgbVZMPz63ctS
	 DkkovZNUJixHgvONLhBIeEHAWEBRxWECdMr+awrZUUFAhD0SX+4C0i8CsVjjjKxV/ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6gqJTG2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560D606EEA7;
	Wed,  4 Nov 2026 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6gqJTG2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760611;
	b=VojHC/nYuqxpy6k7ODWLTkXtrT3exVVSWwIOV5V2o/J2CUhR0EgtqhzkvJxOKl5FMnsE
	 ogbqJvWpKiVoaVyDj1hFFvz2bUOq1JZNztr/fyQ+44JgC4KLk6CP2ysJ14VUQkpYfhRle
	 rtKms0U3ObvysxWzWB3eQOn3Z73zffNereIH0kiZmzK7bViQAan3leb/+7URdMYIGLh0E
	 EuNDM0bvOiKDLe+0JWTnR+IxmLzeKRRImx6ceR3ItxzURqaALzH7pwoT/Z5JUnMMROgnG
	 sleaCcEKDoa2gUve/IaGhmncB8b60twjq+L/SNS05x5geRzAemq/A+KVxVNnufBevUQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760611;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LJOIxfJLv0sJAdXcclidi4MfburOXblVLonzNGoSoik=;
	b=vlS75Lz+UBtnXZ8ULDWxOa+bBJTqGQLwm7nq7r062l9Vs61v1op1Gk61UWlPiY1muULB
	 2pfA2ig049aq1wiAN70UIGtGQH5ADzLgiaL7OhYyf9rSwqnsxs+8UkTAtTxLylwhJ2XA4
	 urLypEIvXpDuIA5vy32ymI7Qqdlx8Qe73uOIlV4cecxDQa9TKfKtYfOKOpylfkNQXoJf7
	 +YAvbYngSlHbd5nurdC7Y6mJ4paj2F6pFThzcvk5EFC+w4OrjgB/lKIMsiG1Is5DnmNBI
	 4CaK3xnURvCUw4PJenZ894geZTea8I5NeLGMeNmTHubfdQqEA4f4kkDCpQtPIWDL20Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 44AC71F0157D;
	Wed,  4 Nov 2026 02:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760611;
	bh=LJOIxfJLv0sJAdXcclidi4MfburOXblVLonzNGoSoik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=K6gqJTG2CMyE0uS+uxkoycy6EFWGtED19QV4oiYwkIl3Mbu29+Oyvc4CApOakCjKf
	 RXh3ETH2Cm6rRXrkQTLAcOvt9vBHQqRKybpgxNPI64/xvvyUDVIakVpEgyn139/8Co
	 Rd0fN7OOCtjtcBR7XLD0EwedWLFBk7MHKYgl4HUy0A9dsVxwfJV+0rLGAP/KRaN715
	 8UYu3WQw7UEB7gowJ0s/tQV0yhkOHdHS8iVxt/YK5tvbhJesdepW7sCbG5RXnsQxOa
	 UBT5jQD7RC5aU18pjEgb1cD8HGqQMXygLhrPtJj1EhMwoHKZwdGJWIxJ5dnuDgfGeU
	 4fjB6n4d/m6BQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 86B9746C53;
	Wed,  4 Nov 2026 02:50:03 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:50:05 -0600
Subject: [PATCH v4 24/25] dmaengine: sdxi: MSI/MSI-X vector allocation and
 mapping
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
Message-Id: <20261103-sdxi-base-v4-24-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=6357;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=rAeqXk/oG8Bg3LI60ESSqL+dK+1F4GFWd8SwD/KZQBQ=;
 b=ob+2RYgPGyvNwaOXm7mhnmhqfsBE3/zKQtqIcu3drdcSoJm65Ipt35WAh0xWIYjFvh2rKBLOH
 i+PMoPOyBa+Dcd2XEYpaH2hOUwAAueyLYfUZtxXF/LVK0ZFNRwAYW1T
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Request MSI/MSI-X vectors for the error log interrupt and up to one
interrupt per supported client context. Reserve vector 0 for the error log
and track the remaining allocated vectors with an IDA.

Introduce sdxi_alloc_vector() and sdxi_free_vector() which are thin
wrappers around the IDA that tracks the allocated vector range.

Introduce sdxi_vector_to_irq() which invokes a new get_irq() bus op to
translate the device-relative index to the Linux IRQ number for use
with request_irq() etc. For PCI this dispatches to pci_irq_vector().

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c |  3 +++
 drivers/dma/sdxi/pci.c    | 30 ++++++++++++++++++++++++++-
 drivers/dma/sdxi/sdxi.h   | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 8786be71d3e3..30c4e687cedf 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -11,6 +11,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/export.h>
+#include <linux/idr.h>
 #include <linux/iopoll.h>
 #include <linux/jiffies.h>
 #include <linux/limits.h>
@@ -437,6 +438,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 
 	sdxi->dev = dev;
 	sdxi->bus_ops = ops;
+	ida_init(&sdxi->vectors);
 	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
 	dev_set_drvdata(dev, sdxi);
 
@@ -459,6 +461,7 @@ void sdxi_unregister(struct device *dev)
 	/* Stop/reset is best effort if the hardware cannot be quiesced. */
 	sdxi_dev_stop(sdxi);
 	sdxi_client_cxts_exit(sdxi);
+	ida_destroy(&sdxi->vectors);
 }
 EXPORT_SYMBOL_NS_GPL(sdxi_unregister, "SDXI");
 
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index d196ab5cf6f1..ef978ca22db1 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -31,8 +31,9 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
 {
 	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
 	struct device *dev = &pdev->dev;
+	u32 cap1_max_cxt;
 	u64 cap1;
-	int ret;
+	int vecs, ret;
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
@@ -63,6 +64,27 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
 	sdxi->has_mailbox = pdev->is_virtfn ||
 		pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
 
+	/*
+	 * Allocate the minimum required set of vectors plus one for
+	 * each client context supported by the function.
+	 *
+	 * pci_alloc_irq_vectors() handles calling pci_free_irq_vectors()
+	 * automatically despite not being called pcim_*. See
+	 * pci_setup_msi_context().
+	 */
+	cap1_max_cxt = FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT,
+				 sdxi_read64(sdxi, SDXI_MMIO_CAP1));
+	vecs = pci_alloc_irq_vectors(pdev, SDXI_MIN_VECTORS,
+				     SDXI_MIN_VECTORS + cap1_max_cxt,
+				     PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (vecs < 0)
+		return dev_err_probe(dev, vecs,
+				     "failed to allocate MSIs (max_cxt=%u)\n",
+				     cap1_max_cxt);
+
+	sdxi->nr_vectors = vecs;
+	dev_dbg(sdxi->dev, "allocated %u vectors\n", sdxi->nr_vectors);
+
 	pci_set_master(pdev);
 	return 0;
 }
@@ -86,9 +108,15 @@ static int sdxi_pci_reset(struct sdxi_dev *sdxi)
 	return err;
 }
 
+static int sdxi_pci_get_irq(struct sdxi_dev *sdxi, unsigned int nr)
+{
+	return pci_irq_vector(sdxi_to_pci_dev(sdxi), nr);
+}
+
 static const struct sdxi_bus_ops sdxi_pci_ops = {
 	.init = sdxi_pci_init,
 	.reset = sdxi_pci_reset,
+	.get_irq = sdxi_pci_get_irq,
 };
 
 static int sdxi_pci_probe(struct pci_dev *pdev,
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index aaa43eab00b3..07044d837d9a 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -8,8 +8,10 @@
 #ifndef DMA_SDXI_H
 #define DMA_SDXI_H
 
+#include <linux/bug.h>
 #include <linux/compiler_types.h>
 #include <linux/dev_printk.h>
+#include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
@@ -25,6 +27,18 @@
 #define L1_CXT_CTRL_PTR_SHIFT		6
 #define L1_CXT_AKEY_PTR_SHIFT		12
 
+enum {
+	/* Reserve vector 0 for the error log interrupt. */
+	SDXI_ERROR_VECTOR = 0,
+
+	/*
+	 * Request at least one vector to account for the error log
+	 * interrupt. Increment this if the driver gains more
+	 * dedicated interrupts (e.g. one for the admin context).
+	 */
+	SDXI_MIN_VECTORS = 1,
+};
+
 struct sdxi_dev;
 
 /**
@@ -41,6 +55,10 @@ struct sdxi_bus_ops {
 	 * @reset: Bus-specific recovery when the native stop sequence fails.
 	 */
 	int (*reset)(struct sdxi_dev *sdxi);
+	/**
+	 * @get_irq: Map device interrupt index to Linux IRQ number.
+	 */
+	int (*get_irq)(struct sdxi_dev *sdxi, unsigned int index);
 };
 
 struct sdxi_dev {
@@ -61,6 +79,9 @@ struct sdxi_dev {
 
 	struct dma_pool *cxt_ctl_pool;
 
+	unsigned int nr_vectors;
+	struct ida vectors;
+
 	struct sdxi_cxt *admin_cxt;
 	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
 
@@ -69,6 +90,38 @@ struct sdxi_dev {
 	const struct sdxi_bus_ops *bus_ops;
 };
 
+/**
+ * sdxi_alloc_vector() - Allocate an interrupt vector.
+ *
+ * A vector that will have the same lifetime as the device does not
+ * need to be released explicitly. Otherwise the vector must be
+ * released with sdxi_free_vector().
+ */
+static inline int sdxi_alloc_vector(struct sdxi_dev *sdxi)
+{
+	return ida_alloc_range(&sdxi->vectors, SDXI_MIN_VECTORS,
+			       sdxi->nr_vectors - 1, GFP_KERNEL);
+}
+
+/**
+ * sdxi_free_vector() - Release a previously allocated index.
+ */
+static inline void sdxi_free_vector(struct sdxi_dev *sdxi, unsigned int nr)
+{
+	ida_free(&sdxi->vectors, nr);
+}
+
+/**
+ * sdxi_vector_to_irq() - Translate an allocated interrupt vector to
+ *                        Linux IRQ number suitable for passing to
+ *                        request_irq() et al.
+ */
+static inline int sdxi_vector_to_irq(struct sdxi_dev *sdxi, unsigned int nr)
+{
+	WARN_ON_ONCE(!ida_exists(&sdxi->vectors, nr));
+	return sdxi->bus_ops->get_irq(sdxi, nr);
+}
+
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
 void sdxi_unregister(struct device *dev);
 

-- 
2.56.0


