Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 19 Feb 2013 02:13:51 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-kernel@vger.kernel.org, Frederik Himpe <fhimpe@vub.ac.be>,
	Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: do not try to assign irq 255
Message-ID: <20130219011351.GA4756@hardeman.nu>
References: <1361182193-31894-1-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1361182193-31894-1-git-send-email-hare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 18, 2013 at 11:09:53AM +0100, Hannes Reinecke wrote:
>The PCI config space reseves a byte for the interrupt line,
>so irq 255 actually refers to 'not set'.
>However, the 'irq' field for struct pci_dev is an integer,
>so the original meaning is lost, causing the system to
>assign an interrupt '255', which fails.
>
>So we should _not_ assign an interrupt value here, and
>allow upper layers to fixup things.
>
>This patch make PCI devices with MSI interrupts only
>(like the xhci device on certain HP laptops) work properly.

Just tested and it works for me. Thank you.

Tested-by: David Härdeman <david@hardeman.nu>

>Cc: Frederik Himpe <fhimpe@vub.ac.be>
>Cc: Oliver Neukum <oneukum@suse.de>
>Cc: David Haerdeman <david@hardeman.nu>
>Cc: linux-usb@vger.kernel.org
>Cc: linux-pci@vger.kernel.org
>Signed-off-by: Hannes Reinecke <hare@suse.de>
>
>diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>index 6186f03..a2db887f 100644
>--- a/drivers/pci/probe.c
>+++ b/drivers/pci/probe.c
>@@ -923,7 +923,8 @@ static void pci_read_irq(struct pci_dev *dev)
> 	dev->pin = irq;
> 	if (irq)
> 		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>-	dev->irq = irq;
>+	if (irq < 255)
>+		dev->irq = irq;
> }
> 
> void set_pcie_port_type(struct pci_dev *pdev)
>

-- 
David Härdeman
