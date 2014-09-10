Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0140.outbound.protection.outlook.com ([157.56.111.140]:57280
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750719AbaIJD3C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Sep 2014 23:29:02 -0400
Message-ID: <5410361B.20005@freescale.com>
Date: Wed, 10 Sep 2014 11:29:31 +0000
From: Lian Minghuan-B31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
CC: "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: =?UTF-8?B?562U5aSNOiBbUEFUQ0ggMi8yXSBQQ0k6IExheWVyc2NhcGU6IEE=?=
 =?UTF-8?B?ZGQgTGF5ZXJzY2FwZSBQQ0llIGRyaXZlcg==?=
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
 <60096763.M59cqLJ4gm@wuerfel> <540F51F1.1060909@freescale.com>
 <10318509.zOTEUpfc9B@wuerfel>
In-Reply-To: <10318509.zOTEUpfc9B@wuerfel>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 2014年09月09日 11:58, Arnd Bergmann wrote:
> On Tuesday 09 September 2014 19:16:01 Lian Minghuan-B31939 wrote:
>> On 2014年09月09日 10:50, Arnd Bergmann wrote:
>>> On Tuesday 09 September 2014 18:46:59 Lian Minghuan-B31939 wrote:
>>>> On 2014年09月09日 09:56, Arnd Bergmann wrote:
>>>>> On Tuesday 09 September 2014 17:25:57 Lian Minghuan-B31939 wrote:
>>>>>> [Minghuan] I discussed with my colleague. They worry about performance
>>>>>> degradation if using regmap API,
>>>>>> because there are some fast device use scfg. We tend to use a simple way
>>>>>> to map andread/write scfg directly.
>>>>> I see. In this case, I would probably create a separate msi controller
>>>>> driver that owns the "fsl,ls1021a-scfg" device, and is referenced
>>>>> through the "msi-parent" property in the pcie controller.
>>>>>
>>>>> You can use of_pci_find_msi_chip_by_node() to get the msi_chip
>>>>> instance and then connect that to your pci host. This will also
>>>>> take care of the case where you may want to use the main GICv3
>>>>> on a future SoC.
>>>> [Minghuan] There is something wrong with LS1021A MSI hardware that it
>>>> only supports one interrupt not 32 interrupts.  Now, I do not want to
>>>> create a separate msi controller driver just for incorrect hardware.
>>>> I may provide complete MSI driver for the new hardware when it is ready.
>>> Would you just leave out MSI support for the LS1021A PCIe variant?
>>> I guess that's fine because all device drivers should also support
>>> legacy interrupts and there is no performance gain in MSI in this
>>> case.
>> [Minghuan] I have added MSI support for LS1021A PCIe just reserved 31
>> interrupts as used.
> I don't understand your logic then. If LS1021A has an incorrect MSI
> implementation, and you may want to reuse the PCIe driver with a
> future chip that either includes a correct MSI implementation, or
> with one that uses the GICv3 instead, isn't that even more reason
> to split out the MSI support into a separate driver?
>
> That way you can at least separate the normal code path from the
> broken one and don't need any special run-time or compile-conditionals
> beyond calling of_pci_find_msi_chip_by_node().
[Minghuan] The new MSI hardware implementation is not ready, I do not 
know how to describe its dts node
and how to implement its driver. When it is ready, I will implement the 
driver and add a workaround
for the current incorrect MSI. The current MSI driver is based on 
pci-designware.
> 	Arnd

