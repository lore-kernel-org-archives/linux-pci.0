Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360539;
	b=nyBbeRJYqsDfs+rDbZPikC2H+1SkvsC5WV4SzEdUgotpXtul/RzL8k5LbQGjoMdpzJrd
	 biPTlLkLZpd4aTuLz76BPbeWcjbIDzvuIEaw8meTpYIWW5p6GFjDAhbx+alMWgMizBABR
	 Nj6jEkWS854fNUTa/BqZ7rdnTte4eMRfk7v5AtuXjewbtMBAg5p7KLoZLVBKmGuoGxAvg
	 y9BMlkFhLW3Cp34WuyMT+do6jznh3Gzvb6NUXlOpU+6C7B+ZZhUFUst9k6o7PXJxfIpyJ
	 TDNY+ywPstIL2xYI/6dzp71qFNmoJj73d1qtPIDXSG4Kk/Zcu0/yHwzDZ/h4XXlAn6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360539;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fp1gqCJQWC7Z4+tB0dKDQQvYxRSMJQy+4mMu2dwz1JM=;
	b=iE9JczV5J0MtRLWaLosqLNAU0cP4hp4HpTvOxeQEBSIWgx3Q56Hl30LmlcYVARUy9yG8
	 sniob/gnQBkkS60JP8StY6V6DyyXIzsR40OaqoGN9BgUaFD1G3pAOepWppgppoAOeMQr2
	 shChs2IwzeJEX/nxrAxmQV9gUSuaVZyLCS5QsnSIP85dt7eyNIBUeY4YmO79AgNX6tmqg
	 6Csv6bEWtCt03LokwSB+/2xBpNfjBGsvuyVUyMwgxIfbpC/Su0LfI9DDx8ufyKgxXm3La
	 VAHJ4EO9jPDJimTPZGw5cuhyEDY2caiEH3ZfhgBWW0wjm6aujwac3L9bL+aXTkaqfRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laAE45Bs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA63606A32F;
	Fri, 30 Oct 2026 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laAE45Bs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1151F1F000C1;
	Fri, 30 Oct 2026 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793360538;
	bh=fp1gqCJQWC7Z4+tB0dKDQQvYxRSMJQy+4mMu2dwz1JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=laAE45BsmSfb80cLZfdhIGxTP2x4cXkZw1y4TRQztRbLzC55Z4sSAOLExNKyIZoaQ
	 k39I/1hpoG+7gJtN3jTSeWu4GjDVXUqcQKOKk77vvxpKZ38btbbWck+8k6HUk+G9fh
	 QXIyMqIoJ4QTz9F9VDNr17MaBKNPKBW1y7+s/ZmmtpHr0SurB8QJPJLW7b4zMV7VBy
	 IXLDPJ0xr5PsMrd02XKhF8dEOtFJaSU7eXaDxNNqWOT3GDoFgUenoGuXfp+L01bVuN
	 CFfmLGRCED3kNZDq6QLPrcJlXHn2CZnE6AqjMsalkg9ejfmxzkawyD0HEj0JIGk0zd
	 GB1DVvMq2b7pQ==
Date: Fri, 30 Oct 2026 12:42:10 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI/pwrctrl: Enable pwrctrl for devices powered by a
 power domain
Message-ID: <wsdh7j6cevksxn4vd3uoat2f77dcyyhqlixr4lssrmadw5dlob@omoc2jryarjx>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-2-4d843dda0b02@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-2-4d843dda0b02@nvidia.com>

On Thu, Oct 29, 2026 at 12:32:04PM +0900, Mikko Perttunen wrote:
> Update pci_pwrctrl_is_required to return true for devices that require a
> power domain specified by the power-domains property, such as the
> integrated GPU on Tegra264.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
