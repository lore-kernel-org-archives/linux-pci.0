Return-Path: <SRS0=kwRk=2I=gmail.com=ddaney.cavm@kernel.org>
Return-Path: <SRS0=kwRk=2I=gmail.com=ddaney.cavm@kernel.org>
Subject: Re: [PATCH] PCI: Add cavium acs pci quirk
To: Bjorn Helgaas <helgaas@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Manish Jaggi <mjaggi@caviumnetworks.com>,
 Tirumalesh Chalamarla <tchalamarla@cavium.com>
References: <56ABC5AE.1050209@caviumnetworks.com>
 <20170213214457.248084de@t450s.home>
 <20170214150722.GC8080@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 "Richter, Robert" <Robert.Richter@caviumnetworks.com>,
 Bjorn Helgaas <bhelgaas@google.com>
From: David Daney <ddaney.cavm@gmail.com>
Message-ID: <b9192b8b-5105-f78a-70dc-607778b78b95@gmail.com>
Date: Mon, 27 Feb 2017 11:02:19 -0800
MIME-Version: 1.0
In-Reply-To: <20170214150722.GC8080@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 02/14/2017 07:07 AM, Bjorn Helgaas wrote:
> On Mon, Feb 13, 2017 at 09:44:57PM -0700, Alex Williamson wrote:
>> On Sat, 30 Jan 2016 01:33:58 +0530
>> Manish Jaggi <mjaggi@caviumnetworks.com> wrote:
>>
>>> Cavium devices matching this quirk do not perform
>>> peer-to-peer with other functions, allowing masking out
>>> these bits as if they were unimplemented in the ACS capability.
>>>
>>> Acked-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
>>> Signed-off-by: Manish Jaggi <mjaggi@caviumnetworks.com>
>>> ---
>>>  drivers/pci/quirks.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 7e32730..a300fa6 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -3814,6 +3814,19 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
>>>  #endif
>>>  }
>>>
>>> +static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
>>> +{
>>> +	/*
>>> +	 * Cavium devices matching this quirk do not perform
>>> +	 * peer-to-peer with other functions, allowing masking out
>>> +	 * these bits as if they were unimplemented in the ACS capability.
>>> +	 */
>>> +	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
>>> +		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
>>> +
>>> +	return acs_flags ? 0 : 1;
>>> +}
>>> +
>>>  /*
>>>   * Many Intel PCH root ports do provide ACS-like features to disable peer
>>>   * transactions and validate bus numbers in requests, but do not provide an
>>> @@ -3966,6 +3979,8 @@ static const struct pci_dev_acs_enabled {
>>>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
>>>  	{ 0x19a2, 0x710, pci_quirk_mf_endpoint_acs }, /* Emulex BE3-R */
>>>  	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
>>> +	/* Cavium ThunderX */
>>> +	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
>>>  	{ 0 }
>>>  };
>>>
>>
>> Apologies for not catching this, but what sort of crystal ball do you
>> have that can predict not only current devices, but future devices will
>> not support peer-to-peer features?  Is there an internal design
>> guidelines reference specification for Cavium that we can realistically
>> expect this to remain consistent, or is this just an attempt to never
>> think about ACS again at the customer's peril?  What about the existing
>> non-ThunderX products with Cavium vendor ID, does this really apply to
>> those?  I would strongly suggest taking the device ID into account.
>> See examples like the pci_quirk_intel_pch_acs quirk where the initial
>> filter is PCI_ANY_ID, but specific device types and ranges of device
>> IDs are identified by the function for evaluation.  This seems reckless
>> to me and I'd advise that it be reverted.  Thanks,
>
> I'd be happy to revert this, but it would be easier if somebody sent a
> patch and a changelog.
>

I agree that it should be reverted.

I was hoping that Manish or Tirumalesh would fix this properly by only 
activating the quirk on the faulty hardware, but such a fix has never 
appeared.

David Daney
