Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36496 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbbDFQYH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Apr 2015 12:24:07 -0400
Date: Mon, 6 Apr 2015 09:24:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/6] input/serio: drop pci_ids dependency
Message-ID: <20150406162402.GC36770@dtor-ws>
References: <1427712964-16155-1-git-send-email-mst@redhat.com>
 <1427712964-16155-3-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427712964-16155-3-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 30, 2015 at 12:59:27PM +0200, Michael S. Tsirkin wrote:
> This driver does not use any PCI IDs, don't include
> the pci_ids.h header.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied, thank you.

> ---
>  drivers/input/serio/gscps2.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
> index 94ab494..ecba666 100644
> --- a/drivers/input/serio/gscps2.c
> +++ b/drivers/input/serio/gscps2.c
> @@ -31,7 +31,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/delay.h>
>  #include <linux/ioport.h>
> -#include <linux/pci_ids.h>
>  
>  #include <asm/irq.h>
>  #include <asm/io.h>
> -- 
> MST
> 

-- 
Dmitry
