Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:32964 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbbFWP3u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2015 11:29:50 -0400
MIME-Version: 1.0
In-Reply-To: <000301d0a910$09d9bd60$1d8d3820$@com>
References: <000301d0a910$09d9bd60$1d8d3820$@com>
From: Rob Herring <robherring2@gmail.com>
Date: Tue, 23 Jun 2015 10:29:30 -0500
Message-ID: <CAL_JsqJcVuQpCxmmNwMzRu1Ypxdnaijroz7va5CuevJe_M2r+A@mail.gmail.com>
Subject: Re: [PATCH] of/address: use atomic allocation in pci_register_io_range()
To: Jingoo Han <jingoohan1@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 17, 2015 at 10:12 AM, Jingoo Han <jingoohan1@gmail.com> wrote:
> When kzalloc() is called under spin_lock(), GFP_ATOMIC should be
> used to avoid sleeping allocation.
> The call tree is:
>   of_pci_range_to_resource()
>     --> pci_register_io_range() <-- takes spin_lock(&io_range_lock);
>        --> kzalloc()
>
> Signed-off-by: Jingoo Han <jingoohan1@gmail.com>

Applied. Thanks.

Rob

> ---
>  drivers/of/address.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 78a7dcb..65c3289 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -712,7 +712,7 @@ int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
>         }
>
>         /* add the range to the list */
> -       range = kzalloc(sizeof(*range), GFP_KERNEL);
> +       range = kzalloc(sizeof(*range), GFP_ATOMIC);
>         if (!range) {
>                 err = -ENOMEM;
>                 goto end_register;
> --
> 1.9.1
>
>
