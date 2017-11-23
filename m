Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbdKWOL1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Nov 2017 09:11:27 -0500
Date: Thu, 23 Nov 2017 15:11:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Oded Gabbay <oded.gabbay@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: add class codes for processing accelerators
Message-ID: <20171123141131.GA1801@kroah.com>
References: <1511445862-4383-1-git-send-email-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1511445862-4383-1-git-send-email-oded.gabbay@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 23, 2017 at 04:04:22PM +0200, Oded Gabbay wrote:
> Add PCI codes to include/linux/pci_ids.h for Processing Accelerators. There
> are new ASICs (now in development) for Deep Learning that will utilize this
> base class.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  include/linux/pci_ids.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index ab20dc5..4c210cd 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -139,6 +139,9 @@
>  #define PCI_CLASS_SP_DPIO		0x1100
>  #define PCI_CLASS_SP_OTHER		0x1180
>  
> +#define PCI_BASE_CLASS_PROCESSING_ACCELERATOR	0x12
> +#define PCI_CLASS_PA_VENDOR_SPECIFIC		0x1200

Did you read the top of this file?

And if these really do belong here, then it should go in as part of a
patch series that contains a driver that uses these values.

thanks,

greg k-h
