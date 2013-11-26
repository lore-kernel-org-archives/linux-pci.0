Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:52292 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756421Ab3KZVZp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 16:25:45 -0500
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/7] PCI: imx6: Fix link start operation
Date: Tue, 26 Nov 2013 22:25:43 +0100
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Harro Haan <hrhaan@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
References: <1385500248-6551-1-git-send-email-marex@denx.de> <1385500248-6551-6-git-send-email-marex@denx.de>
In-Reply-To: <1385500248-6551-6-git-send-email-marex@denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201311262225.43711.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Marek Vasut,

> This patch first forces the link into Gen1 mode before starting up
> the link and only after the link is up requests the link to start
> negotiating possible Gen2 mode operation. This is because without
> such sequence, some PCIe switches are not detected at all.

[...]

> +	/* Make sure link training is finished as well! */
> +	if (count)
> +		ret = imx6_pcie_wait_for_link(pp);
> +	else
> +		ret = -EINVAL;
> 
> +	if (ret) {
> +		dev_err(pp->dev, "Failed to bring link up!\n");
> +	} else {
> +		tmp = readl(pp->dbi_base + 0x80);
> +		dev_err(pp->dev, "Link up, Gen=%i\n", (tmp >> 16) & 0xf);

Hm meh, this dev_err() shouldn't be here of course. But I'd be interested if you 
people now get stable Gen2 link up properly all the time. Please test. Thanks!

[...]
Best regards,
Marek Vasut
