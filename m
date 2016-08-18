Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754879AbcHSBgO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 21:36:14 -0400
Date: Thu, 18 Aug 2016 16:59:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Helen Koike <helen.koike@collabora.co.uk>
Cc: hch@infradead.org, mlin@kernel.org, fes@google.com,
        keith.busch@intel.com, rlnelson@google.com, axboe@fb.com,
        digitaleric@google.com, tytso@mit.edu, mikew@google.com,
        monish@google.com, Helen Koike <helen.koike@collabora.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 RFC 1/2] PCI: Add Google device ID
Message-ID: <20160818215932.GR27353@localhost>
References: <cover.1471308889.git.helen.koike@collabora.co.uk>
 <69910419c3745269604fcb052ad9b08d1b601590.1471308889.git.helen.koike@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <69910419c3745269604fcb052ad9b08d1b601590.1471308889.git.helen.koike@collabora.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 15, 2016 at 10:41:19PM -0300, Helen Koike wrote:
> Add device ID for the local SSDs (NVMe) in Google Clound Engine

s/Clound/Cloud/

> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> ---
> 
> Changes since v2:
> - This is a new patch in the serie
> 
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index c58752f..d422afc 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -948,6 +948,8 @@
>  #define PCI_DEVICE_ID_APPLE_IPID2_GMAC	0x006b
>  #define PCI_DEVICE_ID_APPLE_TIGON3	0x1645
>  
> +#define PCI_VENDOR_ID_GOOGLE		0x1AE0

See the comment at the top of pci_ids.h.

It looks like you only use this in drivers/nvme/host/pci.c.

>  #define PCI_VENDOR_ID_YAMAHA		0x1073
>  #define PCI_DEVICE_ID_YAMAHA_724	0x0004
>  #define PCI_DEVICE_ID_YAMAHA_724F	0x000d
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
