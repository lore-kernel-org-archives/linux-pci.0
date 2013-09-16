Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:42218 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3IPWxU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2013 18:53:20 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Shawn Guo' <shawn.guo@linaro.org>
Cc: 'Sean Cross' <xobs@kosagi.com>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	'Sascha Hauer' <s.hauer@pengutronix.de>,
	'Zhu Richard-R65037' <r65037@freescale.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1379065222-7275-1-git-send-email-xobs@kosagi.com>
 <1379065222-7275-4-git-send-email-xobs@kosagi.com>
 <20130916060631.GF31147@S2101-09.ap.freescale.net>
 <5236AB28.5060708@kosagi.com>
 <20130916090146.GL31147@S2101-09.ap.freescale.net>
In-reply-to: <20130916090146.GL31147@S2101-09.ap.freescale.net>
Subject: Re: [PATCH v4 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
Date: Tue, 17 Sep 2013 07:53:19 +0900
Message-id: <003901ceb32f$89941060$9cbc3120$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, September 16, 2013 6:02 PM, Shawn Guo wrote:
> On Mon, Sep 16, 2013 at 02:54:32PM +0800, Sean Cross wrote:
> > >>@@ -116,6 +116,22 @@
> > >>  			arm,data-latency = <4 2 3>;
> > >>  		};
> > >>+		pcie: pcie@0x01000000 {
> > >>+			compatible = "fsl,imx6-pcie", "snps,dw-pcie";
> > >We generally use particular SoC name to specify the compatible string.
> > >So "fsl,imx6q-pcie" will be more appropriate.
> > Any reason to specify imx6q in particular?  It's also present on the
> > imx6d, imx6dl, and imx6s (basically, everything but the imx6sl).
> 
> The compatible naming is not about coverage but versioning.  We
> generally encode the name of the SoC that firstly integrates the block
> to specify the version.
> 

Yes, you're right. :-)
The name of the first SoC would be used.

Best regards,
Jingoo Han

