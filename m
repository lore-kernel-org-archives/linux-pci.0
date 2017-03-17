Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34906 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdCQSXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2017 14:23:46 -0400
Received: by mail-pg0-f51.google.com with SMTP id b129so47104308pgc.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Mar 2017 11:23:35 -0700 (PDT)
Date: Fri, 17 Mar 2017 11:23:31 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: Mark SLC bit as well as CCC bit for RCg
Message-ID: <20170317182331.GA36848@google.com>
References: <1489735493-148838-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489735493-148838-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On Fri, Mar 17, 2017 at 03:24:53PM +0800, Shawn Lin wrote:
> lspci traces CCC to see if the end-2-end supports common
> clock, so the current code should work as we mark the CCC bit
> of RC. However, ASPM code actually check SLC bit of RC and try to
> compare it with the downstream components' SLC instead. So when
> enabling ASPM, CCC will be cleared after failing to match SLC with
> the corresponding bit of downstream components. On one hand, from the
> code of pcie_aspm_configure_common_clock, we could find that what we
> actually need to set is SLC. On the other hand, we should also guarantee
> that CCC should be marked w/o supporting ASPM. This patch fixes this
> issue.

This matches my understanding of the code more or less.

This fixes the Common Clock bit for me, with ASPM enabled on the Google
Kevin board; and my EndPoint (Marvell 8997) even reports a lower ASPM
L0s latency now. Nice! Thanks for the patch.

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

Personally, I might even mark this as:

Fixes: b8ab8e041cc0 ("PCI: rockchip: Mark RC as common clock architecture")

Not that it necessarily deserves -stable, but it helps people browsing
the logs, and wondering why the above commit doesn't seem to take effect
:)

> Cc: Brian Norris <briannorris@chromium.org>
> Cc: jeffy.chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 26ddd35..7cd4d5c 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -596,7 +596,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  
>  	/* Set RC's clock architecture as common clock */
>  	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> -	status |= PCI_EXP_LNKCTL_CCC;
> +	status |= (PCI_EXP_LNKCTL_CCC | PCI_EXP_LNKSTA_SLC << 16);
>  	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
>  
>  	/* Enable Gen1 training */
> -- 
> 1.9.1
> 
> 
