Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com
Cc: net147@gmail.com, linux-pci@vger.kernel.org, agross@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V5 0/3] ACPI,PCI,IRQ: revert penalty calculation for ISA and SCI interrupts
Date: Mon, 24 Oct 2016 00:31:29 -0400
Message-Id: <1477283492-26657-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


By the time ACPI gets initialized, this code tries to determine an
IRQ number based on penalty values in this array. It will try to locate
the IRQ with the least penalty assignment so that interrupt sharing is
avoided if possible.

A couple of notes about the external APIs:
1. These API can be called before the ACPI is started. Therefore, one
cannot assume that the PCI link objects are initialized for calculating
penalties.
2. The polarity and trigger information passed via the
acpi_penalize_sci_irq from the BIOS may not match what the IRQ subsystem
is reporting as the call might have been placed before the IRQ is
registered by the interrupt subsystem.

The reverted changes were in the direction to remove these external API and
try to calculate the penalties at runtime for the ISA, SCI as well as PCI
IRQS.
This didn't work out well with the existing platforms.

V5:
* clean up the commit message for 1/3 and 2/3
* drop 3/3
* bring back ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts as 3/3

V4:
https://www.spinics.net/lists/arm-kernel/msg537158.html
* Drop ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts
* A new patch to isolate early boot ISA penalty calculations from dynamic
penalty calculation by directly modifying the array members in
("ACPI, PCI, IRQ: assign ISA IRQ directly during early boot stages")
* Now that we isolated both SCI and ISA interrupts, revert commit ("Revert
"ACPI,PCI,IRQ: separate ISA penalty calculation"") and commit
("487cf917ed0d
(Revert "ACPI, PCI, IRQ: remove redundant code in acpi_irq_penalty_init()")
to share code between ISA and PCI penalties as originally intended.

V3:
http://www.spinics.net/lists/arm-kernel/msg536208.html
* drop patch #1 as discussed with Bjorn
* add patch #3 to track SCI irq and penalty separately

V2: https://lkml.org/lkml/2016/10/1/106
* Commit message updates

V1:
http://lists-archives.com/linux-kernel/28673954-revert-acpi-pci-irq-reduce-static-irq-array-size-to-16.html
* initial implementation

Sinan Kaya (3):
  ACPI, PCI, IRQ: assign ISA IRQ directly during early boot stages
  ACPI: pci_link: penalize SCI correctly
  ACPI: pci_link: Include PIRQ_PENALTY_PCI_USING for ISA IRQs

 arch/x86/kernel/acpi/boot.c |  1 +
 drivers/acpi/pci_link.c     | 38 +++++++++++++++++++++-----------------
 include/linux/acpi.h        |  1 +
 3 files changed, 23 insertions(+), 17 deletions(-)

-- 
1.9.1

