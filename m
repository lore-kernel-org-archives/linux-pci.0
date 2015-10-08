Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1444334056-4870-1-git-send-email-ddaney.cavm@gmail.com>
References: <1444334056-4870-1-git-send-email-ddaney.cavm@gmail.com>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 8 Oct 2015 17:05:07 -0500
Message-ID: <CAL_JsqKobjdCOHiQLEStp4Q12e9=3dLZUgq+TuTkmoFVtAz5xw@mail.gmail.com>
Subject: Re: [PATCH] PCI: generic: Fix address window calculation for non-zero
 starting bus.
To: David Daney <ddaney.cavm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 8, 2015 at 2:54 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
>
> Make the offset from the beginning of the "reg" property be from the
> starting bus number, rather than zero.  Hoist the invariant size
> calculation out of the mapping for loop.
>
> Update host-generic-pci.txt to clarify the semantics of the "reg"
> property with respect to non-zero starting bus numbers.
>
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> This is a replacement for:
>
> https://lkml.org/lkml/2015/10/2/653
>
> Since that patch is getting too much push-back, this is the only other
> option for fixing the driver to be internally consistent in its
> treatment of the offset from "reg" to the first bus in the "bus-range"
> property.
>
>  Documentation/devicetree/bindings/pci/host-generic-pci.txt | 5 +++--
>  drivers/pci/host/pci-host-generic.c                        | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> index cf3e205..3f1d3fc 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> @@ -34,8 +34,9 @@ Properties of the host controller node:
>  - #size-cells    : Must be 2.
>
>  - reg            : The Configuration Space base address and size, as accessed
> -                   from the parent bus.
> -
> +                   from the parent bus.  The base address corresponds to
> +                   the first bus in the "bus-range" property.  If no
> +                   "bus-range" is specified, this will be bus 0 (the default).
>
>  Properties of the /chosen node:
>
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index fe9a81b..bb93346 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -169,6 +169,7 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>         struct resource *bus_range;
>         struct device *dev = pci->host.dev.parent;
>         struct device_node *np = dev->of_node;
> +       u32 sz = 1 << pci->cfg.ops->bus_shift;
>
>         err = of_address_to_resource(np, 0, &pci->cfg.res);
>         if (err) {
> @@ -196,10 +197,9 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>         bus_range = pci->cfg.bus_range;
>         for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
>                 u32 idx = busn - bus_range->start;
> -               u32 sz = 1 << pci->cfg.ops->bus_shift;
>
>                 pci->cfg.win[idx] = devm_ioremap(dev,
> -                                                pci->cfg.res.start + busn * sz,
> +                                                pci->cfg.res.start + idx * sz,
>                                                  sz);
>                 if (!pci->cfg.win[idx])
>                         return -ENOMEM;
> --
> 1.9.1
>
