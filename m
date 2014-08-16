Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:53053 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbaHPM1l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Aug 2014 08:27:41 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so2863167qaj.21
        for <linux-pci@vger.kernel.org>; Sat, 16 Aug 2014 05:27:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1406137961-14684-3-git-send-email-l.stach@pengutronix.de>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
	<1406137961-14684-3-git-send-email-l.stach@pengutronix.de>
Date: Sat, 16 Aug 2014 17:57:40 +0530
Message-ID: <CAHM4w1nToF7uK4wrPHpTkMNF+aoBEuUCuyvYwk9cJAZwHRPuGA@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: designware: get rid of pci_scan_root_bus
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
> Use pci_create_root_bus() similar to other pci
> host controller drivers.
>
> The main problem with pci_scan_root_bus() is that
> not only it will create the root bus, but also try
> to activate all devices on the bus. This triggers
> PCI device drivers probe, which try to use the device
> but fail as resource allocation isn't done at that
> point in time.
>
> To work around this we made sure that the host
> controller driver is probed early and finishes resource
> allocation before any other device drivers are registered.
> Switching to pci_create_root_bus() allows us to get rid
> of this special handling.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/host/pcie-designware.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index b13a830c8b0f..b869e202367c 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -801,14 +801,13 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>         struct pci_bus *bus;
>         struct pcie_port *pp = sys_to_pcie(sys);
>
> -       if (pp) {
> -               pp->root_bus_nr = sys->busnr;
> -               bus = pci_scan_root_bus(pp->dev, sys->busnr, &dw_pcie_ops,
> -                                       sys, &sys->resources);
> -       } else {
> -               bus = NULL;
> -               BUG();
> -       }
> +       pp->root_bus_nr = sys->busnr;
> +       bus = pci_create_root_bus(pp->dev, sys->busnr,
> +                                 &dw_pcie_ops, sys, &sys->resources);
> +       if (!bus)
> +               return NULL;
> +
> +       pci_scan_child_bus(bus);
>
>         return bus;
>  }
> --

Looks fine to me.
Reviewed-by: Pratyush Anand <pratyush.anand@st.com>

> 2.0.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
