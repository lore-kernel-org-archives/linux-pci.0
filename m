Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:58085 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932335AbcJQKeo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Oct 2016 06:34:44 -0400
Date: Mon, 17 Oct 2016 12:34:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Emmanuel Benisty <benisty.e@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, tj@kernel.org,
        linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: use pci_alloc_irq_vectors issues
Message-ID: <20161017103442.GA12240@lst.de>
References: <CA+i8gKJ1BnOE8tOzxfbFJcG1qa9XchiDBQSGZUHUOch6byi+tQ@mail.gmail.com> <20161017080103.GA8732@lst.de> <CA+i8gK+dxqJgAcANzsHecE4dD4tGARuaNka-29nZWdrRUL=+Hw@mail.gmail.com> <20161017092621.GA11124@lst.de> <CA+i8gKK55YWL0SsB0UL89TL1XAgySvFwhmU=c+fTpkGo_s4XTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+i8gKK55YWL0SsB0UL89TL1XAgySvFwhmU=c+fTpkGo_s4XTA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 17, 2016 at 11:33:03AM +0200, Emmanuel Benisty wrote:
> Hi Christoph,
> 
> On Mon, Oct 17, 2016 at 11:26 AM, Christoph Hellwig <hch@lst.de> wrote:
> > can you run the lspci -vv command as again, but this time as root
> > user?
> 
> Please find attached the new file.
> 
> > Also just to make sure I interpret your report correctly:
> > The ata3 devices that's creating the problems is the SK-Hynix device,
> > probably a SSD that shows up as ahci controller?
> 
> Yep, it's the only drive on this machine, which is indeed a SSD drive.

Thanks.  Still can't make sense of the issue, can you apply the debug
patch below, and try to caputure the screen output when the ata
device is beeing probed?

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ba5f11c..458d139 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1422,6 +1422,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 			PCI_IRQ_MSIX | PCI_IRQ_MSI);
 	if (nvec > 0) {
 		if (!(readl(hpriv->mmio + HOST_CTL) & HOST_MRSM)) {
+			printk(KERN_INFO "ahci: using %d MSI(-X) vectors)\n", nvec);
 			hpriv->get_irq_vector = ahci_get_irq_vector;
 			hpriv->flags |= AHCI_HFLAG_MULTI_MSI;
 			return nvec;
@@ -1439,17 +1440,22 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	 * -ENOSPC indicated we don't have enough vectors.  Don't bother trying
 	 * a single vectors for any other error:
 	 */
-	if (nvec < 0 && nvec != -ENOSPC)
+	if (nvec < 0 && nvec != -ENOSPC) {
+		printk("ahci: pci_alloc_irq_vectors (multi) returned %d\n", nvec);
 		return nvec;
+	}
 
 	/*
 	 * If the host is not capable of supporting per-port vectors, fall
 	 * back to single MSI before finally attempting single MSI-X.
 	 */
 	nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
+	printk("ahci: pci_alloc_irq_vectors (MSI) returned %d\n", nvec);
 	if (nvec == 1)
 		return nvec;
-	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+	nvec =  pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+	printk("ahci: pci_alloc_irq_vectors (MSI-X) returned %d\n", nvec);
+	return nvec;
 }
 
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
