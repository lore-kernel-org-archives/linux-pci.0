Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35920 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbHDET7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 00:19:59 -0400
References: <1438010223-124422-1-git-send-email-gabriele.paoloni@huawei.com> <20150729172053.GE31170@google.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D6F350@lhreml503-mbs> <CAL_JsqKs11-sXQTdBD+ZjbVYFWUHBARTW9q5MF1hCXUhZ+nWLQ@mail.gmail.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D6F94A@lhreml503-mbs> <20150730161447.GG9640@google.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D6FB3B@lhreml503-mbs> <20150730171445.GI9640@google.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D6FC15@lhreml503-mbs> <CAL_Jsq+aQVakaZf4xo7sxnVyTmPR+HJ-9ByyS6OYJ0PHDYOwmg@mail.gmail.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D70589@lhreml503-mbs> <55BB8CC6.1080203@ti.com> <CAL_JsqJqjiWVaKs-3ghQ1EBQzRRQ38GzkMV+FELPj53bSF-yXQ@mail.gmail.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D712E7@lhreml503-mbs>
Mime-Version: 1.0 (1.0)
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D712E7@lhreml503-mbs>
Content-Type: text/plain;
	charset=euc-kr
Message-Id: <7F6386B4-D2F5-4840-AC72-F8C76CBC3B94@gmail.com>
Cc: Rob Herring <robherring2@gmail.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@linaro.org>, jingoohan1@gmail.com
From: Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v6] PCI: Store PCIe bus address in struct of_pci_range
Date: Tue, 4 Aug 2015 13:19:50 +0900
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015. 8. 3., at PM 8:18, Gabriele Paoloni <gabriele.paoloni@huawei.com> wrote:
> 
> Rob, Kishon what about the following solution?....
> 
> ---
> drivers/pci/host/pci-dra7xx.c      | 12 ++++++++++++
> drivers/pci/host/pcie-designware.c |  9 +++------

Hi Paoloni,

OK, it looks good.
I want you to revert the following patch. 

commit "f4c55c5a3f7f (PCI: designware: Program ATU with untranslated address)"

Would you remove all '*_mode_base's?

Best regards,
Jingoo Han

