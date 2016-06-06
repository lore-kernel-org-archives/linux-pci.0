Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59366 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbcFFOqC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2016 10:46:02 -0400
Date: Mon, 6 Jun 2016 07:46:00 -0700
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"hjk@hansjkoch.de" <hjk@hansjkoch.de>
Subject: Re: [PATCH] Introducing kernel option to force all PCI memory
 resources to be page aligned. Fixes issues with uio based drivers.
Message-ID: <20160606144600.GA6126@kroah.com>
References: <a3411d517fbd4626b2c78e420b387f76@FE-MBX1012.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a3411d517fbd4626b2c78e420b387f76@FE-MBX1012.de.bosch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 06, 2016 at 06:53:28AM +0000, Koehrer Mathias (ETAS/ESW5) wrote:
> Some uio based PCI drivers (e.g. uio_cif) do not work if the assigned 
> PCI memory resources are not page aligned.
> By using the kernel option "pci=resource_alignment" it is possible to force
> single PCI boards to use page alignment for their memory resources.
> However, this is fairly cumbersome if multiple of these cards are in use.
> This patch adds another kernel option "pci=resources_page_aligned"
> that allows to set the default alignment of PCI memory resources to
> be page aligned.
> Overwriting of this default alignment via "pci=resource_alignment" is
> still possible.

This seems like a very large hammer for a very specific problem with a
card that seems to be not-in-spec (I can't find anywhere that requires
resources to be "page" aligned in the PCI spec).  Why not fix the
firmware in these cards?

thanks,

greg k-h
