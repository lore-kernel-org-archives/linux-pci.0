Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:65211 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbcFIMma (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2016 08:42:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Rockchip: Add Rockchip PCIe controller support
Date: Wed, 08 Jun 2016 22:06:21 +0200
Message-ID: <19495840.MdNPOj1Q7K@wuerfel>
In-Reply-To: <5757E397.40401@arm.com>
References: <1465373154-882-1-git-send-email-shawn.lin@rock-chips.com> <5757E397.40401@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, June 8, 2016 10:21:27 AM CEST Marc Zyngier wrote:
> > +     rockchip_pcie_enable_interrupts(port);
> > +     if (!IS_ENABLED(CONFIG_PCI_MSI)) {
> > +             err = rockchip_pcie_init_irq_domain(port);
> > +             if (err < 0)
> > +                     goto err_vpcie;
> 
> Why are you excluding wired interrupts if you have PCI_MSI configured?
> MSI allocation can fail, and wired interrupts become handy....

Also, a lot of drivers don't do MSI and rely on legacy interrupts.

	Arnd
