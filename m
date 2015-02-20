Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:48237 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037AbbBTWJu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Feb 2015 17:09:50 -0500
MIME-Version: 1.0
In-Reply-To: <1424214840-26498-1-git-send-email-fkan@apm.com>
References: <1424214840-26498-1-git-send-email-fkan@apm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 20 Feb 2015 16:09:29 -0600
Message-ID: <CAL_JsqJY24ptfEcA2EQ32M=4-KdQ5xac-j45EZp3aXT8uBM8EQ@mail.gmail.com>
Subject: Re: [PATCH] pci: host: xgene: fix incorrectly returned address by map_bus
To: Feng Kan <fkan@apm.com>
Cc: "patches@apm.com" <patches@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 17, 2015 at 5:14 PM, Feng Kan <fkan@apm.com> wrote:
> The generic accessor functions for pci-xgene uses map_bus
> call that returns the base address but did not add the additional
> offset.
>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/pci/host/pci-xgene.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks.

Acked-by: Rob Herring <robh@kernel.org>

>
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index aab5547..ee082c0 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -127,7 +127,7 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
>         return false;
>  }
>
> -static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> +static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>                               int offset)
>  {
>         struct xgene_pcie_port *port = bus->sysdata;
> @@ -137,7 +137,7 @@ static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>                 return NULL;
>
>         xgene_pcie_set_rtdid_reg(bus, devfn);
> -       return xgene_pcie_get_cfg_base(bus);
> +       return xgene_pcie_get_cfg_base(bus) + offset;
>  }
>
>  static struct pci_ops xgene_pcie_ops = {
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
