Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32844 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbaIVNcl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 09:32:41 -0400
Message-ID: <1411392758.2599.9.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] PCI: imx6: fix boot hang when link already enabled
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Shawn Guo <Shawn.Guo@freescale.com>
Date: Mon, 22 Sep 2014 15:32:38 +0200
In-Reply-To: <CAOMZO5AAZXVRu3WkKkU=5SM+t8CYBww+Jmqyz5UFYsdog479wA@mail.gmail.com>
References: <1406830565-23450-1-git-send-email-l.stach@pengutronix.de>
	 <1406830565-23450-3-git-send-email-l.stach@pengutronix.de>
	 <20140814202248.GA2071@google.com> <1409743007.1535.1.camel@pengutronix.de>
	 <20140904202436.GA17125@google.com>
	 <CAOMZO5AAZXVRu3WkKkU=5SM+t8CYBww+Jmqyz5UFYsdog479wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabio,

Am Montag, den 22.09.2014, 10:27 -0300 schrieb Fabio Estevam:
> Bjorn,
> 
> On Thu, Sep 4, 2014 at 5:24 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> 
> >> Bjorn,
> >>
> >> I would have expected for this to show up in 3.17 as it fixes a real bug
> >> and has been posted some time ago. While you have picked it up into your
> >> pci/host-imx6 branch it doesn't show up in Linus tree nor in any pull
> >> requests AFAICS.
> >> Was it intentional from you to hold this patch or is this just an
> >> oversight?
> >
> > Nope, I just missed it, thanks for the reminder.  I put in my
> > for-linus branch and will ask Linus to pull it after it's been
> > in -next for a few days.
> 
> We still don't see this patch applied in linux-next.

I see this commit in -next for some time now. It changed subject tho, so
look out for a patch called "PCI: imx6: Put LTSSM in "Detect" state
before disabling it".

Also Bjorn issued a pull request including this patch last Friday, so
things should go ok.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

