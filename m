Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:48414 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758561AbaDXR6s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Apr 2014 13:58:48 -0400
Received: by mail-pa0-f43.google.com with SMTP id rd3so334914pab.30
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2014 10:58:47 -0700 (PDT)
Date: Thu, 24 Apr 2014 11:58:44 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Sean Cross <xobs@kosagi.com>, Marek Vasut <marex@denx.de>,
	Richard Zhu <r65037@freescale.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tim Harvey <tharvey@gateworks.com>, kernel@pengutronix.de
Subject: Re: [PATCH 0/8] i.MX6 PCIe binding change and MSI support
Message-ID: <20140424175844.GD29593@google.com>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 28, 2014 at 05:52:51PM +0100, Lucas Stach wrote:
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
> 
> Lucas Stach (8):
>   ARM: imx6q-clk: parent lvds_gate from lvds_sel
>   PCI: designware: split Exynos and i.MX bindings
>   ARM: dts: imx6: update pcie to bring in line with new binding
>   PCI: imx6: use new clock names
>   PCI: imx6: drop old irq mapping
>   PCI: imx6: rip out optional (and unused) irqs
>   PCI: designware: make MSI isr shared irq aware
>   PCI: imx6: add support for MSI

What's the status of all these?  I would normally apply patches 4-8 of this
series through my tree, given the appropriate acks, but I haven't seen
those yet.  And I'm not sure what dependencies there are between the
non-PCI patches and the PCI ones.

Bjorn
