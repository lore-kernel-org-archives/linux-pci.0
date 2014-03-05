Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:43163 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbaCEVzp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Mar 2014 16:55:45 -0500
Message-ID: <53179D5D.4070303@wwwdotorg.org>
Date: Wed, 05 Mar 2014 14:55:41 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>,
	Simon Horman <horms@verge.net.au>,
	Shawn Guo <shawn.guo@linaro.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/6] ARM: dts: tegra: add PCIe interrupt mapping properties
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de> <1394025951-32438-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1394025951-32438-2-git-send-email-l.stach@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/05/2014 06:25 AM, Lucas Stach wrote:
> Those are defined by the common PCI binding.

It sounds like there's no dependency between pathces 1/6 and 2/6, so I
should apply 1/6 to the Tegra tree, and Bjorn apply 2/6 to the PCI tree?
