Return-Path: <SRS0=xxzS=J3=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=xxzS=J3=broadcom.com=ray.jui@kernel.org>
Subject: Re: [PATCH v2 1/5] PCI: iproc: Activate PAXC bridge quirk for more
 devices
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-2-git-send-email-ray.jui@broadcom.com>
 <20180711131138.GE188359@bhelgaas-glaptop.roam.corp.google.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <6a931918-f5ba-1b80-658d-1f7ed1e8c84e@broadcom.com>
Date: Wed, 11 Jul 2018 09:52:31 -0700
MIME-Version: 1.0
In-Reply-To: <20180711131138.GE188359@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 7/11/2018 6:11 AM, Bjorn Helgaas wrote:
> On Mon, Jun 11, 2018 at 05:21:03PM -0700, Ray Jui wrote:
>> Activate PAXC bridge quirk for more PAXC based PCIe root complex with
>> the following PCIe device ID:
>> 0xd750, 0xd802, 0xd804
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> 
> Because this quirk_paxc_bridge() mechanism is already established,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 

Thanks!

> BUT, I would push back on quirk_paxc_bridge() if it were new code.
> 
> I think it would be much better to implement this in the driver's
> config accessors so lspci would show the correct things and the
> generic code that deals with pcie_mpss would work unmodified.
>

Noted.

I agree with you. I'll find time to improve this by moving them into the 
driver's config accessors in the future, after v4.19.

>> ---
>>   drivers/pci/quirks.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 2990ad1..47dfea0 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2195,6 +2195,9 @@ static void quirk_paxc_bridge(struct pci_dev *pdev)
>>   }
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
>>   #endif
>>   
>>   /* Originally in EDAC sources for i82875P:
>> -- 
>> 2.1.4
>>
