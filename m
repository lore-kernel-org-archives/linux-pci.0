Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 10 Jun 2016 19:06:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 35/54] MAINTAINERS: Add file patterns for pci device tree
 bindings
Message-ID: <20160611000619.GE16462@localhost>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
 <1463907991-7916-36-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463907991-7916-36-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 22, 2016 at 11:06:12AM +0200, Geert Uytterhoeven wrote:
> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Applied to pci/misc for v4.8, thanks, Geert.

> ---
> Please apply this patch directly if you want to be involved in device
> tree binding documentation for your subsystem.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 868111d26536f086..2e4bacda7f40a7e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8695,6 +8695,7 @@ L:	linux-pci@vger.kernel.org
>  Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>  S:	Supported
> +F:	Documentation/devicetree/bindings/pci/
>  F:	Documentation/PCI/
>  F:	drivers/pci/
>  F:	include/linux/pci*
> -- 
> 1.9.1
> 
