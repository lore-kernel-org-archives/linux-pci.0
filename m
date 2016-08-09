Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34474 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932342AbcHIQyd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Aug 2016 12:54:33 -0400
Date: Tue, 9 Aug 2016 11:54:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jszhang@marvell.com
Subject: Re: [PATCH v4 3/3] pcie-designware: fix typo
Message-ID: <20160809165428.GB27301@localhost>
References: <cover.1470758382.git.jpinto@synopsys.com>
 <bba00c66a124b80c2bc259b3d2f78e561c3df27a.1470758382.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bba00c66a124b80c2bc259b3d2f78e561c3df27a.1470758382.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joao,

On Tue, Aug 09, 2016 at 05:35:34PM +0100, Joao Pinto wrote:
> Simple fix typo.

This patch actually does more than fix a typo.  Not sure if you
intended to split this into separate patches, or to write a better
changelog for this one.  If these code changes are related and we have
a good changelog, I don't mind if the typo fix is included as an
incidental change.

Bjorn

> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ---
> changes v1->v4:
> - Nothing changed. Just to keep up patch set version.
> 
>  drivers/pci/host/pcie-designware.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 3fb9036..7731eda 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -36,7 +36,7 @@
>  #define LINK_WAIT_IATU_MIN		9000
>  #define LINK_WAIT_IATU_MAX		10000
>  
> -/* Synopsis specific PCIE configuration registers */
> +/* Synopsys specific PCIE configuration registers */
>  #define PCIE_PORT_LINK_CONTROL		0x710
>  #define PORT_LINK_MODE_MASK		(0x3f << 16)
>  #define PORT_LINK_MODE_1_LANES		(0x1 << 16)
> @@ -253,7 +253,7 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
>  		}
>  
>  		if (val == PCIE_ATU_ENABLE)
> -			break;
> +			return;
>  
>  		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
>  	}
> @@ -646,11 +646,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
>  
> +	pp->iatu_unroll_status = dw_pcie_get_atu_mode(pp);
> +
>  	if (pp->ops->host_init)
>  		pp->ops->host_init(pp);
>  
> -	pp->iatu_unroll_status = dw_pcie_get_atu_mode(pp);
> -
>  	pp->root_bus_nr = pp->busn->start;
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
> -- 
> 1.8.1.5
> 
