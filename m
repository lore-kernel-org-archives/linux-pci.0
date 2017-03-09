Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/3] PCI: rockchip: fix sign issues for current limits
To: Brian Norris <briannorris@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20170308233748.54706-1-briannorris@chromium.org>
Cc: shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <662fb87d-de80-ac96-4a25-c478956cceb2@rock-chips.com>
Date: Thu, 9 Mar 2017 16:59:15 +0800
MIME-Version: 1.0
In-Reply-To: <20170308233748.54706-1-briannorris@chromium.org>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/3/9 7:37, Brian Norris wrote:
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

For this patch,

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

And I think patch 2 is not so urgent so we could just wait for your
non-WIP patch 3?

> Fixes: 4816c4c7b82b ("PCI: rockchip: Provide captured slot power limit and scale")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v4.11 candidate?
>
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
>


-- 
Best Regards
Shawn Lin
