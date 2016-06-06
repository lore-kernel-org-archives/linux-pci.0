Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"hjk@hansjkoch.de" <hjk@hansjkoch.de>
Subject: Re: [PATCH] Introducing kernel option to force all PCI memory
 resources to be page aligned. Fixes issues with uio based drivers.
Date: Mon, 6 Jun 2016 14:59:47 +0000
Message-ID: <a2e2c02820fd495e845a9cf9340a30e3@FE-MBX1012.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Greg,

thanks for the response.
> > Some uio based PCI drivers (e.g. uio_cif) do not work if the assigned
> > PCI memory resources are not page aligned.
> > By using the kernel option "pci=resource_alignment" it is possible to
> > force single PCI boards to use page alignment for their memory resources.
> > However, this is fairly cumbersome if multiple of these cards are in use.
> > This patch adds another kernel option "pci=resources_page_aligned"
> > that allows to set the default alignment of PCI memory resources to be
> > page aligned.
> > Overwriting of this default alignment via "pci=resource_alignment" is
> > still possible.
> 
> This seems like a very large hammer for a very specific problem with a card
> that seems to be not-in-spec (I can't find anywhere that requires resources to
> be "page" aligned in the PCI spec).  Why not fix the firmware in these cards?
The issue is not the firmware. The issue is that the Linux uio driver (here: uio_cif)
does not work as uio_mmap() -> uio_mmap_physical() does not do a mmap 
on physical memory that is not page aligned...

Regards

Mathias
