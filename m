Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA847426690
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167349; cv=none; b=bskmfDfmim3R3DLHljGZ2AIl3APdr7gBOyaz/JmaKYIu74a0xB8IzBtA6DQ/E2vNr4qpp1iBMjcXvOk93to+SzOjtYUKNQo3TxEeAgZtb20cjmp0ZPZzrWWwhO+T/hBysxwgyTGUzp/YKx0dK0bu8jOVHa7eBOCYLV8DpPFgG20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167349; c=relaxed/simple;
	bh=tL8vhjTM/0lzcBl5kGybgTGbZkaz7KtDK49q0G/JKg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0PBwNmvUi0LhFvxaCp+psTF2IYjFrrA/s5lhv7spvL7nJ+YVrCsBMh8wO60py+76IeStszJ/VOnNFtI0OFuP5WAeTY44KBjg48B4T0noZUj8X3XcZNZNZG59MTP24xUIaBAoUfe/oMGdBUO26QMPnaK27nvhGVlyIeCs0peHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hn1ioPfR; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hn1ioPfR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=YpeiknJVJPLIFMqNflFehOonJQLV87GJbhuLuF4ydoc=;
	b=Hn1ioPfRoik0hfxvXAUbZxjHccxhXuHbsG1B/HaOWqrRfJMCb9gNqzROk2C39Q
	BOiaTEFejCewTp2/554L94+7hOixi/UfyjxmHGzMZiSClhaC3BC582mQngwl/r1h
	T1EU1vbWpGl4O+EpngsfeTeRIvDc9miUGmv3MzLWxIzU0=
Received: from [192.168.71.11] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDnn_gDrvxp1fr3DQ--.42093S2;
	Thu, 07 May 2026 23:21:40 +0800 (CST)
Message-ID: <3280415c-3c38-4b69-b2a5-6b97d0d24e54@163.com>
Date: Thu, 7 May 2026 23:21:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: Use cdns_pcie_find_capability() to get PCIe
 Cap offset in host driver
To: Aksh Garg <a-garg7@ti.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: sashiko@lists.linux.dev, linux-pci@vger.kernel.org
References: <20260506171227.GA797577@bhelgaas>
 <a791e1d8-f17a-4e8c-8afe-d1da338f4c5e@163.com>
 <2e92d011-02fa-433f-92e3-142880d5d0d2@163.com>
 <181c2204-dfb6-4484-b4e4-069d8c7445fd@ti.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <181c2204-dfb6-4484-b4e4-069d8c7445fd@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDnn_gDrvxp1fr3DQ--.42093S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3tw4fJry3ArW7CFW3Xr1kKrg_yoW8JFy8Jo
	Wftr4xGw4xCr18Jay0kasFqryUZ3Wjv3Z8Ar98Kw4DZryaya15Jr47Ja13Xw42vr48Ar4U
	Ary8tw1Y9FW2g3Zxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU5a0mUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAVG6Wn8rgU6egAA3Q



