Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36915 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753527AbdGUUUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2017 16:20:19 -0400
Received: by mail-wr0-f173.google.com with SMTP id 33so29772895wrz.4
        for <linux-pci@vger.kernel.org>; Fri, 21 Jul 2017 13:20:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170720162255.36e015f1@ul30vt.home>
References: <1500511611-2019-1-git-send-email-fkan@apm.com> <20170720162255.36e015f1@ul30vt.home>
From: Feng Kan <fkan@apm.com>
Date: Fri, 21 Jul 2017 13:20:18 -0700
Message-ID: <CAL85gmBB=U_4jkChKwfZGPQR0zeoZ4=hg7e6HMnu-DS0u1-Wsg@mail.gmail.com>
Subject: Re: [PATCH V2] pci: quirk: Apply APM ACS quirk to XGene devices
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 20, 2017 at 3:22 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Wed, 19 Jul 2017 17:46:51 -0700
> Feng Kan <fkan@apm.com> wrote:
>
>> The APM X-Gene PCIe root port does not support ACS at this point.
>> However, the hw provides isolation and source validation through
>> the SMMU. Turn on ACS but disable all the peer to peer features.
>>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> ---
>>  drivers/pci/quirks.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 085fb78..0f8f1cd 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4120,6 +4120,19 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
>>       return acs_flags ? 0 : 1;
>>  }
>>
>> +static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
>> +{
>> +     /*
>> +      * XGene root matching this quirk do not allow peer-to-peer
>> +      * transactions with others, allowing masking out these bits as if they
>> +      * were unimplemented in the ACS capability.
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
>> @@ -4368,6 +4381,8 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
>>       { 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
>>       /* Cavium ThunderX */
>>       { PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
>> +     /* APM XGene */
>> +     { PCI_VENDOR_ID_AMCC, 0xE004, pci_quirk_xgene_acs },
>>       { 0 }
>>  };
>>
>
> Sorry, I'm not yet convinced there's an equivalent of SV, if a device
> spoofs a different bdf and it reaches the smmu, what prevents that from
> simply referencing the context for that alternate bdf?
Perhaps I am not understanding the question correctly. The bdf forms a
stream id which is used to provide an context. Since there is no actual
context created by an alternate bdf, the transaction would be rejected
by the SMMU.

The point of
> root port SV is to ensure that any forwarded transaction is within the
> downstream bdf range.  Thanks,
>
> Alex
