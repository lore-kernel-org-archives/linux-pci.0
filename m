Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34700 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbcC1T7q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2016 15:59:46 -0400
Received: by mail-oi0-f53.google.com with SMTP id o62so71689644oig.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2016 12:59:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
	<CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
	<CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
Date: Mon, 28 Mar 2016 12:59:45 -0700
Message-ID: <CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
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

On Sun, Mar 27, 2016 at 5:26 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Sun, Mar 27, 2016 at 11:44 AM, Fabio Estevam <festevam@gmail.com> wrote:
>
>> Good catch!
>>
>> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> I will fix imx6q-sabresd.dtsi when this patch gets applied.
>
> After thinking more about it, I think the correct fix is to revert
> 5c5fb40de8f143 ("PCI: imx6: Add support for active-low reset GPIO") so
> that we do not break old dtb's.
>
> Then a new dt property can be added if someone needs gpio active high PCI reset.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Fabio,

I would agree with you on this - 5c5fb40de8f143 ("PCI: imx6: Add
support for active-low reset GPIO")  should be reverted.

I just finished bisecting an issue to this specific patch only to find
out Krzysztof found it a few days ago ;) Thanks Krzysztof.

Tim
