Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35142 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbcD2BrR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2016 21:47:17 -0400
MIME-Version: 1.0
In-Reply-To: <1461167131-26025-2-git-send-email-andrew.smirnov@gmail.com>
References: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
	<1461167131-26025-2-git-send-email-andrew.smirnov@gmail.com>
Date: Thu, 28 Apr 2016 22:47:10 -0300
Message-ID: <CAOMZO5AiaNFashMd6XEz=zjyodm6UEAuBMsK=otQ5nHeE+voqw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PCI: imx6: Implement reset sequence for i.MX6+
From: Fabio Estevam <festevam@gmail.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Gary Bisson <gary.bisson@boundarydevices.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 20, 2016 at 12:45 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> I.MX6+ has a dedicated bit for reseting PCIe core, which should be used
> instead of a regular reset sequence since using the latter will hang the
> SoC.
>
> This commit is based on c34068d48273e24d392d9a49a38be807954420ed from
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
