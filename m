Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com
Subject: [PATCH V4 0/3] ACPI, PCI,
 IRQ: revert penalty calculation for ISA and SCI interrupts
Date: Wed, 19 Oct 2016 18:21:01 -0400
Message-Id: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, agross@codeaurora.org,
 Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 wim@djo.tudelft.nl, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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

V4:
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
  Revert "ACPI,PCI,IRQ: remove SCI penalize function"
  Revert "ACPI,PCI,IRQ: separate ISA penalty calculation"

 arch/x86/kernel/acpi/boot.c |  1 +
 arch/x86/pci/acpi.c         |  1 -
 drivers/acpi/pci_link.c     | 72 ++++++++++++---------------------------------
 include/acpi/acpi_drivers.h |  1 -
 include/linux/acpi.h        |  1 +
 5 files changed, 21 insertions(+), 55 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
