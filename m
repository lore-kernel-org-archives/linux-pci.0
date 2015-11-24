Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48091 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975AbbKXN5P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2015 08:57:15 -0500
Message-ID: <1448373429.3689.34.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6:don't sleep in atomic context
From: Lucas Stach <l.stach@pengutronix.de>
To: "Sharma, Sanjeev" <Sanjeev_Sharma@mentor.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Richard.Zhu@freescale.com" <Richard.Zhu@freescale.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Mueller <dave.mueller@gmx.ch>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Date: Tue, 24 Nov 2015 14:57:09 +0100
In-Reply-To: <FDC088D3B5555644AE135ED28A7ABDE98636E07B@EU-MBX-02.mgc.mentorg.com>
References: <1447066080-5859-1-git-send-email-sanjeev_sharma@mentor.com>
	 <4800389.dqcmlJY3HC@wuerfel> <1447148110.3142.6.camel@pengutronix.de>
	 <6415545.xzR4A6SaUL@wuerfel>
	 <FDC088D3B5555644AE135ED28A7ABDE98636E07B@EU-MBX-02.mgc.mentorg.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 16.11.2015, 09:36 +0000 schrieb Sharma, Sanjeev:
> On Tuesday 10 November 2015 10:35:10 Lucas Stach wrote:
> > Am Dienstag, den 10.11.2015, 10:28 +0100 schrieb Arnd Bergmann:
> > > On Tuesday 10 November 2015 09:41:18 Lucas Stach wrote:
> > > > > diff --git a/drivers/pci/host/pci-imx6.c 
> > > > > b/drivers/pci/host/pci-imx6.c index 233a196..9769b13 100644
> > > > > --- a/drivers/pci/host/pci-imx6.c
> > > > > +++ b/drivers/pci/host/pci-imx6.c
> > > > > @@ -499,7 +499,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
> > > > >                * Wait a little bit, then re-check if the link finished
> > > > >                * the training.
> > > > >                */
> > > > > -             usleep_range(1000, 2000);
> > > > > +             mdelay(1000);
> > > > 
> > > > A mdelay(1000) is a whole different timescale than a usleep(1000). 
> > > > If this patch works for you with mdelay(1) or maybe mdelay(2) I 
> > > > would be fine with it.
> > > 
> > > mdelay(1) is still a really long time to block the CPU for, on 
> > > potentially every config space access.
> > > 
> > > Everybody else just returns the link status here, which seems to be 
> > > the better alternative. If you need to delay the startup, better 
> > > have a msleep(1) loop in the initial probe function where you are 
> > > allowed to sleep.
> > > 
> > Yes, it's somewhere on my TODO list to rework the link-up handling 
> > here, but as there are quite a few timing and ordering implications in 
> > that code, this needs a good thought and a good deal of testing. So 
> > I'm inclined to ACK the current patch to get rid of the obvious bug 
> > and sort things out properly in a follow on patchset.
> 
> Maybe use that patch with some modifications then:
> 
> * add a comment to explain that this is currently called from possibly
>   atomic context through pci_config_{read,write} and that the link
>   state handling never belonged here.
> 
> * instead of looping five times for up to 2ms each, loop 100 times
>   around a udelay(20) to hopefully be done earlier. I was going to
>   suggest using time_before(timeout, jiffies) as the condition to
>   wait for, but that doesn't work if called with interrupts disabled.
> 
> 	Arnd
> Shall I go ahead by changing only current patch to mdelay(1). I will also
> Incorporate comment  #1 given by Arnd above. 

Yes, please go ahead. Smaller delay loops make sense, but please ensure
that the total timeouts stay the same.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

