Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:59495 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbcA0XCL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2016 18:02:11 -0500
Subject: Re: [PATCH v2] PCI: iproc: Fix BCMA PCIe bus scanning regression
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1453851100-15196-1-git-send-email-rjui@broadcom.com>
 <20160127225250.GA6379@localhost>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Rafal Milecki <zajec5@gmail.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <56A94C42.9090002@broadcom.com>
Date: Wed, 27 Jan 2016 15:01:22 -0800
MIME-Version: 1.0
In-Reply-To: <20160127225250.GA6379@localhost>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 1/27/2016 2:52 PM, Bjorn Helgaas wrote:
> On Tue, Jan 26, 2016 at 03:31:40PM -0800, Ray Jui wrote:
>> Commit 943ebae781f5 ("PCI: iproc: Add PAXC interface support") causes
>> regression on EP device detection on BCMA based platforms. This patch
>> fixes the issue by allowing multiple devices to be configured on the
>> same bus, for all PAXB based child buses. In addition, this patch also
>> adds check to prevent non-zero function from being used on bus 0 (root
>> bus).
>>
>> Function 'iproc_pcie_device_is_valid' is now removed with checks
>> folding into 'iproc_pcie_map_cfg_bus' to make them more clear and less
>> error-prone
>>
>> Reported-by: Rafal Milecki <zajec5@gmail.com>
>> Fixes: 943ebae781f5 ("PCI: iproc: Add PAXC interface support")
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>
> Since this fixes a regression, I applied this to for-linus for v4.5,
> thanks, Ray.

Thanks!

>
> I still have one clarification question below.
>
>> ---
>>   drivers/pci/host/pcie-iproc.c | 28 +++++++++++-----------------
>>   1 file changed, 11 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>> index 5816bce..67396ab 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c
>> @@ -170,20 +170,6 @@ static inline void iproc_pcie_ob_write(struct iproc_pcie *pcie,
>>   	writel(val, pcie->base + offset + (window * 8));
>>   }
>>
>> -static inline bool iproc_pcie_device_is_valid(struct iproc_pcie *pcie,
>> -					      unsigned int slot,
>> -					      unsigned int fn)
>> -{
>> -	if (slot > 0)
>> -		return false;
>> -
>> -	/* PAXC can only support limited number of functions */
>> -	if (pcie->type == IPROC_PCIE_PAXC && fn >= MAX_NUM_PAXC_PF)
>> -		return false;
>> -
>> -	return true;
>> -}
>> -
>>   /**
>>    * Note access to the configuration registers are protected at the higher layer
>>    * by 'pci_lock' in drivers/pci/access.c
>> @@ -199,11 +185,11 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>>   	u32 val;
>>   	u16 offset;
>>
>> -	if (!iproc_pcie_device_is_valid(pcie, slot, fn))
>> -		return NULL;
>> -
>>   	/* root complex access */
>>   	if (busno == 0) {
>> +		if (slot > 0 || fn > 0)
>> +			return NULL;
>> +
>
> This looks good and makes sense since config access to root bus is
> fundamentally different from other access.
>

The new code does look cleaner. Thanks for the suggestion!


>>   		iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_IND_ADDR,
>>   				     where & CFG_IND_ADDR_MASK);
>>   		offset = iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_IND_DATA);
>> @@ -213,6 +199,14 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>>   			return (pcie->base + offset);
>>   	}
>>
>> +	/*
>> +	 * PAXC is connected to internally emulated EP within the SoC. It
>> +	 * allows only one device and supports limited number of functions
>> +	 */
>> +	if (pcie->type == IPROC_PCIE_PAXC)
>> +		if (slot > 0 || fn >= MAX_NUM_PAXC_PF)
>> +			return NULL;
>
> Is this really necessary?  I assume 00:00.0 is a Root Port leading to
> bus 01, and 01:00.0, 01:00.1, 01:00.2, and 01:00.3 are the functions
> of the internal EP.  So this test prevents us from issuing a config
> request to devices like 01:00.4.
>
> I would assume the Root Port is standard and would handle a config
> request for 01:00.4 correctly, i.e., convert the type 1 request to
> type 0 (since it targets the Root Port's secondary bus), and forward
> it to the link.
>
> The endpoint should be responsible for handling it as an Unsupported
> Request, since it addresses an unimplemented function.  But maybe this
> embedded EP doesn't do that correctly?
>

Okay. I'll need to do slightly more investigation and experiment on this 
and after that I'll get back to you. It might take a while since I'm now 
extremely busy with some other tasks.... :(

In addition, this behavior might change slightly between A0 and B0 
revision of our chip....

> Also, assuming we *do* need this PAXC testing, do you want to test for
> "busno == 1" as well?  The PCI core shouldn't try to access bus 2
> unless there's a bridge from bus 1 to bus 2, but a user could use
> things like setpci to issue random config requests.
>
>> +
>>   	/* EP device access */
>>   	val = (busno << CFG_ADDR_BUS_NUM_SHIFT) |
>>   		(slot << CFG_ADDR_DEV_NUM_SHIFT) |
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
