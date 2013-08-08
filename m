Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:36922 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933948Ab3HHIXD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2013 04:23:03 -0400
Date: Thu, 8 Aug 2013 10:22:55 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv7 07/13] irqdomain: add function to find a MSI
 irq_domain
Message-ID: <20130808102255.05fd79d8@skate>
In-Reply-To: <1375915536.12551.9.camel@pasglop>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1375867954-2320-8-git-send-email-thomas.petazzoni@free-electrons.com>
	<1375908620.9300.3.camel@pasglop>
	<20130808000443.17f57875@skate>
	<1375914665.12551.5.camel@pasglop>
	<1375915344.12551.6.camel@pasglop>
	<1375915536.12551.9.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Benjamin Herrenschmidt,

On Thu, 08 Aug 2013 08:45:36 +1000, Benjamin Herrenschmidt wrote:

> > >  - You don't need my ack since I am not the maintainer of the irqdomain
> > > code anymore, Grant is :-)
> > 
> > Hrm, I'm being told Grant isn't anymore... I can step in and take it all
> > back but you might not like the result ....
> 
> Oh but it looks like MAINTAINERS says I am :-)
> 
> Ok so from that perspective, I don't like it at all. You can try to
> convince me otherwise but I don't think we need to introduce a
> dependency to something like msi into the core remapper. It's already to
> complex.
> 
> Why don't you move the powerpc bitmap allocator over to a generic
> place ? I feel like it would be actually simpler but feel free to prove
> me wrong.

I'm sorry, but I'm not buying this. There must be some continuity when
the maintenance of one subsystem transitions from one maintainer to
another. I'm perfectly ok with accepting some hick-ups, but not radical
changes in design decisions.

What you're asking me to do is to go completely backwards compared to
the comments and review Grant made. The irqdomain-based allocator was
suggested by Grant (see my previous e-mail, or Grant reply at
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175430.html)
and was even Acked-by Grant in
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/187082.html.

Note that this patch set has been posted at the following dates:

 * PATCH version 7 sent on August, 7th 2013
 * PATCH version 6 sent on August, 1st 2013
 * PATCH version 5 sent on July, 15th 2013
 * PATCH version 4 sent on July, 1st 2013
 * PATCH version 3 sent on June, 19th 2013
 * PATCH version 2 sent on June, 6th 2013
 * RFC version 1 sent on March, 26th 2013

So it has been around since 4 months, I've taken into account all the
comments from the various maintainers who were involved, and especially
the comments from Grant. You cannot ask me now, as we are approaching
the next merge window for which this code is intended, to take
completely opposite design choices than what the previous irqdomain
maintainer was suggesting.

Could you contact Grant and align with him on those design decisions?
It would also be good if you could read the past discussions on this
patch set, because all what you're pointing at has already been
discussed at length, as I pointed out in my previous e-mail.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
