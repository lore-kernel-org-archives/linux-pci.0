Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 6 Jun 2016 08:26:45 -0700
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"hjk@hansjkoch.de" <hjk@hansjkoch.de>
Subject: Re: [PATCH] Introducing kernel option to force all PCI memory
 resources to be page aligned. Fixes issues with uio based drivers.
Message-ID: <20160606152645.GA7605@kroah.com>
References: <a2e2c02820fd495e845a9cf9340a30e3@FE-MBX1012.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a2e2c02820fd495e845a9cf9340a30e3@FE-MBX1012.de.bosch.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 06, 2016 at 02:59:47PM +0000, Koehrer Mathias (ETAS/ESW5) wrote:
> Hi Greg,
> 
> thanks for the response.
> > > Some uio based PCI drivers (e.g. uio_cif) do not work if the assigned
> > > PCI memory resources are not page aligned.
> > > By using the kernel option "pci=resource_alignment" it is possible to
> > > force single PCI boards to use page alignment for their memory resources.
> > > However, this is fairly cumbersome if multiple of these cards are in use.
> > > This patch adds another kernel option "pci=resources_page_aligned"
> > > that allows to set the default alignment of PCI memory resources to be
> > > page aligned.
> > > Overwriting of this default alignment via "pci=resource_alignment" is
> > > still possible.
> > 
> > This seems like a very large hammer for a very specific problem with a card
> > that seems to be not-in-spec (I can't find anywhere that requires resources to
> > be "page" aligned in the PCI spec).  Why not fix the firmware in these cards?
> The issue is not the firmware. The issue is that the Linux uio driver (here: uio_cif)
> does not work as uio_mmap() -> uio_mmap_physical() does not do a mmap 
> on physical memory that is not page aligned...

Then why not fix the uio_cif driver?

greg k-h
