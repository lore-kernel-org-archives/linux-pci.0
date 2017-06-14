Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751590AbdFNTN5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Jun 2017 15:13:57 -0400
Date: Wed, 14 Jun 2017 14:13:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MAINTAINERS: update maintainer for rockchip PCIe driver
Message-ID: <20170614191353.GF20778@bhelgaas-glaptop.roam.corp.google.com>
References: <1496389333-234834-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496389333-234834-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 02, 2017 at 03:42:13PM +0800, Shawn Lin wrote:
> Wenrui Li changed his employer and is no longer able to
> maintain this driver. So remove his email address from this
> file.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/host-rockhcip for v4.13, thanks!

> ---
> 
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9609ca6..5066ebe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10005,7 +10005,6 @@ F:	drivers/pci/dwc/pcie-hisi.c
>  
>  PCIE DRIVER FOR ROCKCHIP
>  M:	Shawn Lin <shawn.lin@rock-chips.com>
> -M:	Wenrui Li <wenrui.li@rock-chips.com>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-rockchip@lists.infradead.org
>  S:	Maintained
> -- 
> 1.9.1
> 
> 
