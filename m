Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34848 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755793AbdCTWOe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2017 18:14:34 -0400
Received: by mail-pg0-f46.google.com with SMTP id t143so18026330pgb.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2017 15:14:32 -0700 (PDT)
Date: Mon, 20 Mar 2017 15:14:19 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix PCIe domain number for rk3399
Message-ID: <20170320221418.GA76087@google.com>
References: <1489977480-8785-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489977480-8785-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 20, 2017 at 10:38:00AM +0800, Shawn Lin wrote:
> It's suggested to fix the domain number for all PCIe
> host bridges or not set it at all. However, if we don't
> fix it, the domain number will keep increasing ever when
> doing unbind/bind test, which makes the bus tree of lspci
> introduce pointless domain hierarchy. More investigation shows
> the domain number allocater of PCI doesn't consider the conflict
> of domain number if we have more than one PCIe port belonging to
> different domains. So once unbinding/binding one of them and keep
> others would going to overflow the domain number so that finally
> it will share the same domain as others, but actually it shouldn't.
> We should fix the domain number for PCIe or invent new indexing
> ID mechanisms. However it isn't worth inventing new indexing ID
> mechanisms personlly, Just look at how other Root Complex drivers
> did, for instance, broadcom and qualcomm, it seems fixing the domain
> number was more popular. So this patch gonna fix the domain number
> of PCIe for rk3399.
> 
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Seems OK, though it still feels like we should fix the domain number
allocation code.

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index f5681be..f66c320 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -234,6 +234,7 @@
>  				<0 0 0 2 &pcie0_intc 1>,
>  				<0 0 0 3 &pcie0_intc 2>,
>  				<0 0 0 4 &pcie0_intc 3>;
> +		linux,pci-domain = <0>;
>  		max-link-speed = <1>;
>  		msi-map = <0x0 &its 0x0 0x1000>;
>  		phys = <&pcie_phy>;
> -- 
> 1.9.1
> 
> 
