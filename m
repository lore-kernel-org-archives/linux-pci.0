Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33406 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161046AbbEOW5r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2015 18:57:47 -0400
Received: by igbpi8 with SMTP id pi8so50517343igb.0
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:57:46 -0700 (PDT)
Date: Fri, 15 May 2015 17:57:43 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	donald.d.dugger@intel.com
Subject: Re: [PATCH] PCI: ACS quirks for Intel 9-series PCH root ports
Message-ID: <20150515225743.GB31666@google.com>
References: <20150501191925.1863.71223.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150501191925.1863.71223.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 01, 2015 at 01:20:13PM -0600, Alex Williamson wrote:
> Intel confirms that 9-series chipset root ports provide ACS-equivalent
> isolation when configured via the existing Intel PCH ACS quirk setup.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Cc: Don Dugger <donald.d.dugger@intel.com>

Applied with Don's ack to pci/virtualization for v4.2, thanks!

> ---
>  drivers/pci/quirks.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index c6dc1df..f126bd6 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3740,6 +3740,8 @@ static const u16 pci_quirk_intel_pch_acs_ids[] = {
>  	/* Wellsburg (X99) PCH */
>  	0x8d10, 0x8d11, 0x8d12, 0x8d13, 0x8d14, 0x8d15, 0x8d16, 0x8d17,
>  	0x8d18, 0x8d19, 0x8d1a, 0x8d1b, 0x8d1c, 0x8d1d, 0x8d1e,
> +	/* Lynx Point (9 series) PCH */
> +	0x8c90, 0x8c92, 0x8c94, 0x8c96, 0x8c98, 0x8c9a, 0x8c9c, 0x8c9e,
>  };
>  
>  static bool pci_quirk_intel_pch_acs_match(struct pci_dev *dev)
> 
