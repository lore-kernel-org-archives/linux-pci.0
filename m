Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:51276 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758614AbcIWBHR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 21:07:17 -0400
Subject: Re: [PATCH v3] PCI: rockchip: Increase the Max Credit update
 interval.
To: Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>
References: <c7a733c8-df1c-3917-9874-15496fe95758@rock-chips.com>
 <1474591842-27836-1-git-send-email-rajatja@google.com>
Cc: shawn.lin@rock-chips.com, rajatxjain@gmail.com
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <8f6e1013-2962-6bd0-1a18-81a918e400f6@rock-chips.com>
Date: Fri, 23 Sep 2016 09:07:07 +0800
MIME-Version: 1.0
In-Reply-To: <1474591842-27836-1-git-send-email-rajatja@google.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

ÔÚ 2016/9/23 8:50, Rajat Jain Ð´µÀ:
> This increases the likelihood of link state to automatically go to L1
> and save some power.
>
> The default credit update interval of 7.5 us results in the rootport
> sending UpdateFC-P and UpdateFC-NP packets too often, thus resulting
> in the link never going to L1, and always staying in L0/L0s. The
> value 24 us was chosen after some experiments and peeking over the
> PCIe bus to see that we do enter L1 substate when there is not enough
> traffic on the PCIe bus.

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v3: Fix the commit message.
> v2: Use the link bandwidth change irq to program the register.
>
>  drivers/pci/host/pcie-rockchip.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index c3593e6..99e700f 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -95,6 +95,11 @@
>  #define   PCIE_CORE_PL_CONF_SPEED_MASK		0x00000018
>  #define   PCIE_CORE_PL_CONF_LANE_MASK		0x00000006
>  #define   PCIE_CORE_PL_CONF_LANE_SHIFT		1
> +#define PCIE_CORE_TXCREDIT_CFG1		(PCIE_CORE_CTRL_MGMT_BASE + 0x020)
> +#define   PCIE_CORE_TXCREDIT_CFG1_MUI_MASK	0xFFFF0000
> +#define   PCIE_CORE_TXCREDIT_CFG1_MUI_SHIFT	16
> +#define   PCIE_CORE_TXCREDIT_CFG1_MUI_ENCODE(x) \
> +		(((x) >> 3) << PCIE_CORE_TXCREDIT_CFG1_MUI_SHIFT)
>  #define PCIE_CORE_INT_STATUS		(PCIE_CORE_CTRL_MGMT_BASE + 0x20c)
>  #define   PCIE_CORE_INT_PRFPE			BIT(0)
>  #define   PCIE_CORE_INT_CRFPE			BIT(1)
> @@ -224,6 +229,17 @@ static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
>  	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
>  }
>
> +static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
> +{
> +	u32 val;
> +
> +	/* Update Tx credit maximum update interval */
> +	val = rockchip_pcie_read(rockchip, PCIE_CORE_TXCREDIT_CFG1);
> +	val &= ~PCIE_CORE_TXCREDIT_CFG1_MUI_MASK;
> +	val |= PCIE_CORE_TXCREDIT_CFG1_MUI_ENCODE(24000);	/* ns */
> +	rockchip_pcie_write(rockchip, val, PCIE_CORE_TXCREDIT_CFG1);
> +}
> +
>  static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
>  				      struct pci_bus *bus, int dev)
>  {
> @@ -597,6 +613,7 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
>  		rockchip_pcie_write(rockchip, sub_reg, PCIE_CORE_INT_STATUS);
>  	} else if (reg & PCIE_CLIENT_INT_PHY) {
>  		dev_dbg(dev, "phy link changes\n");
> +		rockchip_pcie_update_txcredit_mui(rockchip);
>  		rockchip_pcie_clr_bw_int(rockchip);
>  	}
>
>


-- 
Best Regards
Shawn Lin

