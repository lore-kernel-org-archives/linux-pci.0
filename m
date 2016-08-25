Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] PCI: rockchip: fix broken ASPM due to incorrect L1PwrOnSc/Val
Date: Thu, 25 Aug 2016 16:03:34 +0800
Message-Id: <1472112214-31550-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a bug of controller found recently which makes the
default values of L1PwrOnSc and L1PwrOnVal unreliable when
enabling ASPM. We could work around this by reading L1 substate
control 2 register and then write back the value again.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 1671d02..ed782b51 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -40,6 +40,7 @@
 #define PCIE_CLIENT_BASE			0x0
 #define PCIE_RC_CONFIG_NORMAL_BASE		0x800000
 #define PCIE_RC_CONFIG_BASE			0xa00000
+#define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2	0x90c
 #define PCIE_RC_CONFIG_LCSR			0xd0
 #define  PCIE_RC_CONFIG_LCSR_LBMIE		BIT(10)
 #define  PCIE_RC_CONFIG_LCSR_LABIE		BIT(11)
@@ -477,6 +478,18 @@ static int rockchip_pcie_init_port(struct rockchip_pcie_port *port)
 		return err;
 	}
 
+	/*
+	 * We need to read/write PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2
+	 * before enabling ASPM. Otherwise L1PwrOnSc and L1PwrOnVal isn't
+	 * reliable which makes the controller in broken state when
+	 * enabling ASPM. This is a controller's bug we need to work
+	 * around.
+	 */
+	status = pcie_read(port,  PCIE_RC_CONFIG_BASE +
+				  PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
+	pcie_write(port, status,  PCIE_RC_CONFIG_BASE +
+				  PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
+
 	/* Enable Gen1 training */
 	pcie_write(port,
 		   HIWORD_UPDATE(PCIE_CLIENT_LINK_TRAIN_ENABLE,
-- 
2.3.7
