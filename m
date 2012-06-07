Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout0.freenet.de ([195.4.92.90]:58657 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754929Ab2FGGQz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Jun 2012 02:16:55 -0400
Message-ID: <4FD046A5.8080903@01019freenet.de>
Date: Thu, 07 Jun 2012 08:13:57 +0200
From: Andreas Hartmann <andihartmann@01019freenet.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: bjorn.helgaas@hp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	jan.kiszka@siemens.com, andihartmann@01019freenet.de
Subject: Re: [PATCH] PCI: Add Ralink RT2800 broken INTx masking quirk
References: <20120606212241.6627.98371.stgit@bling.home>
In-Reply-To: <20120606212241.6627.98371.stgit@bling.home>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex Williamson wrote:
> Passes pci_intx_mask_supported but continues to send interrupts as
> discovered through VFIO-based device assignment.
> 
> http://www.spinics.net/lists/kvm/msg73738.html
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Andreas Hartmann <andihartmann@01019freenet.de>
> ---
> 
> Depends on Jan's base patch for this quirk: 
> http://www.spinics.net/lists/linux-pci/msg15516.html
> 
> drivers/pci/quirks.c |    2 ++ 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> cbb4358..178f494 100644 --- a/drivers/pci/quirks.c +++
> b/drivers/pci/quirks.c @@ -2940,6 +2940,8 @@ static void __devinit
> quirk_broken_intx_masking(struct pci_dev *dev) } 
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x0010, 
> quirk_broken_intx_masking); +DECLARE_PCI_FIXUP_FINAL(0x1814,
> 0x0601, /* Ralink RT2800 802.11n PCI */ +
> quirk_broken_intx_masking);
> 
> static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup
> *f, struct pci_fixup *end)
> 
