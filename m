Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:33703 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdH2Pkb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2017 11:40:31 -0400
Received: by mail-io0-f179.google.com with SMTP id s101so21876240ioe.0
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2017 08:40:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170828180437.2646-1-ard.biesheuvel@linaro.org>
References: <20170828180437.2646-1-ard.biesheuvel@linaro.org>
From: Marcin Wojtas <mw@semihalf.com>
Date: Tue, 29 Aug 2017 17:40:30 +0200
Message-ID: <CAPv3WKfzwA6C_jvw1i39q2X34PPLtDAipJMKuGvKh2fb8SPe_A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] pci: add support for firmware initialized
 designware RCs
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-pci@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ard,

It works on Armada 8040 MacchiatoBin board with e1000 card. You can add my:

Tested-by: Marcin Wojtas <mw@semihalf.com>

Best regards,
Marcin

2017-08-28 20:04 GMT+02:00 Ard Biesheuvel <ard.biesheuvel@linaro.org>:
> UEFI based systems incorporating a Synopsys Designware PCIe controller
> in RC mode will typically configure it before entering the OS. If this
> configuration is fully static and ECAM compliant, there is no need to
> expose particulars of the device to the OS, and we can simply describe
> it as "pci-host-ecam-generic".
>
> However, the Synopsys IP may be synthesized in a way where a quirk is
> needed for config space accesses to the first bus. It makes little sense
> to instantiate yet another pcie-designware driver that contains all the
> low level setup code, but it is also not justified to add quirks handling
> to the generic ECAM driver.
>
> So instead, create a variant of the generic ECAM driver that filters config
> space accesses directed at device #1 and up on the first bus.
>
> v3: - use SoC specific compatible strings
>     - drop MSI patch [for now], since it turns out we may not need it
>
> v2: - use dev->fwnode directly
>     - replace an instance of pr_err with dev_err, and clarify the error message
>     - fix Kconfig/Makefile dependency errors reported by kbuild
>
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: Graeme Gregory <graeme.gregory@linaro.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
> Cc: Rob Herring <robh@kernel.org>
>
> Ard Biesheuvel (2):
>   pci: designware: add driver for DWC controller in ECAM shift mode
>   dt-bindings: designware: add binding for Designware PCIe in ECAM mode
>
>  Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt | 42 +++++++++++
>  drivers/pci/dwc/Kconfig                                        | 11 +++
>  drivers/pci/dwc/Makefile                                       |  1 +
>  drivers/pci/dwc/pcie-designware-ecam.c                         | 77 ++++++++++++++++++++
>  4 files changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
>  create mode 100644 drivers/pci/dwc/pcie-designware-ecam.c
>
> --
> 2.11.0
>
