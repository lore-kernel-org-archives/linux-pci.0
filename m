Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34409 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161002AbbEOXD6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2015 19:03:58 -0400
Received: by ieczm2 with SMTP id zm2so61249477iec.1
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 16:03:58 -0700 (PDT)
Date: Fri, 15 May 2015 18:03:54 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Pratyush Anand <panand@redhat.com>
Cc: jg1.han@samsung.com, linux-pci@vger.kernel.org,
	mohit.kumar.dhaka@gmail.com,
	Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update SPEAr13xx and Designware PCIe
 maintainer
Message-ID: <20150515230354.GC31666@google.com>
References: <dd210909090e843e8f7cfc84479af7baa2250d33.1430366548.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dd210909090e843e8f7cfc84479af7baa2250d33.1430366548.git.panand@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 30, 2015 at 09:46:07AM +0530, Pratyush Anand wrote:
> From: Pratyush Anand <pratyush.anand@gmail.com>
> 
> Didn't add myself as Maintainer earlier, as I was moving out of ST
> and didn't had a board to test. But learnt recently that, its fine being
> in MAINTAINERS in such situations, at least I can review the patches.
> 
> So, let me add myself.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@gmail.com>

Applied with Jingoo's ack to for-linus for v4.1, thanks!

> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68e96ee0d58c..69ce49782ff9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7553,6 +7553,7 @@ F:	drivers/pci/host/pci-exynos.c
>  
>  PCI DRIVER FOR SYNOPSIS DESIGNWARE
>  M:	Jingoo Han <jg1.han@samsung.com>
> +M:	Pratyush Anand <pratyush.anand@gmail.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	drivers/pci/host/*designware*
> @@ -7566,8 +7567,9 @@ F:	Documentation/devicetree/bindings/pci/host-generic-pci.txt
>  F:	drivers/pci/host/pci-host-generic.c
>  
>  PCIE DRIVER FOR ST SPEAR13XX
> +M:	Pratyush Anand <pratyush.anand@gmail.com>
>  L:	linux-pci@vger.kernel.org
> -S:	Orphan
> +S:	Maintained
>  F:	drivers/pci/host/*spear*
>  
>  PCMCIA SUBSYSTEM
> -- 
> 2.1.0
> 
