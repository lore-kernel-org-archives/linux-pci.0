Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52361 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbbJCObA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 3 Oct 2015 10:31:00 -0400
Date: Sat, 3 Oct 2015 09:30:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ruud <netwerkforens@gmail.com>
Cc: linux-pci@vger.kernel.org, Martin Mares <mj@ucw.cz>
Subject: Re: [PATCH] Enumerate all undiscovered PCIe busses
Message-ID: <20151003143056.GA17684@localhost>
References: <1443810216-3215-1-git-send-email-netwerkforens@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443810216-3215-1-git-send-email-netwerkforens@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This appears to be a patch for pciutils, so I cc'd Martin, who
maintains that.

On Fri, Oct 02, 2015 at 06:23:36PM +0000, Ruud wrote:
> Multiple root complexes have a different start busnumber.
> Poll all undiscovered busses for a root complex
>
> Signed-off-by: Ruud <netwerkforens@gmail.com>
> ---
>  lib/generic.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/generic.c b/lib/generic.c
> index c219592..21b8022 100644
> --- a/lib/generic.c
> +++ b/lib/generic.c
> @@ -69,9 +69,13 @@ void
>  pci_generic_scan(struct pci_access *a)
>  {
>    byte busmap[256];
> +  int basebus;
>  
>    memset(busmap, 0, sizeof(busmap));
> -  pci_generic_scan_bus(a, busmap, 0);
> +  for(basebus=0;basebus<256;basebus++) {
> +      if (busmap[basebus]==0)
> +          pci_generic_scan_bus(a, busmap, basebus);
> +  }
>  }
>  
>  int
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
