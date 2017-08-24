Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37775 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752909AbdHXSno (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2017 14:43:44 -0400
Received: by mail-wm0-f42.google.com with SMTP id b189so1962976wmd.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2017 11:43:44 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-pci@vger.kernel.org
Cc: mw@semihalf.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 0/3] pci: add support for firmware initialized designware RCs
Date: Thu, 24 Aug 2017 19:43:18 +0100
Message-Id: <20170824184321.19432-1-ard.biesheuvel@linaro.org>
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

Also, add a binding and driver to support the MSI functionality available
in some versions of this IP. This allows the MSI routing to be described
at the DT level rather than hardcoding it in the driver.

v2: - use dev->fwnode directly
    - replace an instance of pr_err with dev_err, and clarify the error message
    - fix Kconfig/Makefile dependency errors reported by kbuild

Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>

Ard Biesheuvel (3):
  pci: designware: add driver for DWC controller in ECAM shift mode
  pci: designware: add separate driver for the MSI part of the RC
  dt-bindings: designware: add binding for Designware PCIe in ECAM mode

 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt |  56 +++++
 drivers/pci/dwc/Kconfig                                        |  11 +
 drivers/pci/dwc/Makefile                                       |   4 +-
 drivers/pci/dwc/pcie-designware-ecam.c                         |  75 ++++++
 drivers/pci/dwc/pcie-designware-msi.c                          | 255 ++++++++++++++++++++
 5 files changed, 400 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
 create mode 100644 drivers/pci/dwc/pcie-designware-ecam.c
 create mode 100644 drivers/pci/dwc/pcie-designware-msi.c

-- 
2.11.0
