Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:25295 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbcA1XMW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2016 18:12:22 -0500
Subject: Re: [PATCH v2] PCI: iproc: Fix BCMA PCIe bus scanning regression
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1453851100-15196-1-git-send-email-rjui@broadcom.com>
 <20160127225250.GA6379@localhost> <56A94C42.9090002@broadcom.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Rafal Milecki <zajec5@gmail.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <56AAA040.2010305@broadcom.com>
Date: Thu, 28 Jan 2016 15:12:00 -0800
MIME-Version: 1.0
In-Reply-To: <56A94C42.9090002@broadcom.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 1/27/2016 3:01 PM, Ray Jui wrote:
>
>
> On 1/27/2016 2:52 PM, Bjorn Helgaas wrote:
>> On Tue, Jan 26, 2016 at 03:31:40PM -0800, Ray Jui wrote:
>>> Commit 943ebae781f5 ("PCI: iproc: Add PAXC interface support") causes
>>> regression on EP device detection on BCMA based platforms. This patch
>>> fixes the issue by allowing multiple devices to be configured on the
>>> same bus, for all PAXB based child buses. In addition, this patch also
>>> adds check to prevent non-zero function from being used on bus 0 (root
>>> bus).
>>>
>>> Function 'iproc_pcie_device_is_valid' is now removed with checks
>>> folding into 'iproc_pcie_map_cfg_bus' to make them more clear and less
>>> error-prone
>>>
>>> Reported-by: Rafal Milecki <zajec5@gmail.com>
>>> Fixes: 943ebae781f5 ("PCI: iproc: Add PAXC interface support")
>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
...
...
>>>           iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_IND_ADDR,
>>>                        where & CFG_IND_ADDR_MASK);
>>>           offset = iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_IND_DATA);
>>> @@ -213,6 +199,14 @@ static void __iomem
>>> *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>>>               return (pcie->base + offset);
>>>       }
>>>
>>> +    /*
>>> +     * PAXC is connected to internally emulated EP within the SoC. It
>>> +     * allows only one device and supports limited number of functions
>>> +     */
>>> +    if (pcie->type == IPROC_PCIE_PAXC)
>>> +        if (slot > 0 || fn >= MAX_NUM_PAXC_PF)
>>> +            return NULL;
>>
>> Is this really necessary?  I assume 00:00.0 is a Root Port leading to
>> bus 01, and 01:00.0, 01:00.1, 01:00.2, and 01:00.3 are the functions
>> of the internal EP.  So this test prevents us from issuing a config
>> request to devices like 01:00.4.
>>
>> I would assume the Root Port is standard and would handle a config
>> request for 01:00.4 correctly, i.e., convert the type 1 request to
>> type 0 (since it targets the Root Port's secondary bus), and forward
>> it to the link.
>>
>> The endpoint should be responsible for handling it as an Unsupported
>> Request, since it addresses an unimplemented function.  But maybe this
>> embedded EP doesn't do that correctly?
>>
>
> Okay. I'll need to do slightly more investigation and experiment on this
> and after that I'll get back to you. It might take a while since I'm now
> extremely busy with some other tasks.... :(
>
> In addition, this behavior might change slightly between A0 and B0
> revision of our chip....
>

It turns out I do manage to find some time to test this today, :)

Bjorn, you are right. The additional check for function number is indeed 
redundant. It doesn't cause any issue now but will limit the number of 
physical functions to be supported on PAXC in our next-gen SoC.

I will submit another patch to remove the check.

Thanks,

Ray
