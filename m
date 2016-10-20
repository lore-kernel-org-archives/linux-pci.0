Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:35143 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbcJTBDl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2016 21:03:41 -0400
Subject: Re: [PATCH] PCI: rockchip: remove the pointer to L1 substate cap
To: Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
References: <1476868234-15135-1-git-send-email-shawn.lin@rock-chips.com>
 <20161019174205.GA78840@google.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <13a8275f-da5e-31b8-512b-c597817aa349@rock-chips.com>
Date: Thu, 20 Oct 2016 09:03:26 +0800
MIME-Version: 1.0
In-Reply-To: <20161019174205.GA78840@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

在 2016/10/20 1:42, Brian Norris 写道:
> Hi,
>
> On Wed, Oct 19, 2016 at 05:10:34PM +0800, Shawn Lin wrote:
>> Per the errata of TRM, the RC can't support L1 substate, so we
>> need to remove the L1 substate cap.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>  drivers/pci/host/pcie-rockchip.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>> index e0b22da..8370a85 100644
>> --- a/drivers/pci/host/pcie-rockchip.c
>> +++ b/drivers/pci/host/pcie-rockchip.c
>> @@ -142,6 +142,8 @@
>>  #define   PCIE_RC_CONFIG_LCS_LBMS		BIT(30)
>>  #define   PCIE_RC_CONFIG_LCS_LAMS		BIT(31)
>>  #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
>> +#define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
>> +#define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
>>
>>  #define PCIE_CORE_AXI_CONF_BASE		0xc00000
>>  #define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
>> @@ -558,6 +560,12 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>  	rockchip_pcie_write(rockchip,
>>  			    PCI_CLASS_BRIDGE_PCI << PCIE_RC_CONFIG_SCC_SHIFT,
>>  			    PCIE_RC_CONFIG_RID_CCR);
>> +
>> +	/* Clear THP cap's next cap pointer to remove L1 substate cap */
>> +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_THP_CAP);
>> +	status &= ~PCIE_RC_CONFIG_THP_CAP_NEXT_MASK;
>> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_THP_CAP);
>> +
>
> Tested-by: Brian Norris <briannorris@chromium.org>
>
>>  	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
>>
>>  	rockchip_pcie_write(rockchip,
>
> You could also probably do away with the handling of L1 substates here,
> since they're officially declared broken:

okay, I will respin v2 later to remove this.

>
>         /*
>          * We need to read/write PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 before
>          * enabling ASPM.  Otherwise L1PwrOnSc and L1PwrOnVal isn't
>          * reliable and enabling ASPM doesn't work.  This is a controller
>          * bug we need to work around.
>          */
>         status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
>         rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

