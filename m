Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:53642 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbaGUCzp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Jul 2014 22:55:45 -0400
Received: by mail-lb0-f173.google.com with SMTP id p9so1159675lbv.32
        for <linux-pci@vger.kernel.org>; Sun, 20 Jul 2014 19:55:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140721025034.GH8537@dragon>
References: <1403772229.4254.4.camel@weser.hi.pengutronix.de>
	<20140628143712.GA7869@dragon>
	<1404135864.4305.23.camel@weser.hi.pengutronix.de>
	<20140701065105.GE14471@dragon>
	<1404724251.4587.20.camel@weser.hi.pengutronix.de>
	<20140707135502.GR30239@dragon>
	<20140716065505.GB2612@dragon>
	<1405605306.12800.7.camel@weser.hi.pengutronix.de>
	<247043c4c45c41bf9eaa09aaf91bcc46@DM2PR0301MB0862.namprd03.prod.outlook.com>
	<1405675308.6072.6.camel@weser.hi.pengutronix.de>
	<20140721025034.GH8537@dragon>
Date: Sun, 20 Jul 2014 23:55:42 -0300
Message-ID: <CAOMZO5DS2NR57kzrjzMBSh8urxSB84Y0TPSJCaGjf7q3cPZPmg@mail.gmail.com>
Subject: Re: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
From: Fabio Estevam <festevam@gmail.com>
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	"Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 20, 2014 at 11:50 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Fri, Jul 18, 2014 at 11:21:48AM +0200, Lucas Stach wrote:
>> However I seem to have a board with rev 1.1 silicon and although the pci
>> driver starts up it never establishes a link. So my board may just work
>> by chance as I don't really know the differences between rev 1.1 silicon
>> and later revisions.
>
> Lucas, thanks for the info.
>
> I just checked my board on which the issue is seen, and found it has a
> rev 1.3 silicon.  I just tested on a board with rev 1.2 and did not even
> see the issue.
>
> Richard,
>
> Is this an issue only with rev 1.3?

I could see this issue on my board with rev 1.2.
