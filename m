Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Dmitry Torokhov <dtor@chromium.org>,
	Simon Horman <horms@verge.net.au>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: rcar: fix error handling of irq_of_parse_and_map
Date: Tue, 18 Nov 2014 10:43:36 +0000
Message-ID: <af1a2829f9084caf86f3ec22ebdea77d@SIXPR06MB0639.apcprd06.prod.outlook.com>
References: <20141114222153.GA39494@dtor-ws>
In-Reply-To: <20141114222153.GA39494@dtor-ws>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Dmitry,

On 14 November 2014 22:22, Dmitry wrote:
> 
> Return value of irq_of_parse_and_map() is unsigned int, with 0
> indicating failure, so testing for negative result never works.
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>

Acked-by: Phil Edworthy <phil.edworthy@renesas.com>

Thanks
Phil

> ---
> 
> Not tested, found by casual code inspection.
> 
>  drivers/pci/host/pcie-rcar.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 9b356c3..6ca976f 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -764,7 +764,7 @@ static int rcar_pcie_get_resources(struct platform_device
> *pdev,
>  		goto err_map_reg;
> 
>  	i = irq_of_parse_and_map(pdev->dev.of_node, 0);
> -	if (i < 0) {
> +	if (!i) {
>  		dev_err(pcie->dev, "cannot get platform resources for msi
> interrupt\n");
>  		err = -ENOENT;
>  		goto err_map_reg;
> @@ -772,7 +772,7 @@ static int rcar_pcie_get_resources(struct platform_device
> *pdev,
>  	pcie->msi.irq1 = i;
> 
>  	i = irq_of_parse_and_map(pdev->dev.of_node, 1);
> -	if (i < 0) {
> +	if (!i) {
>  		dev_err(pcie->dev, "cannot get platform resources for msi
> interrupt\n");
>  		err = -ENOENT;
>  		goto err_map_reg;
> --
> 2.1.0.rc2.206.gedb03e5
> 
> 
> --
> Dmitry
