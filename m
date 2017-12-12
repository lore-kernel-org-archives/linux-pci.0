Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752329AbdLLRet (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Dec 2017 12:34:49 -0500
Date: Tue, 12 Dec 2017 11:34:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: cyndis@kapsi.fi, thierry.reding@gmail.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, jonathanh@nvidia.com,
        robh+dt@kernel.org, frowand.list@gmail.com, rjw@rjwysocki.net,
        tglx@linutronix.de, vidyas@nvidia.com, kthota@nvidia.com,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 2/7] PCI: tegra: Use bus->sysdata to store and get
 host private data
Message-ID: <20171212173440.GC53955@bhelgaas-glaptop.roam.corp.google.com>
References: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
 <1512723493-865-3-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512723493-865-3-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 08, 2017 at 02:28:08PM +0530, Manikanta Maddireddy wrote:
> Tegra host driver is using pci_find_host_bridge() to get private data,
> however pci_find_host_bridge() is causing module build failure because
> it is not exported. pci_find_host_bridge() can be avoided by using
> bus->sysdata to store and get private data.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Thanks a lot for doing this!  Looks like it was even easier than I
expected :)

> ---
> V4:
> * new patch in V4
> 
>  drivers/pci/host/pci-tegra.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 6f2f44539020..a549c5899e26 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -448,8 +448,7 @@ static unsigned long tegra_pcie_conf_offset(unsigned char b, unsigned int devfn,
>  
>  static int tegra_pcie_add_bus(struct pci_bus *bus)
>  {
> -	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> -	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
> +	struct tegra_pcie *pcie = bus->sysdata;
>  	struct tegra_pcie_bus *b;
>  
>  	b = kzalloc(sizeof(*b), GFP_KERNEL);
> @@ -466,8 +465,7 @@ static int tegra_pcie_add_bus(struct pci_bus *bus)
>  
>  static void tegra_pcie_remove_bus(struct pci_bus *child)
>  {
> -	struct pci_host_bridge *host = pci_find_host_bridge(child);
> -	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
> +	struct tegra_pcie *pcie = child->sysdata;
>  	struct tegra_pcie_bus *bus, *tmp;
>  
>  	list_for_each_entry_safe(bus, tmp, &pcie->buses, list) {
> @@ -483,8 +481,7 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>  					unsigned int devfn,
>  					int where)
>  {
> -	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> -	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
> +	struct tegra_pcie *pcie = bus->sysdata;
>  	void __iomem *addr = NULL;
>  	u32 val = 0;
>  	u32 offset = 0;
> @@ -675,8 +672,7 @@ static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
>  
>  static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
> -	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
> -	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
> +	struct tegra_pcie *pcie = pdev->bus->sysdata;
>  	int irq;
>  
>  	tegra_cpuidle_pcie_irqs_in_use();
> @@ -2570,6 +2566,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	pcie = pci_host_bridge_priv(host);
> +	host->sysdata = pcie;
>  
>  	pcie->soc = of_device_get_match_data(dev);
>  	INIT_LIST_HEAD(&pcie->buses);
> -- 
> 2.1.4
> 
