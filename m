Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbdJDTtP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Oct 2017 15:49:15 -0400
Date: Wed, 4 Oct 2017 14:49:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <stephen.bates@microsemi.com>
Subject: Re: [PATCH] MAINTAINERS: remove Stephen Bates
Message-ID: <20171004194913.GK25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20171004095523.19461-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171004095523.19461-1-bigeasy@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Kurt, Stephen, Logan]

On Wed, Oct 04, 2017 at 11:55:23AM +0200, Sebastian Andrzej Siewior wrote:
> Just sent an email there and received an autoreply because he no longer
> works there.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to pci/misc for v4.15, thanks!

Stephen, if this is incorrect, or just needs an updated email address, send
me a patch and I'll replace this one.

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 65b0c88d5ee0..af77ef599efb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10331,7 +10331,6 @@ F:	drivers/pci/host/vmd.c
>  
>  PCI DRIVER FOR MICROSEMI SWITCHTEC
>  M:	Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> -M:	Stephen Bates <stephen.bates@microsemi.com>
>  M:	Logan Gunthorpe <logang@deltatee.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> -- 
> 2.14.2
> 
