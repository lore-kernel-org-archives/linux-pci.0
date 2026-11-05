Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898020;
	b=BbFrx/8ol8+71snd1ijivo8WHNRVM+liIHjU8+uqDXHLFLoxjVAmpox/jXRWuQkdLPSp
	 bR0rjr4rsFzuLMj64kqr4K/ERaA2OeZMd/XXiiFXkytaFsP9MYlYYCcDxCWJNJWqzIr6H
	 bkbC931YkfmdgP/VPAiTvT0G7a1aYivKDaM++8PUBPWNrFfbfem4uq05iDmlSR5LViS3Z
	 B73E/5DwTaLZDL+F6tHRtT49U9PcvF9Nq3EaTaqYn1619o6lJU9INCFp79/GDTP3A4iu/
	 eML3lPKOT+XS059MsMJeb+SXmvm+E39WL+g2TQO0PCbP9ugAlA43jRxxhmSmhfVjp0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898020;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EVMpohpJSY1UJ2VsxHD6Pnf4OUiuIyHOcjFu9ZhcCrg=;
	b=S0x/BKVja7a/sXJ6zRxp5NZZlyFTTDbnfplnBGa+nw1Q/lscRi8HRyQQEYmEG0KMwaNM
	 OswKL/W0qK+0CC6BK6+1TAN+taGtmRiqVevw978LsuwGJ8AwDGebhlMN73Q4GGGAHEiLL
	 bl5BW/Vv3NN3Qz/0hIva9clJDBn7Tv0adMXr78zmFiVEMg+0edKieYsiadMPrqa2xrss/
	 5j8/yBrbEQhmxRkH/gzaRtzKexUm0bBLWOfMKxjfGGhl54qScrJWiEewhlDfIG5p9AHv1
	 46yD8168/DB+yp8kDpqX6pwGvNW1FdRGiQK39c6IrRqYUk7RnlsHQFqKRTfWcUoOXAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPBmI02z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232E606A329;
	Thu,  5 Nov 2026 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPBmI02z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D3A1F00919;
	Thu,  5 Nov 2026 17:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898019;
	bh=EVMpohpJSY1UJ2VsxHD6Pnf4OUiuIyHOcjFu9ZhcCrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jPBmI02zv9E+tmEBf0aW7UfMXq8v9rU9JVHvtW5iYj5JpOZf8Jhx/zUVKeVirJO1M
	 ilhIxj6UtH0I3gpXN9+wET55dgQ8pEOlaYwrKhkwwfg5JGoCGDHK8+796Tp/aLkSis
	 DuHccEqJ3h5Eys4fNwbbRG+u4F0Sy5HmNoxOTMNjCxYbsSR8BaQZDf+PowDdZq25CY
	 Zk5hRgJZLtek4oO2u5OTYakYMYGvhK8NYHBcXLBajH2uFj35nEaA2NysNEym7qIF78
	 NJes4kJAheLO0dWfcYYm3/cKVj2Ru6ar7TjNJxBu8SLK2AGOxN3/v6SktUKDNHJ4TZ
	 VvP0jEWOrWVYw==
Date: Thu, 5 Nov 2026 10:00:16 -0700
From: Tycho Andersen <tycho@kernel.org>
To: nathan.lynch@amd.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
	Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, PradeepVineshReddy.Kodamati@amd.com, 
	Shivank Garg <shivankg@amd.com>, Stephen Bates <Stephen.Bates@amd.com>, 
	Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 22/25] dmaengine: sdxi: Encode copy and interrupt
 descriptors
Message-ID: <auy1tOkaItMy84Wl@tycho.pizza>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-22-3668ccc7aab8@amd.com>
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
In-Reply-To: <20261103-sdxi-base-v4-22-3668ccc7aab8@amd.com>

On Tue, Nov 03, 2026 at 08:50:03PM -0600, Nathan Lynch via B4 Relay wrote:
> +int sdxi_encode_intr(struct sdxi_desc *desc,
> +		     const struct sdxi_intr *params)
> +{

Same here, this one can't fail and isn't checked.

Tycho
