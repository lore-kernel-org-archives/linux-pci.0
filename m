Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41075 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbbHEKkr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Aug 2015 06:40:47 -0400
Date: Wed, 5 Aug 2015 03:40:43 -0700
From: Tony Lindgren <tony@atomide.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: bhelgaas@google.com, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	bcousson@baylibre.com, linux@arm.linux.org.uk, nsekhar@ti.com
Subject: Re: [PATCH 2/2] ARM: dts: am57xx-evm: Add 'gpios' property with
 gpio2_8
Message-ID: <20150805104043.GD16878@atomide.com>
References: <1438090750-11604-1-git-send-email-kishon@ti.com>
 <1438090750-11604-3-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438090750-11604-3-git-send-email-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Kishon Vijay Abraham I <kishon@ti.com> [150728 06:42]:
> gpio2_8 is connected to the PCIe_RESETn line and it has to be driven low
> in order to reset the PCIe cards. So added gpios property to pcie
> dt node.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

This should not conflict with the device tree changes I'm queuing
for v4.3 merge window, so please feel free to queue with the PCIe
driver changes:

Acked-by: Tony Lindgren <tony@atomide.com>
