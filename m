Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:58587 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbcFGOcY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2016 10:32:24 -0400
Date: Tue, 7 Jun 2016 07:32:22 -0700
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"hjk@hansjkoch.de" <hjk@hansjkoch.de>
Subject: Re: [PATCH] Extending kernel option pci=resource_alignment to be
 able to specify PCI device/vendor IDs
Message-ID: <20160607143222.GA14596@kroah.com>
References: <22400b8828ad44ddbccb876cc5ca3b11@FE-MBX1012.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22400b8828ad44ddbccb876cc5ca3b11@FE-MBX1012.de.bosch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 07, 2016 at 02:24:17PM +0000, Koehrer Mathias (ETAS/ESW5) wrote:
> Some uio based PCI drivers (e.g. uio_cif) do not work if the assigned 
> PCI memory resources are not page aligned.
> By using the kernel option "pci=resource_alignment" it is possible to force
> single PCI boards to use page alignment for their memory resources.
> However, this is fairly cumbersome if multiple of these boards are in use as 
> the specification of the cards has to be done via PCI bus/slot/function number
> which might change e.g. by adding another board.
> This patch extends the kernel option "pci=resource_alignment" to allow to
> specify the relevant boards via PCI device/vendor (and subdevice/subvendor) ids.
> The specification of the devices via device/vendor is indicated by a leading
> string "pci:" as argument to "pci=resource_alignment".
> The format of the specification is
>   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> 
> Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>
> 
> ---
>  Documentation/kernel-parameters.txt |    2 +
>  drivers/pci/pci.c                   |   66 +++++++++++++++++++++++++-----------
>  2 files changed, 49 insertions(+), 19 deletions(-)

This looks better, but wow, messy.  I'll defer to the PCI maintainer and
developers now, this is in their camp, not mine :)

thanks,

greg k-h
