Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34733 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdGDB4V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2017 21:56:21 -0400
MIME-Version: 1.0
In-Reply-To: <fca21589-b01a-ea17-d03c-89eee75af744@oracle.com>
References: <5952D144.8060609@oracle.com> <CABawtvOHnQ12WvSNDn2gZRLAqLjAXUGXc8PObtdU5uBS6rpe_Q@mail.gmail.com>
 <fca21589-b01a-ea17-d03c-89eee75af744@oracle.com>
From: Ethan Zhao <ethan.kernel@gmail.com>
Date: Tue, 4 Jul 2017 09:56:19 +0800
Message-ID: <CABawtvOsKv0TeVHBS9zuruaWr3PrJV1RzyH8ay0i=_o=tfzj+A@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Workaround wrong flags completions for IDT switch
To: james puthukattukaran <james.puthukattukaran@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

James,

On Tue, Jul 4, 2017 at 2:17 AM, james puthukattukaran
<james.puthukattukaran@oracle.com> wrote:
>
> Ethan -
>
>
> On 7/2/2017 9:55 PM, Ethan Zhao wrote:
>>
>> James,
>>
>> On Wed, Jun 28, 2017 at 5:42 AM, James Puthukattukaran
>> <james.puthukattukaran@oracle.com> wrote:
>>>
>>> From: James Puthukattukaran <james.puthukattukaran@oracle.com>
>>>
>>> The IDT switch incorrectly flags an ACS source violation on a read conf=
ig
>>> request to an end point device on the completion (IDT 89H32H8G3-YC,
>>> errata #36) even though the PCI Express spec states that completions ar=
e
>>> never affected by ACS source violation (PCI Spec 3.1, Section 6.12.1.1)=
.
>>>
>>> The suggested workaround by IDT is to issue a configuration write to th=
e
>>> downstream device before issuing the first config read. This allows the
>>> downstream device to capture its bus number, thus avoiding the ACS
>>> violation on the completion.
>>>
>>> The patch does the following -
>>>
>>> 1. Disable ACS source violation if enabled
>>> 2. Wait for config space access to become available by reading vendor i=
d
>>> 3. Do a config write to the end point (errata workaround)
>>> 4. Enable ACS source validation (if it was enabled to begin with)
>>>
>>> -v2: move workaround to pci_bus_read_dev_vendor_id() from
>>> pci_bus_check_dev()
>>>       and move enable_acs_sv to drivers/pci/pci.c -- by Yinghai
>>> -v3: add bus->self check for root bus and virtual bus for sriov vfs.
>>> -v4: only do workaround for IDT switches
>>>
>>> Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>
>>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>>
>>> --
>>>
>>>   drivers/pci/pci.c   | 33 +++++++++++++++++++++++++++++++++
>>>   drivers/pci/pci.h   |  1 +
>>>   drivers/pci/probe.c | 38 ++++++++++++++++++++++++++++++++++++--
>>>   3 files changed, 70 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 563901c..a7a2e2b 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -2835,6 +2835,39 @@ static bool pci_acs_flags_enabled(struct pci_dev
>>> *pdev, u16 acs_flags)
>>>   }
>>>
>>>   /**
>>> + *  pci_std_enable_acs_sv - enable/disable ACS source validation if
>>> supported by the switch
>>> + *  @dev - pcie switch/RP
>>> + *  @enable - enable (1) or disable (0) source validation
>>> + *
>>> + *  Returns : < 0 on failure
>>
>> You didn't define the meaning of 0 and >0, but you check it later agains=
t
>> >0,
>> Then what does it mean 0 and >0 ?
>
> see below..
>>
>>
>>> + *           previous acs_sv state
>
>
> It returns the previous acs_sv state (0 or 1).

You didn't clarify the meaning of previous acs_sv state, or possible value,
you check it later with >0 also confused the possibility.


>>>
>>> + */
>>> +int pci_std_enable_acs_sv(struct pci_dev *dev, bool enable)
>>> +{
>>> +       int pos;
>>> +       u16 cap;
>>> +       u16 ctrl;
>>> +       int retval;
>>> +
>>> +       pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
>>> +       if (!pos)
>>> +               return -ENODEV;
>>> +
>>> +       pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
>>> +       pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
>>> +
>>> +       retval =3D !!(ctrl & cap & PCI_ACS_SV);
>>
>> If the device's ACS SV( ACS Source Validation) capability wasn't
>> implemented, the return value of this function will still tell us the
>> operation of enabling is successful ? though it might be rare case.
>
> If the ACS capability is implemented, then all bits are expected to have
> meaning and are valid. If SV is not implemented by the switch, the contro=
l
> bit for it should return zero (no source validation done). This is the PC=
I
> specification.  The onus is on the switch designer to keep it so.

PCI spec doesn't say SV must be implemented in every device even it
has ACS Cap, see also:

"6.12.1.2. ACS Functions in Multi-Function Devices This section
applies to multi-Function device ACS Functions, with the exception of
Downstream Port Functions, which are covered in the preceding section.
=EF=81=B1 ACS Source Validation: must not be implemented. 20 =EF=81=B1 ACS =
Translation
Blocking: must not be implemented. =EF=81=B1 ACS P2P Request Redirect: must=
 be
implemented by Functions that support peer-to-peer traffic with other
Functions.
"
Here pci_std_enable_acs_sv() is common function, once implemented,
possible be used by other code to enable acs beside this workaround.

Then how about it is called with a MF device ?

Thanks,
Ethan

>
> thanks,
> James
>
>
>>> +       if (enable)
>>> +               ctrl |=3D (cap & PCI_ACS_SV);
>>> +       else
>>> +               ctrl &=3D ~(cap & PCI_ACS_SV);
>>> +
>>> +       pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
>>> +
>>> +       return retval;
>>> +}
>>> +
>>> +/**
>>>    * pci_acs_enabled - test ACS against required flags for a given devi=
ce
>>>    * @pdev: device to test
>>>    * @acs_flags: required PCI ACS flags
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index f8113e5..3960c2a 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -343,6 +343,7 @@ static inline resource_size_t
>>> pci_resource_alignment(struct pci_dev *dev,
>>>   }
>>>
>>>   void pci_enable_acs(struct pci_dev *dev);
>>> +int pci_std_enable_acs_sv(struct pci_dev *dev, bool enable);
>>>
>>>   #ifdef CONFIG_PCIE_PTM
>>>   void pci_ptm_init(struct pci_dev *dev);
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 19c8950..c154a90 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -1763,8 +1763,8 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus=
)
>>>   }
>>>   EXPORT_SYMBOL(pci_alloc_dev);
>>>
>>> -bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l=
,
>>> -                               int crs_timeout)
>>> +static bool __pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devf=
n,
>>> +                                        u32 *l, int crs_timeout)
>>>   {
>>>          int delay =3D 1;
>>>
>>> @@ -1801,6 +1801,40 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus
>>> *bus,
>>> int devfn, u32 *l,
>>>
>>>          return true;
>>>   }
>>> +
>>> +bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l=
,
>>> +                               int crs_timeout)
>>> +{
>>> +       int found;
>>> +       int enable =3D -1;
>>> +       int idt_workaround =3D (bus->self && (bus->self->vendor =3D=3D
>>> PCI_VENDOR_ID_IDT));
>>> +       /*
>>> +        * Some IDT switches flag an ACS violation for config reads
>>> +        * even though the PCI spec allows for it (PCIe 3.1, 6.1.12.1)
>>> +        * It flags it because the bus number is not properly set in th=
e
>>> +        * completion. The workaround is to do a dummy write to properl=
y
>>> +        * latch number once the device is ready for config operations
>>> +        */
>>> +
>>> +       if (idt_workaround)
>>> +               enable =3D pci_std_enable_acs_sv(bus->self, false);
>>> +
>>> +       found =3D __pci_bus_read_dev_vendor_id(bus, devfn, l, crs_timeo=
ut);
>>> +
>>> +       /*
>>> +        * The fact that we can read the vendor id indicates that the
>>> device
>>> +        * is ready for config operations. Do the write as part of the
>>> errata
>>> +        * workaround.
>>> +        */
>>> +       if (idt_workaround) {
>>> +               if (found)
>>> +                       pci_bus_write_config_word(bus, devfn,
>>> PCI_VENDOR_ID,
>>> 0);
>>> +               if (enable > 0)
>>> +                       pci_std_enable_acs_sv(bus->self, enable);
>>> +       }
>>> +
>>> +       return found;
>>> +}
>>>   EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>>>
>
