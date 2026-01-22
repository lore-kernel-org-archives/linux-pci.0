Received: from mail-m15596.qiye.163.com (mail-m15596.qiye.163.com [101.71.155.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670113D3333;
	Thu, 22 Jan 2026 03:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769051901; cv=none; b=EVgkJWXH/13TT+x3HYHpn4C+X3oP4Rr07GJ2w4fHGwl7nHZcftJgsrjyMJ9VwTUQzAzkmeBGGo6+hFtolJxSxakh/qMou7s5HFra0EUZyzLnGHeLhtVggun8PZzbu9glKKx3zWuhZP0BWvlSTJ/76VqvpQsRDFMqnErUaMItti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769051901; c=relaxed/simple;
	bh=pc44sqvSMPtmfSnTXeIpdPs/ozZHJ2UK97Q1MRSHUOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rNZla3wx3X4IHKjVzDbqmxzs3GuD78S8FoU+nmEO1J41xgoK4IZlUeNPL68rmMhe8BfH11b2oqRGM1kMQI/PwrjqEE+PGqrlU6NVtsrJqKgJCa3rg2GwMNq1SfLFKDDOphCGnmTzLH+GlZs2xWHB69DcjO0spHA+OHzOWWFHd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dPz02LST; arc=none smtp.client-ip=101.71.155.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dPz02LST"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3184fafe6;
	Thu, 22 Jan 2026 10:02:35 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition trace support
Date: Thu, 22 Jan 2026 10:02:20 +0800
Message-Id: <1769047340-113287-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
References: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9be37070fe09cckunm8c44f6d054e5e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh0ZQlZJSU1IGBgZGB5KHxhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dPz02LSTeKFbb1Y5KOG4mqccKgZ3vkBzMA9jIMEhC44fAKlEhLiYTjM3s8y+QiMSRa87ofDmfQx7TUVQseE2t/LibDmELg8HF4uQmkMfXz+BF6ItWI+9pz7dK44tmRmYhCzOsmwyfh6/r1q055zs9D9bI7RKNHnRHeh+eKRd2SQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=3IriWBu0NO6ZjqkCv7pP5bxw/S+T2xzX6jT2gTaB0G8=;
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
index 0fd7bb9..135326c 100644
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
+	if (!pci_ltssm_tp_enabled())
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

