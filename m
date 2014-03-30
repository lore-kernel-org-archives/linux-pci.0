Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:34159 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbaC3VCH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 30 Mar 2014 17:02:07 -0400
From: Marek Vasut <marex@denx.de>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 0/8] i.MX6 PCIe binding change and MSI support
Date: Sun, 30 Mar 2014 19:41:52 +0200
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Sean Cross <xobs@kosagi.com>,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tim Harvey <tharvey@gateworks.com>, kernel@pengutronix.de
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201403301941.52149.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, March 28, 2014 at 05:52:51 PM, Lucas Stach wrote:
> While working on MSI support for the i.MX6 PCIe host driver
> it has been discovered that the binding for this host controller
> is broken in many ways (refer to the patch descriptions for more
> info) and was introduced without proper discussion about what
> should/should not be in the binding.
> 
> This series fixes this and minimizes the difference of the
> i.MX6 binding to the common designware PCIe binding. I'm aware
> that this is a quite radical change, but I think it's justified
> to do this as long as there aren't many user of the old binding
> (most of the optional properties in the binding aren't even
> implemented).
> 
> Looking forward to your feedback.

Other but 2/8, which needs further discussion,

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
