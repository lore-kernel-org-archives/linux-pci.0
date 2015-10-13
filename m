Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36759 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbbJMULT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 13 Oct 2015 16:11:19 -0400
MIME-Version: 1.0
In-Reply-To: <3604931244806840dd12ff9663671b52d2acd951.1444288748.git.p.fedin@samsung.com>
References: <cover.1444288748.git.p.fedin@samsung.com> <3604931244806840dd12ff9663671b52d2acd951.1444288748.git.p.fedin@samsung.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 13 Oct 2015 15:10:57 -0500
Message-ID: <CAL_JsqJd3MisGEEahkx=46AiTBgLah42tL3ozzvkPiLtwCTG+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: of: Ignore resources with failed translation
To: Pavel Fedin <p.fedin@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Grant Likely <grant.likely@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 8, 2015 at 2:24 AM, Pavel Fedin <p.fedin@samsung.com> wrote:
> This patch allows PCI host controller to function even if part of resources
> is unusable for some reason. An example is non-LPAE kernel on a machine
> which has some 64-bit resources. Unusable resources will be just skipped
> instead of a complete failure.
>
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>

Applied, thanks.

Rob

> ---
>  drivers/of/of_pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 5751dc5..ea7c2b6 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -223,8 +223,10 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>                 }
>
>                 err = of_pci_range_to_resource(&range, dev, res);
> -               if (err)
> -                       goto conversion_failed;
> +               if (err) {
> +                       kfree(res);
> +                       continue;
> +               }
>
>                 if (resource_type(res) == IORESOURCE_IO) {
>                         if (!io_base) {
> --
> 2.4.4
>
