Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35605 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbbFSRWx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 13:22:53 -0400
Received: by igbzc4 with SMTP id zc4so18985203igb.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2015 10:22:52 -0700 (PDT)
Date: Fri, 19 Jun 2015 12:22:49 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Cc: linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: Re: [PATCH] PCI: Remove 10ms d3_delay restriction for Cherrytrail
Message-ID: <20150619172249.GM7710@google.com>
References: <20150619062238.GA13267@intel-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150619062238.GA13267@intel-desktop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 19, 2015 at 11:52:46AM +0530, Srinidhi Kasagar wrote:
> Just like Haswell, Intel Atom Cherrytrail also do not need
> the default 10ms d3_delay imposed by the PCI specification.
> 
> Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>

Applied with the following changelog to pci/misc for v4.2, thanks!

    PCI: Remove Intel Cherrytrail D3 delays
    
    Just like Haswell, Intel Atom Cherrytrail does not need the default 10ms
    d3_delay imposed by the PCI specification.
    
    Expand quirk_remove_d3_delay() to apply to Cherrytrail devices, so we can
    ignore the 10ms delay before entering or exiting D3 suspend.
    
    [bhelgaas: changelog, comment]
    Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/quirks.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index c6dc1dfd25d5..9f1cf197119d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3037,7 +3037,16 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c26, quirk_remove_d3_delay);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c4e, quirk_remove_d3_delay);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c02, quirk_remove_d3_delay);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c22, quirk_remove_d3_delay);
> -
> +/* Even few Cherrytrail devices do not need 10ms d3_delay */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x2280, quirk_remove_d3_delay);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b0, quirk_remove_d3_delay);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b8, quirk_remove_d3_delay);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22d8, quirk_remove_d3_delay);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22dc, quirk_remove_d3_delay);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b5, quirk_remove_d3_delay);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b7, quirk_remove_d3_delay);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x2298, quirk_remove_d3_delay);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x229c, quirk_remove_d3_delay);
>  /*
>   * Some devices may pass our check in pci_intx_mask_supported if
>   * PCI_COMMAND_INTX_DISABLE works though they actually do not properly
> -- 
> 1.7.9.5
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
