Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36442 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbbGNULE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 16:11:04 -0400
Received: by obnw1 with SMTP id w1so13217836obn.3
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 13:11:04 -0700 (PDT)
Date: Tue, 14 Jul 2015 15:10:59 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] PCI-iproc: Delete unnecessary checks before two function
 calls
Message-ID: <20150714201059.GG24416@google.com>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <55900A20.5070407@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55900A20.5070407@users.sourceforge.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 28, 2015 at 04:52:16PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 28 Jun 2015 16:42:04 +0200
> 
> The functions phy_exit() and phy_power_off() test whether their argument
> is NULL and then return immediately.
> Thus the test around the calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I haven't seen a followup to Ray's review, but in the interest of making
progress, I updated and applied the patch as appended.  I also reviewed
other phy_*() calls under drivers/pci, and they all look OK (with no
unnecessary tests for NULL).

This is on the pci/host-iproc branch for v4.3.

> ---
>  drivers/pci/host/pcie-iproc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index d77481e..f875821 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -239,12 +239,9 @@ err_rm_root_bus:
>  	pci_remove_root_bus(bus);
>  
>  err_power_off_phy:
> -	if (pcie->phy)
> -		phy_power_off(pcie->phy);
> +	phy_power_off(pcie->phy);
>  err_exit_phy:
> -	if (pcie->phy)
> -		phy_exit(pcie->phy);
> -
> +	phy_exit(pcie->phy);
>  	return ret;
>  }
>  EXPORT_SYMBOL(iproc_pcie_setup);
> -- 
> 2.4.4

commit 55b5e16332eb9ffc1cbaf975585f4521417ab427
Author: Markus Elfring <elfring@users.sourceforge.net>
Date:   Sun Jun 28 16:42:04 2015 +0200

    PCI: iproc: Delete unnecessary checks before phy calls
    
    The functions phy_exit() and phy_power_off() test whether their argument is
    NULL and then return immediately.  Thus the test around the calls is not
    needed.
    
    This issue was detected by using the Coccinelle software.
    
    [bhelgaas: also phy_init() and phy_power_on(), as Ray Jui suggested]
    [bhelgaas: also remove tests in iproc_pcie_remove()]
    Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index d77481e..9a00dca 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -191,19 +191,16 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	if (!pcie || !pcie->dev || !pcie->base)
 		return -EINVAL;
 
-	if (pcie->phy) {
-		ret = phy_init(pcie->phy);
-		if (ret) {
-			dev_err(pcie->dev, "unable to initialize PCIe PHY\n");
-			return ret;
-		}
-
-		ret = phy_power_on(pcie->phy);
-		if (ret) {
-			dev_err(pcie->dev, "unable to power on PCIe PHY\n");
-			goto err_exit_phy;
-		}
+	ret = phy_init(pcie->phy);
+	if (ret) {
+		dev_err(pcie->dev, "unable to initialize PCIe PHY\n");
+		return ret;
+	}
 
+	ret = phy_power_on(pcie->phy);
+	if (ret) {
+		dev_err(pcie->dev, "unable to power on PCIe PHY\n");
+		goto err_exit_phy;
 	}
 
 	iproc_pcie_reset(pcie);
@@ -239,12 +236,9 @@ err_rm_root_bus:
 	pci_remove_root_bus(bus);
 
 err_power_off_phy:
-	if (pcie->phy)
-		phy_power_off(pcie->phy);
+	phy_power_off(pcie->phy);
 err_exit_phy:
-	if (pcie->phy)
-		phy_exit(pcie->phy);
-
+	phy_exit(pcie->phy);
 	return ret;
 }
 EXPORT_SYMBOL(iproc_pcie_setup);
@@ -254,10 +248,8 @@ int iproc_pcie_remove(struct iproc_pcie *pcie)
 	pci_stop_root_bus(pcie->root_bus);
 	pci_remove_root_bus(pcie->root_bus);
 
-	if (pcie->phy) {
-		phy_power_off(pcie->phy);
-		phy_exit(pcie->phy);
-	}
+	phy_power_off(pcie->phy);
+	phy_exit(pcie->phy);
 
 	return 0;
 }
