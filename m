Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519581;
	b=yRxVG1cn2VDemaZX9X34VXm+aBqqsT38soHCB7l6vr+e0rdZ84YSBiLJAVplL0PUubQA
	 pBalpFyoaEZLUH7rI/zB5wIfGLAIXbguXr4gTJ5/pm+1ctz5wW/FVcvOOGsngoqZaeQe1
	 4VjLk71lzchdy1Bvb8/gTfF8nagOVDHbeq1omLtUBrZ9eR4OyUzIMZ6FwvAGQALNXtNC+
	 sBR4ZC4pNbgl7puDHECxYy11fs3S7sbC5AkFsmp3+KfA3DGeAUilDxQAgzwT+I3l3dz3l
	 fmvAuNdXY9Ogk9OSLzeII/7fN2ijoxQ5Te8mqrJveaJheZsU4lkuNz76Yy1rgi79F8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519581;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HVb+cZJd/B0SyswVrB5yNoiyhOraxVQrSwREAf5tTOE=;
	b=teARR8Ol0RpM2q/I6oKAzG3P94nRztZZo0rStM9vgYTYSgh/5gM6i6ceD2/aPv8M43b7
	 i/wb3vejoioWbSQ5dIYmRMdis7SutRBdRjkubh201pBm0T7BiOPP/T7ErhFf/+F/iDfDd
	 CsbNt37bunaDxroi4eBnWVDBpirU9ExHDnXK4BR0zD7Pkq4/VNLpm+9rextk8vELFQuxp
	 1PuYJyg3TxhYaQSRJU5Yxj3qEuEtuUS9xXWprEAyf1Qhan2bcVe6ICLpHGAyae17tZOFA
	 pZ1Gkr901ji1Or1c/nGHaMBkp+tWMZrTnyZWE0GIHLmL/S47zTiBpRJwEv+THm6gVZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOSCLcav;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAFA606A323;
	Tue, 20 Oct 2026 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOSCLcav
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F9B1F000C9;
	Tue, 20 Oct 2026 18:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792519581;
	bh=HVb+cZJd/B0SyswVrB5yNoiyhOraxVQrSwREAf5tTOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VOSCLcav+2Q4vNjUNvhkr6i5DNiI17LtAqaaIRzCzrM8wZyC5l4KcdrlFDpvx5311
	 SEo6MM2zhzIGkyPZXOnlvwBXy6MFWr3/RnJaISTv+py52eDkP3e4GcI070pM172tyA
	 aN9qceol4RnuUJReHmdm/O+2skabYnJSxsPSNRHdhamkukSo5wMIWfncUJIpwQm6A1
	 iZu/hz1oyXwCkgHMK8aqynuQK/TsdwJQ5k636/lNnJ3/8qBYlWEZ0bsE2odhTVdnJU
	 /Os3eb+hvwQdYrZMQNU7V5fqPT3awKe8qb+OD5vIErPd7bWxHq17+Xs4tg8sbSyrMe
	 zj9J8181KItxQ==
Date: Tue, 20 Oct 2026 11:06:19 -0700
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
Message-ID: <20261020110619.12774a1c@kernel.org>
In-Reply-To: <cover.1791890466.git.kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
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

On Tue, 13 Oct 2026 15:16:20 +0200 Imre Kaloz wrote:
> This series adds support for the SGI machines built around the Bedrock
> hub (IP35), such as Fuel and Tezro, to the IP27 platform code.

Why do we need support for machines discontinued 20+ years ago?
