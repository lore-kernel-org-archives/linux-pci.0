Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760606;
	b=ajR2Hlm/Zv7VTOnnR3vquAjABE9PhHMLD8sccnVg9h1mEz9kDKFtb0Fd5PntItuhyo0a
	 X+FGSXbNu2khD2AR7o0YYcTXgA04t/Nm4lJbLHYk7H9yX0aTr39y7TxcH3w8x+GRf84Hs
	 hpLmNODyMtpQsG5NN0qwwVi+099KmtIfeyvmSzltK/ErAKomz+v5gjFaPFhkomBh+qtNM
	 MLOUZ0F4v1RFYJIAiMSp9/8RarD/qdhNEFLOzHUpcWHKv/SMGXlqd1XQgjOhQlAvHLK4k
	 Sf3LbS9KSc5q37EC/00Cn3XF8GG0Pj0CiGOlXEOgAuDR8c6W9HojqgQdJl1lSZLSp7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760606;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5MCmlDGB9On+HhPDIdfN81H7uPhxYEfjHhT5vNICJ6A=;
	b=mCNCX3afVv80c9Q9Y3gfpjGLDqifWPTgKHzIqNw6NGH5fV/Q2qIEjSr67+zIvH466vm1
	 U/nTaVcuq1jHYDPiflzTQXfTgrMLUgo2PmfKSIatMCS6z+UFAq8qYWVjI4X2YfbSj3tPo
	 hAwuVIEkhhA91U8PSLWSl8Lz7SECWulnw2z+nJmBfoCG245hR4JU6HNrrD9wKZRjRqXxz
	 jVU5TKIHiMJbemXCW0zu7xh2cPtX1Z3vsA/RIRARWDc2bPEFeHBNfXoZVPnEWqszqIVGz
	 0nmV7k7iSNniW8ByM6lokx8JCUEwLA8uuGfrKcVblalFmKSMVbBUDCP8NQ8++g4ec8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZrfFVpGi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6E3606A337;
	Wed,  4 Nov 2026 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZrfFVpGi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760605;
	b=HfYGUNkASCLm+0MCGjtnFqCeD+88D1YXnV8KRyasT/8Gmt1JRlRE2SQCh7H1Wl4o5WZg
	 cAF/bdAu2V57aHa5RlpMsePIRxN4cdC9lUDr9n/FtPZQN8NHiP6Ebmad1CMvXufQEW5kj
	 OeLY2Ab9n1qTxN5KStB4m1TRzEQ+Ck0Dio8lcU04ofvE8tRABRzjMVrxuw6Ljv3n+Zphs
	 Hoh4W7fKkmzsVPqaW8hbgVrTcpeFB2pMpNFa6bYwE3d3tY7x8oYkU4GQQj3JsxO97t9AZ
	 6xDbPozVCt37dlt5FVuYQyxBgHqNbUcfrslAFbUIUrQSInLkdgk9PFZQszSqMCtYnzw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760605;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5MCmlDGB9On+HhPDIdfN81H7uPhxYEfjHhT5vNICJ6A=;
	b=LVfjrcSYjbpQqFSMjMOV1Pq4xXSGmN+ZCvdXl9cpEgNsDvcreM4+1jblIGj3wQaox9rQ
	 me6ApbZKZ3bMVvWLs3gWZEJK03nY1RCRn5p+yLD4xEOjZ2/o8QZDGPR1rQVfzirI6LXLJ
	 h+grJxsIX18K9g0Li+QVixOGNBMlNvCqkRCpQiUJZDvoDUGtmXNVLSZrDo18VNAOcRQDg
	 ygMiaNv+uCWzSp11ZW0422DLEYNudjiDuKHquP7MbbkUgFDNyxQaESRp8pGHkm0wAvpfO
	 3eYc1D+Vjd4zwtCwdgQ9wgff8SIHQI+saf5wvZsYIDk4aBGXZ14iqR5ySfH2n5VedKw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E04A61F00A15;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760605;
	bh=5MCmlDGB9On+HhPDIdfN81H7uPhxYEfjHhT5vNICJ6A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZrfFVpGi5X7/dLBP4IfNusHjv23qjZ6nCUN+rIRvdU4Y3H9Z8Kh+jY7sIYs27FzPd
	 WiEpkXhT3D9Cni3UbljMw1kQIk4w82iGW+jmUpxLIzaUEbW9WEb+hdD8MQY/zXGa98
	 N+nqRNvGa+VYXRXOLKG5wRjF8dfpc46fDWUWcZLmHa5dvliuMlLexG4rk+XRIHhxjU
	 w9+IXedqdmkIN92Uvcm5OUxOX4/mxApV+iqiWKFeYDYZFUak+oWBXWMDs7nleGOAX9
	 tZ3TZhRWOAh9MwjlbCUmbe33xaodyu8xEGrFYl2vD6vEn1kefbHL1yS8zKTezFfbgs
	 rO9lFpZsDXorw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 65CBB46C03;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:45 -0600