> 2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 80db09e..bb2635f 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -61,6 +61,7 @@
> 
> #define    PCIECTRL_DRA7XX_CONF_PHY_CS            0x010C
> #define    LINK_UP                        BIT(16)
> +#define CPU_TO_BUS_ADDR             0x0FFFFFFF
> 
> struct dra7xx_pcie {
>    void __iomem        *base;
> @@ -138,6 +139,17 @@ static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
> 
> static void dra7xx_pcie_host_init(struct pcie_port *pp)
> {
> +    if (pp->io_mod_base)
> +        pp->io_mod_base &= CPU_TO_BUS_ADDR;
> +
> +    if (pp->mem_mod_base)
> +        pp->mem_mod_base &= CPU_TO_BUS_ADDR;
> +
> +    if (pp->cfg0_mod_base) {
> +        pp->cfg0_mod_base &= CPU_TO_BUS_ADDR;
> +        pp->cfg1_mod_base &= CPU_TO_BUS_ADDR;
> +    }
> +
>    dw_pcie_setup_rc(pp);
>    dra7xx_pcie_establish_link(pp);
>    if (IS_ENABLED(CONFIG_PCI_MSI))
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 69486be..06c682b 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -416,8 +416,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>            pp->io_base = range.cpu_addr;
> 
>            /* Find the untranslated IO space address */
> -            pp->io_mod_base = of_read_number(parser.range -
> -                             parser.np + na, ns);
> +            pp->io_mod_base = range.cpu_addr;;
>        }
>        if (restype == IORESOURCE_MEM) {
>            of_pci_range_to_resource(&range, np, &pp->mem);
> @@ -426,8 +425,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>            pp->mem_bus_addr = range.pci_addr;
> 
>            /* Find the untranslated MEM space address */
> -            pp->mem_mod_base = of_read_number(parser.range -
> -                              parser.np + na, ns);
> +            pp->mem_mod_base = range.cpu_addr;
>        }
>        if (restype == 0) {
>            of_pci_range_to_resource(&range, np, &pp->cfg);
> @@ -437,8 +435,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>            pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
> 
>            /* Find the untranslated configuration space address */
> -            pp->cfg0_mod_base = of_read_number(parser.range -
> -                               parser.np + na, ns);
> +            pp->cfg0_mod_base = range.cpu_addr;
>            pp->cfg1_mod_base = pp->cfg0_mod_base +
>                        pp->cfg0_size;
>        }
> -- 
> 1.9.1
> 
> 
>> -----Original Message-----
>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>> owner@vger.kernel.org] On Behalf Of Rob Herring
>> Sent: Friday, July 31, 2015 5:53 PM
>> To: Kishon Vijay Abraham I
>> Cc: Gabriele Paoloni; Bjorn Helgaas; arnd@arndb.de;
>> lorenzo.pieralisi@arm.com; Wangzhou (B); robh+dt@kernel.org;
>> james.morse@arm.com; Liviu.Dudau@arm.com; linux-pci@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
>> Yuanzhichang; Zhudacai; zhangjukuo; qiuzhenfa; Liguozhu (Kenneth);
>> Jingoo Han; Pratyush Anand; Arnd Bergmann
>> Subject: Re: [PATCH v6] PCI: Store PCIe bus address in struct
>> of_pci_range
>> 
>> On Fri, Jul 31, 2015 at 9:57 AM, Kishon Vijay Abraham I <kishon@ti.com>
>> wrote:
>>> +Arnd
>>> 
>>> Hi,
>>> 
>>>> On Friday 31 July 2015 07:55 PM, Gabriele Paoloni wrote:
>>>> [+cc Kishon]
>>>> 
>>>>> -----Original Message-----
>>>>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>>>>> owner@vger.kernel.org] On Behalf Of Rob Herring
>>>>> Sent: Thursday, July 30, 2015 9:42 PM
>>>>> To: Gabriele Paoloni
>>>>> Cc: Bjorn Helgaas; arnd@arndb.de; lorenzo.pieralisi@arm.com;
>> Wangzhou
>>>>> (B); robh+dt@kernel.org; james.morse@arm.com; Liviu.Dudau@arm.com;
>>>>> linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>>> devicetree@vger.kernel.org; Yuanzhichang; Zhudacai; zhangjukuo;
>>>>> qiuzhenfa; Liguozhu (Kenneth); Jingoo Han; Pratyush Anand
>>>>> Subject: Re: [PATCH v6] PCI: Store PCIe bus address in struct
>>>>> of_pci_range
>>>>> 
>>>>> On Thu, Jul 30, 2015 at 12:34 PM, Gabriele Paoloni
>>>>> <gabriele.paoloni@huawei.com> wrote:
>>>>>>> -----Original Message-----
>>>>>>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>>>>>>> Sent: 30 July 2015 18:15
>>>>>>> On Thu, Jul 30, 2015 at 04:50:55PM +0000, Gabriele Paoloni wrote:
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>>>>>>>>> owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
>>>>>>>>> Sent: Thursday, July 30, 2015 5:15 PM
>>>>>>>>> On Thu, Jul 30, 2015 at 01:52:13PM +0000, Gabriele Paoloni
>> wrote:
>>>>> 
>>>>> [...]
>>>>> 
>>>>>>>>>> I don¡¯t think we should rely on [CPU] addresses...what if the
>>>>>>>>> intermediate
>>>>>>>>>> translation layer changes the lower significant bits of the
>>>>> "bus
>>>>>>>>> address"
>>>>>>>>>> to translate into a cpu address?
>>>>>>>>> 
>>>>>>>>> Is it really a possiblity that the lower bits could be changed?
>>>>>>>> 
>>>>>>>> I've checked all the current deignware users DTs except "pci-
>>>>>>> layerscape"
>>>>>>>> that I could not find:
>>>>>>>> spear1310.dtsi
>>>>>>>> spear1340.dtsi
>>>>>>>> dra7.dtsi
>>>>>>>> imx6qdl.dtsi
>>>>>>>> imx6sx.dtsi
>>>>>>>> keystone.dtsi
>>>>>>>> exynos5440.dtsi
>>>>>>>> 
>>>>>>>> None of them modifies the lower bits. To be more precise the
>> only
>>>>> guy
>>>>>>>> that provides another translation layer is "dra7.dtsi":
>>>>>>>> axi0
>>>>>>>> http://lxr.free-
>>>>> electrons.com/source/arch/arm/boot/dts/dra7.dtsi#L207
>>>>>>>> 
>>>>>>>> axi1
>>>>>>>> http://lxr.free-
>>>>> electrons.com/source/arch/arm/boot/dts/dra7.dtsi#L241
>>>>>>>> 
>>>>>>>> For this case masking the top 4bits (bits28 to 31) should make
>> the
>>>>> job.
>>>>> 
>>>>> IMO, we should just fix this case. After further study, I don't
>> think
>>>>> this is a DW issue, but rather an SOC integration issue.
>>>>> 
>>>>> I believe you can just fixup the address in the pp->ops->host_init
>> hook.
>>>> 
>>>> Yes I guess that I could just assign pp->(*)_mod_base to the CPU
>> address
>>>> in DW and mask it out in dra7xx_pcie_host_init()...
>>>> 
>>>> Kishon, would you be ok with that?
>>> 
>>> Initially I was using *base-mask* property from dt. Me and Arnd
>> (cc'ed) had
>>> this discussion [1] before we decided the current approach. It'll be
>> good to
>>> check with Arnd too.
>>> 
>>> [1] ->  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-
>> May/253528.html
>> 
>> The problem I have here is the use of ranges does not necessarily mean
>> fewer address bits are available. It can be used just for convenience
>> of not putting the full address into every node's reg property. And
>> vice versa, there are probably plenty of cases where we have the full
>> address in the nodes, but really only some of the address bits are
>> decoded at the IP block. Whether the address bits are present is
>> rarely cared about or known by s/w folks until you hit a problem like
>> this. Given this is an isolated case ATM, I would fix it in an
>> isolated way. It does not affect the binding and could be changed in
>> the kernel later if this becomes a common need.
>> 
>> Rob
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
