Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Richard Zhu <hongxing.zhu@nxp.com>
To: Colin King <colin.king@canonical.com>, Lucas Stach
 <l.stach@pengutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] PCI: imx6: fix spelling mistake: "contol" -> "control"
Date: Tue, 25 Apr 2017 06:09:54 +0000
Message-ID: <AM5PR0402MB28502178051215CE9C1EBAD08C1E0@AM5PR0402MB2850.eurprd04.prod.outlook.com>
References: <20170421070230.16582-1-colin.king@canonical.com>
In-Reply-To: <20170421070230.16582-1-colin.king@canonical.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Colin King [mailto:colin.king@canonical.com]
> Sent: Friday, April 21, 2017 3:03 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>; Lucas Stach
> <l.stach@pengutronix.de>; Bjorn Helgaas <bhelgaas@google.com>; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] PCI: imx6: fix spelling mistake: "contol" -> "control"
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> trivial fix to spelling mistake in dev_err message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Richard Zhu <hongxing.Zhu@nxp.com>

Best Regards
hongxing zhu
Email: hongxing.zhu@nxp.com

> ---
>  drivers/pci/dwc/pci-imx6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c index
> 102edcf1e261..129717ae5022 100644
> --- a/drivers/pci/dwc/pci-imx6.c
> +++ b/drivers/pci/dwc/pci-imx6.c
> @@ -726,13 +726,13 @@ static int imx6_pcie_probe(struct platform_device
> *pdev)
>  		imx6_pcie->pciephy_reset = devm_reset_control_get(dev,
>  								  "pciephy");
>  		if (IS_ERR(imx6_pcie->pciephy_reset)) {
> -			dev_err(dev, "Failed to get PCIEPHY reset contol\n");
> +			dev_err(dev, "Failed to get PCIEPHY reset control\n");
>  			return PTR_ERR(imx6_pcie->pciephy_reset);
>  		}
> 
>  		imx6_pcie->apps_reset = devm_reset_control_get(dev,
> "apps");
>  		if (IS_ERR(imx6_pcie->apps_reset)) {
> -			dev_err(dev, "Failed to get PCIE APPS reset
> contol\n");
> +			dev_err(dev, "Failed to get PCIE APPS reset
> control\n");
>  			return PTR_ERR(imx6_pcie->apps_reset);
>  		}
>  		break;
> --
> 2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
