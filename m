Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573629;
	b=rJumeTl39JHTbqjLTwfTxJUB5jCU8SoP6Xt42Vtog9CeFnGWvaT5vzBFwePrgjlgwM/Y
	 i0i2FHbX9uUuB04slTejOoyhkGrBAIfdDHoZvM/zb83VW+Mcah4/YNr1OTMxFoFdM1d6D
	 dFKf7ywiJMU7Dl8SRYf/GA1Yw3XSSOWFrIvS/Xv4vZOJUmp/PRNwDSNYyoIi2+w0Iwt9Z
	 lbe+r5JeFSJUXuaexh6K5p+OXmvadm37Yp0RauPNBWSLLFwXcQrxeENaX61zJn1lvvCvO
	 jZGEVloxlO0v5vN2gKqYdABbETtGxJRW2dhS95V5LhQjQFDIVTc5rP0twOsC0HbuxoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573629;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rg0LSI4npnBDUHtGy7KX4tR0xQfgXS+TF5Cj0A9UQlA=;
	b=TwReF0pqTdL156r1ljAVacn3FKYqMOkoZvCi5WusGSUgovFNjyx8XCN8rA3MD/j+Skg3
	 mIV3JwvsqZqrvj9xKeM3wWFkgly+FhRNyxHbDZ2p4TmMC2SIZ7BO0p8v6Lc2XIZQrovF/
	 86k0YDC4YAbZAaesDpJm1I1MQgikWhOOtf0i3O+has/Ats5Q/baZYUP1UZapDSmrV2Vjj
	 XrjK3IoW7IsWOo/lUM/N4neMQAp39fD/8DKyAWlSFH0XLKsEyJTo4CZOLcd5BCdHfu9RA
	 PgGaDlEPmmJXWrW1UnbuxoFQflcUR1uDAUVtvhT+l4763yVqXZ2j7Kqxb7V1sLQiozA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dyuS/W3e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59655606A31A;
	Wed, 21 Oct 2026 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyuS/W3e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFE11F000C9;
	Wed, 21 Oct 2026 09:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792573629;
	bh=rg0LSI4npnBDUHtGy7KX4tR0xQfgXS+TF5Cj0A9UQlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dyuS/W3ea7Wx2GQYveNRK6A4clR9WKquzSo7emGhmilDJhGfkRm482JLiSIwwvRnx
	 tRz4YkGWU3RkgKsj26EjGPNpY38Ya01YaNDP0hCT90bnF7P5q+D7Py9DsMI5woYLHu
	 wWbIaBLbHYHuXIVgoDtWJ0GLSihrVcRJkLfNz8gTGWeofTATdXiiLIVoIqZpPBnzRO
	 XCtataIa6A8TKYyIOUu2+EzZ1bNvRfuGc+c8P/3T4KJasoornuP0Gp+q4aozA5S8bU
	 fB3ivzGfBxENRbMhT6L4jvtekd5apDXWVnfilDfcEojbQzi8sh0s8xZWFvkeCBEgDP
	 PUnDjzchRcszg==
From: Imre Kaloz <kaloz@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	mfd@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	linux-leds@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/53] MIPS: SGI-IP27: add support for the IP35 (Bedrock hub) machines
Date: Wed, 21 Oct 2026 11:05:55 +0200
Message-ID: <20261021090556.21168-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020145611.4e277615@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org> <20261020110619.12774a1c@kernel.org> <20261020204214.28625-1-kaloz@kernel.org> <20261020145611.4e277615@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Oct 2026 14:56:11 -0700 Jakub Kicinski wrote:
> I don't think you answered my question, or at least I'm too daft 
> to catch what you mean. IP35 was not supported so nobody is using
> it with Linux today. You're adding the support, and since it's 
> a platform discontinued 20 years ago there's 0 chance of real users 
> of any of this code.
> 
> What am I missing?

The users are the people running these machines, the same population
as for IP27 and IP30, and the ioc3-eth driver in net/ exists for them
today. The series was developed and tested on a Fuel and a Tezro in
regular use, so "nobody is using it with Linux" is true only in the
sense that the support isn't merged yet; that was equally true of IP30
when it went in for 5.5, and of every port before it.

The kernel's test for a platform isn't commercial relevance, it's a
maintainer, which Thomas is, and testers, which this series has. If
netdev doesn't want to spend time on it, say so and I'll ask Thomas to
take the two ioc3-eth patches through the MIPS tree.


Imre