Subject: [PATCH v4 04/25] dmaengine: sdxi: Prepare function and sanitize
 MMIO state
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
Message-Id: <20261103-sdxi-base-v4-4-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=15263;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=oWuj3noFUtZvqc1BxjPqEeqOtVeqx+qhD05NxD4jrwk=;
 b=jAHTCcMNiAUIeO1QKvM3axPfP6PxX8pALrQPN9ripTgXMVK39nWiCQV+FNwOiIg/o+OpQGOt7
 kaTNVSttDayAeAxR8cd7S58w0DKw16cjvmpcyiGEXaHh9K+SEJo/Br7
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Recover an inherited function state using bounded native stop/reset
transitions and a PCI function reset that saves and restores PCI
configuration. Use the locked reset API because probe and removal hold
the device lock. If reset fails, disable bus mastering and wait
for pending transactions as a best-effort fallback.

Disable inherited error logging before stop commands can provoke errors.
After stopping, sanitize writable configuration in Chapter 9 order:
preserve the function group ID, clear PASID and interrupt enables,
restore CTL2 reset limits with operation groups disabled, discard stale
context and supported RKey tables, and clear error-log state. Disable
mailbox interrupts only on functions with SR-IOV mailbox support.

Keep mailbox commands and peer-owned payloads untouched. Status cleanup
uses the specified write-one-to-clear semantics. Invoke preparation
before feature configuration or publishing new DMA control structures.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c | 271 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/dma/sdxi/mmio.h   |  49 ++++++++-
 drivers/dma/sdxi/pci.c    |  24 ++++
 drivers/dma/sdxi/sdxi.h   |  20 ++++
 4 files changed, 362 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 0974a83bb45c..23a75beb6912 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -5,15 +5,280 @@
  * Copyright Advanced Micro Devices, Inc.
  */
 
+#include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
+#include <linux/time.h>
 
+#include "mmio.h"
 #include "sdxi.h"
 
