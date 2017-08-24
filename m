Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751168AbdHXUC6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Aug 2017 16:02:58 -0400
MIME-Version: 1.0
In-Reply-To: <20170824184321.19432-4-ard.biesheuvel@linaro.org>
References: <20170824184321.19432-1-ard.biesheuvel@linaro.org> <20170824184321.19432-4-ard.biesheuvel@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 24 Aug 2017 15:02:35 -0500
Message-ID: <CAL_JsqJTGeLv-c0wXCvMZggU4yzo__s-pD7qEZ7Q3w8=uUuu4Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: designware: add binding for
 Designware PCIe in ECAM mode
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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

Cc the DT list for bindings please.

On Thu, Aug 24, 2017 at 1:43 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Describe the binding for firmware-configured instances of the Synopsys
> Designware PCIe controller in RC mode.
>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt | 56 ++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt b/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
> new file mode 100644
> index 000000000000..b8127b19c220
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
> @@ -0,0 +1,56 @@
> +* Synopsys Designware PCIe root complex in ECAM mode
> +
> +In some cases, firmware may already have configured the Synopsys Designware
> +PCIe controller in RC mode with static ATU window mappings that cover all
> +config, MMIO and I/O spaces in a [mostly] ECAM compatible fashion.
> +In this case, there is no need for the OS to perform any low level setup
> +of clocks or device registers, nor is there any reason for the driver to
> +reconfigure ATU windows for config and/or IO space accesses at runtime.
> +
> +Such hardware configurations should be described as "pci-host-ecam-generic"
> +if they are truly ECAM compatible. Configurations that require no low-level
> +setup by the OS nor any ATU window reconfiguration at runtime, but do
> +require special handling for type 0 config TLPs may instead be described as
> +"snps,dw-pcie-ecam".

Humm, what happens when we have the next exception that's SoC specific
or another vendor? Seems like perhaps "firmware initialized" should
have been a separate property flag for bootloaders to add rather than
a compatible string.

I'd rather see this done in a way that does not require DT updates if
quirks have to be handled/added later.

Rob
