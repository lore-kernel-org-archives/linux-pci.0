Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37979 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbcC1A0g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2016 20:26:36 -0400
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
	<CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
Date: Sun, 27 Mar 2016 21:26:35 -0300
Message-ID: <CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
From: Fabio Estevam <festevam@gmail.com>
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 27, 2016 at 11:44 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Good catch!
>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>
> I will fix imx6q-sabresd.dtsi when this patch gets applied.

After thinking more about it, I think the correct fix is to revert
5c5fb40de8f143 ("PCI: imx6: Add support for active-low reset GPIO") so
that we do not break old dtb's.

Then a new dt property can be added if someone needs gpio active high PCI reset.
