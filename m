Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE4F3655FA;
	Fri, 14 Aug 2026 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747001; cv=none; b=iYnoz8lXaicljy2MtpCj7wa6Pf9GfuoLDoRn/Lx/JwPR0dvYfKcfVP05Zqi9urpg+N5EQZJn320bYd1gDRCBB/JH4Il6tRjPegd4Cdl65Ih5CdOws3bOehiDJsbwAM+Hd1xYL8iJejdtkxZ9c+vAFgPGmmQKmZ8HVXZASb8CLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747001; c=relaxed/simple;
	bh=r6nLz7OgQW8GYy6ajxbyaSTyAZnnkOgssv59ys8N8Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lkqRRcSubISbThgfJDvLaLd+iKtAeSLz+Q7d9Q1fXYmo2ADm8tIevetYPSxcOLhh3J/Sa0IMQ2whiym8juU2mLBBxi8NnGywsE5vzA8BvSSxo3Q1sm5yI/mSIqWCTg/YF/apEcWKPckdsOBpLZ5YFxf8Tbjlva/tdVS6gqkuWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqimssAJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqimssAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6684D1F000E9;
	Fri, 14 Aug 2026 22:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786746999;
	bh=YUAbOEyEyBMxZ+qzv/qxdrNwShBAdqijr1A2NR4ulUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=dqimssAJJb8IVS+A8bwvUFYFMRA1HzWgD9IMQJxF4NfE0BSnHnoTzzBWHbCSK9lDA
	 iovQLPN+qGeBAvEO3wGcQFoRoqAeL0k7jSXUDXJvI/IJERvuuTh12zeU1BbAwwc8SX
	 JyUPqb/eDe/ua8JMX99aKksyKcGZc4N/nzc+X7vYdRoXwin/dgtA/+CQyRmScs5Bg2
	 qhHsJVGoJXVtZTj6p8aVBvPIXXpGQfXdAJ27DB7gT+09MJKsYuv9a/H/NbNJSCG5UT
	 IgZ55c1tTS1NphLDEvpD5ANVxQmgAlX04Ts7byuIbEFlVGeWeu7tYy8b8JLTu7iBUa
	 fhxgpkIkYqXcg==
Date: Fri, 14 Aug 2026 17:36:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/2] PCI: mediatek-gen3: Add 2-lanes mode support +
 clock
Message-ID: <20260814223638.GA181706@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806165334.7328-1-ansuelsmth@gmail.com>

On Thu, Aug 06, 2026 at 06:53:30PM +0200, Christian Marangi wrote:
> This small series introduce support for 2-lanes mode for Airoha AN7581
> SoC. This is needed for correctly functionality of Eagle WiFi Card
> normally attached to this SoC that require a 2-line PCIe card to
> correctly work (and give the proper performance)
> ...

> Christian Marangi (2):
>   dt-bindings: PCI: mediatek-gen3: Split Airoha schema and document
>     2-lanes

This is applied on pci/controller/mediatek-gen3:
https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=39f758dc5fbd
("dt-bindings: PCI: mediatek-gen3: Split Airoha schema and document
2-lanes")

Just a heads-up that it conflicts with Chen-Yu's patch on
pci/dt-binding:
https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=7e38b7b0e0e5
("dt-bindings: PCI: mediatek-gen3: Allow memory-region for restricted
DMA buffer")

https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=f281334a4e82
is the resolution; let me know if I did it wrong.
