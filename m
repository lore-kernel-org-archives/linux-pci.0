Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697311;
	b=XB4V+Po99+OuMeCJpZsolI2kG1PLPNc0nvWbkZJ+CGklmKMYcK+L1z8aFPqAqOxtVNff
	 xy5yw91qaWEc6q7ZtW7mVlJtzvkauv97SGkboZSdwcD+8KLPHsyYFhUpAsWP2XDS3VXu4
	 K0otXeOgoIop3s30xjC5+F9uDEnhag2AtYxLltrqLDjhGSSZ77iHqFWclurjLHr4ouXkk
	 XZgB9oHsLqMo5GFyDd2vrUu1zuDnyeaH5Kxq1NyNOqJ2CdssV2B84OK3gGa7Nx2oxJ0Qf
	 Q+rFvfXIgwxjxrhhqAsD3s3tzJ5wwUGWAPxmYfZUlikY3x1DqFz9NZPSPpUfmb7Iw0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697311;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=MzbjIiGq5wiJfmZJ63aC+LL2BZBa5CdrmsF8cqDfJW4=;
	b=PcmUub2XtpjpdrF83Ko3ZsC081XSIVsb/CgikxKhWmcszHmqpuGu06/OxWFtWXQGPlFr
	 34oxnFAotXuTo79+Cmj0qb1T1ZVJ6YTpbE9CyElNMze5l+QJ2az2fzP5PiMWgr9Rt0FDS
	 HEtt24IAdi2Hq77lsPtDSI0oKY0gqSNiMo2fqX7AMJBk0aQinleKwl7zgWh/DPYVoD7fc
	 T9/FAweLxcR5XLJ0fKkzA3oUMxiGPcKtiq0zbVdEVclmL1Y0eWEyRm910F5pd1crdFwpU
	 LWzYOsAchtgywch0GLD0/MxLCfXBf64Krv1OgYO9ZslQOHh56+IVsA1pTYGSUrd/+Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF882606A31F;
	Thu, 22 Oct 2026 19:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF882606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 65FAB9200B3; Thu, 22 Oct 2026 21:28:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 5F8E692009E;
	Thu, 22 Oct 2026 20:28:25 +0100 (BST)
Date: Thu, 22 Oct 2026 20:28:25 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jakub Kicinski <kuba@kernel.org>
cc: Imre Kaloz <kaloz@kernel.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Lee Jones <lee@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, mfd@lists.linux.dev, 
    linux-serial@vger.kernel.org, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    linux-rtc@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    netdev@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
    Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
    Pavel Machek <pavel@kernel.org>, linux-leds@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/53] MIPS: SGI-IP27: add support for the IP35 (Bedrock
 hub) machines
In-Reply-To: <20261021073921.07632a37@kernel.org>
Message-ID: <alpine.DEB.2.21.2610222009000.22065@angie.orcam.me.uk>
References: <cover.1791890466.git.kaloz@kernel.org> <20261020110619.12774a1c@kernel.org> <20261020204214.28625-1-kaloz@kernel.org> <20261020145611.4e277615@kernel.org> <20261021090556.21168-1-kaloz@kernel.org> <20261021073921.07632a37@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 21 Oct 2026, Jakub Kicinski wrote:

> > The users are the people running these machines, the same population
> > as for IP27 and IP30, and the ioc3-eth driver in net/ exists for them
> > today. The series was developed and tested on a Fuel and a Tezro in
> > regular use, so "nobody is using it with Linux" is true only in the
> > sense that the support isn't merged yet; that was equally true of IP30
> > when it went in for 5.5, and of every port before it.
> 
> Not sure if you followed the discussions at the recent maintainer
> summit but we are now allowed to be more opinionated about code
> we merge. Merging code just to test that code seems like entertainment
> for the authors, not useful development.

 I thought the event was by invitation only.

 Anyway, this seems to me like discouraging enthusiasts who do their work 
outside their day job from making contributions.  Their natural target are 
commercially worthless systems, since working for free on commercially 
valuable systems would be taking away someone's bread and I think grossly 
undeserved support for corporations.  Taking this stance effectively would 
be cutting Linux off from its origins and making it a commercial project.

 Please let's not go down this route and only base the acceptance, or not, 
of submissions on quality merits.  Many of us took this route to Linux, by 
showing competence in public with work done for free, and some of us still 
enjoy such side project even if we do have a day job now that involves 
Linux development.  Let's not close this option to people.

  Maciej
