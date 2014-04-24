Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:34044 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbaDXVCs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Apr 2014 17:02:48 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so2369675pbc.16
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2014 14:02:48 -0700 (PDT)
Date: Thu, 24 Apr 2014 15:02:45 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] pci_ids: Remove old serial device IDs
Message-ID: <20140424210245.GF29593@google.com>
References: <20140331151929.7bd3afef@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140331151929.7bd3afef@endymion.delvare>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 31, 2014 at 03:19:29PM +0200, Jean Delvare wrote:
> These IDs are no longer referenced since kernel 3.1 so I suppose we
> can remove them from pci_ids.h.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Applied with Greg's ack to pci/misc for v3.16, thanks!

> ---
>  include/linux/pci_ids.h |    3 ---
>  1 file changed, 3 deletions(-)
> 
> --- linux-3.14-rc8.orig/include/linux/pci_ids.h	2014-03-31 14:15:00.832955000 +0200
> +++ linux-3.14-rc8/include/linux/pci_ids.h	2014-03-31 14:55:08.635085484 +0200
> @@ -1628,8 +1628,6 @@
>  #define PCI_DEVICE_ID_ATT_VENUS_MODEM	0x480
>  
>  #define PCI_VENDOR_ID_SPECIALIX		0x11cb
> -#define PCI_DEVICE_ID_SPECIALIX_IO8	0x2000
> -#define PCI_DEVICE_ID_SPECIALIX_RIO	0x8000
>  #define PCI_SUBDEVICE_ID_SPECIALIX_SPEED4 0xa004
>  
>  #define PCI_VENDOR_ID_ANALOG_DEVICES	0x11d4
> @@ -2868,7 +2866,6 @@
>  #define PCI_DEVICE_ID_SCALEMP_VSMP_CTL	0x1010
>  
>  #define PCI_VENDOR_ID_COMPUTONE		0x8e0e
> -#define PCI_DEVICE_ID_COMPUTONE_IP2EX	0x0291
>  #define PCI_DEVICE_ID_COMPUTONE_PG	0x0302
>  #define PCI_SUBVENDOR_ID_COMPUTONE	0x8e0e
>  #define PCI_SUBDEVICE_ID_COMPUTONE_PG4	0x0001
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support
