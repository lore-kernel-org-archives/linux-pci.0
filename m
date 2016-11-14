Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:37396 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966169AbcKNELy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2016 23:11:54 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RESEND PATCH 2/2] PCI: rockchip: Add quirk to disable RC's ASPM L0s
Date: Mon, 14 Nov 2016 12:11:06 +0800
Message-Id: <1479096666-112668-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1479096666-112668-1-git-send-email-shawn.lin@rock-chips.com>
References: <1479096666-112668-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rockchip's RC outputs 100MHz reference clock but there are
two methods for PHY to generate it.

(1)One of them is to use system PLL to generate 100MHz clock and
the PHY will relock it and filter signal noise then outputs the
reference clock.

(2)Another way is to share Soc's 24MHZ crystal oscillator with
PHY and force PHY's DLL to generate 100MHz internally.

When using case(2), the exit from L0s doesn't work fine occasionally
due to the broken design of RC receiver's logical circuit. So even if
we use extended-synch, it still fails for PHY to relock the bits from
FTS sometimes. This will hang the system.

Maybe we could argue that why not use case(1) to avoid it? The reason
is that as we could see the reference clock is derived from system PLL
and the path from it to PHY isn't so clean which means there are some
noise introduced by power-domain and other buses can't be filterd out
by PHY and we could see noise from the frequency spectrum by oscilloscope.
This makes the TX compatibility test a little difficult to pass the spec.
So case(1) and case(2) are both used indeed now. If using case(2), we
should disable RC's L0s support, and that is why we need this property to
indicate this quirk.

Also after checking quirk.c, I noticed there is already a quirk for
disabling L0s unconditionally, quirk_disable_aspm_l0s. But obviously we
shouldn't do that as mentioned above that case(1) could still works fine
with L0s.

Reported-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 Documentation/devicetree/bindings/pci/rockchip-pcie.txt | 2 ++
 drivers/pci/host/pcie-rockchip.c                        | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
index ba67b39..cfa44a7 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
@@ -42,6 +42,8 @@ Required properties:
 Optional Property:
 - ep-gpios: contain the entry for pre-reset gpio
 - num-lanes: number of lanes to use
+- quirk,aspm-no-l0s: RC won't support ASPM L0s. This property is needed if
+	using 24MHz OSC for RC's PHY.
 - vpcie3v3-supply: The phandle to the 3.3v regulator to use for PCIe.
 - vpcie1v8-supply: The phandle to the 1.8v regulator to use for PCIe.
 - vpcie0v9-supply: The phandle to the 0.9v regulator to use for PCIe.
diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 1dba698..9b7d921 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -140,6 +140,8 @@
 #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
 #define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
 #define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
+#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
+#define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
 #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
@@ -607,6 +609,13 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	status &= ~PCIE_RC_CONFIG_THP_CAP_NEXT_MASK;
 	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_THP_CAP);
 
+	/* Clear L0s from RC's link cap */
+	if (of_property_read_bool(dev->of_node, "quirk,apsm-no-l0s")) {
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LINK_CAP);
+		status &= ~PCIE_RC_CONFIG_LINK_CAP_L0S;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LINK_CAP);
+	}
+
 	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
 
 	rockchip_pcie_write(rockchip,
-- 
1.9.1


