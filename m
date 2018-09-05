Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeIFB5n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:57:43 -0400
Date: Wed, 5 Sep 2018 16:25:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH] PCI: remove ids for NFP32xx
Message-ID: <20180905212540.GT107892@bhelgaas-glaptop.roam.corp.google.com>
References: <20180815001430.27660-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180815001430.27660-1-jakub.kicinski@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 14, 2018 at 05:14:30PM -0700, Jakub Kicinski wrote:
> Defines for NFP32xx are no longer used anywhere, remove them.
> 
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Applied to pci/misc for v4.20, thanks!

> ---
>  include/linux/pci_ids.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 381fc009551d..39f7f0b14572 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2538,8 +2538,6 @@
>  #define PCI_VENDOR_ID_HUAWEI         	0x19e5
>  
>  #define PCI_VENDOR_ID_NETRONOME		0x19ee
> -#define PCI_DEVICE_ID_NETRONOME_NFP3200	0x3200
> -#define PCI_DEVICE_ID_NETRONOME_NFP3240	0x3240
>  #define PCI_DEVICE_ID_NETRONOME_NFP4000	0x4000
>  #define PCI_DEVICE_ID_NETRONOME_NFP5000	0x5000
>  #define PCI_DEVICE_ID_NETRONOME_NFP6000	0x6000
> -- 
> 2.17.1
> 
