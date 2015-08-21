Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36366 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbbHUSSt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 14:18:49 -0400
MIME-Version: 1.0
In-Reply-To: <1440138067-4314-44-git-send-email-yinghai@kernel.org>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org> <1440138067-4314-44-git-send-email-yinghai@kernel.org>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 21 Aug 2015 13:18:29 -0500
Message-ID: <CAL_JsqL3pR2U4Fzv0j5Htd2O0cRXVQta-1rOZLkWR9kyz89RuA@mail.gmail.com>
Subject: Re: [PATCH v4 43/52] OF/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 21, 2015 at 1:20 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> For device resource PREF bit setting under bridge 64-bit pref resource,
> we need to make sure only set PREF for 64bit resource, so set
> IORESOUCE_MEM_64 for 64bit resource during OF device resource flags
> parsing.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org

My comment from v1[1] is not addressed still.

Rob

[1] https://lkml.org/lkml/2015/7/10/736

> ---
>  drivers/of/address.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 8bfda6a..073125f 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -128,9 +128,11 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
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
> --
> 1.8.4.5
>
