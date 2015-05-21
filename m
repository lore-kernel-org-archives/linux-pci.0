Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:9002 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbbEUMaq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2015 08:30:46 -0400
Message-ID: <555DCFA4.7090104@hisilicon.com>
Date: Thu, 21 May 2015 20:29:24 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <liviu.dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, "Zhang Jukuo" <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, Liguozhu <liguozhu@hisilicon.com>
Subject: Re: [RFC PATCH v1 2/3] PCI: hisi: Add PCIe host support for Hisilicon
 Soc Hip05
References: <000101d092fb$94dde100$be99a300$@com> <555D37B0.2080909@hisilicon.com> <CAErSpo7TEgY=oJvLU3jyh=FcZqgsSxLi1Cw1mo6w+5WSRkfPMQ@mail.gmail.com>
In-Reply-To: <CAErSpo7TEgY=oJvLU3jyh=FcZqgsSxLi1Cw1mo6w+5WSRkfPMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/21 20:09, Bjorn Helgaas wrote:
> On Wed, May 20, 2015 at 8:41 PM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
>> On 2015/5/20 20:50, Jingoo Han wrote:
>>> On Wed, 20 May 2015 14:21:40 +0800, Zhou Wang wrote:
> 
>>>> +/* Configure vmid/asid table in PCIe host */
>>>> +static void hisi_pcie_config_context(struct hisi_pcie *pcie)
>>>> +{
>>>> +    int i;
>>>> +
>>>> +    hisi_pcie_change_apb_mode(pcie, PCIE_SLV_CONTENT_MODE);
>>>> +
>>>> +    for (i = 0; i < 0x400; i++)
>>>> +            hisi_pcie_apb_writel(pcie, 0x0, i * 4);
>>>> +
>>>> +    for (i = 0x400; i < 0x800; i++)
>>>> +            hisi_pcie_apb_writel(pcie, 0x0, i * 4);
>>>
>>> How about the following?
>>>
>>> +     for (i = 0; i < 0x800; i++)
>>> +             hisi_pcie_apb_writel(pcie, 0x0, i * 4);
>>>
>>
>> This is to configure init value of vmid and asid of each pcie device.
> 
> But the combined loop looks functionally equivalent, i.e., I don't
> think the device can tell the difference.  Personally I wouldn't mind
> if you kept the two loops separate, but if you do, each one needs a
> comment immediately before it so the reader has a clue that they are
> doing semantically different things.  Otherwise it just looks like a
> mistake and the reader wonders why they are split.
> 
> Bjorn

Got it. There is a vmid table and a asid table in host controll
registers. They are just adjoining as above. I will combine above loops
with more comments together.

Thanks and Regards,
Zhou

> 
> .
> 


