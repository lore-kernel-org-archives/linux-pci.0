Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:50170 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758902Ab3JOQef (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2013 12:34:35 -0400
From: Marek Vasut <marex@denx.de>
To: linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: imx6: Random fixes
Date: Tue, 15 Oct 2013 18:34:32 +0200
Cc: linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
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
References: <1381853200-5534-1-git-send-email-marex@denx.de>
In-Reply-To: <1381853200-5534-1-git-send-email-marex@denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310151834.33118.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

> Set of random fixes for the PCIe driver for i.MX6 . With these fixes, my
> setup with MX6Q -> PCIe bridge -> i210 ethernet adapter works as expected.
> 
> NOTE: I'm sure this will start some discussion. There are quite a few
> patches that are more of a hacks. Shawn, I didn't ignore your remark about
> the clock patches, I will test it ASAP, I just want to have these fixes in
> the public so others can comment/test.

0002 and 0003 are NOT needed on my setup, Shawn. You were right, so please 
ignore these two.

Best regards,
Marek Vasut
