Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57810 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbeGFJEk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jul 2018 05:04:40 -0400
Subject: Re: [PATCH v6 07/11] pci-epf-test/pci_endpoint_test: Use irq_type
 module parameter
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>,
        <shawn.lin@rock-chips.com>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
 <98be2b2cfd6dfb9cdfed95da5fe8cde0a96ce37e.1529595907.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7257e7a6-50be-ee72-776d-41af141739a7@ti.com>
Date: Fri, 6 Jul 2018 14:34:25 +0530
MIME-Version: 1.0
In-Reply-To: <98be2b2cfd6dfb9cdfed95da5fe8cde0a96ce37e.1529595907.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thursday 21 June 2018 09:31 PM, Gustavo Pimentel wrote:
> Add new driver parameter to allow interruption type selection.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v2->v3:
>  - New patch file created base on the previous patch
> "misc: pci_endpoint_test: Add MSI-X support" patch file following
> Kishon's suggestion.
> Change v3->v4:
>  - Rebased to Lorenzo's master branch v4.18-rc1.
> Change v4->v5:
>  - Nothing changed, just to follow the patch set version.
> Change v5->v6:
>  - Nothing changed, just to follow the patch set version.
> 
>  drivers/misc/pci_endpoint_test.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 35fbfbd..4d2c9cb 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -82,6 +82,10 @@ static bool no_msi;
>  module_param(no_msi, bool, 0444);
>  MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
>  
> +static int irq_type = IRQ_TYPE_MSI;
> +module_param(irq_type, int, 0444);
> +MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI)");
> +
>  enum pci_barno {
>  	BAR_0,
>  	BAR_1,
> @@ -108,7 +112,7 @@ struct pci_endpoint_test {
>  struct pci_endpoint_test_data {
>  	enum pci_barno test_reg_bar;
>  	size_t alignment;
> -	bool no_msi;
> +	int irq_type;
>  };
>  
>  static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
> @@ -291,8 +295,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE,
>  				 size);
>  
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
> -				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>  				 COMMAND_COPY);
> @@ -361,8 +364,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
>  
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
>  
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
> -				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>  				 COMMAND_READ);
> @@ -419,8 +421,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
>  
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
>  
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
> -				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>  				 COMMAND_WRITE);
> @@ -505,11 +506,14 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	test->alignment = 0;
>  	test->pdev = pdev;
>  
> +	if (no_msi)
> +		irq_type = IRQ_TYPE_LEGACY;
> +
>  	data = (struct pci_endpoint_test_data *)ent->driver_data;
>  	if (data) {
>  		test_reg_bar = data->test_reg_bar;
>  		test->alignment = data->alignment;
> -		no_msi = data->no_msi;
> +		irq_type = data->irq_type;
>  	}
>  
>  	init_completion(&test->irq_raised);
> @@ -529,13 +533,21 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  
>  	pci_set_master(pdev);
>  
> -	if (!no_msi) {
> +	switch (irq_type) {
> +	case IRQ_TYPE_LEGACY:
> +		irq = 0;

Looks like this is not required. irq variable is used only for MSI irq.

Thanks
Kishon
