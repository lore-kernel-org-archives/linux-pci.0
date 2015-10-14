Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:35897 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbbJNJoh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2015 05:44:37 -0400
Message-ID: <561E23EB.7050504@hisilicon.com>
Date: Wed, 14 Oct 2015 17:44:11 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"jason@lakedaemon.net" <jason@lakedaemon.net>,
	"robh@kernel.org" <robh@kernel.org>,
	"gabriel.fernandez@linaro.org" <gabriel.fernandez@linaro.org>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	qiujiang <qiujiang@huawei.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	"Wangkefeng (Kevin)" <wangkefeng.wang@huawei.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com> <11677087.JbqAo0FWJE@wuerfel> <561E1957.5030503@hisilicon.com> <30775300.COZ4nEMWXC@wuerfel>
In-Reply-To: <30775300.COZ4nEMWXC@wuerfel>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/14 17:06, Arnd Bergmann wrote:
> On Wednesday 14 October 2015 16:59:03 Zhou Wang wrote:
>>
>> Hi Arnd,
>>
>> In Hip05 PCIe host, it uses GITS_TRANSLATER's address to get TLP package
>> which contains MSI address and MSI data, and then combine BDF and MSI data
>> to a 32 bit data which will be writen to GITS_TRANSLATER register of ITS.
>>
>> I think maybe this is a defect of our PCIe controller.
> 
> I'd consider it a bug in the firmware if this is not set up correctly
> before boot.
> 
>>> I don't think what you do here is safe because the 'reg' property
>>> of the MSI controller might point to the address that is used for
>>> the message directly.
>>
>> I see your point, however we must get address of GITS_TRANSLATER and
>> set it to PCIe host. How about adding necessary comments here?
> 
> This seems to just be static setup that should be done before Linux
> is even loaded. Any reason you can't do it that way?
>

There are some ITSs in Hip05-D02 platform, in fact, we can use any of them
as a msi-controller,  which we can configure in dts. I am afraid that
hard-setting the value in BIOS would lead to restrictions in terms of flexibility,
as with the current implementation the same BIOS-driver can fit different
DTS structures.

Regards,
Zhou

> 	Arnd
> 
> .
> 


