Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34124 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbaBUF2q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 21 Feb 2014 00:28:46 -0500
Message-ID: <5306E3FE.1070405@ti.com>
Date: Fri, 21 Feb 2014 10:58:30 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: <jg1.han@samsung.com>, Mohit KUMAR DCG <Mohit.KUMAR@st.com>
CC: Ajay KHANDELWAL <ajay.khandelwal@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI:designware:Fix iATU programming for cfg1, io
 and mem viewport
References: <17773172.14231392946292058.JavaMail.weblogic@epml01>
In-Reply-To: <17773172.14231392946292058.JavaMail.weblogic@epml01>
Content-Type: text/plain; charset="EUC-KR"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 21 February 2014 07:01 AM, Jingoo Han wrote:
> On Thursday, February 20, 2014 10:34 PM, Mohit KUMAR DCG wrote:
>> Thursday, February 20, 2014 5:43 PM, Kishon Vijay Abraham I wrote:
>>> On Thursday 20 February 2014 05:28 PM, Mohit KUMAR DCG wrote:
>>>> On Thursday, February 20, 2014 5:08 PM, Kishon Vijay Abraham I wrote:
>>>>> On Thursday 20 February 2014 10:52 AM, Mohit Kumar wrote:
>>>>>> This patch correct iATU programming for cfg1, io and mem viewport.
>>>>>> Enable ATU only after configuring it.
>>>>>
>>>>> Does this patch actually fixes device enumeration behind a PCIe-pci
>>>>> bridge or this is more of cleaning up the sequence?
>>>>>
>>>> - This patch corrects ATU programming sequence. I am not aware of any
>>>> such issue with current driver. Pls specify  which bridge do you use in your
>>> setup and what is the problem?
>>>
>>> I tried with card [1], it had a PLX bridge chip. It couldn't read the configuration
>>> space of the device connected to the PCIe-PCI bridge.
>>>
>> - I don¡¯t have the mentioned card with me, but we are successfully using Lecroy PTC switch
>>  and SIL3124-2CB364 PCI-X compatible RAID card.
>>
>> May be Jingoo or others can also comment if they are using PCI bridge card.
>>
> 
> Hi Kishon,
> Nice to see you again. :-)
> 
> I don't have PCIe-PCI bridge. Currently, I can test Ethernet cards
> and SATA cards.

The problem seems to be seen only if a device is connected after PCIe-PCI
bridge. I've tested USB and Ethernet cards but that works just fine.
> 
> By the way, according to the Datasheet, PCIE_ATU_CR1 setting can be
> followed by PCIE_ATU_CR2 setting as below:
> 
>   1. Setup the Index Register.
>   2. Setup the Region Base and Limit Address Registers.
>   3. Setup the Target Address Registers.
>   4. Configure the region through the Region Control 1 Register.
>   5. Enable the region.
> 
> Thus, how about testing the following patch?
> I also moved PCIE_ATU_CR1 as well as PCIE_ATU_CR2.

Thanks for the patch. I have just burnt my PCIE-to-PCI bridge card :-s Will
test this once I get a new card.

Thanks
Kishon
