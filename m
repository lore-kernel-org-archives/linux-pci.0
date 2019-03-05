Return-Path: <SRS0=Jbu+=RI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472FBC43381
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 21:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C15205F4
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 21:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfCEVO1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:14:27 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:44131 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCEVO1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Mar 2019 16:14:27 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 4D519240005;
        Tue,  5 Mar 2019 21:14:23 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH] PCI: aardvark: Use LTSSM state to build link training flag
Date:   Tue,  5 Mar 2019 22:23:25 +0100
Message-Id: <20190305212325.30602-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI_EXP_LNKSTA_LT flag in the emulated root device's PCI_EXP_LNKSTA
config register does not reflect the actual link training state and is
always cleared. The Link Training and Status State Machine (LTSSM) flag
in LMI config register could be used as a link training indicator.
Indeed if the LTSSM is in L0 or upper state then link training has
completed (see [1]).

Unfortunately because setting the PCI_EXP_LINCTL_RL flag does not
instantly imply a LTSSM state change (e.g. L0s to recovery state
transition takes some time), LTSSM can be in L0 but link training has
not finished yet. Thus a lower L0 LTSSM state followed by a L0 or upper
state sequence has to be seen to be sure that link training has been
done.

Because one may not call a pcie conf register read on LNKSTA after
doing a retrain link or may miss the link down state due to timing, a
20ms timeout is used. Passing this timeout link is considered retrained.

This fixes boot hang or kernel panic with the following callstack due to
ASPM setup doing a link re-train and polling for PCI_EXP_LNKSTA_LT flag
to be cleared before using it.

-------------------- 8< -------------------
	[    0.915389]  dump_backtrace+0x0/0x140
	[    0.915391]  show_stack+0x14/0x20
	[    0.915393]  dump_stack+0x90/0xb4
	[    0.915394]  panic+0x134/0x2c0
	[    0.915396]  nmi_panic+0x6c/0x70
	[    0.915398]  arm64_serror_panic+0x74/0x80
	[    0.915400]  is_valid_bugaddr+0x0/0x8
	[    0.915402]  el1_error+0x7c/0xe4
	[    0.915404]  advk_pcie_rd_conf+0x4c/0x250
	[    0.915406]  pci_bus_read_config_word+0x7c/0xd0
	[    0.915408]  pcie_capability_read_word+0x90/0xc8
	[    0.915410]  pcie_get_aspm_reg+0x68/0x118
	[    0.915412]  pcie_aspm_init_link_state+0x460/0xa98
	[    0.915414]  pci_scan_slot+0xe8/0x100
	[    0.915416]  pci_scan_child_bus_extend+0x50/0x288
	[    0.915418]  pci_scan_bridge_extend+0x348/0x4f0
	[    0.915420]  pci_scan_child_bus_extend+0x1dc/0x288
	[    0.915423]  pci_scan_root_bus_bridge+0xc4/0xe0
	[    0.915424]  pci_host_probe+0x14/0xa8
	[    0.915426]  advk_pcie_probe+0x838/0x910
	[...]
-------------------- 8< -------------------

[1] "PCI Express Base Specification", REV. 2.1
    PCI Express, March 4 2009, Table 4-7

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
Beside the lack of publicly available documentation I tried to find a
better workaround for this. But after having monitored every defined
registers, none seemed to reflect the actual link training state.
Vendor has been contacted about this issue about a month ago.
---
 drivers/pci/controller/pci-aardvark.c | 30 ++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index eb58dfdaba1b..a30ae7cf8e7e 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -180,6 +180,7 @@
 #define LINK_WAIT_MAX_RETRIES		10
 #define LINK_WAIT_USLEEP_MIN		90000
 #define LINK_WAIT_USLEEP_MAX		100000
+#define LINK_RETRAIN_DELAY_MAX		(20 * HZ / 1000) /* 20 ms */
 
 #define MSI_IRQ_NUM			32
 
@@ -199,6 +200,8 @@ struct advk_pcie {
 	u16 msi_msg;
 	int root_bus_nr;
 	struct pci_bridge_emul bridge;
+	unsigned long rl_deadline; /* Retrain link jiffies deadline */
+	u8 retraining; /* Retraining has been asked and is in transition */
 };
 
 static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
@@ -400,6 +403,19 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
+static int advk_pcie_link_retraining(struct advk_pcie *pcie)
+{
+	if (!advk_pcie_link_up(pcie)) {
+		pcie->retraining = 0;
+		return 1;
+	}
+
+	if (pcie->retraining && time_before(jiffies, pcie->rl_deadline))
+		return 1;
+
+	pcie->retraining = 0;
+	return 0;
+}
 
 static pci_bridge_emul_read_status_t
 advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
@@ -426,11 +442,19 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		return PCI_BRIDGE_EMUL_HANDLED;
 	}
 
+	case PCI_EXP_LNKCTL: {
+		u32 val = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg) &
+			~(PCI_EXP_LNKSTA_LT << 16);
+		if (advk_pcie_link_retraining(pcie))
+			val |= (PCI_EXP_LNKSTA_LT << 16);
+		*value = val;
+		return PCI_BRIDGE_EMUL_HANDLED;
+	}
+
 	case PCI_CAP_LIST_ID:
 	case PCI_EXP_DEVCAP:
 	case PCI_EXP_DEVCTL:
 	case PCI_EXP_LNKCAP:
-	case PCI_EXP_LNKCTL:
 		*value = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
 		return PCI_BRIDGE_EMUL_HANDLED;
 	default:
@@ -449,6 +473,10 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 	case PCI_EXP_DEVCTL:
 	case PCI_EXP_LNKCTL:
 		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
+		if (new & PCI_EXP_LNKCTL_RL) {
+			pcie->retraining = 1;
+			pcie->rl_deadline = jiffies + LINK_RETRAIN_DELAY_MAX;
+		}
 		break;
 
 	case PCI_EXP_RTCTL:
-- 
2.20.1

