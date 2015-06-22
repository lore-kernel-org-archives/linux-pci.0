Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40569 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933473AbbFVNhZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2015 09:37:25 -0400
Message-ID: <1434980241.3014.16.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: imx6: Fix "BUG: scheduling while atomic" if PCIe
 switch is attached
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: David =?ISO-8859-1?Q?M=FCller?= <dave.mueller@gmx.ch>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Date: Mon, 22 Jun 2015 15:37:21 +0200
In-Reply-To: <CAOMZO5BLQXKwVjykQVVmD1kHHm=M31RJPmgGa1Tznz8gpYwvyw@mail.gmail.com>
References: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
	 <1434616021.3061.2.camel@pengutronix.de>
	 <CAOMZO5BLQXKwVjykQVVmD1kHHm=M31RJPmgGa1Tznz8gpYwvyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 22.06.2015, 10:30 -0300 schrieb Fabio Estevam:
> On Thu, Jun 18, 2015 at 5:27 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> 
> >> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> >> index fdb9536..c63691c 100644
> >> --- a/drivers/pci/host/pci-imx6.c
> >> +++ b/drivers/pci/host/pci-imx6.c
> >> @@ -489,7 +489,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
> >>                * Wait a little bit, then re-check if the link finished
> >>                * the training.
> >>                */
> >> -             usleep_range(1000, 2000);
> >> +             mdelay(20);
> >
> > While switching to mdelay might be the right thing to do here, you are
> > also changing the timeout. This is a change in behavior and so not okay.
> 
> msleep(2) is not recommended according to Documentation/timers/timers-howto.txt.
> 
> What would be the proper fix then?
> 
mdelay(2) is completely reasonable. Note the difference between delay
and sleep.

The mid-term correct solution would be to move all the link-up handling
out of the atomic path.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
