Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: iproc: Fix BCMA PCIe bus scanning regression
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1453330510-21926-1-git-send-email-rjui@broadcom.com>
 <20160126182239.GA17600@localhost>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Rafal Milecki <zajec5@gmail.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <56A7BCE0.8090404@broadcom.com>
Date: Tue, 26 Jan 2016 10:37:20 -0800
MIME-Version: 1.0
In-Reply-To: <20160126182239.GA17600@localhost>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 1/26/2016 10:22 AM, Bjorn Helgaas wrote:
> Hi Ray,
>
> On Wed, Jan 20, 2016 at 02:55:10PM -0800, Ray Jui wrote:
>> Commit 943ebae781f5 ("PCI: iproc: Add PAXC interface support") causes
>> regression on EP device detection on BCMA based platforms. This patch
>> fixes the issue by allowing multiple devices to be configured on the
>> same bus, for all PAXB based child buses
>>
>> Reported-by: Rafal Milecki <zajec5@gmail.com>
>> Fixes: 943ebae781f5 ("PCI: iproc: Add PAXC interface support")
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> ---
>>   drivers/pci/host/pcie-iproc.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>> index 5816bce..4627561 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c
>> @@ -171,10 +171,11 @@ static inline void iproc_pcie_ob_write(struct iproc_pcie *pcie,
>>   }
>>
>>   static inline bool iproc_pcie_device_is_valid(struct iproc_pcie *pcie,
>> +					      unsigned int busnum,
>>   					      unsigned int slot,
>>   					      unsigned int fn)
>>   {
>> -	if (slot > 0)
>> +	if ((pcie->type == IPROC_PCIE_PAXC || busnum == 0) && slot > 0)
>>   		return false;
>>
>>   	/* PAXC can only support limited number of functions */
>
> I don't understand this.  Here's the whole function (with this patch
> applied):
>
>      static inline bool iproc_pcie_device_is_valid(struct iproc_pcie *pcie,
> 						  unsigned int busnum,
> 						  unsigned int slot,
> 						  unsigned int fn)
>      {
> 	    if ((pcie->type == IPROC_PCIE_PAXC || busnum == 0) && slot > 0)
> 		    return false;
>
> 	    /* PAXC can only support limited number of functions */
> 	    if (pcie->type == IPROC_PCIE_PAXC && fn >= MAX_NUM_PAXC_PF)
> 		    return false;
>
> 	    return true;
>      }
>
> This says:
>
>    - On bus 00, device 0 is the only valid device.  That seems
>      plausible because the devices on bus 00 are probably built-in to
>      the SoC.
>
>    - On PAXC-based systems, device 0 is the only valid device on *any*
>      bus.  Is that really true?  If there's any way to add a plug-in
>      card, this seems overly restrictive.

Yah, PAXC is connected with one internal device within the SoC. There's 
no connection brought out of the chip.

>
>      PCIe devices are generally all device 0, but this would mean you
>      cannot plug in a PCIe-to-PCI bridge leading to a PCI device with a
>      non-zero device number.
>
>      I think it also means you could not plug in a PCIe device with ARI
>      enabled, because I think we store the upper 5 bits of the 8-bit
>      ARI function number in the PCI_SLOT bits.
>
>    - On PAXC-based systems, only functions 0, 1, 2, and 3 are valid
>      anywhere in the hierarchy.  I think this again restricts what what
>      cards can be plugged in.

Yes, the internal device connected to PAXC supports 4 physical functions.

>
> If iProc only supports devices built directly into the SoC, maybe
> these constraints are valid.  But if it supports any plugin or
> external devices, they don't seem to make sense.

Correct. PAXC only connects to one built-in device, while PAXB can 
support external EP devices.

>
> Also, is it the case that an iProc root bus is always bus number zero?
> That's certainly not the case for many other host controllers, but
> maybe you only have one possible host controller per system and the
> base number is not programmable.

An iProc based SoC can potentially have multiple root complexes, with 
each of them resides on separate PCIe domain (and always on bus 0). I 
think this is similar to how Exynos PCIe host controller is modeled.

>
> Bjorn
>

Thanks,

Ray
