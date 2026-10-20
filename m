Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533373;
	b=CDhK9dOLHAOAqUzeUOtSfOwE6joSiBofnE8gxrjCBbteeeJq/Giddszio4YQgJrvevsI
	 CuE0X+Ff/5AuzNZQYOWifJ4Pzl1go/tDJAqy9hEfI3GhatfnZnBZ3Hss/mU9m1A5Rrngo
	 4XbIwt+cHyXV64gaUPvDq4ZbwVtoH1CVRik+JgIuTrff3TR2jNF7ZbFWn28WlsXXVn6l9
	 YfDeUd4/yR3ocfhPB14RYwuy3OARYJtb/2tIsi4ArwGfjId+p0Q12Hz7BFYfte22qdbps
	 u4BrdjSgbCob3/tzsiQ9vH8lViFS6P6GWLb4XoJvMVlw6PrYLpSJnCtX/mmeZzlwJ9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533373;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RC3iU6EQa1/dBaJxMKqA5Cnd4YmN92OAMtq0Pq+n7O8=;
	b=jSKaiObb3NAmzBEa2MOm6ZpAuK5qMy8pxLOqGoXkXavSAO5wgOTVEs/PvX9y2m+tCEsW
	 5OT7DIknQaE7xqH7ZC0yaKH03dPBYOfMhYwehVnBj9H8nwAg0gcM3yP1hj0tWn/lkwmYl
	 +Qh8B0onsvg8ZBJT34oqT8lrn2M8ZoKPPAoLI0zjIMlxgztnT0GzhhgO2UWq5CMopv0HN
	 F+3kQs5PZD+tzR4cWDHG3fP3JMIUwf6kbYfQarCU4r2+8pX9CNXfL79M/8fuiy1kLUrFJ
	 JNqND/QiQeEkz9WhlCFPLzsXNleO62jGBrWRUYmzPUdWWxzas5YWZ66fRsPvivP8lig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DuUrn674;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4B606A319;
	Tue, 20 Oct 2026 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DuUrn674
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D229A1F000C9;
	Tue, 20 Oct 2026 21:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792533372;
	bh=RC3iU6EQa1/dBaJxMKqA5Cnd4YmN92OAMtq0Pq+n7O8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DuUrn674JMfXslg2ZVIwkEZJtPfpC7JU+qX2L2K8Oh2/xjnofe6PrmmX8ZxFxsTVl
	 CJOnJDtdnjIXlGFq9CBRrcq2ueUjWplnyH5AncNdRDpLNGHRWpzIGomydnzupqLOlw
	 FbTBqEUAveMFam6YnOpQTQ2/COE0/VT3wzF286C/7ye0i4M/CdCChU9ZLOk2i9EXSv
	 Q+lY65xyMmC5+k2HSifJ14S7zMp6VcSauQcNjY3AHqv32NC+zsFhfpkmQnPH+Ey97p
	 I/wIrP0EUbChYnjCb7+tAIweHRJRGK6ruc5DheKNK5rKsZGenGsEL9OuNluLdwEQoQ
	 W3xcV/fHxt1jA==
Date: Tue, 20 Oct 2026 14:56:11 -0700
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
Message-ID: <20261020145611.4e277615@kernel.org>
In-Reply-To: <20261020204214.28625-1-kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
	<20261020110619.12774a1c@kernel.org>
	<20261020204214.28625-1-kaloz@kernel.org>
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

On Tue, 20 Oct 2026 22:42:13 +0200 Imre Kaloz wrote:
> On Tue, 20 Oct 2026 11:06:19 -0700 Jakub Kicinski wrote:
> > Why do we need support for machines discontinued 20+ years ago?  
> 
> For netdev the question is smaller than the series: patches 25 and 38,
> 44 lines in ioc3-eth, a driver that is already in tree for the same
> part on IP27 and IP30. Patch 25 is a no-op on both of those (the bit it
> tests is always set behind a classic Bridge); patch 38 is a MAC-address
> fallback. I should have said in the cover that the series is meant to go
> through the MIPS tree and that I'm only after an Ack for those two --
> sorry for the noise on your queue.
> 
> As for why at all: same reason IP27, IP30 and IP32 are in tree. The
> hardware is in use, Thomas maintains the platform, and people run and
> test it; "discontinued" has never been the removal criterion, lack of
> maintainers has. IP35 is IP27's direct successor on the same
> Hub/XTalk/Bridge architecture with the same IOC3, plus its successor
> IOC4, so most of the series is teaching existing code about one more
> hub generation. And these boxes still earn their keep as a stress case
> for arch and core code -- e.g. the kmem_cache_destroy() race that just
> turned up on my Ultra 45:
> https://lore.kernel.org/all/atDCYwNfKW3m6YXh@thinkstation/

I don't think you answered my question, or at least I'm too daft 
to catch what you mean. IP35 was not supported so nobody is using
it with Linux today. You're adding the support, and since it's 
a platform discontinued 20 years ago there's 0 chance of real users 
of any of this code.

What am I missing?
