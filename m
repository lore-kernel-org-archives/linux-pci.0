Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:58871 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaHPM0k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Aug 2014 08:26:40 -0400
Received: by mail-qc0-f178.google.com with SMTP id x3so3314187qcv.9
        for <linux-pci@vger.kernel.org>; Sat, 16 Aug 2014 05:26:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1406137961-14684-2-git-send-email-l.stach@pengutronix.de>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
	<1406137961-14684-2-git-send-email-l.stach@pengutronix.de>
Date: Sat, 16 Aug 2014 17:56:39 +0530
Message-ID: <CAHM4w1nvYyMytByD4NZZ5QqKU=hbZ4Hw6PVDAGE5BGg-Ut-zgA@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: designware: start parsing bus-range
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	kernel@pengutronix.de, Pratyush ANAND <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 23, 2014 at 11:22 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> This allows to explicitly specify the covered bus
> numbers in the devicetree, which will come in handy
> once we see a SoC with more than one PCIe host
> controller instance.
>
> Previously the driver relied on the behavior of
> pci_scan_root_bus() to fill in a range of 0x00-0xff
> if no valid range was found. We fall back to the
> same range if no valid DT entry was found to keep
> backwards compatibility, but now do it explicitly.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie.txt |  3 +++
>  drivers/pci/host/pcie-designware.c                        | 13 ++++++++++++-
>  drivers/pci/host/pcie-designware.h                        |  1 +
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index ed0d9b9fff2b..9f4faa8e8d00 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -23,3 +23,6 @@ Required properties:
>
>  Optional properties:
>  - reset-gpio: gpio pin number of power good signal
> +- bus-range: PCI bus numbers covered (it is recommended for new devicetrees to
> +  specify this property, to keep backwards compatibility a range of 0x00-0xff
> +  is assumed if not present)
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 52bd3a143563..b13a830c8b0f 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -425,7 +425,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>         struct resource *cfg_res;
>         u32 val, na, ns;
>         const __be32 *addrp;
> -       int i, index;
> +       int i, index, ret;
>
>         /* Find the address cell size and the number of cells in order to get
>          * the untranslated address.
> @@ -500,6 +500,16 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>                 }
>         }
>
> +       ret = of_pci_parse_bus_range(np, &pp->busn);
> +       if (ret < 0) {
> +               dev_dbg(pp->dev, "failed to parse bus-range property: %d, using default [0x00-0xff]\n",
> +                       ret);
> +               pp->busn.name = np->name;
> +               pp->busn.start = 0;
> +               pp->busn.end = 0xff;
> +               pp->busn.flags = IORESOURCE_BUS;
> +       }
> +
>         if (!pp->dbi_base) {
>                 pp->dbi_base = devm_ioremap(pp->dev, pp->cfg.start,
>                                         resource_size(&pp->cfg));
> @@ -781,6 +791,7 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
>
>         sys->mem_offset = pp->mem.start - pp->config.mem_bus_addr;
>         pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
> +       pci_add_resource(&sys->resources, &pp->busn);
>
>         return 1;
>  }
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index daf81f922cda..9a09633ecdf8 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -48,6 +48,7 @@ struct pcie_port {
>         struct resource         cfg;
>         struct resource         io;
>         struct resource         mem;
> +       struct resource         busn;
>         struct pcie_port_info   config;
>         int                     irq;
>         u32                     lanes;
> --
> 2.0.1
>

Looks fine to me.
Reviewed-by: Pratyush Anand <pratyush.anand@st.com>

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
