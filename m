Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:52962 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbaCFRgz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Mar 2014 12:36:55 -0500
Message-ID: <5318B232.2020507@wwwdotorg.org>
Date: Thu, 06 Mar 2014 10:36:50 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Lucas Stach <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org
CC: linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Shawn Guo <shawn.guo@linaro.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when
 possible
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de> <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/05/2014 06:25 AM, Lucas Stach wrote:
> This is the recommended method of doing the IRQ
> mapping. For old devicetrees we fall back to the
> previous practice.

Tested-by: Stephen Warren <swarren@nvidia.com>

I tested both with and without patch 1/6, and the PCIe-based NIC on
Beaver worked fine either way. Without patch 1/6, I do see:

pci 0000:00:01.0: of_irq_parse_pci() failed with rc=-22

... but that seems reasonable given that the DT that of_irq_parse_pci()
parses is missing, and did correctly trigger the fallback path, so
everything still worked.
