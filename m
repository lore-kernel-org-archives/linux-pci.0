Return-Path: <SRS0=xyCL=RH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3786C43381
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 00:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D2920842
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 00:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551659037;
	bh=+P220HBzLg2VmLITxx6aa7YVkX8tNAEPFdERNuID3/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q2VlGICkvUVq4mZY/AgoCUjco6x3HEbxoCfrRJkh/oRzbaYaivxagO0HzGveal289
	 DldfPDs9pdnURkZcrKaDTQhE39aanK36HLj5Iy797HM79Tyb1IMPR5F3cSxi5ALs0K
	 7htqKEAXAq/bxQE/yNt5iED33cbJPuoytYABSHWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfCDAX5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:23:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfCDAX4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 Mar 2019 19:23:56 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3966A20835;
        Mon,  4 Mar 2019 00:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551659035;
        bh=+P220HBzLg2VmLITxx6aa7YVkX8tNAEPFdERNuID3/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uIaNgTVDOMpNMXSMgCv+CIggOBFcNxL1trQc0dbihN2P3iu9UoeoK4+i/En8KbTIB
         qSBIIqkgYRbWE9K7+xI++l7UuRLRY6sdFHpOrynPQUYv5xYGRpv9+zKilaDIJaveYK
         s+nmiii9DqqFoXCfLAxcEb1hbkk3YKTS6WPKYViE=
Date:   Sun, 3 Mar 2019 18:23:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 1/2] PCI: Prevent 64-bit resources from being counted in
 32-bit bridge region
Message-ID: <20190304002351.GA26569@google.com>
References: <20190214170028.27862-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214170028.27862-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Logan,

Sorry for the delay.  This code gives a headache.  I still remember
my headache from the last time we touched it.  Help me understand
what's going on here.

On Thu, Feb 14, 2019 at 10:00:27AM -0700, Logan Gunthorpe wrote:
> When using the pci=realloc command line argument, with hpmemsize not
> equal to zero, some hierarchies of 32-bit resources can fail to be
> assigned in some situations. When this happens, the user will see
> some PCI BAR resources being ignored and some PCI Bridge windows
> being left unset. In lspci this may look like:
> 
>   Memory behind bridge: fff00000-000fffff
> 
> or
> 
>   Region 0: Memory at <ignored> (32-bit, non-prefetchable) [size=256K]
> 
> Ignored BARs mean the underlying device will not be usable.
> 
> The possible situations where this can happen will be quite varied and
> depend highly on the exact hierarchy and how the realloc code ends up
> trying to assign the regions. It's known to at least require a
> large 64-bit BAR (>1GB) below a PCI bridge.

I guess the bug is that some BAR or window is unset when we actually
have space for it?  We need to make this more concrete, e.g., with a
minimal example of a failure case, and then connect this code change
specifically with that.

"Ignored BARs" doesn't seem like the best terminology here.  Can we
just say they're "unset" as you do for windows?  Even that's a little
squishy because there's really no such thing as a clearly "unset" or
invalid value for a BAR.  All we can say is that Linux *thinks* it's
unset because it happens to be zero (technically still a valid BAR
value) or it conflicts with another device.

Strictly speaking, the result is that we can't enable decoding for
that BAR type.  Often that does mean the device is unusable, but in
some cases, e.g., an I/O BAR being unset and a driver using
pci_enable_device_mem(), the device *is* usable.

Surely realloc can fail even without a large 64-bit BAR?  I don't
think there's a magic threshold at 1GB.  Maybe an example would
illustrate the problem better.

> The cause of this bug is in __pci_bus_size_bridges() which tries to
> calculate the total resource space required for each of the bridge windows
> (typically IO, 64-bit, and 32-bit / non-prefetchable). The code, as
> written, tries to allocate all the 64-bit prefetchable resources
> followed by all the remaining resources. It uses two calls to
> pbus_size_mem() for this. If the first call to pbus_size_mem() fails
> it tries to fit all resources into the 32-bit bridge window and it
> expects the size of the 32-bit bridge window to be multiple GBs which
> will never be assignable under the 4GB limit imposed on it.

There are actually three calls to pbus_size_mem():

  1) If bridge has a 64-bit prefetchable window, find the size of all
     64-bit prefetchable resources below the bridge

  2) If bridge has no 64-bit prefetchable window, find the size of all
     prefetchable resources below the bridge

  3) Find the size of everything else (non-prefetchable resources plus
     any prefetchable ones that couldn't be accommodated above)

Sorry again for being so literal and unimaginative, but I don't
understand how the code "expects the size of the ... window to be
multiple GBs which will never be assignable ...".  Whether things are
assignable just depends on what resources are available.  It's not a
matter of "expecting" the window to be big enough; it just is big
enough or it isn't.

> There are only two reasons for pbus_size_mem() to fail: if there is no
> 64-bit/prefetchable bridge window, or if that window is already
> assigned (in other words, its resource already has a parent set). We know
> the former case can't be true because, in __pci_bus_size_bridges(), it's
> existence is checked before making the call. So if the pbus_size_mem()
> call in question fails, the window must already be assigned, and in this
> case, we still do not want 64-bit resources trying to be sized into the
> 32-bit catch-all resource.

I guess this question of putting a 64-bit resource in the 32-bit
non-prefetchable window (legal but undesirable) is a secondary thing,
not the chief complaint you're fixing?

> So to fix the bug, we must always set mask, type2 and type3 in cases
> where a 64-bit resource exists even if pbus_size_mem() fails.
> 
> Reported-by: Kit Chow <kchow@gigaio.com>
> Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/setup-bus.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ed960436df5e..56b7077f37ff 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1265,21 +1265,20 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
>  		if (b_res[2].flags & IORESOURCE_MEM_64) {
>  			prefmask |= IORESOURCE_MEM_64;
> -			ret = pbus_size_mem(bus, prefmask, prefmask,
> +			pbus_size_mem(bus, prefmask, prefmask,
>  				  prefmask, prefmask,
>  				  realloc_head ? 0 : additional_mem_size,
>  				  additional_mem_size, realloc_head);
>  
>  			/*
> -			 * If successful, all non-prefetchable resources
> -			 * and any 32-bit prefetchable resources will go in
> -			 * the non-prefetchable window.
> +			 * Given the existence of a 64-bit resource for this
> +			 * bus, all non-prefetchable resources and any 32-bit
> +			 * prefetchable resources will go in the
> +			 * non-prefetchable window.
>  			 */
> -			if (ret == 0) {
> -				mask = prefmask;
> -				type2 = prefmask & ~IORESOURCE_MEM_64;
> -				type3 = prefmask & ~IORESOURCE_PREFETCH;
> -			}
> +			mask = prefmask;
> +			type2 = prefmask & ~IORESOURCE_MEM_64;
> +			type3 = prefmask & ~IORESOURCE_PREFETCH;
>  		}
>  
>  		/*
> -- 
> 2.19.0
> 
