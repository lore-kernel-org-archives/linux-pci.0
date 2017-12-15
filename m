Return-Path: <SRS0=7YLV=DL=redhat.com=hdegoede@kernel.org>
Return-Path: <SRS0=7YLV=DL=redhat.com=hdegoede@kernel.org>
Subject: Re: [PATCH v6] mfd: Add support for RTS5250S power saving
To: Bjorn Helgaas <helgaas@kernel.org>, rui_feng@realsil.com.cn
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, linux-pci@vger.kernel.org
References: <1504772799-15173-1-git-send-email-rui_feng@realsil.com.cn>
 <20171214222522.GL30595@bhelgaas-glaptop.roam.corp.google.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <f1220fc3-8d86-4153-297d-d3b6b4aadaa0@redhat.com>
Date: Fri, 15 Dec 2017 08:41:45 +0100
MIME-Version: 1.0
In-Reply-To: <20171214222522.GL30595@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 14-12-17 23:25, Bjorn Helgaas wrote:
> [+cc Hans, Dave, linux-pci]

I appreciate the Cc but I'm not really involved in this, other
then fixing the original commit up so that the T440s can reach
idle-state PC7 again, instead of only going to PC3.

With that said, for any fixes to this please Cc me so that I can
test that the T440s does not regress again.

Regards,

Hans


> 
> On Thu, Sep 07, 2017 at 04:26:39PM +0800, rui_feng@realsil.com.cn wrote:
>> From: Rui Feng <rui_feng@realsil.com.cn>
> 
> I wish this had been posted to linux-pci before being merged.
> 
> I'm concerned because some of this appears to overlap and
> conflict with PCI core management of ASPM.
> 
> I assume these devices advertise ASPM support in their Link
> Capabilites registers, right?  If so, why isn't the existing
> PCI core ASPM support sufficient?
> 
>> Enable power saving for RTS5250S as following steps:
>> 1.Set 0xFE58 to enable clock power management.
> 
> Is this clock power management something specific to RTS5250S, or is
> it standard PCIe architected stuff?
> 
>> 2.Check cfg space whether support L1SS or not.
> 
> This sounds like standard PCIe ASPM L1 Substates, right?
> 
>> 3.If support L1SS, set 0xFF03 to free clkreq.
>> 4.When entering idle status, enable aspm
>>    and set parameters for L1SS and LTR.
>> 5.Wnen entering run status, disable aspm
>>    and set parameters for L1SS and LTR.
> 
> In general, drivers should not configure ASPM, L1SS, and LTR
> themselves; the PCI core should do that.
> 
> If a driver needs to tweak ASPM at run-time, it should use interfaces
> exported by the PCI core to do so.
> 
>> If entering L1SS mode successfully,
>> electric current will be below 2mA.
> 
>> Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
>> ...
> 
>> +static void rts5249_init_from_cfg(struct rtsx_pcr *pcr)
>> +{
>> +	struct rtsx_cr_option *option = &(pcr->option);
>> +	u32 lval;
>> +
>> +	if (CHK_PCI_PID(pcr, PID_524A))
>> +		rtsx_pci_read_config_dword(pcr,
>> +			PCR_ASPM_SETTING_REG1, &lval);
>> +	else
>> +		rtsx_pci_read_config_dword(pcr,
>> +			PCR_ASPM_SETTING_REG2, &lval);
> 
> This looks like you're reading the ASPM L1 Substates capability, i.e.,
> PCI_L1SS_CAP, using hard-coded offsets based on the Device ID.  You
> should be using pci_find_ext_capability() to locate it.
> 
>> +	if (lval & ASPM_L1_1_EN_MASK)
>> +		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
>> +
>> +	if (lval & ASPM_L1_2_EN_MASK)
>> +		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
>> +
>> +	if (lval & PM_L1_1_EN_MASK)
>> +		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
>> +
>> +	if (lval & PM_L1_2_EN_MASK)
>> +		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
> 
> You're adding these:
> 
>    #define ASPM_L1_1_EN_MASK              BIT(3)
>    #define ASPM_L1_2_EN_MASK              BIT(2)
>    #define PM_L1_1_EN_MASK                BIT(1)
>    #define PM_L1_2_EN_MASK                BIT(0)
> 
> The PCI core already defines these and you should use them instead:
> 
>    #define  PCI_L1SS_CAP_PCIPM_L1_2        0x00000001  /* PCI-PM L1.2 Supported */
>    #define  PCI_L1SS_CAP_PCIPM_L1_1        0x00000002  /* PCI-PM L1.1 Supported */
>    #define  PCI_L1SS_CAP_ASPM_L1_2         0x00000004  /* ASPM L1.2 Supported */
>    #define  PCI_L1SS_CAP_ASPM_L1_1         0x00000008  /* ASPM L1.1 Supported */
> 
>> +	if (option->ltr_en) {
>> +		u16 val;
>> +
>> +		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
>> +		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
>> +			option->ltr_enabled = true;
>> +			option->ltr_active = true;
> 
> ltr_active is never actually used.
> 
>> +			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
>> +		} else {
>> +			option->ltr_enabled = false;
>> +		}
>> +	}
>> +}
>> ...
> 
>> +static void rts5249_set_aspm(struct rtsx_pcr *pcr, bool enable)
>> +{
>> +	struct rtsx_cr_option *option = &pcr->option;
>> +	u8 val = 0;
>> +
>> +	if (pcr->aspm_enabled == enable)
>> +		return;
>> +
>> +	if (option->dev_aspm_mode == DEV_ASPM_DYNAMIC) {
>> +		if (enable)
>> +			val = pcr->aspm_en;
>> +		rtsx_pci_update_cfg_byte(pcr,
>> +			pcr->pcie_cap + PCI_EXP_LNKCTL,
>> +			ASPM_MASK_NEG, val);
> 
> This stomps on whatever ASPM configuration the PCI core did.
> 
>> +	} else if (option->dev_aspm_mode == DEV_ASPM_BACKDOOR) {
> 
> DEV_ASPM_BACKDOOR is never set, so this looks like dead code.
> 
>> +		u8 mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0;
>> +		if (!enable)
>> +			val = FORCE_ASPM_CTL0;
>> +		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
>> +	}
>> +
>> +	pcr->aspm_enabled = enable;
>> +}
