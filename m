Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:54521 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdBHSiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2017 13:38:20 -0500
Date: Wed, 8 Feb 2017 18:30:32 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/msi: remove pci_msi_domain_{alloc,free}_irqs
In-Reply-To: <20170208171744.17100-3-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1702081830200.3536@nanos>
References: <20170208171744.17100-1-hch@lst.de> <20170208171744.17100-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On Wed, 8 Feb 2017, Christoph Hellwig wrote:

> Just call the msi_* version directly instead of having trivial wrappers
> for one or two callsites.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
