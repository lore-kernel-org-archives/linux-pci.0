Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:37342 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752751AbdHXUMX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2017 16:12:23 -0400
Received: by mail-it0-f43.google.com with SMTP id x187so2601345ite.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2017 13:12:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJTGeLv-c0wXCvMZggU4yzo__s-pD7qEZ7Q3w8=uUuu4Q@mail.gmail.com>
References: <20170824184321.19432-1-ard.biesheuvel@linaro.org>
 <20170824184321.19432-4-ard.biesheuvel@linaro.org> <CAL_JsqJTGeLv-c0wXCvMZggU4yzo__s-pD7qEZ7Q3w8=uUuu4Q@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Aug 2017 21:12:22 +0100
Message-ID: <CAKv+Gu-D0tgygJ84iGEoEU9OcjUwrtvS2Z2wrOHAZ9kO_kE_rA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: designware: add binding for
 Designware PCIe in ECAM mode
To: Rob Herring <robh@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 24 August 2017 at 21:02, Rob Herring <robh@kernel.org> wrote:
> Cc the DT list for bindings please.
>
> On Thu, Aug 24, 2017 at 1:43 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Describe the binding for firmware-configured instances of the Synopsys
>> Designware PCIe controller in RC mode.
>>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt | 56 ++++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt b/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
>> new file mode 100644
>> index 000000000000..b8127b19c220
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
>> @@ -0,0 +1,56 @@
>> +* Synopsys Designware PCIe root complex in ECAM mode
>> +
>> +In some cases, firmware may already have configured the Synopsys Designware
>> +PCIe controller in RC mode with static ATU window mappings that cover all
>> +config, MMIO and I/O spaces in a [mostly] ECAM compatible fashion.
>> +In this case, there is no need for the OS to perform any low level setup
>> +of clocks or device registers, nor is there any reason for the driver to
>> +reconfigure ATU windows for config and/or IO space accesses at runtime.
>> +
>> +Such hardware configurations should be described as "pci-host-ecam-generic"
>> +if they are truly ECAM compatible. Configurations that require no low-level
>> +setup by the OS nor any ATU window reconfiguration at runtime, but do
>> +require special handling for type 0 config TLPs may instead be described as
>> +"snps,dw-pcie-ecam".
>
> Humm, what happens when we have the next exception that's SoC specific
> or another vendor?

This is not SoC specific, but IP specific. We are working with two
different SoCs from completely different vendors that both synthesized
this IP with a 64 KB ATU window size, not expecting this to break ECAM
compatibility.

> Seems like perhaps "firmware initialized" should
> have been a separate property flag for bootloaders to add rather than
> a compatible string.
>

Yes, but then you still have 10 different drivers that all retain the
low-level bits that are all different between SoCs. That is exactly
what I want to get rid of, and usually we can do that with existing
bindings, because we simply expose it as pci-host-ecam-generic. Only
in this particular case, that doesn't fly due to the quirk.

> I'd rather see this done in a way that does not require DT updates if
> quirks have to be handled/added later.
>

Do you see a way that still allows us to keep the abstraction? I don't
want a flag, I simply don't want to expose any low-level specifics
about the device to the OS, beyond what it needs to use it in its
configured state.
