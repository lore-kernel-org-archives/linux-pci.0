Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbdDNPno (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Apr 2017 11:43:44 -0400
Date: Fri, 14 Apr 2017 10:43:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mason <slash.tmp@free.fr>,
        Grant Grundler <grundler@chromium.org>,
        Greg Hackmann <ghackmann@google.com>,
        Michael Davidson <md@google.com>
Subject: Re: [PATCH v2] PCI: Make PCI_ROM_ADDRESS_MASK a 32-bit constant
Message-ID: <20170414154340.GA5864@bhelgaas-glaptop.roam.corp.google.com>
References: <20170411175658.58512-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170411175658.58512-1-mka@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 11, 2017 at 10:56:58AM -0700, Matthias Kaehlcke wrote:
> A 64-bit value is not needed since a PCI ROM address consists in 32 bits.
> This fixes a clang warning about "implicit conversion from 'unsigned
> long' to 'u32'".
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - Define PCI_ROM_ADDRESS_MASK as a 32-bit constant instead of using a cast
> - Updated commit message
> 
>  include/uapi/linux/pci_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 634c9c44ed6c..fff521c9458c 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -114,7 +114,7 @@
>  #define PCI_SUBSYSTEM_ID	0x2e
>  #define PCI_ROM_ADDRESS		0x30	/* Bits 31..11 are address, 10..1 reserved */
>  #define  PCI_ROM_ADDRESS_ENABLE	0x01
> -#define PCI_ROM_ADDRESS_MASK	(~0x7ffUL)
> +#define PCI_ROM_ADDRESS_MASK	(~0x7ffU)

Does this mean we can remove the "(u32)" casts in __pci_read_base() and
pci_std_update_resource()?  If so, can you do that in the same patch?

>  #define PCI_CAPABILITY_LIST	0x34	/* Offset of first capability list entry */
>  
> -- 
> 2.12.2.715.g7642488e1d-goog
> 
