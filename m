Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36699 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbbDHBbU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Apr 2015 21:31:20 -0400
MIME-Version: 1.0
In-Reply-To: <1428452680-24861-1-git-send-email-yinghai@kernel.org>
References: <1428452680-24861-1-git-send-email-yinghai@kernel.org>
From: Rob Herring <robherring2@gmail.com>
Date: Tue, 7 Apr 2015 20:30:58 -0500
Message-ID: <CAL_JsqLx4dB9CG0t0pCV89VxECXVTZyyiGfq=awNJSgfD50Raw@mail.gmail.com>
Subject: Re: [PATCH] of/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 7, 2015 at 7:24 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> For device resource PREF bit setting under bridge 64-bit pref resource,
> we need to make sure only set PREF for 64bit resource, so set IORESOUCE_MEM_64
> for 64bit resource during of device resource flags parsing.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org

Acked-by: Rob Herring <robh@kernel.org>

Bjorn, are you collecting these or should I apply?

Rob

> ---
>  drivers/of/address.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Index: linux-2.6/drivers/of/address.c
> ===================================================================
> --- linux-2.6.orig/drivers/of/address.c
> +++ linux-2.6/drivers/of/address.c
> @@ -128,9 +128,11 @@ static unsigned int of_bus_pci_get_flags
>                 flags |= IORESOURCE_IO;
>                 break;
>         case 0x02: /* 32 bits */
> -       case 0x03: /* 64 bits */
>                 flags |= IORESOURCE_MEM;
>                 break;
> +       case 0x03: /* 64 bits */
> +               flags |= IORESOURCE_MEM | IORESOURCE_MEM_64;
> +               break;
>         }
>         if (w & 0x40000000)
>                 flags |= IORESOURCE_PREFETCH;
