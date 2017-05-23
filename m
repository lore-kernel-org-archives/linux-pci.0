Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbdEWTme (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 May 2017 15:42:34 -0400
Date: Tue, 23 May 2017 14:42:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: Configure RC's MPS setting
Message-ID: <20170523194232.GC7241@bhelgaas-glaptop.roam.corp.google.com>
References: <1493887204-5501-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493887204-5501-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 04, 2017 at 04:40:04PM +0800, Shawn Lin wrote:
> The default value of MPS for RC is 128 bytes, but actually
> it could support 256 bytes. So this patch fix this issue.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/host-rockchip for v4.13, thanks!

This didn't apply cleanly on top of the previous restructuring
patches, so I'm attaching the patch as applied.  Let me know if you
want the MPS setting with the PCIE_RC_BAR_CONF instead of with the
PCIE_RC_CONFIG_LINK_CAP.

commit 60f8ed61a6bc729ba3367e6f1a2dd3a80c94cd73
Author: Shawn Lin <shawn.lin@rock-chips.com>
Date:   Tue May 23 14:32:56 2017 -0500

    PCI: rockchip: Configure RC's MPS setting
    
    The default value of MPS for RC is 128 bytes, but actually it could support
    256 bytes.  So this patch fixes this issue.
    
    Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index bf0ff579e515..2e832b1d6c24 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -146,6 +146,9 @@
 #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
 #define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
 #define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
+#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
+#define   PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
+#define   PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
 #define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
 #define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
 #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
@@ -701,6 +704,11 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LINK_CAP);
 	}
 
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCSR);
+	status &= ~PCIE_RC_CONFIG_DCSR_MPS_MASK;
+	status |= PCIE_RC_CONFIG_DCSR_MPS_256;
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
+
 	return 0;
 }
 

> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 0e020b6..a05fec5 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -146,6 +146,9 @@
>  #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
>  #define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
>  #define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
> +#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
> +#define   PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
> +#define   PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
>  #define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
>  #define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
>  #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
> @@ -664,6 +667,11 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LINK_CAP);
>  	}
>  
> +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCSR);
> +	status &= ~PCIE_RC_CONFIG_DCSR_MPS_MASK;
> +	status |= PCIE_RC_CONFIG_DCSR_MPS_256;
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
> +
>  	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
>  
>  	rockchip_pcie_write(rockchip,
> -- 
> 1.9.1
> 
> 
