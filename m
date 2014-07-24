Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0183.outbound.protection.outlook.com ([207.46.163.183]:5754
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751248AbaGXGcr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 02:32:47 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH 4/4] PCI: imx6: move to module_init
Date: Thu, 24 Jul 2014 06:32:44 +0000
Message-ID: <eb34b98d76674c0d9f70c1f55dc1a4fa@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
 <1406137961-14684-5-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1406137961-14684-5-git-send-email-l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Lucas Stach [mailto:l.stach@pengutronix.de]
> Sent: Thursday, July 24, 2014 1:53 AM
> To: Bjorn Helgaas
> Cc: linux-pci@vger.kernel.org; Zhu Richard-R65037; Mohit Kumar; Jingoo Han;
> Marek Vasut; Kishon Vijay Abraham I; kernel@pengutronix.de
> Subject: [PATCH 4/4] PCI: imx6: move to module_init
> 
> This effectively reverts f216f57ffe6eede3c8a763add65d331e688f8c56
> "PCI: imx6: Probe the PCIe in fs_initcall()" as the ressource allocation issue
> that prevented the driver from working properly at module_initcall level is
> now fixed in pcie-designware.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/host/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c index
> a568efaa331c..0fc2ba8ea006 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -609,7 +609,7 @@ static int __init imx6_pcie_init(void)  {
>  	return platform_driver_probe(&imx6_pcie_driver, imx6_pcie_probe);  } -
> fs_initcall(imx6_pcie_init);
> +module_init(imx6_pcie_init);
> 
Acked-by: Richard Zhu <r65037@freescale.com>

Best Regards
Richard Zhu
>  MODULE_AUTHOR("Sean Cross <xobs@kosagi.com>");  MODULE_DESCRIPTION("Freescale
> i.MX6 PCIe host controller driver");
> --
> 2.0.1

