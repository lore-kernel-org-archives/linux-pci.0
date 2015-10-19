Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 20 Oct 2015 04:46:26 +0800
From: kbuild test robot <lkp@intel.com>
To: WingMan Kwok <w-kwok2@ti.com>
Cc: kbuild-all@01.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, kishon@ti.com, rogerq@ti.com,
	m-karicheri2@ti.com, bhelgaas@google.com, ssantosh@kernel.org,
	linux@arm.linux.org.uk, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, WingMan Kwok <w-kwok2@ti.com>
Subject: [RFC PATCH] phy: keystone: ks2_gbe_serdes_firmwares[] can be static
Message-ID: <20151019204626.GA42156@athens>
References: <201510200459.7i1D4X2p%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445281040-14742-2-git-send-email-w-kwok2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 phy-keystone-serdes.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/phy-keystone-serdes.c b/drivers/phy/phy-keystone-serdes.c
index ee1cda7..e34201c 100644
--- a/drivers/phy/phy-keystone-serdes.c
+++ b/drivers/phy/phy-keystone-serdes.c
@@ -209,9 +209,9 @@
  * Newest first. Search starts from the 0-th array entry until a firmware
  * file is found.
  */
-const char *ks2_gbe_serdes_firmwares[] = {"ks2_gbe_serdes.bin"};
-const char *ks2_xgbe_serdes_firmwares[] = {"ks2_xgbe_serdes.bin"};
-const char *ks2_pcie_serdes_firmwares[] = {"ks2_pcie_serdes.bin"};
+static const char *ks2_gbe_serdes_firmwares[] = {"ks2_gbe_serdes.bin"};
+static const char *ks2_xgbe_serdes_firmwares[] = {"ks2_xgbe_serdes.bin"};
+static const char *ks2_pcie_serdes_firmwares[] = {"ks2_pcie_serdes.bin"};
 
 /* SERDES Link Rate Kbps */
 enum KSERDES_LINK_RATE {
@@ -933,7 +933,7 @@ done:
 	return val;
 }
 
-int kserdes_get_status(struct kserdes_config *sc)
+static int kserdes_get_status(struct kserdes_config *sc)
 {
 	unsigned long timeout;
 
@@ -1568,7 +1568,7 @@ static void kserdes_att_boost_phy_patch(struct kserdes_config *sc)
 		for_each_lane(kserdes_att_boost_phyb_patch, sc);
 }
 
-int kserdes_sgmii_lanes_enable(struct kserdes_config *sc)
+static int kserdes_sgmii_lanes_enable(struct kserdes_config *sc)
 {
 	int ret, i;
 	u32 val, lanes_enable = 0;
