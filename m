Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:36313 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933473AbbFVNqB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2015 09:46:01 -0400
Received: by lacny3 with SMTP id ny3so110047046lac.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2015 06:46:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434980241.3014.16.camel@pengutronix.de>
References: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
	<1434616021.3061.2.camel@pengutronix.de>
	<CAOMZO5BLQXKwVjykQVVmD1kHHm=M31RJPmgGa1Tznz8gpYwvyw@mail.gmail.com>
	<1434980241.3014.16.camel@pengutronix.de>
Date: Mon, 22 Jun 2015 10:46:00 -0300
Message-ID: <CAOMZO5DRQBZKXA3NZMGEEms6Na9=Z_N9ta6YFNU0zbJZu7Od1Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx6: Fix "BUG: scheduling while atomic" if PCIe
 switch is attached
From: Fabio Estevam <festevam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: =?UTF-8?Q?David_M=C3=BCller?= <dave.mueller@gmx.ch>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 22, 2015 at 10:37 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> mdelay(2) is completely reasonable. Note the difference between delay
> and sleep.

Oh, that's right :-)

Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
