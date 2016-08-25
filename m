Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755386AbcHYNmQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Aug 2016 09:42:16 -0400
Date: Thu, 25 Aug 2016 08:41:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/2] PCI: rockchip: fix broken ASPM due to incorrect
 L1PwrOnSc/Val
Message-ID: <20160825134144.GA11257@localhost>
References: <1472112214-31550-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472112214-31550-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 25, 2016 at 04:03:34PM +0800, Shawn Lin wrote:
> This is a bug of controller found recently which makes the
> default values of L1PwrOnSc and L1PwrOnVal unreliable when
> enabling ASPM. We could work around this by reading L1 substate
> control 2 register and then write back the value again.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

My pci/host-rockchip branch hasn't been merged anywhere, so I just folded
both these patches into the original commits.

> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 1671d02..ed782b51 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -40,6 +40,7 @@
>  #define PCIE_CLIENT_BASE			0x0
>  #define PCIE_RC_CONFIG_NORMAL_BASE		0x800000
>  #define PCIE_RC_CONFIG_BASE			0xa00000
> +#define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2	0x90c
>  #define PCIE_RC_CONFIG_LCSR			0xd0
>  #define  PCIE_RC_CONFIG_LCSR_LBMIE		BIT(10)
>  #define  PCIE_RC_CONFIG_LCSR_LABIE		BIT(11)
> @@ -477,6 +478,18 @@ static int rockchip_pcie_init_port(struct rockchip_pcie_port *port)
>  		return err;
>  	}
>  
> +	/*
> +	 * We need to read/write PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2
> +	 * before enabling ASPM. Otherwise L1PwrOnSc and L1PwrOnVal isn't
> +	 * reliable which makes the controller in broken state when
> +	 * enabling ASPM. This is a controller's bug we need to work
> +	 * around.
> +	 */
> +	status = pcie_read(port,  PCIE_RC_CONFIG_BASE +
> +				  PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
> +	pcie_write(port, status,  PCIE_RC_CONFIG_BASE +
> +				  PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
> +
>  	/* Enable Gen1 training */
>  	pcie_write(port,
>  		   HIWORD_UPDATE(PCIE_CLIENT_LINK_TRAIN_ENABLE,
> -- 
> 2.3.7
> 
> 
