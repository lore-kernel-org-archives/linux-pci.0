Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:55117 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbbJPTnT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2015 15:43:19 -0400
Subject: Re: [PATCH] PCI: iproc: Fix company name
To: Florian Fainelli <f.fainelli@gmail.com>,
	<linux-pci@vger.kernel.org>
References: <1445022248-12203-1-git-send-email-f.fainelli@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Markus Elfring <elfring@users.sourceforge.net>,
	"moderated list:BROADCOM CYGNUS/IPROC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>,
	"open list:BROADCOM CYGNUS/IPROC ARM ARCHITECTURE"
	<bcm-kernel-feedback-list@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <56215355.4070009@broadcom.com>
Date: Fri, 16 Oct 2015 12:43:17 -0700
MIME-Version: 1.0
In-Reply-To: <1445022248-12203-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 10/16/2015 12:04 PM, Florian Fainelli wrote:
> The header of pcie-iproc.c contains an obvious typo on Broadcom
> Corporation, fix that.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
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
> 

When I saw the subject, for a while I thought you are going to change it
to Broadcom Limited, :)

Thanks for fixing this!

Acked-by: Ray Jui <rjui@broadcom.com>
