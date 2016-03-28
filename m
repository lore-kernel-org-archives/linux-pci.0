Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34503 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbcC1Ume (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2016 16:42:34 -0400
Received: by mail-oi0-f48.google.com with SMTP id o62so73201078oig.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2016 13:42:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
	<CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
	<CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
	<CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
	<CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
Date: Mon, 28 Mar 2016 13:42:33 -0700
Message-ID: <CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>
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

On Mon, Mar 28, 2016 at 1:13 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Tim,
>
> On Mon, Mar 28, 2016 at 4:59 PM, Tim Harvey <tharvey@gateworks.com> wrote:
>
>> Fabio,
>>
>> I would agree with you on this - 5c5fb40de8f143 ("PCI: imx6: Add
>> support for active-low reset GPIO")  should be reverted.
>>
>> I just finished bisecting an issue to this specific patch only to find
>> out Krzysztof found it a few days ago ;) Thanks Krzysztof.
>
> I sent the revert patch yesterday:
> http://marc.info/?l=linux-pci&m=145912622805757&w=2

Fabio,

ok - I'll respond there as I agree with the patch but not the wording
of the commit (It's Gateworks 'Ventana' using IMX6 not Laguna and we
do define the polarity properly as active-low in Ventana dt's). It is
the fact that the gpio polarity has the wrong logic level that breaks
Ventana.

However, there seems to be another regression in 4.5 that's keeping
PCI working for me and I'm still bisecting that (using 802.11n access
points to test). Can you confirm that PCI works in v4.5 on IMX6 boards
with only 5c5fb40de8f14391a1238db05cef88754faf9229 reverted?

Tim
