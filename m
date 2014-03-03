Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:54901
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751990AbaCCGTR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Mar 2014 01:19:17 -0500
Date: Mon, 3 Mar 2014 13:22:21 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Lucas Stach <l.stach@pengutronix.de>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, Richard Zhu <r65037@freescale.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] ARM: dts: imx6: extend PCIe interrupt list for MSI
Message-ID: <20140303052216.GC9706@shlinux1.ap.freescale.net>
References: <1393608633-18321-1-git-send-email-l.stach@pengutronix.de>
 <1393608633-18321-2-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1393608633-18321-2-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 28, 2014 at 06:30:31PM +0100, Lucas Stach wrote:
> Optional IRQ necessary for handling MSI.
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 9 ++++++++-

Please have this change go with driver or a separate patch, not with
dts update.

Shawn

>  arch/arm/boot/dts/imx6qdl.dtsi                           | 4 +++-
>  2 files changed, 11 insertions(+), 2 deletions(-)

