Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33418 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbcC1VaR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2016 17:30:17 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
	<CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
	<CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
	<CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
	<CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
	<CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
Date: Mon, 28 Mar 2016 18:30:16 -0300
Message-ID: <CAOMZO5A2osG3=mTaCayYfMokUj-vT+Udq9ckq45b1yaUP9Tn3g@mail.gmail.com>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
From: Fabio Estevam <festevam@gmail.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
	Lucas Stach <l.stach@pengutronix.de>,
	=?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 28, 2016 at 5:42 PM, Tim Harvey <tharvey@gateworks.com> wrote:

> Fabio,
>
> ok - I'll respond there as I agree with the patch but not the wording
> of the commit (It's Gateworks 'Ventana' using IMX6 not Laguna and we
> do define the polarity properly as active-low in Ventana dt's). It is
> the fact that the gpio polarity has the wrong logic level that breaks
> Ventana.

Ok, I will change the wording in v2.

>
> However, there seems to be another regression in 4.5 that's keeping
> PCI working for me and I'm still bisecting that (using 802.11n access
> points to test). Can you confirm that PCI works in v4.5 on IMX6 boards
> with only 5c5fb40de8f14391a1238db05cef88754faf9229 reverted?

On imx6qdl-sabresd.dtsi the PCI reset gpio polarity is set to high,
which is not correct, so the Wifi card could be detected even with
5c5fb40de8f. So two errors in sequence and PCI still works on this
board :-)

I don't have access to the board at the moment, but the only test I
did was to see that the Wifi card got detected. I haven't really tried
to communicate via Wifi.
