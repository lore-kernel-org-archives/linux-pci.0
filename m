Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbeBVVBN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Feb 2018 16:01:13 -0500
Date: Thu, 22 Feb 2018 15:01:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Martin Mares <mj@ucw.cz>,
        Michal Vaner <vorner@vorner.cz>
Subject: Re: [PATCH] PCI: update location of pci.ids file
Message-ID: <20180222210112.GF16519@bhelgaas-glaptop.roam.corp.google.com>
References: <1703ad43-3bf3-b777-7e1c-0beb55b064e8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1703ad43-3bf3-b777-7e1c-0beb55b064e8@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 03, 2018 at 04:53:09PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Update the URL for the pci.ids file and add locations for its mirrors.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Martin Mares <mj@ucw.cz>
> Cc: Michal Vaner <vorner@vorner.cz>

Applied to for-linus for v4.16, thanks!

> ---
>  Documentation/PCI/pci.txt |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- linux-next-20180202.orig/Documentation/PCI/pci.txt
> +++ linux-next-20180202/Documentation/PCI/pci.txt
> @@ -570,7 +570,9 @@ your driver if they're helpful, or just
>  The device IDs are arbitrary hex numbers (vendor controlled) and normally used
>  only in a single location, the pci_device_id table.
>  
> -Please DO submit new vendor/device IDs to http://pciids.sourceforge.net/.
> +Please DO submit new vendor/device IDs to http://pci-ids.ucw.cz/.
> +There are mirrors of the pci.ids file at http://pciids.sourceforge.net/
> +and https://github.com/pciutils/pciids.
>  
>  
>  
> 