+enum sdxi_fn_gsv {
+	SDXI_GSV_STOP     = 0,
+	SDXI_GSV_INIT     = 1,
+	SDXI_GSV_ACTIVE   = 2,
+	SDXI_GSV_STOPG_SF = 3,
+	SDXI_GSV_STOPG_HD = 4,
+	SDXI_GSV_ERROR    = 5,
+};
+
+static const char *const gsv_strings[] = {
+	[SDXI_GSV_STOP]     = "stopped",
+	[SDXI_GSV_INIT]     = "initializing",
+	[SDXI_GSV_ACTIVE]   = "active",
+	[SDXI_GSV_STOPG_SF] = "soft stopping",
+	[SDXI_GSV_STOPG_HD] = "hard stopping",
+	[SDXI_GSV_ERROR]    = "error",
+};
+
+static const char *gsv_str(enum sdxi_fn_gsv gsv)
+{
+	if ((size_t)gsv < ARRAY_SIZE(gsv_strings))
+		return gsv_strings[(size_t)gsv];
+
+	return "unknown";
+}
+
+enum sdxi_fn_gsr {
+	SDXI_GSRV_RESET   = 0,
+	SDXI_GSRV_STOP_SF = 1,
+	SDXI_GSRV_STOP_HD = 2,
+	SDXI_GSRV_ACTIVE  = 3,
+};
+
+static const char *const gsr_strings[] = {
+	[SDXI_GSRV_RESET]   = "reset",
+	[SDXI_GSRV_STOP_SF] = "soft stop",
+	[SDXI_GSRV_STOP_HD] = "hard stop",
+	[SDXI_GSRV_ACTIVE]  = "activate",
+};
+
+static const char *gsr_str(enum sdxi_fn_gsr gsr)
+{
+	if ((size_t)gsr < ARRAY_SIZE(gsr_strings))
+		return gsr_strings[(size_t)gsr];
+
+	return "unknown";
+}
+
+static enum sdxi_fn_gsv sdxi_dev_gsv(const struct sdxi_dev *sdxi)
+{
+	u64 sts0 = sdxi_read64(sdxi, SDXI_MMIO_STS0);
+	enum sdxi_fn_gsv gsv = FIELD_GET(SDXI_MMIO_STS0_FN_GSV, sts0);
+
+	dev_dbg(sdxi->dev, "MMIO_STS0.fn_gsv = %#x (%s)\n", gsv, gsv_str(gsv));
+
+	switch (gsv) {
+	case SDXI_GSV_STOP ... SDXI_GSV_ERROR:
+		break;
+	default:
+		dev_warn_ratelimited(sdxi->dev, "unknown gsv %u\n", gsv);
+		break;
+	}
+
+	return gsv;
+}
+
+static const unsigned long gsv_poll_interval_us = USEC_PER_MSEC * 100;
+static const unsigned long gsv_transition_timeout_us = USEC_PER_SEC * 1;
+
+#define sdxi_dev_gsv_poll(sdxi, val, cond)				\
+	read_poll_timeout(sdxi_dev_gsv, val, cond, gsv_poll_interval_us, \
+			  gsv_transition_timeout_us, false, sdxi)
+
+static void sdxi_write_fn_gsr(struct sdxi_dev *sdxi, enum sdxi_fn_gsr cmd)
+{
+	u64 ctl0 = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
+
+	dev_dbg(sdxi->dev, "MMIO_CTL0.fn_gsr = %#x (%s)\n", cmd, gsr_str(cmd));
+
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_GSR, &ctl0, cmd);
+	sdxi_write64(sdxi, SDXI_MMIO_CTL0, ctl0);
+}
+
+/*
+ * How to make progress toward GSV_STOP from each function state. See
+ * SDXI 1.0 Figure 4-1: SDXI Function States and State Transitions.
+ *
+ * The function ordinarily leaves a @transient state without software
+ * intervention, so @cmd applies only to the others. @stall_cmd, if any,
+ * is issued when the state outlasts the poll timeout. @next is the set
+ * of states software may observe after the step.
+ */
+struct gsv_stop_step {
+	bool transient:1;
+	bool issue_stall_cmd:1;
+	enum sdxi_fn_gsr cmd;
+	enum sdxi_fn_gsr stall_cmd;
+	unsigned long next;
+};
+
+static const struct gsv_stop_step gsv_stop_steps[] = {
+	[SDXI_GSV_STOP] = { },
+	[SDXI_GSV_INIT] = {
+		/*
+		 * Any fn_gsr write other than SDXI_GSRV_ACTIVE during
+		 * initialization forces HaltErr:Fn -> GSV_ERROR.
+		 * GSV_STOPG_HD and GSV_STOP are valid next values since
+		 * the stop command could race with a GSV_INIT ->
+		 * GSV_ACTIVE transition.
+		 */
+		.transient = true,
+		.issue_stall_cmd = true,
+		.stall_cmd = SDXI_GSRV_STOP_HD,
+		.next = BIT(SDXI_GSV_ACTIVE) | BIT(SDXI_GSV_ERROR) |
+			BIT(SDXI_GSV_STOPG_HD) | BIT(SDXI_GSV_STOP),
+	},
+	[SDXI_GSV_ACTIVE] = {
+		.cmd = SDXI_GSRV_STOP_SF,
+		.next = BIT(SDXI_GSV_STOPG_SF) | BIT(SDXI_GSV_STOP) |
+			BIT(SDXI_GSV_ERROR),
+	},
+	[SDXI_GSV_STOPG_SF] = {
+		.transient = true,
+		.issue_stall_cmd = true,
+		.stall_cmd = SDXI_GSRV_STOP_HD,
+		.next = BIT(SDXI_GSV_STOPG_HD) | BIT(SDXI_GSV_STOP) |
+			BIT(SDXI_GSV_ERROR),
+	},
+	[SDXI_GSV_STOPG_HD] = {
+		/* All fn_gsr writes are ignored here; only waiting helps. */
+		.transient = true,
+		.next = BIT(SDXI_GSV_STOP) | BIT(SDXI_GSV_ERROR),
+	},
+	[SDXI_GSV_ERROR] = {
+		.cmd = SDXI_GSRV_RESET,
+		.next = BIT(SDXI_GSV_STOP),
+	},
+};
+
+/* Drive the function to GSV_STOP from any state. */
+static int sdxi_dev_stop(struct sdxi_dev *sdxi)
+{
+	unsigned long stepped_from = 0;
+	enum sdxi_fn_gsv gsv;
+
+	/*
+	 * Each step must reach a state we have not already stepped from.
+	 * The table admits no cycles, so revisiting one means the device
+	 * is not behaving as specified.
+	 */
+	for (gsv = sdxi_dev_gsv(sdxi); gsv != SDXI_GSV_STOP; ) {
+		const struct gsv_stop_step *step;
+		enum sdxi_fn_gsv from = gsv;
+
+		if ((size_t)gsv >= ARRAY_SIZE(gsv_stop_steps))
+			break;
+		if (stepped_from & BIT(gsv))
+			break;
+		stepped_from |= BIT(gsv);
+
+		step = &gsv_stop_steps[gsv];
+		if (!step->transient)
+			sdxi_write_fn_gsr(sdxi, step->cmd);
+
+		if (sdxi_dev_gsv_poll(sdxi, gsv, gsv != from)) {
+			if (!step->issue_stall_cmd)
+				break;
+			dev_notice(sdxi->dev, "stop: %s, issuing %s\n",
+				   gsv_str(from), gsr_str(step->stall_cmd));
+			sdxi_write_fn_gsr(sdxi, step->stall_cmd);
+			if (sdxi_dev_gsv_poll(sdxi, gsv, gsv != from))
+				break;
+		}
+
+		WARN_ONCE(!(BIT(gsv) & step->next), "unexpected %s -> %s\n",
+			  gsv_str(from), gsv_str(gsv));
+	}
+
+	if (gsv == SDXI_GSV_STOP)
+		return 0;
+
+	dev_err(sdxi->dev, "stop: stuck at MMIO_STS0.fn_gsv = %#x (%s)\n",
+		gsv, gsv_str(gsv));
+
+	return sdxi->bus_ops->reset ? sdxi->bus_ops->reset(sdxi) : -EIO;
+}
+
+/* Stop the function and discard inherited MMIO configuration. */
+static int sdxi_fn_prepare(struct sdxi_dev *sdxi)
+{
+	u64 cap1, ctl0, ctl2, err_cfg, rkey;
+	int err;
+
+	/* Disable inherited error logging before stop can provoke an error. */
+	err_cfg = sdxi_read64(sdxi, SDXI_MMIO_ERR_CFG);
+	FIELD_MODIFY(SDXI_MMIO_ERR_CFG_EN, &err_cfg, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, err_cfg);
+	err_cfg = sdxi_read64(sdxi, SDXI_MMIO_ERR_CFG);
+	if (FIELD_GET(SDXI_MMIO_ERR_CFG_EN, err_cfg)) {
+		dev_err(sdxi->dev, "failed to disable error logging\n");
+		return -EIO;
+	}
+
+	/*
+	 * Ensure the function is in GSV_STOP state, then clear ctl0's
+	 * pasid and error interrupt configuration while preserving
+	 * any assigned group ID (fn_grp_id).
+	 */
+	err = sdxi_dev_stop(sdxi);
+	if (err)
+		return err;
+
+	ctl0 = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_ERR_INTR_EN, &ctl0, 0);
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_PASID_VL, &ctl0, 0);
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_PASID, &ctl0, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_CTL0, ctl0);
+
+	/* Restore CTL2's reset limits, with operation groups disabled. */
+	cap1 = sdxi_read64(sdxi, SDXI_MMIO_CAP1);
+	ctl2 = FIELD_PREP(SDXI_MMIO_CTL2_MAX_BUFFER,
+			  FIELD_GET(SDXI_MMIO_CAP1_MAX_BUFFER, cap1));
+	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_MAX_AKEY_SZ,
+			   FIELD_GET(SDXI_MMIO_CAP1_MAX_AKEY_SZ, cap1));
+	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_MAX_CXT,
+			   FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1));
+	sdxi_write64(sdxi, SDXI_MMIO_CTL2, ctl2);
+
+	/* No inherited context or remote-access tables are owned by us. */
+	sdxi_write64(sdxi, SDXI_MMIO_CXT_L2, 0);
+	if (FIELD_GET(SDXI_MMIO_CAP1_RKEY_CAP, cap1)) {
+		rkey = sdxi_read64(sdxi, SDXI_MMIO_RKEY);
+		FIELD_MODIFY(SDXI_MMIO_RKEY_EN, &rkey, 0);
+		sdxi_write64(sdxi, SDXI_MMIO_RKEY, rkey);
+		rkey = sdxi_read64(sdxi, SDXI_MMIO_RKEY);
+		if (FIELD_GET(SDXI_MMIO_RKEY_EN, rkey)) {
+			dev_err(sdxi->dev, "failed to disable RKey access\n");
+			return -EIO;
+		}
+		sdxi_write64(sdxi, SDXI_MMIO_RKEY, 0);
+	}
+
+	/* Clear error-log state using the status register's RW1C semantics. */
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CTL, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_STS,
+		     SDXI_MMIO_ERR_STS_STS_BIT | SDXI_MMIO_ERR_STS_OVF_BIT |
+		     SDXI_MMIO_ERR_STS_ERR_BIT);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_WRT, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_RD, 0);
+
+	/* Mailbox contents and commands belong to the peer protocol. */
+	if (sdxi->has_mailbox)
+		sdxi_write64(sdxi, SDXI_MMIO_MB_CTL, 0);
+
+	return 0;
+}
+
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 {
 	struct sdxi_dev *sdxi;
+	int err;
 
 	sdxi = devm_kzalloc(dev, sizeof(*sdxi), GFP_KERNEL);
 	if (!sdxi)
@@ -23,7 +288,11 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 	sdxi->bus_ops = ops;
 	dev_set_drvdata(dev, sdxi);
 
-	return sdxi->bus_ops->init(sdxi);
+	err = sdxi->bus_ops->init(sdxi);
+	if (err)
+		return err;
+
+	return sdxi_fn_prepare(sdxi);
 }
 EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
 
