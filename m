Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50836 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbaBLXYc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 18:24:32 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: mvebu - Call request_resources on the apertures
Date: Thu, 13 Feb 2014 00:24:29 +0100
Message-ID: <1516995.fJPJigzAve@wuerfel>
In-Reply-To: <1392245828-23244-2-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com> <1392245828-23244-2-git-send-email-jgunthorpe@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 12 February 2014 15:57:08 Jason Gunthorpe wrote:
> It is typical for host drivers to request a resource for the
> aperture, once this is done the PCI core will properly populate
> resources for all BARs in the system.
> 
> With this patch cat /proc/iomem will now show:
> 
> e0000000-efffffff : PCI MEM 0000
>   e0000000-e00fffff : PCI Bus 0000:01
>     e0000000-e001ffff : 0000:01:00.0
> 
> Tested on Kirkwood
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> Arnd: Please confirm your SOB line, thanks.
> 

Yes, that's good. Thanks for taking care of this.

	Arnd
