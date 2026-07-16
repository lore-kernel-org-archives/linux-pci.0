Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30119222590;
	Thu, 16 Jul 2026 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237882; cv=none; b=mnDxhNhrrn7bIxyRwtJr2FV8LH9jSYU7JL78Fv6gvS5Z0tsKikXQvglphKqw+h6sbNG5Uv1QgHqbA7pD7IDpH942NvoCLiB1ZX5TnE/NjFNIyZo0g9Zxna0R3o1TECBhBpEPPMhmESRgWvK10sC7x3KHZCqBx/WlH10eoMinOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237882; c=relaxed/simple;
	bh=IAeKlN/Imrk+rFbCRknx36m3JcXZLzrx4MCYGF078FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbyZ0Deh1JUhja1BUU1LDv0VZp5j+Sj1vEDIGQyJhjcbNLw3p+gcTCYmo2PDuBsLlmmkzbs1i7FxzBFNRlui+0/mETMgAc9hIoADLd1XmFON5Jq4whu+3+issvaDvn+nqxFr5cc2qLOA5bEBXWEXsx4wOPwIY+PL663Lkmp15KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCRJStND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCRJStND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A0D1F000E9;
	Thu, 16 Jul 2026 21:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784237880;
	bh=EJr436MNWU4FHf0Qya4qCGFup/W4Zr7kdLcK7Wvawhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nCRJStNDbJR4neX+mwEQgrUPfcgx8XRMSPTjJCOD09jm2uX+VTtGrJoSZFA1Gw+7l
	 ZC+AKoab13Hglb+GWzkJt3wQbWTqx+qeXy/FuklJHxOqskivfQbEL5BPhwIMlxbUIM
	 EkKVHcENsqzR827c9WnHB8mbjhjer7kwwQn2tCvpZBioS6MGA0cUFrcBDu3+Ln0D1D
	 EtE/tNqLqWr+zwbvaWLbMUeiGckbnNWQGg/ikw7j1ffr+GCgTxkPfoaTMuY7ZCpGKg
	 pWa5fYKVDQPsbHIfZqb46Um4w4NJR5Ls5tJxSk6VCEAdK/wmdTdxTvg5zC9c1HdRQ9
	 3kT1EvldR+xPQ==
Date: Thu, 16 Jul 2026 16:38:00 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: mediatek: Add support for optional
 perstout reset
Message-ID: <20260716213800.GA1472290-robh@kernel.org>
References: <20260708090533.19734-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708090533.19734-1-ansuelsmth@gmail.com>

On Wed, Jul 08, 2026 at 11:05:28AM +0200, Christian Marangi wrote:
> Airoha AN7583 have a dedicated reset for PCIe PERSTOUT. Add optional
> support for it in schema.

This is just the standard PCIe PERST# signal? Then it should be in the 
device that gets it or at least the RP node if the downstream device is 
not described. That is how we're handling perst-gpios in anything new.

Rob
