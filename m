Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:35663 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdGRRmm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2017 13:42:42 -0400
Received: by mail-wr0-f170.google.com with SMTP id w4so38422282wrb.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2017 10:42:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717202324.105e993c@w520.home>
References: <1500338752-30576-1-git-send-email-fkan@apm.com> <20170717202324.105e993c@w520.home>
From: Feng Kan <fkan@apm.com>
Date: Tue, 18 Jul 2017 10:42:40 -0700
Message-ID: <CAL85gmAsjSiThTujA=tbhceOd71ee3AVmGDaFhc3FMFWDsQ4HA@mail.gmail.com>
Subject: Re: [PATCH] pci: quirk: Apply APM ACS quirk to XGene devices
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Jonglih (Daniel) Yu" <jyu@apm.com>,
        "jcm@redhat.com" <jcm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 17, 2017 at 7:23 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Mon, 17 Jul 2017 17:45:52 -0700
> Feng Kan <fkan@apm.com> wrote:
>
>> The APM X-Gene PCIe root port does not support ACS at this point.
>> Since the root does not allow peer to peer transactions, mask out
>> ACS capability flag bits.
>>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> ---
>>  drivers/pci/quirks.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 085fb78..951064d 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4368,6 +4368,8 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
>>       { 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
>>       /* Cavium ThunderX */
>>       { PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
>> +     /* APM XGene */
>> +     { PCI_VENDOR_ID_AMCC, 0xE004, pci_quirk_mf_endpoint_acs },
>>       { 0 }
>>  };
>
>
> You're using the "mf_enpoint" quirk for something that is not an
> endpoint and may or may not be multi-function.  Downstream ports have
> different rules than multi-function endpoints and the quirk function is
> commented to reflect why certain fields are relevant or not to
> multi-function endpoints.  I don't think it's valid to use this quirk
> for other device types, we'd only need to accidentally test the assumed
> device type in that function to break you in the future.
Would creating another function like what Cavium did be sufficient?


Additionally,
> lack of peer to peer does not necessarily imply functionality like
> Source Validation, without which a device can spoof the requester ID.
> Thanks,
I can remove the statement.
>
> Alex
Alex, the goal here is to enable virtualization to work correctly.
Please let me know if the
above is sufficient. Much thanks.
>
