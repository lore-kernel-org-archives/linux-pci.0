Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34207 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729AbcCCBlZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2016 20:41:25 -0500
Received: by mail-wm0-f67.google.com with SMTP id p65so1655763wmp.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Mar 2016 17:41:25 -0800 (PST)
Message-ID: <1456969281.2246.0.camel@googlemail.com>
Subject: Re: [PATCH v3 0/2] Add PCIe driver support for imx6sx
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Date: Thu, 03 Mar 2016 02:41:21 +0100
In-Reply-To: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

*ping*

On Thu, 2016-02-25 at 15:47 +0100, Christoph Fritz wrote:
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



