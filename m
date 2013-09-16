Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:31104
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755470Ab3IPJBj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2013 05:01:39 -0400
Date: Mon, 16 Sep 2013 17:01:48 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Sean Cross <xobs@kosagi.com>
CC: <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Zhu Richard-R65037 <r65037@freescale.com>
Subject: Re: [PATCH v4 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
Message-ID: <20130916090146.GL31147@S2101-09.ap.freescale.net>
References: <1379065222-7275-1-git-send-email-xobs@kosagi.com>
 <1379065222-7275-4-git-send-email-xobs@kosagi.com>
 <20130916060631.GF31147@S2101-09.ap.freescale.net>
 <5236AB28.5060708@kosagi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <5236AB28.5060708@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 16, 2013 at 02:54:32PM +0800, Sean Cross wrote:
> >>@@ -116,6 +116,22 @@
> >>  			arm,data-latency = <4 2 3>;
> >>  		};
> >>+		pcie: pcie@0x01000000 {
> >>+			compatible = "fsl,imx6-pcie", "snps,dw-pcie";
> >We generally use particular SoC name to specify the compatible string.
> >So "fsl,imx6q-pcie" will be more appropriate.
> Any reason to specify imx6q in particular?  It's also present on the
> imx6d, imx6dl, and imx6s (basically, everything but the imx6sl).

The compatible naming is not about coverage but versioning.  We
generally encode the name of the SoC that firstly integrates the block
to specify the version.

Shawn