On 5/7/26 20:31, Aksh Garg wrote:
> 
> 
> On 07/05/26 09:18, Hans Zhang wrote:
>>
>>
>> On 5/7/26 11:31, Hans Zhang wrote:
>>>
>>>
>>> On 5/7/26 01:12, Bjorn Helgaas wrote:
>>>> On Thu, May 07, 2026 at 12:04:34AM +0800, Hans Zhang wrote:
>>>>> On 5/6/26 05:23, Bjorn Helgaas wrote:
>>>>>> On Mon, May 04, 2026 at 04:22:26PM +0800, Hans Zhang wrote:
>>>>>>> On 5/4/26 00:52, sashiko-bot@kernel.org wrote:
>>>>>>>> Thank you for your contribution! Sashiko AI review found 1
>>>>>>>> potential issue(s) to consider:
>>>>>>>>
>>>>>>>> - [Critical] cdns_pcie_find_capability() searches the wrong
>>>>>>>> register space in Host mode and its return value is not validated,
>>>>>>>> leading to Root Port configuration space corruption.
>>>>>>>> -- 
>>>>>>>>
>>>>>>>> commit 09b3c64b8f5892eb365acd13030a8067652a15e8
>>>>>>>> Author: Hans Zhang <18255117159@163.com>
>>>>>>>>
>>>>>>>> PCI: cadence: Use cdns_pcie_find_capability() to get PCIe Cap 
>>>>>>>> offset in host driver
>>>>>>>>
>>>>>>>> This commit replaces the hardcoded CDNS_PCIE_RP_CAP_OFFSET with 
>>>>>>>> a dynamic
>>>>>>>> lookup using cdns_pcie_find_capability() in Cadence PCIe host- 
>>>>>>>> related
>>>>>>>> functions. The goal is to ensure correct operation across 
>>>>>>>> various SoC designs
>>>>>>>> where the capability might not reside at offset 0xC0.
>>>>>>>>
>>>>>>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host- 
>>>>>>>>> common.c b/drivers/pci/controller/cadence/pcie-cadence-host- 
>>>>>>>>> common.c
>>>>>>>>> index 2b0211870f02..5013d3fe23b5 100644
>>>>>>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>>>>>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>>>>>>>> @@ -26,14 +26,14 @@ EXPORT_SYMBOL_GPL(bar_max_size);
>>>>>>>>>     int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
>>>>>>>>>     {
>>>>>>>>> -    u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
>>>>>>>>>         unsigned long end_jiffies;
>>>>>>>>>         u16 lnk_stat;
>>>>>>>>> +    u8 cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
>>>>>>>>
>>>>>>>> Does this capability search scan the correct register space when
>>>>>>>> operating in host mode?
>>>>>>>>
>>>>>>>> Looking at the helper function, it uses cdns_pcie_read_cfg() which
>>>>>>>> reads directly from the base address without the Root Port offset:
>>>>>>>>
>>>>>>>> drivers/pci/controller/cadence/pcie- 
>>>>>>>> cadence.c:cdns_pcie_find_capability() {
>>>>>>>>        return PCI_FIND_NEXT_CAP(cdns_pcie_read_cfg, 
>>>>>>>> PCI_CAPABILITY_LIST,
>>>>>>>>                                 cap, NULL, pcie);
>>>>>>>> }
>>>>>>>>
>>>>>>>> However, the Root Port configuration registers are physically
>>>>>>>> located at pcie->reg_base + CDNS_PCIE_RP_BASE. Could this cause
>>>>>>>> the search to scan the Local Management register space instead,
>>>>>>>> failing to find PCI_CAP_ID_EXP and returning 0?
>>>>>>>
>>>>>>> I don't think we need to worry about this issue.
>>>>>>>
>>>>>>> As per PCIe r7.0, sec 7.5.1.1.11, Since all PCI Express Functions
>>>>>>> are required to implement the PCI Express Capability structure,
>>>>>>> which must be included somewhere in this linked list;
>>>>>>>
>>>>>>> So, it won't return 0 here.
>>>>>>
>>>>>> It's true that all Root Ports must have a PCIe Capability, but
>>>>>> that's not related to this issue.
>>>>>>
>>>>>> cdns_pcie_host_init_root_port() accesses PCI_EXP_LNKCAP at the
>>>>>> address:
>>>>>>
>>>>>>     pcie->reg_base + CDNS_PCIE_RP_BASE + CDNS_PCIE_RP_CAP_OFFSET + 
>>>>>> PCI_EXP_LNKCAP
>>>>>>
>>>>>> but when we search with cdns_pcie_find_capability(pcie, 
>>>>>> PCI_CAP_ID_EXP),
>>>>>> we start reading at:
>>>>>>
>>>>>>     pcie->reg_base + PCI_CAPABILITY_LIST
>>>>>>
>>>>>> It should be starting at:
>>>>>>
>>>>>>     pcie->reg_base + CDNS_PCIE_RP_BASE + PCI_CAPABILITY_LIST
>>>>>>
>>>>>> Previously, cdns_pcie_find_capability() and
>>>>>> cdns_pcie_find_ext_capability() were only used for endpoints, and I
>>>>>> assume they work fine there.  There is pcie->is_rc, so there 
>>>>>> should be
>>>>>> a way to make this work for both endpoints and Root Ports.
>>>>>
>>>>> The reason for using the "is_rc" tag is that for Cadence IP, it is 
>>>>> not only
>>>>> applicable to the RC or EP mode, but also there are significant 
>>>>> differences
>>>>> between the LGA and HPA generations of IP. Including register 
>>>>> offset values,
>>>>> definitions, etc., it fails to achieve good compatibility. It is 
>>>>> not like
>>>>> Synopsys IP, where compatibility has been handled very well. It was 
>>>>> truly
>>>>> out of necessity.
>>>>
>>>> I think cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP) fails on Root
>>>> Ports because it doesn't include the CDNS_PCIE_RP_BASE offset.  Do you
>>>> have hardware where you can test that?
>>
>> Hi Siddharth,
>>
>> Could you please test the functions mentioned above? It would be great 
>> if you could help test it and give us your feedback. (pci-j721e.c)
>>
>> I guess the following changes might need to be made.
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/ 
>> pci/controller/cadence/pcie-cadence.h
>> index 574e9cf4d003..bb01761749f1 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -298,6 +298,9 @@ static inline int cdns_pcie_read_cfg_byte(struct 
>> cdns_pcie *pcie, int where,
>>   {
>>          void __iomem *addr = pcie->reg_base + where;
>>
>> +       if ((pcie->is_rc) && (!pcie->is_hpa))
>> +               addr += CDNS_PCIE_RP_BASE;
>> +
>>          *val = cdns_pcie_read_sz(addr, 0x1);
>>          return PCIBIOS_SUCCESSFUL;
>>   }
>> @@ -307,6 +310,9 @@ static inline int cdns_pcie_read_cfg_word(struct 
>> cdns_pcie *pcie, int where,
>>   {
>>          void __iomem *addr = pcie->reg_base + where;
>>
>> +       if ((pcie->is_rc) && (!pcie->is_hpa))
>> +               addr += CDNS_PCIE_RP_BASE;
>> +
>>          *val = cdns_pcie_read_sz(addr, 0x2);
>>          return PCIBIOS_SUCCESSFUL;
>>   }
>> @@ -314,7 +320,12 @@ static inline int cdns_pcie_read_cfg_word(struct 
>> cdns_pcie *pcie, int where,
>>   static inline int cdns_pcie_read_cfg_dword(struct cdns_pcie *pcie, 
>> int where,
>>                                             u32 *val)
>>   {
>> -       *val = cdns_pcie_readl(pcie, where);
>> +       void __iomem *addr = pcie->reg_base + where;
>> +
>> +       if ((pcie->is_rc) && (!pcie->is_hpa))
>> +               addr += CDNS_PCIE_RP_BASE;
>> +
>> +       *val = cdns_pcie_read_sz(addr, 0x4);
>>          return PCIBIOS_SUCCESSFUL;
>>   }
>>
>>
>> "is_hpa" flag I added it in another series. As mentioned before, the 
>> compatibility of Cadence IP is not very good. It is divided into LGA 
>> and HPA IP. And there are many differences between the Root Port and 
>> the Endpoint.
>>
>> https://patchwork.kernel.org/project/linux-pci/ 
>> patch/20260406103237.1203127-2-18255117159@163.com/
>>
>> Best regards,
>> Hans
>>
> 
> Hi Hans,
> 
> I have tested this on J7200 and J721E SoCs, which uses pci-j721e.c
> driver for their PCIe controllers. The patch alone fails to find the
> capabilities using cdns_pcie_find_capability() for Root Port.
> 
> With the "is_hpa" flag patch, and the patch "PCI: cadence: Use
> cdns_pcie_find_capability() to get PCIe Cap offset in host driver" along
> with the diff suggested above:

Thank you very much for your test. We need to wait for Bjorn's approval.

> 
> Tested-by: Aksh Garg <a-garg7@ti.com>

When the future patch is sent to the PCI mailing list, if you test it at 
that time, please reply to this tag again.

> 
> 
> I would also like me to be included in the CC list for future
> correspondence regarding Cadence PCIe Controller patches.
> 

Sure. In the future, when I send the patch, I will CC it to you in the 
email.

Best regards,
Hans

> Regards,
> Aksh Garg
> 
>>>
>>> Hi Bjorn,
>>>
>>> The attachment contains the dmesg and lspci -vvv log from the test.
>>>
>>> Here is the test code:
>>>
>>> diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/ 
>>> controller/cadence/pci-sky1.c
>>> index cd55c64e58a9..0d0c42309127 100644
>>> --- a/drivers/pci/controller/cadence/pci-sky1.c
>>> +++ b/drivers/pci/controller/cadence/pci-sky1.c
>>> @@ -130,6 +130,39 @@ static const struct cdns_pcie_ops sky1_pcie_ops = {
>>>       .link_up = sky1_pcie_link_up,
>>>   };
>>>
>>> +void cix_pcie_test_cap(struct sky1_pcie *pcie)
>>> +{
>>> +    u16 offset;
>>> +
>>> +    printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", 
>>> __func__, __LINE__);
>>> +    /* capability */
>>> +    offset = cdns_pcie_find_capability(pcie->cdns_pcie, PCI_CAP_ID_PM);
>>> +    printk(KERN_EMERG"[HANS]pm offset = 0x%x\n", offset);
>>> +    offset = cdns_pcie_find_capability(pcie->cdns_pcie, 
>>> PCI_CAP_ID_MSI);
>>> +    printk(KERN_EMERG"[HANS]msi offset = 0x%x\n", offset);
>>> +    offset = cdns_pcie_find_capability(pcie->cdns_pcie, 
>>> PCI_CAP_ID_MSIX);
>>> +    printk(KERN_EMERG"[HANS]msix offset = 0x%x\n", offset);
>>> +    offset = cdns_pcie_find_capability(pcie->cdns_pcie, 
>>> PCI_CAP_ID_EXP);
>>> +    printk(KERN_EMERG"[HANS]exp offset = 0x%x\n", offset);
>>> +
>>> +    printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", 
>>> __func__, __LINE__);
>>> +    /* extend capability */
>>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>>> PCI_EXT_CAP_ID_ERR);
>>> +    printk(KERN_EMERG"[HANS]aer offset = 0x%x\n", offset);
>>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>>> PCI_EXT_CAP_ID_VC);
>>> +    printk(KERN_EMERG"[HANS]Virtual Channel offset = 0x%x\n", offset);
>>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>>> PCI_EXT_CAP_ID_DSN);
>>> +    printk(KERN_EMERG"[HANS]Device Serial Number offset = 0x%x\n", 
>>> offset);
>>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>>> PCI_EXT_CAP_ID_PWR);
>>> +    printk(KERN_EMERG"[HANS]pwr offset = 0x%x\n", offset);
>>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>>> PCI_EXT_CAP_ID_REBAR);
>>> +    printk(KERN_EMERG"[HANS]resize bar offset = 0x%x\n", offset);
>>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>>> PCI_EXT_CAP_ID_SECPCI);
>>> +    printk(KERN_EMERG"[HANS]second exp offset = 0x%x\n", offset);
>>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>>> PCI_EXT_CAP_ID_L1SS);
>>> +    printk(KERN_EMERG"[HANS]L1ss offset = 0x%x\n", offset);
>>> +}
>>> +
>>>   static int sky1_pcie_probe(struct platform_device *pdev)
>>>   {
>>>       struct cdns_plat_pcie_of_data *reg_off;
>>> @@ -141,6 +174,7 @@ static int sky1_pcie_probe(struct platform_device 
>>> *pdev)
>>>       struct sky1_pcie *pcie;
>>>       int ret;
>>>
>>> +    printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", 
>>> __func__, __LINE__);
>>>       pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>>>       if (!pcie)
>>>           return -ENOMEM;
>>> @@ -202,6 +236,8 @@ static int sky1_pcie_probe(struct platform_device 
>>> *pdev)
>>>
>>>       dev_set_drvdata(dev, pcie);
>>>
>>> +    cix_pcie_test_cap(pcie);
>>> +
>>>       ret = cdns_pcie_hpa_host_setup(rc);
>>>       if (ret < 0) {
>>>           pci_ecam_free(pcie->cfg);
>>> @@ -230,7 +266,7 @@ static struct platform_driver sky1_pcie_driver = {
>>>       .driver = {
>>>           .name = "sky1-pcie",
>>>           .of_match_table = of_sky1_pcie_match,
>>> -        .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>>> +        // .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>>>       },
>>>   };
>>>   module_platform_driver(sky1_pcie_driver);
>>>
>>>
>>> For the LGA IP, an offset address CDNS_PCIE_RP_BASE needs to be 
>>> added. And the HPA IP requires an offset address of 
>>> CDNS_PCIE_HPA_RP_BASE, but it is equal to 0;
>>>
>>> drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
>>>
>>> /* Root Port register base address */
>>> #define CDNS_PCIE_HPA_RP_BASE            0x0
>>>
>>> Therefore, for "drivers/pci/controller/cadence/pci-sky1.c", it is 
>>> normal.
>>>
>>>
>>>
>>> Using the following code for work is also normal. Later, I will re- 
>>> unify it into the same operation.
>>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/ 
>>> pci/controller/cadence/pcie-cadence.h
>>> index 574e9cf4d003..723ea79fb02e 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>>> @@ -314,7 +314,9 @@ static inline int cdns_pcie_read_cfg_word(struct 
>>> cdns_pcie *pcie, int where,
>>>   static inline int cdns_pcie_read_cfg_dword(struct cdns_pcie *pcie, 
>>> int where,
>>>                                             u32 *val)
>>>   {
>>> -       *val = cdns_pcie_readl(pcie, where);
>>> +       void __iomem *addr = pcie->reg_base + where;
>>> +
>>> +       *val = cdns_pcie_read_sz(addr, 0x4);
>>>          return PCIBIOS_SUCCESSFUL;
>>>   }
>>>
>>>
>>> Best regards,
>>> Hans
>>>
>>>
>>

