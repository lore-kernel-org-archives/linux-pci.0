Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:60627 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965005AbcJQT3A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Oct 2016 15:29:00 -0400
Date: Mon, 17 Oct 2016 21:28:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Emmanuel Benisty <benisty.e@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, tj@kernel.org,
        linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: use pci_alloc_irq_vectors issues
Message-ID: <20161017192858.GA25429@lst.de>
References: <CA+i8gKJ1BnOE8tOzxfbFJcG1qa9XchiDBQSGZUHUOch6byi+tQ@mail.gmail.com> <20161017080103.GA8732@lst.de> <CA+i8gK+dxqJgAcANzsHecE4dD4tGARuaNka-29nZWdrRUL=+Hw@mail.gmail.com> <20161017092621.GA11124@lst.de> <CA+i8gKK55YWL0SsB0UL89TL1XAgySvFwhmU=c+fTpkGo_s4XTA@mail.gmail.com> <20161017103442.GA12240@lst.de> <CA+i8gKJkhTjBAPbuceToHD3YJuPHkLhs-joso-vuJzuHRF5OLg@mail.gmail.com> <20161017120234.GA14105@lst.de> <CA+i8gK+UfUmKtYpXH1cObd3_5WWje397pgQqW5SmwFg8ms+aLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+i8gK+UfUmKtYpXH1cObd3_5WWje397pgQqW5SmwFg8ms+aLw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Emmanuel,

I think I have an idea now - we are accidentally hitting the per-port
MSI vector case because your SSD only has one AHCI "port".  Can you
try the below patch:

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ba5f11c..3c2f92b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1413,6 +1413,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
 		return -ENODEV;
 
+	if (n_ports > 1) {
 	/*
 	 * If number of MSIs is less than number of ports then Sharing Last
 	 * Message mode could be enforced. In this case assume that advantage
@@ -1434,6 +1435,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 		printk(KERN_INFO "ahci: MRSM is on, fallback to single MSI\n");
 		pci_free_irq_vectors(pdev);
 	}
+	}
 
 	/*
 	 * -ENOSPC indicated we don't have enough vectors.  Don't bother trying
