Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:34556 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbaLPAS7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Dec 2014 19:18:59 -0500
Date: Mon, 15 Dec 2014 17:18:51 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: Re: [PATCH v3 2/2] arm: pcibios: move to generic PCI domains
Message-ID: <20141216001851.GA1991@obsidianresearch.com>
References: <1416569367-29409-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1416569367-29409-3-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416569367-29409-3-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 21, 2014 at 11:29:26AM +0000, Lorenzo Pieralisi wrote:

> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index b1315e1..dc2ed4d 100644
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -101,9 +101,7 @@ struct mvebu_pcie {
>  	struct mvebu_pcie_port *ports;
>  	struct msi_chip *msi;
>  	struct resource io;
> -	char io_name[30];
>  	struct resource realio;
> -	char mem_name[30];
>  	struct resource mem;
>  	struct resource busn;
>  	int nports;
> @@ -722,18 +720,9 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
>  {
>  	struct mvebu_pcie *pcie = sys_to_pcie(sys);
>  	int i;
> -	int domain = 0;
>  
> -#ifdef CONFIG_PCI_DOMAINS
> -	domain = sys->domain;
> -#endif
> -
> -	snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x",
> -		 domain);
> -	pcie->mem.name = pcie->mem_name;
> -
> -	snprintf(pcie->io_name, sizeof(pcie->io_name), "PCI I/O %04x", domain);
> -	pcie->realio.name = pcie->io_name;
> +	pcie->mem.name = "PCI MEM";
> +	pcie->realio.name = "PCI I/O";
>  
>  	if (request_resource(&iomem_resource, &pcie->mem))
>  		return 0;

For the mvebu section:

Reviewed-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Jason
