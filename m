Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46934 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbcHPTeW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 16 Aug 2016 15:34:22 -0400
Date: Tue, 16 Aug 2016 14:34:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pci@vger.kernel.org, agordeev@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: two pci_alloc_irq_vectors improvements
Message-ID: <20160816193418.GA10555@localhost>
References: <1470924665-25860-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470924665-25860-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph,

On Thu, Aug 11, 2016 at 07:11:03AM -0700, Christoph Hellwig wrote:
> Hi Bjorn, hi Alex,
> 
> below are two patches I'd love to see in 4.8 to improve the
> pci_alloc_irq_vectors interface.  I've realized we need these while
> starting a mass conversion of the MSI-X users to the new interface,
> and getting it into 4.8 before users show up should make life a lot
> easier.
> 
> The positive flags things comes out of the fact that a lot of driver
> want MSI-X only without any fallback, or some elaborate differences
> for the different interrupt schemes.  For example while most modern
> devices use one MSI-X vector per queue and scale nicely from the
> MSI to the MSI-X scheme many older devices use a MSI-X vector per
> functionality in the ISR, so they might wan to allocate them
> differently.
> 
> The second one ensures the legacy interrupt line is actually enabled
> before using it, because some devices like MSI-X might actually have
> it disable by default.

I really like this change.  It's much nicer to read

  if (flags & PCI_IRQ_AFFINITY)

than it was to read

  if (!(flags & PCI_IRQ_NOAFFINITY))

Speaking of affinity, the original documentation said "By default this
function will spread the interrupts around the available CPUs".  After
these patches, you have to pass PCI_IRQ_AFFINITY to get that behavior.
Are you planning to have drivers use

  pci_alloc_irq_vectors(dev, 1, nvec, PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY)

to explicitly ask for affinity?

I applied these to for-linus with the intent of merging them for v4.8.
I fixed a couple typos in the first one as shown below.

Any objections, Alex?

Bjorn


diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
index 8faf14a..cd9c9f6 100644
--- a/Documentation/PCI/MSI-HOWTO.txt
+++ b/Documentation/PCI/MSI-HOWTO.txt
@@ -96,9 +96,9 @@ if it can't meet the minimum number of vectors.
 
 The flags argument is used to specify which type of interrupt can be used
 by the device and the driver (PCI_IRQ_LEGACY, PCI_IRQ_MSI, PCI_IRQ_MSIX).
-A conveniant short-hand (PCI_IRQ_ALL_TYPES) is also avaiable to ask for
-any possible kind of interrupt. If the PCI_IRQ_NOAFFINITY flag is set,
-pci_alloc_irq_vectors will spread the interrupts around the available CPUs.
+A convenient short-hand (PCI_IRQ_ALL_TYPES) is also available to ask for
+any possible kind of interrupt.  If the PCI_IRQ_AFFINITY flag is set,
+pci_alloc_irq_vectors() will spread the interrupts around the available CPUs.
 
 To get the Linux IRQ numbers passed to request_irq() and free_irq() and the
 vectors, use the following function:
@@ -150,8 +150,7 @@ the single MSI mode for a device.  It could be done by passing two 1s as
 		goto out_err;
 
 Some devices might not support using legacy line interrupts, in which case
-the PCI_IRQ_NOLEGACY flag can be used to fail the request if the platform
-can't provide MSI or MSI-X interrupts:
+the driver can specify that only MSI or MSI-X is acceptable:
 
 	nvec = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (nvec < 0)
