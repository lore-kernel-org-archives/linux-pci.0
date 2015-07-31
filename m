Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34930 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbbGaQx0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jul 2015 12:53:26 -0400
MIME-Version: 1.0
In-Reply-To: <55BB8CC6.1080203@ti.com>
References: <1438010223-124422-1-git-send-email-gabriele.paoloni@huawei.com>
 <20150729172053.GE31170@google.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D6F350@lhreml503-mbs>
 <CAL_JsqKs11-sXQTdBD+ZjbVYFWUHBARTW9q5MF1hCXUhZ+nWLQ@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D6F94A@lhreml503-mbs> <20150730161447.GG9640@google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D6FB3B@lhreml503-mbs> <20150730171445.GI9640@google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D6FC15@lhreml503-mbs> <CAL_Jsq+aQVakaZf4xo7sxnVyTmPR+HJ-9ByyS6OYJ0PHDYOwmg@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D70589@lhreml503-mbs> <55BB8CC6.1080203@ti.com>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 31 Jul 2015 11:53:06 -0500
Message-ID: <CAL_JsqJqjiWVaKs-3ghQ1EBQzRRQ38GzkMV+FELPj53bSF-yXQ@mail.gmail.com>
Subject: Re: [PATCH v6] PCI: Store PCIe bus address in struct of_pci_range
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
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
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 31, 2015 at 9:57 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> +Arnd
>
> Hi,
>
> On Friday 31 July 2015 07:55 PM, Gabriele Paoloni wrote:
>> [+cc Kishon]
>>
>>> -----Original Message-----
>>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>>> owner@vger.kernel.org] On Behalf Of Rob Herring
>>> Sent: Thursday, July 30, 2015 9:42 PM
>>> To: Gabriele Paoloni
>>> Cc: Bjorn Helgaas; arnd@arndb.de; lorenzo.pieralisi@arm.com; Wangzhou
>>> (B); robh+dt@kernel.org; james.morse@arm.com; Liviu.Dudau@arm.com;
>>> linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>> devicetree@vger.kernel.org; Yuanzhichang; Zhudacai; zhangjukuo;
>>> qiuzhenfa; Liguozhu (Kenneth); Jingoo Han; Pratyush Anand
>>> Subject: Re: [PATCH v6] PCI: Store PCIe bus address in struct
>>> of_pci_range
>>>
>>> On Thu, Jul 30, 2015 at 12:34 PM, Gabriele Paoloni
>>> <gabriele.paoloni@huawei.com> wrote:
>>>>> -----Original Message-----
>>>>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>>>>> Sent: 30 July 2015 18:15
>>>>> On Thu, Jul 30, 2015 at 04:50:55PM +0000, Gabriele Paoloni wrote:
>>>>>>> -----Original Message-----
>>>>>>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>>>>>>> owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
>>>>>>> Sent: Thursday, July 30, 2015 5:15 PM
>>>>>>> On Thu, Jul 30, 2015 at 01:52:13PM +0000, Gabriele Paoloni wrote:
>>>
>>> [...]
>>>
>>>>>>>> I don’t think we should rely on [CPU] addresses...what if the
>>>>>>> intermediate
>>>>>>>> translation layer changes the lower significant bits of the
>>> "bus
>>>>>>> address"
>>>>>>>> to translate into a cpu address?
>>>>>>>
>>>>>>> Is it really a possiblity that the lower bits could be changed?
>>>>>>
>>>>>> I've checked all the current deignware users DTs except "pci-
>>>>> layerscape"
>>>>>> that I could not find:
>>>>>> spear1310.dtsi
>>>>>> spear1340.dtsi
>>>>>> dra7.dtsi
>>>>>> imx6qdl.dtsi
>>>>>> imx6sx.dtsi
>>>>>> keystone.dtsi
>>>>>> exynos5440.dtsi
>>>>>>
>>>>>> None of them modifies the lower bits. To be more precise the only
>>> guy
>>>>>> that provides another translation layer is "dra7.dtsi":
>>>>>> axi0
>>>>>> http://lxr.free-
>>> electrons.com/source/arch/arm/boot/dts/dra7.dtsi#L207
>>>>>>
>>>>>> axi1
>>>>>> http://lxr.free-
>>> electrons.com/source/arch/arm/boot/dts/dra7.dtsi#L241
>>>>>>
>>>>>> For this case masking the top 4bits (bits28 to 31) should make the
>>> job.
>>>
>>> IMO, we should just fix this case. After further study, I don't think
>>> this is a DW issue, but rather an SOC integration issue.
>>>
>>> I believe you can just fixup the address in the pp->ops->host_init hook.
>>>
>>
>> Yes I guess that I could just assign pp->(*)_mod_base to the CPU address
>> in DW and mask it out in dra7xx_pcie_host_init()...
>>
>> Kishon, would you be ok with that?
>
> Initially I was using *base-mask* property from dt. Me and Arnd (cc'ed) had
> this discussion [1] before we decided the current approach. It'll be good to
> check with Arnd too.
>
> [1] ->  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/253528.html

The problem I have here is the use of ranges does not necessarily mean
fewer address bits are available. It can be used just for convenience
of not putting the full address into every node's reg property. And
vice versa, there are probably plenty of cases where we have the full
address in the nodes, but really only some of the address bits are
decoded at the IP block. Whether the address bits are present is
rarely cared about or known by s/w folks until you hit a problem like
this. Given this is an isolated case ATM, I would fix it in an
isolated way. It does not affect the binding and could be changed in
the kernel later if this becomes a common need.

Rob
