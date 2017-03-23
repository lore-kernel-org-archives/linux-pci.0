Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 23 Mar 2017 17:27:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/5] PCI: rockchip: fix sign issues for current limits
Message-ID: <20170323222717.GD23612@bhelgaas-glaptop.roam.corp.google.com>
References: <20170310024617.67303-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170310024617.67303-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 09, 2017 at 06:46:13PM -0800, Brian Norris wrote:
> The regulator framework can return negative error codes via
> regulator_get_current_limit() for regulators that don't provide current
> information. The subsequent check for postive values isn't very useful,
> if the variable is unsigned.
> 
> Let's just match the signedness of the return value.
> 
> Prevents error messages like this, seen on Samsung Chromebook Plus:
> 
> [    1.069372] rockchip-pcie f8000000.pcie: invalid power supply
> 
> Fixes: 4816c4c7b82b ("PCI: rockchip: Provide captured slot power limit and scale")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

I applied the first two patches (this already has Shawn's ack and the
second is trivially obvious) to pci/host-rockchip.  I'm not sure what the
current state of the others is.

I also applied the appended trivial indentation patch.

> ---
> v2: add Shawn's ack
> ---
>  drivers/pci/host/pcie-rockchip.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 26ddd3535272..d785f64ec03b 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -425,7 +425,8 @@ static struct pci_ops rockchip_pcie_ops = {
>  
>  static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
>  {
> -	u32 status, curr, scale, power;
> +	int curr;
> +	u32 status, scale, power;
>  
>  	if (IS_ERR(rockchip->vpcie3v3))
>  		return;
> -- 
> 2.12.0.246.ga2ecc84866-goog
> 

commit 73edd2b180a18024605c599074596a9e22d745d6
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Mar 23 17:21:26 2017 -0500

    PCI: rockchip: Unindent rockchip_pcie_set_power_limit()
    
    If regulator_get_current_limit() returns 0 or error, return early so the
    body of the function doesn't have to be indented as the body of an "if"
    statement.  No functional change intended.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index d785f64ec03b..7f76ff6af0ba 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -438,24 +438,25 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 	 * to the actual power supply.
 	 */
 	curr = regulator_get_current_limit(rockchip->vpcie3v3);
-	if (curr > 0) {
-		scale = 3; /* 0.001x */
-		curr = curr / 1000; /* convert to mA */
-		power = (curr * 3300) / 1000; /* milliwatt */
-		while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
-			if (!scale) {
-				dev_warn(rockchip->dev, "invalid power supply\n");
-				return;
-			}
-			scale--;
-			power = power / 10;
-		}
+	if (curr <= 0)
+		return;
 
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCR);
-		status |= (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
-			  (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
+	scale = 3; /* 0.001x */
+	curr = curr / 1000; /* convert to mA */
+	power = (curr * 3300) / 1000; /* milliwatt */
+	while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
+		if (!scale) {
+			dev_warn(rockchip->dev, "invalid power supply\n");
+			return;
+		}
+		scale--;
+		power = power / 10;
 	}
+
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCR);
+	status |= (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
+		  (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
 }
 
 /**
