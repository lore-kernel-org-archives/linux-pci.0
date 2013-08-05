Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 5 Aug 2013 17:04:16 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Prarit Bhargava <prarit@redhat.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Myron Stowe <mstowe@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] acpi, acpi_pci_irq_enable must return an error if ACPI
 cannot map an IRQ.
Message-ID: <20130805140416.GA3882@xps8300>
References: <1373900260-1599-1-git-send-email-prarit@redhat.com>
 <51F0F67F.8070200@redhat.com>
 <51FEE549.3050001@redhat.com>
 <2316212.cUEmm9I6aI@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
In-Reply-To: <2316212.cUEmm9I6aI@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Aug 05, 2013 at 03:30:16PM +0200, Rafael J. Wysocki wrote:
> On Sunday, August 04, 2013 07:35:37 PM Prarit Bhargava wrote:
> > Hey Rafael,
> > 
> > I know you're busy but I was just wondering if this was queued up anywhere or if
> > you had any other questions?
> 
> Should be qeued up for 3.12 (currently in linux-next).

This breaks my xHCI :(

If the issues is that you are not getting any interrupt, then should
it not be checked separately and only fail in that case? I'm attaching
a patch that I made on top of linux-next, where I do just that. Would
that work for you?

Thanks,

-- 
heikki

--M9NhX3UHpAaciwkO
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-ACPI-fix-the-behaviour-of-acpi_pci_irq_enable.patch"

>From fdf8fbe4e75e7e320eba86ec51c9ede2495f30cd Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Mon, 5 Aug 2013 15:48:43 +0300
Subject: [PATCH] ACPI: fix the behaviour of acpi_pci_irq_enable()

acpi_pci_irq_enable() should not return error when PCI
provides an IRQ for the device even if ACPI does not know
the IRQ. This will change this case so that the function
only return error when there is no IRQ at all.

Without this the xHCI controller on my PC is allocated an
IRQ but still fails to be probed as pci_enable_device()
returns an error.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/pci_irq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 9681847..3c0b474 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -419,8 +419,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 */
 	if (gsi < 0) {
 		u32 dev_gsi;
+
+		if (!dev->irq) {
+			dev_err(&dev->dev, "PCI INT %c: no IRQ\n",
+				pin_name(pin));
+			return -ENOENT;
+		}
+
 		/* Interrupt Line values above 0xF are forbidden */
-		if (dev->irq > 0 && (dev->irq <= 0xF) &&
+		if ((dev->irq <= 0xF) &&
 		    (acpi_isa_irq_to_gsi(dev->irq, &dev_gsi) == 0)) {
 			dev_warn(&dev->dev, "PCI INT %c: no GSI - using ISA IRQ %d\n",
 				 pin_name(pin), dev->irq);
@@ -430,7 +437,6 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		} else {
 			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
 				 pin_name(pin));
-			return -ENOENT;
 		}
 
 		return 0;
-- 
1.8.3.2


--M9NhX3UHpAaciwkO--
