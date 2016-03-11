Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43959 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbcCKXyc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 18:54:32 -0500
Date: Fri, 11 Mar 2016 17:54:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: tegra: Support per-lane PHYs
Message-ID: <20160311235427.GI4725@localhost>
References: <1457452094-5409-1-git-send-email-thierry.reding@gmail.com>
 <1457452094-5409-2-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457452094-5409-2-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Stephen, you had some comments on the previous version.  What do you
think about this one?

On Tue, Mar 08, 2016 at 04:48:14PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The current XUSB pad controller bindings are insufficient to describe
> PHY devices attached to USB controllers. New bindings have been created
> to overcome these restrictions. As a side-effect each root port now is
> assigned a set of PHY devices, one for each lane associated with the
> root port. This has the benefit of allowing fine-grained control of the
> power management for each lane.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ...

>  static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  {
>  	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> @@ -883,14 +905,24 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  		afi_writel(pcie, value, AFI_FUSE);
>  	}
>  
> -	if (!pcie->phy)
> -		err = tegra_pcie_phy_enable(pcie);
> -	else
> -		err = phy_power_on(pcie->phy);
> +	if (!pcie->legacy_phy) {
> +		list_for_each_entry(port, &pcie->ports, list) {
> +			err = tegra_pcie_port_phy_power_on(port);
> +			if (err < 0) {
> +				dev_err(pcie->dev,
> +					"failed to power on PCIe port: %d\n",
> +					err);
> +				return err;
> +			}
> +		}
> +	} else {
> +		if (!pcie->phy)
> +			err = tegra_pcie_phy_enable(pcie);
> +		else
> +			err = phy_power_on(pcie->phy);
>  
> -	if (err < 0) {
> -		dev_err(pcie->dev, "failed to power on PHY: %d\n", err);
> -		return err;
> +		if (err < 0)
> +			dev_err(pcie->dev, "failed to power on PHY: %d\n", err);

In the legacy_phy case, we used to bail out if tegra_pcie_phy_enable()
or phy_power_on() failed, but now we don't.  I assume this is an
unintentional change.

I would personally write this as follows because I hate reading
"if (!xxx) ... else ..." (this patch applies on top of the one you
posted).  Note that this restores the legacy_phy error path also.


diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 625db7d..139b9ca 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -882,6 +882,31 @@ static int tegra_pcie_port_phy_power_on(struct tegra_pcie_port *port)
 	return 0;
 }
 
+static int tegra_pcie_port_phy_enable(struct tegra_pcie *pcie)
+{
+	if (pcie->legacy_phy) {
+		if (pcie->phy)
+			err = phy_power_on(pcie->phy);
+		else
+			err = tegra_pcie_phy_enable(pcie);
+
+		if (err < 0)
+			dev_err(pcie->dev, "failed to power on PHY: %d\n", err);
+
+		return err;
+	}
+
+	list_for_each_entry(port, &pcie->ports, list) {
+		err = tegra_pcie_port_phy_power_on(port);
+		if (err < 0) {
+			dev_err(pcie->dev, "failed to power on PCIe port: %d\n",
+				err);
+			return err;
+		}
+	}
+	return 0;
+}
+
 static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 {
 	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
@@ -921,25 +946,9 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 		afi_writel(pcie, value, AFI_FUSE);
 	}
 
-	if (!pcie->legacy_phy) {
-		list_for_each_entry(port, &pcie->ports, list) {
-			err = tegra_pcie_port_phy_power_on(port);
-			if (err < 0) {
-				dev_err(pcie->dev,
-					"failed to power on PCIe port: %d\n",
-					err);
-				return err;
-			}
-		}
-	} else {
-		if (!pcie->phy)
-			err = tegra_pcie_phy_enable(pcie);
-		else
-			err = phy_power_on(pcie->phy);
-
-		if (err < 0)
-			dev_err(pcie->dev, "failed to power on PHY: %d\n", err);
-	}
+	err = tegra_pcie_port_phy_enable(pcie);
+	if (err < 0)
+		return err;
 
 	/* take the PCIe interface module out of reset */
 	reset_control_deassert(pcie->pcie_xrst);
