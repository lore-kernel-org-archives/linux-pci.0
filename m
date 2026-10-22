Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792704882;
	b=cxM/5JZsX6z83QX2c5OpyeChXhmB+2a624Z1esMbieMavBArElWpS0JnuqWjh3kYf8xo
	 Yw2YI/PvZGKwf1UwGE5h96OCVSHjTZyrXSBY6pqlwrLq+Pq1WuLwvZJTuW3ReNaQUrKmk
	 vEnXnxv7Nn/0T1s/3diCMPqtWDYNHh/VlG4Uia9lbAmSgGaOFPQFITa9hwlWsUkHP0FJu
	 HJ5NFsEKTRiFulDx06wFIJrbhSNR0ueqBMJsofgNZxC/7YWoJJz981OeBK+pifv/iZTi/
	 JCg+ZZTNiKGL4DhhU9zmmxc7cYFRq2AXm+2g+wIXxpQOChGqaoXKuygiVBeb9Q2UisA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792704882;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GjBPTcmaKEEJEyfOSXTyPmKK18HcbgboEZUzZg44Hg4=;
	b=q4JiRiqqUdirS6v7hvo34X7/GGkYdCfv4MvRjPLOIa/+o7M84n+J1ULQt4Rjoixd9SZP
	 xZmOd8Wj8SUVJcfdel1ktoBi3/YeIF4AsOKhX7YFSRW/PgBnjpHMJCsNnR7Ba5os7o1x6
	 iVxloKeCYizf7XCbKg7spK6FxdLhU7YQar8Z7gn97TJyhE/ncEoJjq8n4J/FBSewEz04o
	 M1t4PaQsLH0wXA7mAmUr8ufPgrPUIRdHK9I5+H3xL+MaJySGlOvQRnXQ9siep6ySyLd3k
	 EoZ+5mZJqaMA19/rU74Qd/owgAENb1sMWtvhBg/SuS/coVcp0vy464r2PNO6Ks9DHLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVn28AAa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59404606A31D;
	Thu, 22 Oct 2026 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVn28AAa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204EA1F01825;
	Thu, 22 Oct 2026 21:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792704881;
	bh=GjBPTcmaKEEJEyfOSXTyPmKK18HcbgboEZUzZg44Hg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HVn28AAatOgqsu3YKKUkLti1PNCx8pyVlgmWUTbL6NGdUayDCSK/vvVc6yLay/EcO
	 TFP4oEmpcIWlMXx/Nt1ejfmRLu7avn7nTfbz0EUj/EIq/E8zFoKTafgAxuQQudya5E
	 TXX8TKt/t5O6f6Au6Af/xmyaRckAH1+SyZdu0NYEiPgBxF7LVvESxe9IObgJPkVH6S
	 KlMAuGC31OeFZdGqgXgSfoeBkScy31SZEw4ygC0GMrBLxfkCP1UI6Da8HM314rlaTT
	 XjJAPXnuSQaNwNnJd9ZoTj/wM7RJ0RLXzAP1zrT6NnRrMy2T9V557bJEzkNXyEf3RO
	 nPYBiVbmv1U/Q==
Date: Thu, 22 Oct 2026 14:34:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Imre Kaloz <kaloz@kernel.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, mfd@lists.linux.dev, linux-serial@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-rtc@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org, Pavel Machek <pavel@kernel.org>,
 linux-leds@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/53] MIPS: SGI-IP27: add support for the IP35
 (Bedrock hub) machines
Message-ID: <20261022143440.4ddae87e@kernel.org>
In-Reply-To: <alpine.DEB.2.21.2610222009000.22065@angie.orcam.me.uk>
References: <cover.1791890466.git.kaloz@kernel.org>
	<20261020110619.12774a1c@kernel.org>
	<20261020204214.28625-1-kaloz@kernel.org>
	<20261020145611.4e277615@kernel.org>
	<20261021090556.21168-1-kaloz@kernel.org>
	<20261021073921.07632a37@kernel.org>
	<alpine.DEB.2.21.2610222009000.22065@angie.orcam.me.uk>
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
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 20:28:25 +0100 (BST) Maciej W. Rozycki wrote:
> On Wed, 21 Oct 2026, Jakub Kicinski wrote:
> > > The users are the people running these machines, the same population
> > > as for IP27 and IP30, and the ioc3-eth driver in net/ exists for them
> > > today. The series was developed and tested on a Fuel and a Tezro in
> > > regular use, so "nobody is using it with Linux" is true only in the
> > > sense that the support isn't merged yet; that was equally true of IP30
> > > when it went in for 5.5, and of every port before it.  
> > 
> > Not sure if you followed the discussions at the recent maintainer
> > summit but we are now allowed to be more opinionated about code
> > we merge. Merging code just to test that code seems like entertainment
> > for the authors, not useful development.  
> 
>  I thought the event was by invitation only.

LWN posts a great summary.

>  Anyway, this seems to me like discouraging enthusiasts who do their work 
> outside their day job from making contributions.  Their natural target are 
> commercially worthless systems, since working for free on commercially 
> valuable systems would be taking away someone's bread and I think grossly 
> undeserved support for corporations.  Taking this stance effectively would 
> be cutting Linux off from its origins and making it a commercial project.

Or. Perhaps. By pushing this useless retro-hobbist hogwash you're
contributing to the burn out of genuine maintainers, pushing the
project into the hands of people who do have anterior motives.
Who is to say..

>  Please let's not go down this route and only base the acceptance, or not, 
> of submissions on quality merits.  Many of us took this route to Linux, by 
> showing competence in public with work done for free, and some of us still 
> enjoy such side project even if we do have a day job now that involves 
> Linux development.  Let's not close this option to people.

Who cares about quality of code nobody will run?
