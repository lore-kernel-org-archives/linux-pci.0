Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593563;
	b=hpnHewK0kxbMtbFAtQJcC/uYKxSfNY5kIvfuo1NJUOUXSB9msRUKv9vb9gH3AxbKAmoB
	 UVZB00dRmGqHz5HesMTUhqQ3f1+hC4ldiNkk8K9QWfkbAWDfWzmM3jOaLML/W7lUgpThZ
	 HhMJnYVl98AsMM2qyVuP6w4VMMspDfGtsmf2pRnR9eK9KelSh27cQiSa6EIyW1zvUnU3n
	 dFMWiAyzI0d1FOb7vWfXdqdYvHgSCWi1wtctAohQB+hlK2mPCoe9KcT5vwnXS6nqrYsfC
	 e+rf47JsbpmvixXDiPK38nqVIjEemmCx72HIVIMhNlQdA563PgBVyH5OSZXXUoUW1ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593563;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2FZ6WSldowIQ5CGzRVSQzX5RHQEHuI8rIa0QlGDiTMI=;
	b=BlRimoVfquKEJg7yi+2AOC+Dsye2ghoCTNp115uXOvGJVJbwp6E23KbxHRqMl9YGUYWK
	 sGL4ok10X6xotDKSJAobktE27QJwF9JuuDLsO6s+ysICRUbt7cIS4Y0lIXMUuJA8iNjrs
	 vAQOY/5mWlHLZXCxoi2tzNEn0zJT4QgjDexfY07gG+j3iRgh87dubnVCQFrRtuLNV27uo
	 ryNHmpuseii7Gbn/sLjMN1TzYhbsz0xyfwjZAM5ixMdNX2v2AUAwJLo3coFCKZK61rIuz
	 LB2HlMF6IHoL2FbBb3frruC17nohPhu4QwnboKvIJu/mWnWlZMYqrVAw0fybODj+0KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJ4Tfzsb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03041606A31F;
	Wed, 21 Oct 2026 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJ4Tfzsb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53DA1F000C1;
	Wed, 21 Oct 2026 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792593562;
	bh=2FZ6WSldowIQ5CGzRVSQzX5RHQEHuI8rIa0QlGDiTMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UJ4TfzsbvdADPiJX+OB0+tvGgRkc1n8Cd4A+lMCi1apFYuz/IexXW/1dOy9xSi3YI
	 liX/1X1GNN+m22ia5nzltzu2Nq3VYIvZ7PKI6yRMzjKf0Dgx+uB5mIaPutT+y1aATw
	 Ra1CMqwgw0npxTCHYHSkxA2wVYL5qBEm0vpxYtgHJn59mWnvDQCHHKpIui2HdK/iuD
	 /B/fKZ7Jbsk1Aswcs1InTrdFePxLaci3TAIzju2T7oQGYoTbaV9R8lXTKDnMZywoRb
	 pS+hyP5bc0htYA29ZogtUZzcMj8GNwzQGneUNpKkRVYne4YM6dw99sUXkE7haOIyl3
	 8LvkUzy5nzrBg==
Date: Wed, 21 Oct 2026 07:39:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones
 <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri
 Slaby <jirislaby@kernel.org>, mfd@lists.linux.dev,
 linux-serial@vger.kernel.org, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel
 <cassel@kernel.org>, linux-ide@vger.kernel.org, Pavel Machek
 <pavel@kernel.org>, linux-leds@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org, Christoph Hellwig
 <hch@lst.de>
Subject: Re: [PATCH v2 00/53] MIPS: SGI-IP27: add support for the IP35
 (Bedrock hub) machines
Message-ID: <20261021073921.07632a37@kernel.org>
In-Reply-To: <20261021090556.21168-1-kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
	<20261020110619.12774a1c@kernel.org>
	<20261020204214.28625-1-kaloz@kernel.org>
	<20261020145611.4e277615@kernel.org>
	<20261021090556.21168-1-kaloz@kernel.org>
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

On Wed, 21 Oct 2026 11:05:55 +0200 Imre Kaloz wrote:
> On Tue, 20 Oct 2026 14:56:11 -0700 Jakub Kicinski wrote:
> > I don't think you answered my question, or at least I'm too daft 
> > to catch what you mean. IP35 was not supported so nobody is using
> > it with Linux today. You're adding the support, and since it's 
> > a platform discontinued 20 years ago there's 0 chance of real users 
> > of any of this code.
> > 
> > What am I missing?  
> 
> The users are the people running these machines, the same population
> as for IP27 and IP30, and the ioc3-eth driver in net/ exists for them
> today. The series was developed and tested on a Fuel and a Tezro in
> regular use, so "nobody is using it with Linux" is true only in the
> sense that the support isn't merged yet; that was equally true of IP30
> when it went in for 5.5, and of every port before it.

Not sure if you followed the discussions at the recent maintainer
summit but we are now allowed to be more opinionated about code
we merge. Merging code just to test that code seems like entertainment
for the authors, not useful development.

> The kernel's test for a platform isn't commercial relevance, it's a
> maintainer, which Thomas is, and testers, which this series has. If
> netdev doesn't want to spend time on it, say so and I'll ask Thomas to
> take the two ioc3-eth patches through the MIPS tree.

Not how subsystem boundaries work. You have to repost the two
networking patches to get them merged via net-next. Our CIs
will not trigger for partial posting to netdev.
