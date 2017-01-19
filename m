Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1484844267.24339.44.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] PCI: imx6: Allow probe deferal by reset GPIO
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 19 Jan 2017 17:44:27 +0100
In-Reply-To: <20170119163631.10668-3-andrew.smirnov@gmail.com>
References: <20170119163631.10668-1-andrew.smirnov@gmail.com>
 <20170119163631.10668-3-andrew.smirnov@gmail.com>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org, yurovsky@gmail.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 19.01.2017, 08:36 -0800 schrieb Andrey Smirnov:
> Some designs implement reset GPIO via a GPIO expander connected to a
> peripheral bus. One such example would be i.MX7 Sabre board where said
> GPIO is provided by SPI shift register connected to a bitbanged SPI
> bus. In order to support such designs allow reset GPIO request to defer
> probing of the driver.
> 
> Cc: yurovsky@gmail.com
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/pci/host/pci-imx6.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 50a1291..574f026 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -653,6 +653,9 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  			dev_err(dev, "unable to get reset gpio\n");
>  			return ret;
>  		}
> +	} else if (imx6_pcie->reset_gpio == -EPROBE_DEFER) {
> +		dev_info(dev, "probe is defered by reset GPIO\n");

No, please no messages for probe deferrals, as those might happen quite
often until the required driver is there and then just spams the logs.
Otherwise looks good.

> +		return imx6_pcie->reset_gpio;
>  	}
>  
>  	/* Fetch clocks */
> @@ -746,11 +749,12 @@ static struct platform_driver imx6_pcie_driver = {
>  		.name	= "imx6q-pcie",
>  		.of_match_table = imx6_pcie_of_match,
>  	},
> +	.probe    = imx6_pcie_probe,
>  	.shutdown = imx6_pcie_shutdown,
>  };
>  
>  static int __init imx6_pcie_init(void)
>  {
> -	return platform_driver_probe(&imx6_pcie_driver, imx6_pcie_probe);
> +	return platform_driver_register(&imx6_pcie_driver);
>  }
>  device_initcall(imx6_pcie_init);



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
