Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com
Subject: [PATCH V3 0/3] ACPI, PCI,
 IRQ: revert penalty calculation for ISA and SCI interrupts
Date: Sat, 15 Oct 2016 00:31:04 -0400
Message-Id: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
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
IRQS. This didn't work out well with the existing platforms.

V3: 
* drop patch #1 as discussed with Bjorn
* add patch #3 to track SCI irq and penalty separately

V2: https://lkml.org/lkml/2016/10/1/106
* Commit message updates

V1:
http://lists-archives.com/linux-kernel/28673954-revert-acpi-pci-irq-reduce-static-irq-array-size-to-16.html
* initial implementation

Sinan Kaya (3):
  ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts
  Revert "ACPI,PCI,IRQ: remove SCI penalize function"
  ACPI,PCI,IRQ: correct SCI penalty calculation

 arch/x86/kernel/acpi/boot.c |  1 +
 drivers/acpi/pci_link.c     | 34 +++++++++++++++++++---------------
 include/linux/acpi.h        |  1 +
 3 files changed, 21 insertions(+), 15 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
