Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:44368 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933537AbaKMRzZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 12:55:25 -0500
Received: by mail-pa0-f47.google.com with SMTP id kx10so15724737pab.20
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 09:55:24 -0800 (PST)
Date: Thu, 13 Nov 2014 10:55:21 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Cooper' <jason@lakedaemon.net>
Subject: Re: [PATCH] PCI: mvebu: Add a blank line after declarations
Message-ID: <20141113175521.GP5064@google.com>
References: <002b01cffe28$a57021d0$f0506570$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002b01cffe28$a57021d0$f0506570$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 12:27:54PM +0900, Jingoo Han wrote:
> This patch fixes the following checkpatch warning.
> 
>   WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied with Jason's ack to pci/host-mvebu for v3.19, thanks!

I dropped the mvebu_pcie_add_bus() hunk because I have a patch in pci/msi
that removes that function altogether.

> ---
>  drivers/pci/host/pci-mvebu.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index b1315e1..0c775afa 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -622,6 +622,7 @@ static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
>  
>  	for (i = 0; i < pcie->nports; i++) {
>  		struct mvebu_pcie_port *port = &pcie->ports[i];
> +
>  		if (bus->number == 0 && port->devfn == devfn)
>  			return port;
>  		if (bus->number != 0 &&
> @@ -751,6 +752,7 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
>  
>  	for (i = 0; i < pcie->nports; i++) {
>  		struct mvebu_pcie_port *port = &pcie->ports[i];
> +
>  		if (!port->base)
>  			continue;
>  		mvebu_pcie_setup_hw(port);
> @@ -777,6 +779,7 @@ static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  static void mvebu_pcie_add_bus(struct pci_bus *bus)
>  {
>  	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
> +
>  	bus->msi = pcie->msi;
>  }
>  
> -- 
> 1.7.9.5
> 
> 
