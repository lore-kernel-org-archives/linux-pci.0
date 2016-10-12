Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753422AbcJLQQz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:16:55 -0400
Date: Wed, 12 Oct 2016 11:15:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: add maintainer for the PCIe Marvell
 Armada 8K driver
Message-ID: <20161012161555.GU4308@localhost>
References: <1475872231-3199-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475872231-3199-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 07, 2016 at 10:30:30PM +0200, Thomas Petazzoni wrote:
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to pci/host-armada for v4.9, thanks, Thomas!

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f593300..8f6fb8c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8965,6 +8965,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/versatile.txt
>  F:	drivers/pci/host/pci-versatile.c
>  
> +PCI DRIVER FOR ARMADA 8K
> +M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> +L:	linux-pci@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
> +F:	drivers/pci/host/pcie-armada8k.c
> +
>  PCI DRIVER FOR APPLIEDMICRO XGENE
>  M:	Tanmay Inamdar <tinamdar@apm.com>
>  L:	linux-pci@vger.kernel.org
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
