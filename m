Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51234 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933833Ab3HHImC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 8 Aug 2013 04:42:02 -0400
Message-ID: <1375951274.12551.31.camel@pasglop>
Subject: Re: [PATCHv7 07/13] irqdomain: add function to find a MSI irq_domain
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
	Thierry Reding <thierry.reding@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 08 Aug 2013 18:41:14 +1000
In-Reply-To: <20130808102255.05fd79d8@skate>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1375867954-2320-8-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1375908620.9300.3.camel@pasglop> <20130808000443.17f57875@skate>
	 <1375914665.12551.5.camel@pasglop> <1375915344.12551.6.camel@pasglop>
	 <1375915536.12551.9.camel@pasglop> <20130808102255.05fd79d8@skate>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-08-08 at 10:22 +0200, Thomas Petazzoni wrote:
> Dear Benjamin Herrenschmidt,

> I'm sorry, but I'm not buying this. There must be some continuity when
> the maintenance of one subsystem transitions from one maintainer to
> another. I'm perfectly ok with accepting some hick-ups, but not radical
> changes in design decisions.

Well, I wrote it in the first place :-)

> What you're asking me to do is to go completely backwards compared to
> the comments and review Grant made. The irqdomain-based allocator was
> suggested by Grant (see my previous e-mail, or Grant reply at
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175430.html)
> and was even Acked-by Grant in
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/187082.html.
> 
> Note that this patch set has been posted at the following dates:
> 
>  * PATCH version 7 sent on August, 7th 2013
>  * PATCH version 6 sent on August, 1st 2013
>  * PATCH version 5 sent on July, 15th 2013
>  * PATCH version 4 sent on July, 1st 2013
>  * PATCH version 3 sent on June, 19th 2013
>  * PATCH version 2 sent on June, 6th 2013
>  * RFC version 1 sent on March, 26th 2013

I'm really sorry and I feel your pain. I have not actively been
monitoring any of that stuff, and you might have gotten away without
CC'ing me or asking for my point of view but you did (and I thank you
for that), and sadly this is my opinion.

> So it has been around since 4 months, I've taken into account all the
> comments from the various maintainers who were involved, and especially
> the comments from Grant. You cannot ask me now, as we are approaching
> the next merge window for which this code is intended, to take
> completely opposite design choices than what the previous irqdomain
> maintainer was suggesting.

I can and I do. However, I also leave the opportunity of bringing in a
third party into the debate with a well known track record to overrule
me if he thinks I'm being unnecessarily obstructive.

> Could you contact Grant and align with him on those design decisions?
> It would also be good if you could read the past discussions on this
> patch set, because all what you're pointing at has already been
> discussed at length, as I pointed out in my previous e-mail.

I can try... Grant, are you around ? (I've added you to the CC list), we
might be able to catch up on IRC and discuss it ...

Cheers,
Ben.


> Thanks,
> 
> Thomas


