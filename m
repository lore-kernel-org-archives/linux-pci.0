Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 22 Oct 2015 13:55:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Markus Elfring <elfring@users.sourceforge.net>,
	"moderated list:BROADCOM CYGNUS/IPROC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>,
	"open list:BROADCOM CYGNUS/IPROC ARM ARCHITECTURE"
	<bcm-kernel-feedback-list@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: iproc: Fix company name
Message-ID: <20151022185502.GE21237@localhost>
References: <1445022248-12203-1-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445022248-12203-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 16, 2015 at 12:04:04PM -0700, Florian Fainelli wrote:
> The header of pcie-iproc.c contains an obvious typo on Broadcom
> Corporation, fix that.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied with Ray's ack to pci/host-iproc for v4.4, thanks, Florian!

> ---
>  drivers/pci/host/pcie-iproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index fe2efb141a9b..6c3d4b54858c 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2014 Hauke Mehrtens <hauke@hauke-m.de>
> - * Copyright (C) 2015 Broadcom Corporatcommon ion
> + * Copyright (C) 2015 Broadcom Corporation
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
