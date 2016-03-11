Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57939 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbcCKSi1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 13:38:27 -0500
Date: Fri, 11 Mar 2016 12:38:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/keystone: check return value of devm_phy_get with
 EPROBE_DEFER
Message-ID: <20160311183823.GE4725@localhost>
References: <1457325141-1354-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457325141-1354-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 07, 2016 at 12:32:21PM +0800, Shawn Lin wrote:
> If the return value of devm_phy_get is EPROBE_DEFER, we should
> defer probing the driver.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/host-keystone for v4.6 with the following changelog.
Thanks, Shawn!

    PCI: keystone: Defer probing if devm_phy_get() returns -EPROBE_DEFER
    
    A SerDes PHY is optional, so if devm_phy_get() doesn't find one at all,
    that's fine.  But if devm_phy_get() finds a PHY that doesn't have a driver
    yet, it returns -EPROBE_DEFER.  In that case, defer probing the Keystone
    driver.  We may be able to load it later after a PHY driver is loaded.
    
    [bhelgaas: changelog]
    Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> 
>  drivers/pci/host/pci-keystone.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> index 0aa81bd..42af6ac 100644
> --- a/drivers/pci/host/pci-keystone.c
> +++ b/drivers/pci/host/pci-keystone.c
> @@ -363,6 +363,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  		ret = phy_init(phy);
>  		if (ret < 0)
>  			return ret;
> +	} else if (PTR_ERR(phy) == -EPROBE_DEFER) {
> +		return PTR_ERR(phy);
>  	}
>  
>  	/* index 2 is to read PCI DEVICE_ID */
> -- 
> 2.3.7
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
