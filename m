Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 11/15] Rename PCIE_CORE_RC_CONF_SCC_SHIFT to match
 similar definitions.
To: Shawn Lin <shawn.lin@rock-chips.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Date: Fri, 02 Sep 2016 10:55:27 -0500
Message-ID: <20160902155527.8650.70814.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


---
 drivers/pci/host/pcie-rockchip.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index fe1b52f..88c16da 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -121,7 +121,7 @@
 
 #define PCIE_RC_CONFIG_BASE		0xa00000
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
-#define  PCIE_CORE_RC_CONF_SCC_SHIFT		16
+#define  PCIE_RC_CONFIG_SCC_SHIFT		16
 #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
 #define  PCIE_RC_CONFIG_LCS_RETRAIN_LINK	BIT(5)
 #define  PCIE_RC_CONFIG_LCS_LBMIE		BIT(10)
@@ -545,7 +545,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
 			    PCIE_RC_CONFIG_BASE);
 	rockchip_pcie_write(rockchip,
-			    PCI_CLASS_BRIDGE_PCI << PCIE_CORE_RC_CONF_SCC_SHIFT,
+			    PCI_CLASS_BRIDGE_PCI << PCIE_RC_CONFIG_SCC_SHIFT,
 			    PCIE_RC_CONFIG_RID_CCR);
 	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
 
