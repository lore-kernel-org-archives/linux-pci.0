Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org
Cc: linux-pci@vger.kernel.org, ravikanth.nalla@hpe.com,
	lenb@kernel.org, harish.k@hpe.com, ashwin.reghunandanan@hpe.com,
	bhelgaas@google.com, rjw@rjwysocki.net,
	Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V2 0/3] simplify ACPI PCI IRQ code
Date: Fri,  8 Apr 2016 21:26:29 -0400
Message-Id: <1460165192-4526-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

differences from V1: https://patchwork.ozlabs.org/patch/599869/

Implement acpi_link_trigger and acpi_pci_compatible_trigger functions to
validate that all requesters agree on the IRQ polarity and trigger before
claiming for PCI and SCI interrupts.


Sinan Kaya (3):
  acpi,pci,irq: reduce resource requirements
  acpi,pci,irq: remove redundant code in acpi_irq_penalty_init
  acpi,pci,irq: remove SCI penalize function

 arch/x86/kernel/acpi/boot.c |   1 -
 arch/x86/pci/acpi.c         |   1 -
 drivers/acpi/pci_link.c     | 185 +++++++++++++++++++++++++++++---------------
 include/acpi/acpi_drivers.h |   1 -
 include/linux/acpi.h        |   1 -
 5 files changed, 122 insertions(+), 67 deletions(-)

-- 
1.8.2.1

