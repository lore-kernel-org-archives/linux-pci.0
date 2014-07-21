Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2lp0235.outbound.protection.outlook.com ([207.46.163.235]:13449
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752490AbaGUCu6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 20 Jul 2014 22:50:58 -0400
Date: Mon, 21 Jul 2014 10:50:38 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Lucas Stach <l.stach@pengutronix.de>
CC: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
Message-ID: <20140721025034.GH8537@dragon>
References: <1403772229.4254.4.camel@weser.hi.pengutronix.de>
 <20140628143712.GA7869@dragon>
 <1404135864.4305.23.camel@weser.hi.pengutronix.de>
 <20140701065105.GE14471@dragon>
 <1404724251.4587.20.camel@weser.hi.pengutronix.de>
 <20140707135502.GR30239@dragon> <20140716065505.GB2612@dragon>
 <1405605306.12800.7.camel@weser.hi.pengutronix.de>
 <247043c4c45c41bf9eaa09aaf91bcc46@DM2PR0301MB0862.namprd03.prod.outlook.com>
 <1405675308.6072.6.camel@weser.hi.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1405675308.6072.6.camel@weser.hi.pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 18, 2014 at 11:21:48AM +0200, Lucas Stach wrote:
> However I seem to have a board with rev 1.1 silicon and although the pci
> driver starts up it never establishes a link. So my board may just work
> by chance as I don't really know the differences between rev 1.1 silicon
> and later revisions.

Lucas, thanks for the info.

I just checked my board on which the issue is seen, and found it has a
rev 1.3 silicon.  I just tested on a board with rev 1.2 and did not even
see the issue.

Richard,

Is this an issue only with rev 1.3?

Shawn
