Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:57550 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbaLMTsB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 13 Dec 2014 14:48:01 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Arend van Spriel <arend@broadcom.com>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Scott Branden <sbranden@broadcom.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Ray Jui <rjui@broadcom.com>,
	Christian Daudt <bcm@fixthebug.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Matt Porter <mporter@linaro.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 1/4] pci: iProc: define Broadcom iProc PCIe binding
Date: Sat, 13 Dec 2014 20:46:42 +0100
Message-ID: <3383252.Ad6Qf0H2fa@wuerfel>
In-Reply-To: <548C0F80.2090300@broadcom.com>
References: <1418351817-14898-2-git-send-email-rjui@broadcom.com> <3907917.zNo7yttzkh@wuerfel> <548C0F80.2090300@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday 13 December 2014 11:05:52 Arend van Spriel wrote:
> 
> Makes sense. I think that is what Hauke meant by "adding
> additional support for registering to bcma". So the discovery info is a 
> piece of read-only memory in the chip. Its address is stored in the 
> chipcommon core register space. BCMA parses that memory blob resulting 
> in a list of cores which register address info. We could add DT support 
> in BCMA matching the compatible string and register a core for it.

Ah, interesting idea. That would mirror what we do for drivers/amba,
I like the idea.

> However, apart from the discovery info a "discoverable ARM AXI" chip has 
> a register space per core that provides common procedures like 
> enable/disable, reset, core status, which are implemented in BCMA. I am 
> not seeing that register space in the DT examples so I guess this IP 
> block is not there for iProc chips.

I wouldn't draw conclusions from the absence of some node. Maybe these
registers are present but just not used by the original BSP.

	Arnd
