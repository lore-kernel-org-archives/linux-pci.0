Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34342 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbcD2BqS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2016 21:46:18 -0400
MIME-Version: 1.0
In-Reply-To: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
References: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
Date: Thu, 28 Apr 2016 22:46:17 -0300
Message-ID: <CAOMZO5ArMbdSDrh+V4EpUS+HOdqJa94XLm+U0vQiwfrD7gVyuQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PCI: imx6: Use enum instead of bool for variant indicator
From: Fabio Estevam <festevam@gmail.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Gary Bisson <gary.bisson@boundarydevices.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 20, 2016 at 12:45 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Use enumerated type instead of a boolean flag to specify the variant of
> the PCIe IP block (6Q, 6SX, etc). This patch has zero functional impact,
> however it makes the code easier to extend for the case of more than 2
> possible variants of an IP block (of which there are).
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
