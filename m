Received: from mail-m3269.qiye.163.com (mail-m3269.qiye.163.com [220.197.32.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A491531E8;
	Wed, 25 Mar 2026 02:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774406067; cv=none; b=irL53jsoYlhQAQRhppOph2I8iYv3ka3MkOUK/BY44Sy8bL01gH8iIyWrtbfZeCwIMilIqsnHE/BK55N6Gap6Ut4YP1Rb5UhetDLnfwAeWxLOzutbC5B5vHAPi1V/J9l+0G2Yzdjjextmq1+A5YShlr0Q1507Jt0gWliMPsmXDFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774406067; c=relaxed/simple;
	bh=xEPSg9x35pAm5jF0bqxjz5w5egKkzWVsk078GyOjTy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZYkOUAGSppNyDna+er0wqyhhp3zGvUt/L5LHxI9duRDJFWEONYaMTQok8njSzz7ClKGBKCKe2P2FJvWvpgjQ4D21BVb+R13xwvEvss6tChqwMB0cFDB4Ej4gIajSsqt55jsDAxzKd80aGs5rukD1HjEwUbAcsSwCLZQC/eVD154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gz89Ybf3; arc=none smtp.client-ip=220.197.32.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gz89Ybf3"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 382e78d8b;
	Wed, 25 Mar 2026 09:58:46 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition trace support
Date: Wed, 25 Mar 2026 09:58:32 +0800
Message-Id: <1774403912-210670-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com>
References: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d22b73a1309cckunm61c156f0a558ae
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMdTFYaGR9JSUtITxpOSR5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gz89Ybf3vXAzPkxRsV/sY2TRC/F1Qbuf1E1T8HZlGmzRAn3aNHv0Xl+P7Z7PriyaDTV+BS23CZIxnqYqxJAhaPatqmTSOJZEuujBevwYJRn8Qq8TSyw5eW7DL1s3DizcfhMPu7SH5zvTCs6JZVxSGXrOQ8CtX5ZCqRycMJp4zao=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=mVQ3wBTObZTHeiuagy3/HA6ngtLOnHt9udd3dqVawG4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Rockchip platforms provide a 64x4 bytes debug FIFO to trace the
LTSSM history. Any LTSSM change will be recorded. It's useful
for debug purpose, for example link failure, etc.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v5:
- rebase
- use trace_pcie_ltssm_state_transition_enabled()

Changes in v4:
- skip trace if pci_ltssm_tp_enabled() is false.(Steven)
- wrap into 80 columns(Bjorn)

Changes in v3:
- reorder variables(Mani)
- rename loop to i; rename en to enable(Mani)
- use FIELD_GET(Mani)
- add comment about how the FIFO works(Mani)

Changes in v2:
- use tracepoint

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 111 ++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index bb5d1a3..e737103 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -22,6 +22,8 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/workqueue.h>
+#include <trace/events/pci_controller.h>
 
 #include "../../pci.h"
 #include "pcie-designware.h"
@@ -73,6 +75,20 @@
 #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
 #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_2	BIT(5)
 
+/* Debug FIFO information */
+#define PCIE_CLIENT_DBG_FIFO_MODE_CON	0x310
+#define  PCIE_CLIENT_DBG_EN		0xffff0007
+#define  PCIE_CLIENT_DBG_DIS		0xffff0000
+#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0	0x320
+#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1	0x324
+#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0	0x328
+#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1	0x32c
+#define  PCIE_CLIENT_DBG_TRANSITION_DATA 0xffff0000
+#define PCIE_CLIENT_DBG_FIFO_STATUS	0x350
+#define  PCIE_DBG_FIFO_RATE_MASK	GENMASK(22, 20)
+#define  PCIE_DBG_FIFO_L1SUB_MASK	GENMASK(10, 8)
+#define PCIE_DBG_LTSSM_HISTORY_CNT	64
+
 /* Hot Reset Control Register */
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
 #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
@@ -98,6 +114,7 @@ struct rockchip_pcie {
 	struct irq_domain *irq_domain;
 	const struct rockchip_pcie_of_data *data;
 	bool supports_clkreq;
+	struct delayed_work trace_work;
 };
 
 struct rockchip_pcie_of_data {
@@ -208,6 +225,96 @@ static enum dw_pcie_ltssm rockchip_pcie_get_ltssm(struct dw_pcie *pci)
 	return rockchip_pcie_get_ltssm_reg(rockchip) & PCIE_LTSSM_STATUS_MASK;
 }
 
+#ifdef CONFIG_TRACING
+static void rockchip_pcie_ltssm_trace_work(struct work_struct *work)
+{
+	struct rockchip_pcie *rockchip = container_of(work,
+						struct rockchip_pcie,
+						trace_work.work);
+	struct dw_pcie *pci = &rockchip->pci;
+	enum dw_pcie_ltssm state;
+	u32 i, l1ss, prev_val = DW_PCIE_LTSSM_UNKNOWN, rate, val;
+
+	if (!trace_pcie_ltssm_state_transition_enabled())
+		goto skip_trace;
+
+	for (i = 0; i < PCIE_DBG_LTSSM_HISTORY_CNT; i++) {
+		val = rockchip_pcie_readl_apb(rockchip,
+				PCIE_CLIENT_DBG_FIFO_STATUS);
+		rate = FIELD_GET(PCIE_DBG_FIFO_RATE_MASK, val);
+		l1ss = FIELD_GET(PCIE_DBG_FIFO_L1SUB_MASK, val);
+		val = FIELD_GET(PCIE_LTSSM_STATUS_MASK, val);
+
+		/*
+		 * Hardware Mechanism: The ring FIFO employs two tracking
+		 * counters:
+		 * - 'last-read-point': maintains the user's last read position
+		 * - 'last-valid-point': tracks the HW's last state update
+		 *
+		 * Software Handling: When two consecutive LTSSM states are
+		 * identical, it indicates invalid subsequent data in the FIFO.
+		 * In this case, we skip the remaining entries. The dual counter
+		 * design ensures that on the next state transition, reading can
+		 * resume from the last user position.
+		 */
+		if ((i > 0 && val == prev_val) || val > DW_PCIE_LTSSM_RCVRY_EQ3)
+			break;
+
+		state = prev_val = val;
+		if (val == DW_PCIE_LTSSM_L1_IDLE) {
+			if (l1ss == 2)
+				state = DW_PCIE_LTSSM_L1_2;
+			else if (l1ss == 1)
+				state = DW_PCIE_LTSSM_L1_1;
+		}
+
+		trace_pcie_ltssm_state_transition(dev_name(pci->dev),
+				dw_pcie_ltssm_status_string(state),
+				((rate + 1) > pci->max_link_speed) ?
+				PCI_SPEED_UNKNOWN : PCIE_SPEED_2_5GT + rate);
+	}
+
+skip_trace:
+	schedule_delayed_work(&rockchip->trace_work, msecs_to_jiffies(5000));
+}
+
+static void rockchip_pcie_ltssm_trace(struct rockchip_pcie *rockchip,
+				      bool enable)
+{
+	if (enable) {
+		rockchip_pcie_writel_apb(rockchip,
+					 PCIE_CLIENT_DBG_TRANSITION_DATA,
+					 PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0);
+		rockchip_pcie_writel_apb(rockchip,
+					 PCIE_CLIENT_DBG_TRANSITION_DATA,
+					 PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1);
+		rockchip_pcie_writel_apb(rockchip,
+					 PCIE_CLIENT_DBG_TRANSITION_DATA,
+					 PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0);
+		rockchip_pcie_writel_apb(rockchip,
+					 PCIE_CLIENT_DBG_TRANSITION_DATA,
+					 PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1);
+		rockchip_pcie_writel_apb(rockchip,
+					 PCIE_CLIENT_DBG_EN,
+					 PCIE_CLIENT_DBG_FIFO_MODE_CON);
+
+		INIT_DELAYED_WORK(&rockchip->trace_work,
+				  rockchip_pcie_ltssm_trace_work);
+		schedule_delayed_work(&rockchip->trace_work, 0);
+	} else {
+		rockchip_pcie_writel_apb(rockchip,
+					 PCIE_CLIENT_DBG_DIS,
+					 PCIE_CLIENT_DBG_FIFO_MODE_CON);
+		cancel_delayed_work_sync(&rockchip->trace_work);
+	}
+}
+#else
+static void rockchip_pcie_ltssm_trace(struct rockchip_pcie *rockchip,
+				      bool enable)
+{
+}
+#endif
+
 static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
@@ -291,6 +398,9 @@ static int rockchip_pcie_start_link(struct dw_pcie *pci)
 	 * 100us as we don't know how long should the device need to reset.
 	 */
 	msleep(PCIE_T_PVPERL_MS);
+
+	rockchip_pcie_ltssm_trace(rockchip, true);
+
 	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
 
 	return 0;
@@ -301,6 +411,7 @@ static void rockchip_pcie_stop_link(struct dw_pcie *pci)
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 
 	rockchip_pcie_disable_ltssm(rockchip);
+	rockchip_pcie_ltssm_trace(rockchip, false);
 }
 
 static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
-- 
2.7.4

