Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33130 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdHIFWt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2017 01:22:49 -0400
Received: by mail-pg0-f50.google.com with SMTP id u5so23711955pgn.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Aug 2017 22:22:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL3dWA-0Sq-_8ufa-cwXZEbFQBJHCK-5wLp_xw5NrTHKw@mail.gmail.com>
References: <1502167455-10516-1-git-send-email-oza.oza@broadcom.com>
 <1502167455-10516-3-git-send-email-oza.oza@broadcom.com> <CAL_JsqL3dWA-0Sq-_8ufa-cwXZEbFQBJHCK-5wLp_xw5NrTHKw@mail.gmail.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Wed, 9 Aug 2017 10:52:48 +0530
Message-ID: <CAMSpPPfjxbjaScqovegcRG6GBhkUutqgj3Ly1B+0_BnZN2Ewug@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: iproc: Add optional brcm,pci-hotplug
To: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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

On Tue, Aug 8, 2017 at 7:50 PM, Rob Herring <robh+dt@kernel.org> wrote:
> Please send bindings to DT list.

Sure, will do that.

>
> On Mon, Aug 7, 2017 at 11:44 PM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
>> Add description for optional device tree property
>> 'brcm,pci-hotplug' for PCI hotplug feature.
>>
>> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>
>> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> index b8e48b4..a3bad24 100644
>> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> @@ -72,6 +72,29 @@ Optional properties:
>>  - brcm,pcie-msi-inten: Needs to be present for some older iProc platforms that
>>  require the interrupt enable registers to be set explicitly to enable MSI
>>
>> +Optional properties:
>> +- brcm,pci-hotplug: PCI hotplug feature is supported.
>
> I think we should make this a common property. We already have
> "ibm,slot-pluggable", so I'd propose "slot-pluggable".
>
> There's also "hotpluggable" for memory nodes defined, so we could
> reuse that here.
>

ok I will rename this to
brcm,slot-pluggable

>> +
>> +If the brcm,pcie-hotplug property is present, the following properties become
>> +effective:
>> +
>> +- brcm,prsnt-gpio: Array of gpios, needs to be present if Hotplug is supported.
>
> prsnt-gpios

will take care.

>
>> +
>> +PCI hotplug implementation is SOC/Board specific, and also it depends on
>> +how add-in card is designed (e.g. how many present pins are implemented).
>> +
>> +If x8 card is connected, then it might be possible that all the
>> +3 present pins could go low, or at least one pin goes low.
>> +
>> +If x4 card is connected, then it might be possible that 2 present
>> +pins go low, or at least one pin goes low.
>> +
>> +Example:
>> +brcm,prsnt-gpio: <&pca9505 32 1>, <&pca9505 33 1>;
>> +This is x4 connector: monitoring max 2 present lines.
>> +brcm,prsnt-gpio: <&pca9505 32 1>, <&pca9505 33 1>, <&pca9505 34 1>;
>> +This is x8 connector: monitoring max 3 present lines.
>> +
>>  Example:
>>         pcie0: pcie@18012000 {
>>                 compatible = "brcm,iproc-pcie";
>> --
>> 1.9.1
>>
