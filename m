Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:40184 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab3H1M6X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 08:58:23 -0400
Received: by mail-ie0-f173.google.com with SMTP id qa5so4637587ieb.18
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 05:58:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <521D3F81.5010003@gmail.com>
References: <CAErSpo6pCzw6Gjn+SCFhu7PnBpHkUz0oqO+tGmmOH8NxoMiH6g@mail.gmail.com>
 <1377621883-6707-1-git-send-email-liuj97@gmail.com> <CAErSpo4B8XTfgq+eQsPZwrEkJ0cG81CskPrtFZWTwuoRBkp8ww@mail.gmail.com>
 <521D3F81.5010003@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 28 Aug 2013 06:58:02 -0600
Message-ID: <CAErSpo7YhokZip4gEo=_gva+26UZF5vfNa-yeLg=UPMspaf06g@mail.gmail.com>
Subject: Re: [PATCH] PCI: correctly check availability of PCIe Link
 Cap/Status/Control registers
To: Jiang Liu <liuj97@gmail.com>
Cc: Yuval Mintz <yuvalmin@broadcom.com>,
	"jacob . e . keller @ intel . com" <jacob.e.keller@intel.com>,
	Yu Zhao <yu.zhao@intel.com>, Jiang Liu <jiang.liu@huawei.com>,
	"linux-pci @ vger . kernel . org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 27, 2013 at 6:08 PM, Jiang Liu <liuj97@gmail.com> wrote:
> On 08/28/2013 01:07 AM, Bjorn Helgaas wrote:
>> On Tue, Aug 27, 2013 at 10:44 AM, Jiang Liu <liuj97@gmail.com> wrote:
>>> From: Jiang Liu <jiang.liu@huawei.com>
>>>
>>> PCIe Base Spec 1.0 Section 5.8 states that "The PCI Express Capabilities,
>>> Device Capabilities, Device Status/Control, Link Capabilities and
>>> Link Status/Control registers are required for all PCI Express devices."
>>
>> And spec 1.1 amended that (in sec 7.8, not 5.8) to say that the link
>> registers are not required for Root Complex Integrated Endpoints.
>> Integrated endpoints and event collectors don't have links, so even if
>> some RC-integrated devices do implement link registers per spec 1.0, I
>> don't think there's any point in allowing access to them.
> Hi Bjorn,
>         Sorry, I haven't noticed that PCIe Base spec 1.1 has modified
> the definition without changing the PCIe capability version. So seems
> we should remove the "pcie_cap_version(dev) == 1" check and just
> verify PCIe express device types. Which form do you prefer?

The "pcie_cap_version(dev) > 1" test is based on the spec r3.0
language to the effect that "For Functions that do not implement the
[Device, Link, Slot, Root] registers, these spaces must be hardwired
to 0b."  That means that for v2 capabilities, we don't need to check
the device type at all.  I think we should keep that check so the
structure of pcie_cap_has_lnkctl() remains similar to
pcie_cap_has_sltctl() and pcie_cap_has_rtctl().

It might be more obvious what we're doing if we restructured them all
in the form of:

    if (pcie_cap_version(dev) == 1)
        return type == PCI_EXP_TYPE_ROOT_PORT ||
                type == PCI_EXP_TYPE_ENDPOINT ||
                ...;
    return true;

That would make it more clear that for v1 capabilities, we have to
make extra checks, and for v2 capabilities, we rely on the r3.0 spec
language.

> !(type == PCI_EXP_TYPE_RC_END || type == PCI_EXP_TYPE_RC_EC)
> or
> type == PCI_EXP_TYPE_ENDPOINT ||
> type == PCI_EXP_TYPE_LEG_END ||
> type == PCI_EXP_TYPE_ROOT_PORT ||
> type == PCI_EXP_TYPE_UPSTREAM ||
> type == PCI_EXP_TYPE_DOWNSTREAM ||
> type == PCI_EXP_TYPE_PCI_BRIDGE ||
> type == PCI_EXP_TYPE_PCIE_BRIDGE;

I don't really care which of these styles we use.  Either way seems
future-proof, since no new device type should ever be added with a v1
capability.  Yours has the advantage of being stated in the positive,
which is a good aid to understanding.

>>> And PCIe Base Spec 3.0 Section 7.8 states that "The Link Capabilities,
>>> Link Status, and Link Control registers are required for all Root Ports,
>>> Switch Ports, Bridges, and Endpoints that are not Root Complex Integrated
>>> Endpoints."
>>>
>>> Changeset 1b6b8ce2ac372e "PCI: only save/restore existent registers in the
>>> PCIe capability" introduces pcie_cap_has_lnkctl(), which assumes:
>>> 1) PCIe root port, endpoint and legacy endpoint with 1.0 PCIe Capability
>>>    implement Link Cap/Status/Control registers.
>>> 2) All PCIe devices with 2.0 PCIe Capability implemnet Link Cap/Status/
>>>    Control registers.
>>>
>>> The above assumptions don't conform to PCIe base specifications, so change
>>> pcie_cap_has_lnkctl() to follow PCIe specifications.
>>>
>>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>>> ---
>>> Hi Bjorn,
>>>         Yuval has a PCIe 1.0 swither, so triggers the bug.  I'm not sure
>>> why Yu Zhao has implemented pcie_cap_has_linctl() in that way, any special
>>> consideration here?
>>>
>>> Hi Yuval,
>>>         Could you please help to test this patch? Due to hardware resource
>>> constraints, I have just compiled the patch on my laptop without testing.
>>>
>>> Thanks!
>>>
>>> ---
>>>  drivers/pci/access.c | 12 ++++++++----
>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>>> index 1cc2366..23ff366 100644
>>> --- a/drivers/pci/access.c
>>> +++ b/drivers/pci/access.c
>>> @@ -484,10 +484,14 @@ static inline bool pcie_cap_has_lnkctl(const struct pci_dev *dev)
>>>  {
>>>         int type = pci_pcie_type(dev);
>>>
>>> -       return pcie_cap_version(dev) > 1 ||
>>> -              type == PCI_EXP_TYPE_ROOT_PORT ||
>>> -              type == PCI_EXP_TYPE_ENDPOINT ||
>>> -              type == PCI_EXP_TYPE_LEG_END;
>>> +       return  pcie_cap_version(dev) == 1 ||
>>> +               type == PCI_EXP_TYPE_ENDPOINT ||
>>> +               type == PCI_EXP_TYPE_LEG_END ||
>>> +               type == PCI_EXP_TYPE_ROOT_PORT ||
>>> +               type == PCI_EXP_TYPE_UPSTREAM ||
>>> +               type == PCI_EXP_TYPE_DOWNSTREAM ||
>>> +               type == PCI_EXP_TYPE_PCI_BRIDGE ||
>>> +               type == PCI_EXP_TYPE_PCIE_BRIDGE;
>>>  }
>>>
>>>  static inline bool pcie_cap_has_sltctl(const struct pci_dev *dev)
>>> --
>>> 1.8.1.2
>>>
>
