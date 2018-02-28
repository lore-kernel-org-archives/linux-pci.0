Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935105AbeB1WGr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 17:06:47 -0500
Date: Wed, 28 Feb 2018 16:06:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Jan H =?iso-8859-1?Q?=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Subject: Re: [PATCH] pci: Do not read INTx PIN and LINE registers for virtual
 functions
Message-ID: <20180228220645.GO127842@bhelgaas-glaptop.roam.corp.google.com>
References: <1516213829-14844-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1516213829-14844-1-git-send-email-karahmed@amazon.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 17, 2018 at 07:30:29PM +0100, KarimAllah Ahmed wrote:
> ... since INTx is not supported by-spec for virtual functions.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>

Applied to pci/virtualization for v4.17, thanks!

I tweaked the changelog to include the motivation:

commit 16edf1c6345ab177ccf1e8b5ba3324ee01a50eb7
Author: KarimAllah Ahmed <karahmed@amazon.de>
Date:   Wed Jan 17 19:30:29 2018 +0100

    PCI/IOV: Skip INTx config reads for VFs
    
    Per PCIe r4.0, sec 9.2.1.4, VFs can not implement INTX, and their Interrupt
    Line and Interrupt Pin registers must be RO Zero.  Some devices have
    thousands of VFs, so skip reading the registers as an optimization.
    
    Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
    Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
    [bhelgaas: changelog, comment]
    Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 489660d0d384..a1cddca37793 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1230,6 +1230,13 @@ static void pci_read_irq(struct pci_dev *dev)
 {
 	unsigned char irq;
 
+	/* VFs are not allowed to use INTx, so skip the config reads */
+	if (dev->is_virtfn) {
+		dev->pin = 0;
+		dev->irq = 0;
+		return;
+	}
+
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
 	dev->pin = irq;
 	if (irq)
