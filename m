Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932374AbdHYVSk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Aug 2017 17:18:40 -0400
Date: Fri, 25 Aug 2017 16:18:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v5 06/10] PCI: rockchip: fix missing phy manipulation for
 legacy phy
Message-ID: <20170825211832.GA8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
 <1503471777-73999-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503471777-73999-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 03:02:57PM +0800, Shawn Lin wrote:
> For instance, if a EP connect to lane3 and work under lagecy
> phy mode, so struct phy phys[0..2] are all NULL. In this case,
> rockchip->lanes_map & BIT(i) will tell the driver that lane0 is
> already inactive, but what we want actually is to power off
> the phys[0] for legacy phy mode. Fix this by add checking of
> rockchip->legacy_phy for rockchip_pcie_deinit_phys.

This changelog is not quite correct.  If "rockchip->legacy_phy", then
rockchip->phys[0] is a valid PHY, but phys[1..3] are NULL (not 0..2).

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/pci/host/pcie-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 9cd51e0..933e3e9 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -759,7 +759,7 @@ static void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip)
>  
>  	for (i = 0; i < MAX_LANE_NUM; i++) {
>  		/* inactive lane is already powered off */
> -		if (rockchip->lanes_map & BIT(i))
> +		if (rockchip->legacy_phy || rockchip->lanes_map & BIT(i))
>  			phy_power_off(rockchip->phys[i]);
>  		phy_exit(rockchip->phys[i]);
>  	}

I think this is harder to understand than necessary.  If we're using
legacy_phy, the pointer is in phys[0].  If we always set
rockchip->lanes_map, even in the legacy_phy case (where it would show
that only phys[0] is valid), this patch won't even be necessary.

I'd propose the following patches, which could be squashed into the
existing series on pci/host-rockchip.  The first is purely cosmetic,
as is some of the second.

The important part is this:

   static u8 rockchip_pcie_lane_map(struct rockchip_pcie *rockchip)
   {
  -       u32 val = rockchip_pcie_read(rockchip, PCIE_CORE_LANE_MAP);
  -       u8 map = val & PCIE_CORE_LANE_MAP_MASK;
  +       u32 val;
  +       u8 map;
  +
  +       if (rockchip->legacy_phy)
  +               return BIT(0);



commit d3d39c577edf63b9441d1a7614808e02721dd2b6
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Aug 25 16:00:25 2017 -0500

    Possibly squash into "PCI: rockchip: Add per-lane PHY support"

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index f8b88004e20f..5ccbdbfa97d0 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -867,24 +867,25 @@ static int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
 	char *name;
 	u32 i;
 
-	rockchip->phys[0] = devm_phy_get(dev, "pcie-phy");
-	if (IS_ERR(rockchip->phys[0])) {
-		if (PTR_ERR(rockchip->phys[0]) == -EPROBE_DEFER)
-			return PTR_ERR(rockchip->phys[0]);
-		dev_dbg(dev, "missing legacy phy; search for per-lane PHY\n");
-	} else {
+	phy = devm_phy_get(dev, "pcie-phy");
+	if (!IS_ERR(phy)) {
 		rockchip->legacy_phy = true;
+		rockchip->phys[0] = phy;
 		dev_warn(dev, "legacy phy model is deprecated!\n");
 		return 0;
 	}
 
+	if (PTR_ERR(phy) == -EPROBE_DEFER)
+		return PTR_ERR(phy);
+
+	dev_dbg(dev, "missing legacy phy; search for per-lane PHY\n");
+
 	for (i = 0; i < MAX_LANE_NUM; i++) {
 		name = kasprintf(GFP_KERNEL, "pcie-phy-%u", i);
 		if (!name)
 			return -ENOMEM;
 
-		phy = devm_of_phy_get(rockchip->dev,
-				      rockchip->dev->of_node, name);
+		phy = devm_of_phy_get(dev, dev->of_node, name);
 		kfree(name);
 
 		if (IS_ERR(phy)) {
commit 6f8bcdfe4568809437e93e2d54e68b2cba3b4ac4
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Aug 25 15:39:10 2017 -0500

    Possibly squash into "PCI: rockchip: Idle inactive PHY(s)"

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 60069acd9f86..29ebfc971896 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -309,8 +309,14 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
 
 static u8 rockchip_pcie_lane_map(struct rockchip_pcie *rockchip)
 {
-	u32 val = rockchip_pcie_read(rockchip, PCIE_CORE_LANE_MAP);
-	u8 map = val & PCIE_CORE_LANE_MAP_MASK;
+	u32 val;
+	u8 map;
+
+	if (rockchip->legacy_phy)
+		return BIT(0);
+
+	val = rockchip_pcie_read(rockchip, PCIE_CORE_LANE_MAP);
+	map = val & PCIE_CORE_LANE_MAP_MASK;
 
 	/* The link may be using a reverse-indexed mapping. */
 	if (val & PCIE_CORE_LANE_MAP_REVERSE)
@@ -715,13 +721,10 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 			  PCIE_CORE_PL_CONF_LANE_SHIFT);
 	dev_dbg(dev, "current link width is x%d\n", status);
 
-	if (!rockchip->legacy_phy) {
-		/*  power off unused lane(s) */
-		rockchip->lanes_map = rockchip_pcie_lane_map(rockchip);
-		for (i = 0; i < MAX_LANE_NUM; i++) {
-			if (rockchip->lanes_map & BIT(i))
-				continue;
-
+	/* Power off unused lane(s) */
+	rockchip->lanes_map = rockchip_pcie_lane_map(rockchip);
+	for (i = 0; i < MAX_LANE_NUM; i++) {
+		if (!(rockchip->lanes_map & BIT(i))) {
 			dev_dbg(dev, "idling lane %d\n", i);
 			phy_power_off(rockchip->phys[i]);
 		}
@@ -1378,7 +1381,7 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 	}
 
 	for (i = 0; i < MAX_LANE_NUM; i++) {
-		/* inactive lane is already powered off */
+		/* inactive lanes are already powered off */
 		if (rockchip->lanes_map & BIT(i))
 			phy_power_off(rockchip->phys[i]);
 		phy_exit(rockchip->phys[i]);
@@ -1628,7 +1631,7 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 	irq_domain_remove(rockchip->irq_domain);
 
 	for (i = 0; i < MAX_LANE_NUM; i++) {
-		/* inactive lane is already powered off */
+		/* inactive lanes are already powered off */
 		if (rockchip->lanes_map & BIT(i))
 			phy_power_off(rockchip->phys[i]);
 		phy_exit(rockchip->phys[i]);
