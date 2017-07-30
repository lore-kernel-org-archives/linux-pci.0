Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754270AbdG3RFX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jul 2017 13:05:23 -0400
Date: Sun, 30 Jul 2017 07:11:59 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Sandeep Singh <Sandeep.Singh@amd.com>
Cc: mathias.nyman@intel.com, bhelgaas@google.com,
        dheitmueller@kernellabs.com, stern@rowland.harvard.edu,
        samuel.thibault@ens-lyon.org, lukas@oxygene.sk,
        linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Subject: Re: [PATCH] usb: xhci: Add quirk for Certain failing HP keyboard on
 reset after resume
Message-ID: <20170730141159.GA21849@kroah.com>
References: <1501144509-19357-1-git-send-email-Sandeep.Singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501144509-19357-1-git-send-email-Sandeep.Singh@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 27, 2017 at 02:05:09PM +0530, Sandeep Singh wrote:
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index c71e532..d3f2296 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -583,6 +583,7 @@
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
>  #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
>  #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
> +#define PCI_DEVICE_ID_AMD_TAISHAN	0x145c
>  
>  #define PCI_VENDOR_ID_TRIDENT		0x1023
>  #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000

Please read the top of this file for why you shouldn't be adding new ids
to it.

thnaks,

greg k-h
