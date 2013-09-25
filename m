Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:58709 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489Ab3IYQFu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2013 12:05:50 -0400
MIME-Version: 1.0
In-Reply-To: <1379319655-20210-4-git-send-email-xobs@kosagi.com>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
	<1379319655-20210-4-git-send-email-xobs@kosagi.com>
Date: Wed, 25 Sep 2013 11:05:49 -0500
Message-ID: <CAHrpEqQXUUtfB3BCmZsq1+YUk4kgzAyVuFHwQT2S0GL01PJjHg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
From: Frank Li <lznuaa@gmail.com>
To: Sean Cross <xobs@kosagi.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Zhu Richard-R65037 <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, bhelgaas@google.com,
	Shawn Guo <shawn.guo@linaro.org>, tharvey@gateworks.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 16, 2013 at 3:20 AM, Sean Cross <xobs@kosagi.com> wrote:
> Add support for the PCIe port present on the i.MX6 family of controllers.
> These use the Synopsis Designware core tied to their own PHY.
>
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

What is the status of this patch, is it queued in next or need future change ?

Best regards
Frank Li