diff --git a/drivers/dma/sdxi/mmio.h b/drivers/dma/sdxi/mmio.h
index 2676736f3998..a9c1fbb404d5 100644
--- a/drivers/dma/sdxi/mmio.h
+++ b/drivers/dma/sdxi/mmio.h
@@ -13,10 +13,57 @@
 
 enum sdxi_reg {
 	/* SDXI 1.0 9.1 General Control and Status Registers */
+	SDXI_MMIO_CTL0       = 0x00000,
+	SDXI_MMIO_CTL2       = 0x00010,
+	SDXI_MMIO_STS0       = 0x00100,
 	SDXI_MMIO_CAP1       = 0x00208,
+
+	/* SDXI 1.0 9.2 Context and RKey Table Registers */
+	SDXI_MMIO_CXT_L2     = 0x10000,
+	SDXI_MMIO_RKEY       = 0x10100,
+
+	/* SDXI 1.0 9.3 Error Logging Control and Status Registers */
+	SDXI_MMIO_ERR_CTL    = 0x20000,
+	SDXI_MMIO_ERR_STS    = 0x20008,
+	SDXI_MMIO_ERR_CFG    = 0x20010,
+	SDXI_MMIO_ERR_WRT    = 0x20020,
+	SDXI_MMIO_ERR_RD     = 0x20028,
+
+	/* SDXI 1.0 9.4 MBOX Mailbox Registers */
+	SDXI_MMIO_MB_CTL     = 0x30000,
 };
 
