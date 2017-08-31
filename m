Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbdHaOXv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Aug 2017 10:23:51 -0400
MIME-Version: 1.0
In-Reply-To: <20170828180437.2646-3-ard.biesheuvel@linaro.org>
References: <20170828180437.2646-1-ard.biesheuvel@linaro.org> <20170828180437.2646-3-ard.biesheuvel@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 31 Aug 2017 09:23:29 -0500
Message-ID: <CAL_Jsq+SE_+yAaPT_bYj-s6yyc22s0n-KzZtmzp8muKnb_iANw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: designware: add binding for
 Designware PCIe in ECAM mode
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 28, 2017 at 1:04 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Describe the binding for firmware-configured instances of the Synopsys
> Designware PCIe controller in RC mode, that are almost but not quite
> ECAM compliant.
>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt | 42 ++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
