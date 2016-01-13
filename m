Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41955 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933270AbcAMSyM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2016 13:54:12 -0500
Message-ID: <1452711249.3694.71.camel@pengutronix.de>
Subject: Re: i.MX6 PCI GPR8 Settings
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>,
	Justin Waters <justin.waters@timesys.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Wed, 13 Jan 2016 19:54:09 +0100
In-Reply-To: <CAOMZO5AwpQdmcD2onLis-ZpktRjyAvfDKCxJa7QQGbY0QRo4LQ@mail.gmail.com>
References: <CAENNV6JHnwNWDi3ACRE+p3fvMzii+di-CRkH-wO4qwEa9nNN7g@mail.gmail.com>
	 <CAOMZO5AwpQdmcD2onLis-ZpktRjyAvfDKCxJa7QQGbY0QRo4LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 13.01.2016, 14:34 -0200 schrieb Fabio Estevam:
> On Wed, Jan 13, 2016 at 2:14 PM, Justin Waters
> <justin.waters@timesys.com> wrote:
> > Hello,
> >
> > I've been working with a custom board based on an i.MX6, and noticed
> > that the GPR8 settings for the PCIe pins are hard coded to specific
> > values. We would like to customize these values for our specific
> > hardware.
> >
> > While it's certainly possible to simply change the hard coding, it
> > strikes me that these should most likely be configurable via the
> > device tree. My initial thinking would be to create a number of
> > properties that would be defined in a dts file, e.g.
> > fsl,pci-deemph-gen1 = < 0>, but perhaps there's a better way to handle
> > this. I'm happy to put something together, but I'd like to know that
> > I'm on the right track. I'd appreciate any feedback.
> 
> Looks like a good idea.
> 
> Adding Lucas for his comments.

Thanks for looping me in Fabio.

Adding optional DT properties while keeping the current behavior as the
default sounds like the right thing to do. I'll happily review patches
once you got them.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

