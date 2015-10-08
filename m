Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34474 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbJHBmy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2015 21:42:54 -0400
MIME-Version: 1.0
In-Reply-To: <d222dd1e4d8ed59e25248091e90e53b662e007c5.1444214119.git.p.fedin@samsung.com>
References: <cover.1444214119.git.p.fedin@samsung.com> <d222dd1e4d8ed59e25248091e90e53b662e007c5.1444214119.git.p.fedin@samsung.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 7 Oct 2015 20:42:34 -0500
Message-ID: <CAL_JsqKV2FpzHQs9OaYoHP66ir9jXvf91bxDFKeoNiRtho_GGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: of: Add 64-bit address recognition without LPAE support
To: Pavel Fedin <p.fedin@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Grant Likely <grant.likely@linaro.org>,
	Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 7, 2015 at 5:49 AM, Pavel Fedin <p.fedin@samsung.com> wrote:
> If non-LPAE kernel is booted up on a machine with 64-bit PCI resources,
> PCI controller probe fails with:
>
> PCI host bridge /pcie@10000000 ranges:
>    IO 0x3eff0000..0x3effffff -> 0x00000000
>   MEM 0x10000000..0x3efeffff -> 0x10000000
>   MEM 0x8000000000..0xffffffffff -> 0x8000000000
> pci-host-generic 3f000000.pcie: resource collision: [mem 0x00000000-0xffffffff] conflicts with /pl011@9000000 [mem 0x09000000-0x09000fff]
> pci-host-generic: probe of 3f000000.pcie failed with error -16
>
> This happens because res->start assignment in of_pci_range_to_resource()
> truncates the upper part of the address, because res->start is of
> phys_addr_t type, which is 32-bit on non-LPAE kernels.
>
> This patch adds explicit recognition of 64-bit resources, preventing from
> potential problems when e. g. 0x8000001234 would be converted to
> 0x00001234.
>
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
>  drivers/of/address.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 384574c..9a8f8c3 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -330,6 +330,12 @@ int of_pci_range_to_resource(struct of_pci_range *range,
>                 }
>                 res->start = port;
>         } else {
> +#ifndef CONFIG_PHYS_ADDR_T_64BIT
> +               if (upper_32_bits(range->cpu_addr)) {

Drop the ifdef:

if ((sizeof(phys_addr_t) > 4) && upper_32_bits(range->cpu_addr)) {

Seems fine otherwise.

> +                       err = -EINVAL;
> +                       goto invalid_range;
> +               }
> +#endif
>                 res->start = range->cpu_addr;
>         }
>         res->end = res->start + range->size - 1;
> --
> 2.4.4
>
