Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35882 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdCEHQP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Mar 2017 02:16:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170213214457.248084de@t450s.home>
References: <56ABC5AE.1050209@caviumnetworks.com> <20170213214457.248084de@t450s.home>
From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date: Sun, 5 Mar 2017 12:37:31 +0530
Message-ID: <CA+sq2CeV-YDkUViJVo9ioiYvAu0oxKJZxqgw8sDN9Lf7y4Gr-g@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add cavium acs pci quirk
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Manish Jaggi <mjaggi@caviumnetworks.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Tirumalesh Chalamarla <tchalamarla@cavium.com>,
        "Richter, Robert" <Robert.Richter@caviumnetworks.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 14, 2017 at 10:14 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Sat, 30 Jan 2016 01:33:58 +0530
> Manish Jaggi <mjaggi@caviumnetworks.com> wrote:
>
>> Cavium devices matching this quirk do not perform
>> peer-to-peer with other functions, allowing masking out
>> these bits as if they were unimplemented in the ACS capability.
>>
>> Acked-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
>> Signed-off-by: Manish Jaggi <mjaggi@caviumnetworks.com>
>> ---
>>  drivers/pci/quirks.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 7e32730..a300fa6 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3814,6 +3814,19 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
>>  #endif
>>  }
>>
>> +static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
>> +{
>> +     /*
>> +      * Cavium devices matching this quirk do not perform
>> +      * peer-to-peer with other functions, allowing masking out
>> +      * these bits as if they were unimplemented in the ACS capability.
>> +      */
>> +     acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
>> +                    PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
>> +
>> +     return acs_flags ? 0 : 1;
>> +}
>> +
>>  /*
>>   * Many Intel PCH root ports do provide ACS-like features to disable peer
>>   * transactions and validate bus numbers in requests, but do not provide an
>> @@ -3966,6 +3979,8 @@ static const struct pci_dev_acs_enabled {
>>       { PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
>>       { 0x19a2, 0x710, pci_quirk_mf_endpoint_acs }, /* Emulex BE3-R */
>>       { 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
>> +     /* Cavium ThunderX */
>> +     { PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
>>       { 0 }
>>  };
>>
>
> Apologies for not catching this, but what sort of crystal ball do you
> have that can predict not only current devices, but future devices will
> not support peer-to-peer features?  Is there an internal design
> guidelines reference specification for Cavium that we can realistically
> expect this to remain consistent, or is this just an attempt to never
> think about ACS again at the customer's peril?  What about the existing
> non-ThunderX products with Cavium vendor ID, does this really apply to
> those?  I would strongly suggest taking the device ID into account.
> See examples like the pci_quirk_intel_pch_acs quirk where the initial
> filter is PCI_ANY_ID, but specific device types and ranges of device
> IDs are identified by the function for evaluation.  This seems reckless
> to me and I'd advise that it be reverted.  Thanks,
>
> Alex

Just a thought, even if Cavium considers to support ACS for future devices,
wouldn't it be better to add exception list inside the quirk on a need basis
rather than adding big list of devices that don't. Especially when currently
almost all Cavium PCI devices don't support ACS.

Thanks,
Sunil.
