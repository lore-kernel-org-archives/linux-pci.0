Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:47041
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751256Ab3IPGOA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2013 02:14:00 -0400
Date: Mon, 16 Sep 2013 14:14:45 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Sean Cross <xobs@kosagi.com>
CC: <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Zhu Richard-R65037 <r65037@freescale.com>,
	<tharvey@gateworks.com>, <bhelgaas@google.com>
Subject: Re: [PATCH v5 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
Message-ID: <20130916061444.GG31147@S2101-09.ap.freescale.net>
References: <1379310497-12362-1-git-send-email-xobs@kosagi.com>
 <1379310497-12362-4-git-send-email-xobs@kosagi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1379310497-12362-4-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 16, 2013 at 05:48:17AM +0000, Sean Cross wrote:
> Add support for the PCIe port present on the i.MX6 family of controllers.
> These use the Synopsis Designware core tied to their own PHY.
> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>

Bjorn gave his ACK with asking us to apply the patch via arm-soc tree.
You should add his ACK into your patch.

Shawn

