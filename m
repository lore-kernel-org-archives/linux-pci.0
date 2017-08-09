Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35174 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdHIFne (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2017 01:43:34 -0400
Received: by mail-pg0-f41.google.com with SMTP id v189so23855813pgd.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Aug 2017 22:43:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <735e0534-ab77-7440-fbc6-5b40598da445@broadcom.com>
References: <1502167455-10516-1-git-send-email-oza.oza@broadcom.com>
 <1502167455-10516-3-git-send-email-oza.oza@broadcom.com> <CAL_JsqL3dWA-0Sq-_8ufa-cwXZEbFQBJHCK-5wLp_xw5NrTHKw@mail.gmail.com>
 <CAMSpPPfjxbjaScqovegcRG6GBhkUutqgj3Ly1B+0_BnZN2Ewug@mail.gmail.com> <735e0534-ab77-7440-fbc6-5b40598da445@broadcom.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Wed, 9 Aug 2017 11:13:33 +0530
Message-ID: <CAMSpPPejuTn210aSYjApbz_Jx_tO7V1Fd6nSt96axm-9MFruhA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: iproc: Add optional brcm,pci-hotplug
To: Ray Jui <ray.jui@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com"
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oza Pawandeep <oza.pawandeep@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 9, 2017 at 10:57 AM, Ray Jui <ray.jui@broadcom.com> wrote:
>
>
> On 8/8/2017 10:22 PM, Oza Oza wrote:
>>
>> On Tue, Aug 8, 2017 at 7:50 PM, Rob Herring <robh+dt@kernel.org> wrote:
>>>
>>> Please send bindings to DT list.
>>
>> Sure, will do that.
>>
>>> On Mon, Aug 7, 2017 at 11:44 PM, Oza Pawandeep <oza.oza@broadcom.com>
>>> wrote:
>>>>
>>>> Add description for optional device tree property
>>>> 'brcm,pci-hotplug' for PCI hotplug feature.
>>>>
>>>> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>> b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>> index b8e48b4..a3bad24 100644
>>>> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>> @@ -72,6 +72,29 @@ Optional properties:
>>>>   - brcm,pcie-msi-inten: Needs to be present for some older iProc
>>>> platforms that
>>>>   require the interrupt enable registers to be set explicitly to enable
>>>> MSI
>>>>
>>>> +Optional properties:
>>>> +- brcm,pci-hotplug: PCI hotplug feature is supported.
>>>
>>> I think we should make this a common property. We already have
>>> "ibm,slot-pluggable", so I'd propose "slot-pluggable".
>>>
>>> There's also "hotpluggable" for memory nodes defined, so we could
>>> reuse that here.
>>>
>> ok I will rename this to
>> brcm,slot-pluggable
>
>
> How's brcm,slot-pluggable a common property? It's still brcm specific.
> Didn't Rob propose either "slot-pluggable" or "hotpluggable"?
>
> And note it goes to the generic PCI binding instead iProc PCIe specific
> binding.
>

Initially I thought, Rob suggested either "slot-pluggable".
followed by, "hotpluggable" since memory node already has such property.

but not sure in which generic pci binding I should add ?
should it be part of
Documentation/devicetree/bindings/pci/host-generic-pci.txt

Can you please clarify Rob ?

Regards,
Oza.
