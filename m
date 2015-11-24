Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db3on0123.outbound.protection.outlook.com ([157.55.234.123]:44807
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751811AbbKXPdI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2015 10:33:08 -0500
From: Ramon Fried <ramon.fried@tandemg.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: PCIe endpoint generic driver
Date: Tue, 24 Nov 2015 15:33:04 +0000
Message-ID: <AM2PR02MB0689D08FDBB116A8EDE4669AE8060@AM2PR02MB0689.eurprd02.prod.outlook.com>
References: <AM2PR02MB06895C98FE39F8BB6D958389E8060@AM2PR02MB0689.eurprd02.prod.outlook.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E162C98EA@lhreml503-mbs>
 <AM2PR02MB06897BD3549D017DCF17FE36E8060@AM2PR02MB0689.eurprd02.prod.outlook.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E162C9A21@lhreml503-mbs>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E162C9A21@lhreml503-mbs>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


>> -----Original Message-----
>> From: linux-pci-owner@vger.kernel.org 
>> [mailto:linux-pci-owner@vger.kernel.org]
>> On Behalf Of Ramon Fried
>> Sent: 24 November 2015 15:02
>> To: linux-pci@vger.kernel.org
>> Subject: RE: PCIe endpoint generic driver
>> 
>> > > Hi.
>> > > Sorry for the noob question :)
>> > > I'm currently developing a PCIe endpoint driver for a board that 
>> > > runs Linux.
>> > > The board will be used as an expansion PCIe card for x86 PC's.
>> > > Is there any guidelines, documentation related to PCI endpoint 
>> > > drivers for Linux kernel ?
>>> 
>> > Hi Ramon
>> >
>> > Have you looked at
>> > http://lxr.free-electrons.com/source/Documentation/PCI/pci.txt
>> >?
>> >
>> > Regards
>> >
>> > Gab
>> 
>> Hi Gab, you misunderstood my driver type.
>> This is not a host driver, that I'm writing, but the actual endpoint driver.
>> Then Linux is on the PCIe board.
>
> Hi Ramon, I understood your driver type.
> I think you misunderstood the Documentation.
> Host Bridges are under drivers/pci/host and none of them use pci_register_driver() API.
>
> pci_register_driver() is actually for endpoints. Please read the link above again.

Hi Gab.
Host bridges AFAIK are supposed to connect between the host CPU, main memory and the PCI itself.
This is not what I need as I'm not at the host side.
pci_register_driver() is a host driver for pci endpoints.

On the device side, pci_register_driver() doesn't make any sense. There's no root complex, no enumeration, etc.
I need for instance a method to send a MSI/MSIx interrupt to the host. I need to develop a function that does it.

My original question was if there's a framework/guidelines for achieving that.

Thanks.
Ramon
