Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35324 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902AbcC2OOj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2016 10:14:39 -0400
MIME-Version: 1.0
In-Reply-To: <1459241739.2565.9.camel@pengutronix.de>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
	<CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
	<CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
	<CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
	<CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
	<CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
	<CAOMZO5A2osG3=mTaCayYfMokUj-vT+Udq9ckq45b1yaUP9Tn3g@mail.gmail.com>
	<CAJ+vNU2ST=XG5H04-OCwpHgcvkoXOQw8F3MjXhJmWhBUbxWE-g@mail.gmail.com>
	<1459241739.2565.9.camel@pengutronix.de>
Date: Tue, 29 Mar 2016 11:14:38 -0300
Message-ID: <CAOMZO5Cisx9xv9hCxzYK2U-MdVCdbVMYGY2y4PVoVReWjwE8=g@mail.gmail.com>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
From: Fabio Estevam <festevam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Tim Harvey <tharvey@gateworks.com>,
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
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

On Tue, Mar 29, 2016 at 5:55 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> I would suspect that most boards specify the reset polarity the wrong
> way around. Fixing this without breaking DT stability is hard. OTOH we

It is not hard if we just revert the buggy commit.

> could just argue that the system description in DT is wrong and needs to
> be fixed.

Sure, this would be a nice thing to do as well.
