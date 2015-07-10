Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33395 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606AbbGJUVk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2015 16:21:40 -0400
MIME-Version: 1.0
In-Reply-To: <1436225966-27247-30-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org> <1436225966-27247-30-git-send-email-yinghai@kernel.org>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 10 Jul 2015 15:21:20 -0500
Message-ID: <CAL_Jsq+P96KYuDWdYSd8-vj_FF_KL6dTW5BM5sqxQ3EmKYX1PA@mail.gmail.com>
Subject: Re: [PATCH 29/36] of/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
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

On Mon, Jul 6, 2015 at 6:39 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> For device resource PREF bit setting under bridge 64-bit pref resource,
> we need to make sure only set PREF for 64bit resource, so set
> IORESOUCE_MEM_64 for 64bit resource during of device resource flags
> parsing.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241

As the BZ says, we have several identical functions. Can we fix the
drivers/of/address.c version and remove the Sparc versions. The only
diff is the generic version converts from be32. I think that should be
a nop for Sparc.

Rob

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
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
