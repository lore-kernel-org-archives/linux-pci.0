Return-Path: <shawn.lin@rock-chips.com>
Return-Path: <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v4 2/4] PCI: rockchip: Mark RC as common clock
 architecture
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1476754889-21804-1-git-send-email-shawn.lin@rock-chips.com>
 <1476754889-21804-2-git-send-email-shawn.lin@rock-chips.com>
 <20161111220905.GQ9868@bhelgaas-glaptop.roam.corp.google.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Wenrui Li <wenrui.li@rock-chips.com>, Brian Norris <briannorris@chromium.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <a71f434b-42b2-c60a-4c7f-13338c07868a@rock-chips.com>
Date: Sat, 12 Nov 2016 09:54:49 +0800
MIME-Version: 1.0
In-Reply-To: <20161111220905.GQ9868@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 2016/11/12 6:09, Bjorn Helgaas wrote:
> On Tue, Oct 18, 2016 at 09:41:27AM +0800, Shawn Lin wrote:
>> The default value of common clock configuration is
>> zero indicating Rockchip's RC is using asynchronous
>> clock architecture but actually we are using common
>> clock. This will confuses some EP drivers if they
>> need some different settings referring to this value.
>> So let's fix it.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v4:
>> - rebase on the next branch
>>
>> Changes in v3:
>> - rebase the code since it isn't cleanly applied again
>>
>> Changes in v2:
>> - rebase the code since it isn't cleanly applied after Bjorn's cleanup
>>
>>  drivers/pci/host/pcie-rockchip.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>> index 3ede865..8e260d2 100644
>> --- a/drivers/pci/host/pcie-rockchip.c
>> +++ b/drivers/pci/host/pcie-rockchip.c
>> @@ -141,6 +141,7 @@
>>  #define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
>>  #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
>>  #define   PCIE_RC_CONFIG_LCS_RETRAIN_LINK	BIT(5)
>> +#define   PCIE_RC_CONFIG_LCS_CCC		BIT(6)
>>  #define   PCIE_RC_CONFIG_LCS_LBMIE		BIT(10)
>>  #define   PCIE_RC_CONFIG_LCS_LABIE		BIT(11)
>>  #define   PCIE_RC_CONFIG_LCS_LBMS		BIT(30)
>
> These look an awful lot like these generic PCIe definitions:
>
>   #define PCI_EXP_LNKCTL          16      /* Link Control */
>   #define  PCI_EXP_LNKCTL_ASPMC   0x0003  /* ASPM Control */
>   #define  PCI_EXP_LNKCTL_ASPM_L0S 0x0001 /* L0s Enable */
>   #define  PCI_EXP_LNKCTL_ASPM_L1  0x0002 /* L1 Enable */
>   #define  PCI_EXP_LNKCTL_RCB     0x0008  /* Read Completion Boundary */
>   #define  PCI_EXP_LNKCTL_LD      0x0010  /* Link Disable */
>   #define  PCI_EXP_LNKCTL_RL      0x0020  /* Retrain Link */
>   #define  PCI_EXP_LNKCTL_CCC     0x0040  /* Common Clock Configuration */
>   #define  PCI_EXP_LNKCTL_ES      0x0080  /* Extended Synch */
>   #define  PCI_EXP_LNKCTL_CLKREQ_EN 0x0100 /* Enable clkreq */
>   #define  PCI_EXP_LNKCTL_HAWD    0x0200  /* Hardware Autonomous Width Disable */
>   #define  PCI_EXP_LNKCTL_LBMIE   0x0400  /* Link Bandwidth Management Interrupt Enable */
>   #define  PCI_EXP_LNKCTL_LABIE   0x0800  /* Link Autonomous Bandwidth Interrupt Enable */
>
> If these are indeed the same, I'd really like it if you could use the
> generic definitions, e.g., by something like:
>

Ahh, thanks for sharing this. PCIE_RC_CONFIG_LCS is short for link
control and status register for RC. So the register layout looks
the same for that of PCI_EXP_LNKCTL after checking the TRM again.

I will come up a cleanup patch to use the existed PCI_EXP_LNKCTL_XXX
instead. :)


>   #define PCIE_RC_PCIE_CAP_BASE    (PCIE_RC_CONFIG_BASE + 0xc0)
>
>   status = rockchip_pcie_read(rockchip, PCIE_RC_PCIE_CAP_BASE + PCI_EXP_LNKCTL);
>   status |= PCI_EXP_LNKCTL_CCC;
>
> That way grep has a chance to find related pieces.
>
> If they only *look* similar but are not really the same, then
> disregard this, of course.
>
>> @@ -536,6 +537,11 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>
>>  	rockchip_pcie_set_power_limit(rockchip);
>>
>> +	/* Set RC's clock architecture as common clock */
>> +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
>> +	status |= PCIE_RC_CONFIG_LCS_CCC;
>> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
>> +
>>  	/* Enable Gen1 training */
>>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>>  			    PCIE_CLIENT_CONFIG);
>> --
>> 2.3.7
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin
