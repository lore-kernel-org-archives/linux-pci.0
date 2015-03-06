Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:39422 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbbCFREM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 12:04:12 -0500
Received: by obcwp18 with SMTP id wp18so10469693obc.6
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2015 09:04:11 -0800 (PST)
Date: Fri, 6 Mar 2015 11:04:08 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Mark Salter <msalter@redhat.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: xgene: fix breakage from generic config usage
Message-ID: <20150306170408.GD20077@google.com>
References: <1425507864-22055-1-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425507864-22055-1-git-send-email-msalter@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 04, 2015 at 05:24:24PM -0500, Mark Salter wrote:
> Commit 350f8be5bb402 ("PCI: xgene: Convert to use generic config
> accessors") breaks PCI on the X-Gene platform. It creates two
> problems with the xgene_pcie_map_bus() function. First, it returns
> an int but should return a void __iomem *, but that's just a
> compile-time warning. The breakage is caused by the offset not
> being added to the base of the config map. So all config reads
> and writes operate on the first four bytes of config space. This
> patch fixes both issues.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

I forgot to copy you, Mark, but I applied Feng's earlier patch [1], which I
think is equivalent to yours.

[1] https://patchwork.ozlabs.org/patch/440759/

> ---
>  drivers/pci/host/pci-xgene.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 52bb25c..b87f80b 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -129,17 +129,21 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
>  	return false;
>  }
>  
> -static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> -			      int offset)
> +static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> +					int offset)
>  {
>  	struct xgene_pcie_port *port = bus->sysdata;
> +	void __iomem *base;
>  
>  	if ((pci_is_root_bus(bus) && devfn != 0) || !port->link_up ||
>  	    xgene_pcie_hide_rc_bars(bus, offset))
>  		return NULL;
>  
>  	xgene_pcie_set_rtdid_reg(bus, devfn);
> -	return xgene_pcie_get_cfg_base(bus);
> +	base = xgene_pcie_get_cfg_base(bus);
> +	if (base)
> +		base += offset;
> +	return base;
>  }
>  
>  static struct pci_ops xgene_pcie_ops = {
> -- 
> 1.8.3.1
> 
