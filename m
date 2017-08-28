Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38759 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdH1SEq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2017 14:04:46 -0400
Received: by mail-wm0-f48.google.com with SMTP id t201so8343861wmt.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Aug 2017 11:04:46 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, mw@semihalf.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 0/2] pci: add support for firmware initialized designware RCs
Date: Mon, 28 Aug 2017 19:04:35 +0100
Message-Id: <20170828180437.2646-1-ard.biesheuvel@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

UEFI based systems incorporating a Synopsys Designware PCIe controller
in RC mode will typically configure it before entering the OS. If this
configuration is fully static and ECAM compliant, there is no need to
expose particulars of the device to the OS, and we can simply describe
it as "pci-host-ecam-generic".

However, the Synopsys IP may be synthesized in a way where a quirk is
needed for config space accesses to the first bus. It makes little sense
to instantiate yet another pcie-designware driver that contains all the
low level setup code, but it is also not justified to add quirks handling
to the generic ECAM driver.

So instead, create a variant of the generic ECAM driver that filters config
space accesses directed at device #1 and up on the first bus.

v3: - use SoC specific compatible strings
    - drop MSI patch [for now], since it turns out we may not need it

v2: - use dev->fwnode directly
    - replace an instance of pr_err with dev_err, and clarify the error message
    - fix Kconfig/Makefile dependency errors reported by kbuild

Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Rob Herring <robh@kernel.org>

Ard Biesheuvel (2):
  pci: designware: add driver for DWC controller in ECAM shift mode
  dt-bindings: designware: add binding for Designware PCIe in ECAM mode

 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt | 42 +++++++++++
 drivers/pci/dwc/Kconfig                                        | 11 +++
 drivers/pci/dwc/Makefile                                       |  1 +
 drivers/pci/dwc/pcie-designware-ecam.c                         | 77 ++++++++++++++++++++
 4 files changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
 create mode 100644 drivers/pci/dwc/pcie-designware-ecam.c

-- 
2.11.0
