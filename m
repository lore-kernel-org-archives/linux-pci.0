Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db3on0058.outbound.protection.outlook.com ([157.55.234.58]:42496
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755857AbcCCBsm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2016 20:48:42 -0500
From: Richard Zhu <hongxing.zhu@nxp.com>
To: Christoph Fritz <chf.fritz@googlemail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 0/2] Add PCIe driver support for imx6sx
Date: Thu, 3 Mar 2016 01:48:36 +0000
Message-ID: <DBXPR04MB27013C807F30DABB9CB667D8CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
In-Reply-To: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Christoph Fritz [mailto:chf.fritz@googlemail.com]
> Sent: Thursday, February 25, 2016 10:48 PM
> To: Richard Zhu; Lucas Stach; Shawn Guo; Fabio Estevam; Bjorn Helgaas; Lee
> Jones
> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH v3 0/2] Add PCIe driver support for imx6sx
> 
> v3:
>  * adapt devicetree bindings documentation fsl,imx6q-pcie.txt
> v2:
>  * leave out regulator handling from driver, will be done later
>    in PM subsystem
>  * use BIT() macro for MFD
> 
> Christoph Fritz (2):
>   MFD: imx6sx: Add PCIe register definitions for iomuxc gpr
>   PCI: imx6: add initial imx6sx support
> 
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
>  drivers/pci/host/pci-imx6.c                        | 130 ++++++++++++++-------
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   5 +
>  3 files changed, 101 insertions(+), 40 deletions(-)
> 
> --
> 2.1.4

[Zhu hongxing]  Acked-by: Richard Zhu <Richard.Zhu@freescale.com>
Richard
Best Regards
