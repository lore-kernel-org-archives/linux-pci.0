Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] dwc: dra7xx: Print link state to console for debug
From: Faiz Abbas <faiz_abbas@ti.com>
To: David Laight <David.Laight@ACULAB.COM>,
        "kishon@ti.com" <kishon@ti.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1508417009-30869-1-git-send-email-faiz_abbas@ti.com>
 <9378c5c9-381d-4c40-3290-f7e3720792ba@ti.com>
 <063D6719AE5E284EB5DD2968C1650D6DD009C62B@AcuExch.aculab.com>
 <53ed97ab-ed02-23be-0ce9-e79f2aaac979@ti.com>
Message-ID: <a4832f67-8511-e903-044c-609e0f4a0352@ti.com>
Date: Mon, 30 Oct 2017 14:18:32 +0530
MIME-Version: 1.0
In-Reply-To: <53ed97ab-ed02-23be-0ce9-e79f2aaac979@ti.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thursday 26 October 2017 01:29 PM, Faiz Abbas wrote:
> David,
> 
> On Thursday 19 October 2017 06:56 PM, David Laight wrote:
>> From: Faiz Abbas
>>> Sent: 19 October 2017 14:09
>>> On Thursday 19 October 2017 06:13 PM, Faiz Abbas wrote:
>>>> Enable support for printing the LTSSM link state for debugging PCI
>>>> when link is down.
>>>>
>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>> ---
>>>> v2:
>>>>  1. Changed dev_err() to dev_dbg()
>>>>  2. Changed static char array to static const char * const
>>>>  3. format changes
>>>>
>>>>  drivers/pci/dwc/pci-dra7xx.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 48 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>>>> index 34427a6..0e70e77 100644
>>>> --- a/drivers/pci/dwc/pci-dra7xx.c
>>>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>>>> @@ -98,6 +98,45 @@ struct dra7xx_pcie_of_data {
>>>>
>>>>  #define to_dra7xx_pcie(x)	dev_get_drvdata((x)->dev)
>>>>
>>>> +static const char * const state[] = {
>>>> +	"DETECT_QUIET",
>> ...
>>>> +	"RCVRY_EQ3"
>>>> +};
>>>> +
>>>>  static inline u32 dra7xx_pcie_readl(struct dra7xx_pcie *pcie, u32 offset)
>>>>  {
>>>>  	return readl(pcie->base + offset);
>>>> @@ -118,6 +157,15 @@ static int dra7xx_pcie_link_up(struct dw_pcie *pci)
>>>>  {
>>>>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>>>>  	u32 reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_PHY_CS);
>>>> +	u32 cmd_reg;
>>>> +	u32 ltssm_state;
>>>> +
>>>> +	if (!(reg & LINK_UP)) {
>>>> +		cmd_reg = dra7xx_pcie_readl(dra7xx,
>>>> +					    PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
>>>> +		ltssm_state = (cmd_reg & GENMASK(7, 2)) >> 2;
>>>> +		dev_dbg(pci->dev, "Link state:%s\n", state[ltssm_state]);
>>
>> Hmmm... GENMASK leaves by hunting header files...> Why not (cmd_reg >> 2) & 63 and explicitly define state[64]
>> to guarantee that you never print anything worse than a NULL
>> pointer.
> 
> I'm not sure what you mean. Are you worried we might print something
> outside the array bounds? How is this easier to decipher than GENMASK?
> 
>>
>>>> +	}
>>>>
>>>>  	return !!(reg & LINK_UP);
>>>>  }
>>>>
>>>
>>> I missed David's comment in v1. Will submit a new version. Please ignore.
>>
>> I've a 'neat' trick for generating strings that match constants.
>> You can get the compiler to do all the work for you:
>> (Assuming I've typed it correctly)
>>
>> #define LTSSM_DEFS(x) \
>>   x(DETECT_QUIET) \
>>   x(DETECT_ACT) \
>> (continue for all the names)
>>
>> Define an enum with the named constants:
>> #define X(name) LTSSM_STATE_##name,
>> enum (LTSSM_DEFS(X) LTSSM_STATE_SIZE=64);
>> #undef X
>>
>> Array of strings:
>> #define X(name) [LTSSM_STATE_##name] = #name
>> static const char * const state_names[LTSSM_STATE_SIZE] = { LTSSM_DEFS(X) };
>> #undef X
>>
>> 	David
>>
> 
> So I implemented your idea and it looks like this:
> http://pastebin.ubuntu.com/25821834/
> 
> I don't know how much we gained by adding the trick. I still had to be
> careful not to be off by 1 when writing the list. Plus we are never
> saying anything like printk("%s", state[LTSSM_STATE_DETECT_QUIET]. Its a
> register read which is used to index the list array.
> 
> Thanks,
> Faiz
> 

Gentle Ping.
