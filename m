Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36415 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbaGXELn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 00:11:43 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N9700LFV7MWCGA0@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 24 Jul 2014 13:11:20 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Lucas Stach' <l.stach@pengutronix.de>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Richard Zhu' <r65037@freescale.com>,
	'Mohit Kumar' <mohit.kumar@st.com>,
	'Marek Vasut' <marex@denx.de>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	kernel@pengutronix.de, 'Jingoo Han' <jg1.han@samsung.com>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
 <1406137961-14684-3-git-send-email-l.stach@pengutronix.de>
In-reply-to: <1406137961-14684-3-git-send-email-l.stach@pengutronix.de>
Subject: Re: [PATCH 2/4] PCI: designware: get rid of pci_scan_root_bus
Date: Thu, 24 Jul 2014 13:11:19 +0900
Message-id: <001201cfa6f5$52863840$f792a8c0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, July 24, 2014 2:53 AM, Lucas Stach wrote:
> 
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
>  	struct pci_bus *bus;
>  	struct pcie_port *pp = sys_to_pcie(sys);
> 
> -	if (pp) {
> -		pp->root_bus_nr = sys->busnr;
> -		bus = pci_scan_root_bus(pp->dev, sys->busnr, &dw_pcie_ops,
> -					sys, &sys->resources);
> -	} else {
> -		bus = NULL;
> -		BUG();
> -	}
> +	pp->root_bus_nr = sys->busnr;
> +	bus = pci_create_root_bus(pp->dev, sys->busnr,
> +				  &dw_pcie_ops, sys, &sys->resources);
> +	if (!bus)
> +		return NULL;
> +
> +	pci_scan_child_bus(bus);


I think that we still need to check if pp is NULL.
Then, how about adding NULL check as below?


+	if (!pp) {
+		BUG();
+		return NULL;
+	}
+
+	pp->root_bus_nr = sys->busnr;
+	bus = pci_create_root_bus(pp->dev, sys->busnr,
+				  &dw_pcie_ops, sys, &sys->resources);
+	if (!bus)
+		return NULL;
+
+	pci_scan_child_bus(bus);


Best regards,
Jingoo Han

> 
>  	return bus;
>  }
> --
> 2.0.1

