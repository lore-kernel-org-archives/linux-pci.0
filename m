Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:32915 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbbFRW6L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 18:58:11 -0400
Received: by yhpn97 with SMTP id n97so66821129yhp.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 15:58:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434665458-28354-1-git-send-email-dhdang@apm.com>
References: <1434665458-28354-1-git-send-email-dhdang@apm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 18 Jun 2015 17:57:50 -0500
Message-ID: <CAErSpo6fn++u3uyE+Z-h9T6qmy30f2eyuO4929a=_xShhHHeDQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pci: xgene: Fix compilation warning
To: Duc Dang <dhdang@apm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>, patches <patches@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 5:10 PM, Duc Dang <dhdang@apm.com> wrote:
> commit 979595bcb8da ("PCI: xgene: Allow config access to Root Port even
> when link is down") removes the port->link_up check, which makes 'port'
> become unused variable. This patch remove struct xgene_pcie_port *port
> declaration to avoid compilation warning.
>
> Signed-off-by: Duc Dang <dhdang@apm.com>
> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>

I folded this fix into the original patch and updated my branch.  Thanks!

> ---
>  drivers/pci/host/pci-xgene.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 3684126..105fd83 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -137,8 +137,6 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
>  static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>                               int offset)
>  {
> -       struct xgene_pcie_port *port = bus->sysdata;
> -
>         if ((pci_is_root_bus(bus) && devfn != 0) ||
>             xgene_pcie_hide_rc_bars(bus, offset))
>                 return NULL;
> --
> 1.9.1
>
