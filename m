Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529008;
	b=PnnbUFmVkmIAw2y5FMq09FxgiHIrvowGQZZDBxXEongMXVZsncv4Y0Z5qg0lhw/yiiH4
	 k2b2UgptgJjG0eUxQWEBJD/3jCCkVveZrouSPx3mtuKooREmAm+DD0/td7lW77zs1aU0t
	 Bhh+OAJ705SA/ABiXJ1zLR3DECpanMPeba+enMHJxOZpY2n2nWUGsg+5/dZ7vcQtRTbBo
	 29k5EbmLb1goCSpG9nWquctWVkWlPg0ZyRocXMzdrvsiU0oBb6Y9yuGhnf1qCuUUuSMIH
	 7EAW87a7BMz3xI4U368Nv1+9ElJswcUHMq6Za2i4MrC8spEjvNoB/mM0mPp3Mlt3HTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529008;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T7BOKY6cJYNPNM9NANNC0B2ipfLfWlNxZfKW696+N+s=;
	b=SHwCZ0JhwRUVlXXDbVJB50UQ5ub8JUYeemej3Yrc8HZc9wjqpUni2S8ahYgLDymY4DKi
	 kZQGNLBHRPQgJTOUqa+bd38nNuxoIYWMr89idzptRMs0Y9ylOroL2eon3d3N4vCjhief7
	 EQE50Oh6JiPOmc9sSvyqbtF/4zdMBNwnw7LMPNwU9kbeA+9tXlSFk30Vsyxi2r5SscpyL
	 5OHfWVlmKBQsUTX1I8cWWkp2AwhnObYUJhdsSp3IGp6PzBI+VaaLZEZ/+rlbtObji0Ohe
	 qBs5z/Tg1CWRuicJlH9wdTMYJKW+lPUg0vsiQU8l8u8wx6nfb5HT1crtvRHMv3Mna0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AiVewjZA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B16606A31D;
	Tue, 20 Oct 2026 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AiVewjZA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68371F000C9;
	Tue, 20 Oct 2026 20:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792529007;
	bh=T7BOKY6cJYNPNM9NANNC0B2ipfLfWlNxZfKW696+N+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AiVewjZAtL5zaicHA/GJW/2iGx6TcPYqWw5PFYTndJROPdl0xJD1Hp8SiuZsGvWfq
	 7PfcOihd0FTtzrwD1hBbrv3ICm5vt0vOTHDVBUqKDu2K7FKnlhcdaeMKsweqP0WZwv
	 cNql9vNSWLQFdxYOIW2v/RAqlXHhh0VAmclYzY0wB1YlCPv8dXk3JFOnlgENXRviYV
	 qsXXyZ+YsHrSURnzeM2PBtf03K+Jd/NaOQunDvG6PCIxoiJQKSUgbt0qi2b4QW+k1I
	 B0mMus6bh6qHdxqW5I3wA2ce6aKEAc5nZK1ikQScQpG5LHbjI5cYjVsAElqVrpEbBx
	 MCUV1ClhHCEvw==
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
Date: Tue, 20 Oct 2026 22:42:13 +0200
Message-ID: <20261020204214.28625-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020110619.12774a1c@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org> <20261020110619.12774a1c@kernel.org>
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

On Tue, 20 Oct 2026 11:06:19 -0700 Jakub Kicinski wrote:
> Why do we need support for machines discontinued 20+ years ago?

For netdev the question is smaller than the series: patches 25 and 38,
44 lines in ioc3-eth, a driver that is already in tree for the same
part on IP27 and IP30. Patch 25 is a no-op on both of those (the bit it
tests is always set behind a classic Bridge); patch 38 is a MAC-address
fallback. I should have said in the cover that the series is meant to go
through the MIPS tree and that I'm only after an Ack for those two --
sorry for the noise on your queue.

As for why at all: same reason IP27, IP30 and IP32 are in tree. The
hardware is in use, Thomas maintains the platform, and people run and
test it; "discontinued" has never been the removal criterion, lack of
maintainers has. IP35 is IP27's direct successor on the same
Hub/XTalk/Bridge architecture with the same IOC3, plus its successor
IOC4, so most of the series is teaching existing code about one more
hub generation. And these boxes still earn their keep as a stress case
for arch and core code -- e.g. the kmem_cache_destroy() race that just
turned up on my Ultra 45:
https://lore.kernel.org/all/atDCYwNfKW3m6YXh@thinkstation/


Imre
