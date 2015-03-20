Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38327 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbCTX1F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2015 19:27:05 -0400
Received: by igbqf9 with SMTP id qf9so746304igb.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 16:27:05 -0700 (PDT)
Date: Fri, 20 Mar 2015 18:27:01 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCH] PCI: mvebu: add suspend/resume support
Message-ID: <20150320232701.GQ26935@google.com>
References: <1426604145-12335-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426604145-12335-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 17, 2015 at 03:55:45PM +0100, Thomas Petazzoni wrote:
> This commit implements suspend/resume support for the mvebu PCIe host
> driver. Without this commit, the system will panic at resume time when
> PCIe devices are connected.
> 
> Note that we have to use the ->suspend_noirq() and ->resume_noirq()
> hooks, because at resume time, the PCI fixups are done at
> ->resume_noirq() time, so the PCIe controller has to be ready at this
> point.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied with Jason's ack to pci/host-mvebu for v4.1, thanks!

> ---
>  drivers/pci/host/pci-mvebu.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 1309cfb..1ab8635 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -129,6 +129,7 @@ struct mvebu_pcie_port {
>  	size_t memwin_size;
>  	phys_addr_t iowin_base;
>  	size_t iowin_size;
> +	u32 saved_pcie_stat;
>  };
>  
>  static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
> @@ -899,6 +900,35 @@ static void mvebu_pcie_msi_enable(struct mvebu_pcie *pcie)
>  		pcie->msi->dev = &pcie->pdev->dev;
>  }
>  
> +static int mvebu_pcie_suspend(struct device *dev)
> +{
> +	struct mvebu_pcie *pcie;
> +	int i;
> +
> +	pcie = dev_get_drvdata(dev);
> +	for (i = 0; i < pcie->nports; i++) {
> +		struct mvebu_pcie_port *port = pcie->ports + i;
> +		port->saved_pcie_stat = mvebu_readl(port, PCIE_STAT_OFF);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mvebu_pcie_resume(struct device *dev)
> +{
> +	struct mvebu_pcie *pcie;
> +	int i;
> +
> +	pcie = dev_get_drvdata(dev);
> +	for (i = 0; i < pcie->nports; i++) {
> +		struct mvebu_pcie_port *port = pcie->ports + i;
> +		mvebu_writel(port, port->saved_pcie_stat, PCIE_STAT_OFF);
> +		mvebu_pcie_setup_hw(port);
> +	}
> +
> +	return 0;
> +}
> +
>  static int mvebu_pcie_probe(struct platform_device *pdev)
>  {
>  	struct mvebu_pcie *pcie;
> @@ -1056,6 +1086,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  	mvebu_pcie_msi_enable(pcie);
>  	mvebu_pcie_enable(pcie);
>  
> +	platform_set_drvdata(pdev, pcie);
> +
>  	return 0;
>  }
>  
> @@ -1068,12 +1100,18 @@ static const struct of_device_id mvebu_pcie_of_match_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mvebu_pcie_of_match_table);
>  
> +static struct dev_pm_ops mvebu_pcie_pm_ops = {
> +	.suspend_noirq = mvebu_pcie_suspend,
> +	.resume_noirq = mvebu_pcie_resume,
> +};
> +
>  static struct platform_driver mvebu_pcie_driver = {
>  	.driver = {
>  		.name = "mvebu-pcie",
>  		.of_match_table = mvebu_pcie_of_match_table,
>  		/* driver unloading/unbinding currently not supported */
>  		.suppress_bind_attrs = true,
> +		.pm = &mvebu_pcie_pm_ops,
>  	},
>  	.probe = mvebu_pcie_probe,
>  };
> -- 
> 2.1.0
> 
