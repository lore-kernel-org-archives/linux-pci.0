Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:56760 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab3JWFFB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Oct 2013 01:05:01 -0400
From: Marek Vasut <marex@denx.de>
To: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
Date: Wed, 23 Oct 2013 07:04:58 +0200
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com>
In-Reply-To: <1382504143-27915-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310230704.58605.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Tim Harvey,

> The IMX6 iATU is used for address translation between the AXI bus
> address space and PCI address space.  This is used for type0 and type1
> config cycles but is not necessary for outbound io/mem regions.
> 
> This patch removes the calls that inappropriately re-configures the ATU
> viewport for outbound memory and IO after config cycles and removes them
> altogether as they are not necessary.
> 
> This resolves issues with PCI devices behind switches and has been tested
> with a Gige device behind a PLX PEX860x switch.  More testing is needed
> for other configurations.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

This probably needs further fixes to the DT on exynos and omap. And it also 
needs testing on those platforms as this was developed on freescale mx6.

Best regards,
Marek Vasut
