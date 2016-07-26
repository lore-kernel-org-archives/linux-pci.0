Return-Path: <tglx@linutronix.de>
Return-Path: <tglx@linutronix.de>
Date: Tue, 26 Jul 2016 13:42:21 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
    Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/msi: Make sure PCI MSIs are activated early
In-Reply-To: <20160725144702.GA12484@localhost>
Message-ID: <alpine.DEB.2.11.1607261307180.19896@nanos>
References: <1468426713-31431-1-git-send-email-marc.zyngier@arm.com> <20160722220440.GC32142@localhost> <alpine.DEB.2.11.1607250928370.5629@nanos> <20160725144702.GA12484@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Mon, 25 Jul 2016, Bjorn Helgaas wrote:
> On Mon, Jul 25, 2016 at 09:45:13AM +0200, Thomas Gleixner wrote:
> I thought the original issue [1] was that PCI_MSI_FLAGS_ENABLE was being
> written before PCI_MSI_ADDRESS_LO.  That doesn't sound like a good
> idea to me.

Well. That's only a problem if the PCI device does not support masking. But
yes, we missed that case back then.
 
> That does seem like a problem.  Maybe it would be better to delay
> setting PCI_MSI_FLAGS_ENABLE until after the MSI address & data bits
> have been set?

I thought about that, but that gets ugly pretty fast. Here is an alternative
solution.

I think that's the proper place to do it _AFTER_ the hierarchical allocation
took place. On x86 Marc's ACTIVATE_EARLY flag would not work because the
message is not yet ready to be assembled.

Thanks,

	tglx
---
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a080f4496fe2..142341f8331b 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -645,6 +645,15 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 		return ret;
 	}
 
+	/*
+	 * The mask can be ignored and PCI 2.3 does not specify mask bits for
+	 * each MSI interrupt. So in case of hierarchical irqdomains we need
+	 * to make sure that if masking is not available that the msi message
+	 * is written prior to setting the MSI enable bit in the device.
+	 */
+	if (pci_msi_ignore_mask || !entry->msi_attrib.maskbit)
+		irq_domain_activate_irq(irq_get_irq_data(entry->irq));
+
 	/* Set MSI enabled bits	 */
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 1);