+/* SDXI 1.0 Table 9-2: MMIO_CTL0 */
+#define SDXI_MMIO_CTL0_FN_GSR         GENMASK_ULL(1, 0)
+#define SDXI_MMIO_CTL0_FN_PASID_VL    BIT_ULL(2)
+#define SDXI_MMIO_CTL0_FN_ERR_INTR_EN BIT_ULL(4)
+#define SDXI_MMIO_CTL0_FN_PASID       GENMASK_ULL(27, 8)
+
+/* SDXI 1.0 Table 9-4: MMIO_CTL2 */
+#define SDXI_MMIO_CTL2_MAX_BUFFER  GENMASK_ULL(3, 0)
+#define SDXI_MMIO_CTL2_MAX_AKEY_SZ GENMASK_ULL(15, 12)
+#define SDXI_MMIO_CTL2_MAX_CXT     GENMASK_ULL(31, 16)
+#define SDXI_MMIO_CTL2_OPB_000_AVL GENMASK_ULL(63, 32)
+
+/* SDXI 1.0 Table 9-5: MMIO_STS0 */
+#define SDXI_MMIO_STS0_FN_GSV GENMASK_ULL(2, 0)
+
 /* SDXI 1.0 Table 9-7: MMIO_CAP1 */
-#define SDXI_MMIO_CAP1_MMIO64 BIT_ULL(6)
+#define SDXI_MMIO_CAP1_MAX_BUFFER  GENMASK_ULL(3, 0)
+#define SDXI_MMIO_CAP1_RKEY_CAP    BIT_ULL(4)
+#define SDXI_MMIO_CAP1_MMIO64      BIT_ULL(6)
+#define SDXI_MMIO_CAP1_MAX_AKEY_SZ GENMASK_ULL(15, 12)
+#define SDXI_MMIO_CAP1_MAX_CXT     GENMASK_ULL(31, 16)
+
+/* SDXI 1.0 Table 9-10: MMIO_RKEY */
+#define SDXI_MMIO_RKEY_EN BIT_ULL(0)
+
+/* SDXI 1.0 Table 9-12: MMIO_ERR_STS (write one to clear) */
+#define SDXI_MMIO_ERR_STS_STS_BIT BIT_ULL(0)
+#define SDXI_MMIO_ERR_STS_OVF_BIT BIT_ULL(1)
+#define SDXI_MMIO_ERR_STS_ERR_BIT BIT_ULL(3)
+
+/* SDXI 1.0 Table 9-13: MMIO_ERR_CFG */
+#define SDXI_MMIO_ERR_CFG_EN BIT_ULL(0)
 
 #endif  /* DMA_SDXI_MMIO_H */
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index 0778cde31f14..6a293db69199 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -59,12 +59,36 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
 		return dev_err_probe(dev, PTR_ERR(sdxi->dbs),
 				     "failed to map doorbell region\n");
 
+	/* Mailbox registers are reserved without SR-IOV support. */
+	sdxi->has_mailbox = pdev->is_virtfn ||
+		pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+
 	pci_set_master(pdev);
 	return 0;
 }
 
+static int sdxi_pci_reset(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
+	int err;
+
+	/* Probe and remove hold the device lock; preserve PCI configuration. */
+	err = pci_reset_function_locked(pdev);
+	if (err) {
+		dev_err(&pdev->dev,
+			"function reset failed (%d), disabling bus mastering\n", err);
+		pci_clear_master(pdev);
+		if (!pci_wait_for_pending_transaction(pdev))
+			dev_warn(&pdev->dev,
+				 "PCIe transactions still pending after disabling bus mastering\n");
+	}
+
+	return err;
+}
+
 static const struct sdxi_bus_ops sdxi_pci_ops = {
 	.init = sdxi_pci_init,
+	.reset = sdxi_pci_reset,
 };
 
 static int sdxi_pci_probe(struct pci_dev *pdev,
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index d4c61ca2f875..bb0d2165d495 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -9,8 +9,12 @@
 #define DMA_SDXI_H
 
 #include <linux/compiler_types.h>
+#include <linux/dev_printk.h>
+#include <linux/io.h>
 #include <linux/types.h>
 
+#include "mmio.h"
+
 struct sdxi_dev;
 
 /**
@@ -23,6 +27,10 @@ struct sdxi_bus_ops {
 	 *        function initialization.
 	 */
 	int (*init)(struct sdxi_dev *sdxi);
+	/**
+	 * @reset: Bus-specific recovery when the native stop sequence fails.
+	 */
+	int (*reset)(struct sdxi_dev *sdxi);
 };
 
 struct sdxi_dev {
@@ -30,9 +38,21 @@ struct sdxi_dev {
 	void __iomem *ctrl_regs;	/* virt addr of ctrl registers */
 	void __iomem *dbs;		/* virt addr of doorbells */
 
+	bool has_mailbox;
+
 	const struct sdxi_bus_ops *bus_ops;
 };
 
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
 
+static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg reg)
+{
+	return readq(sdxi->ctrl_regs + reg);
+}
+
+static inline void sdxi_write64(struct sdxi_dev *sdxi, enum sdxi_reg reg, u64 val)
+{
+	writeq(val, sdxi->ctrl_regs + reg);
+}
+
 #endif /* DMA_SDXI_H */

-- 
2.56.0


