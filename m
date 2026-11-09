Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265191;
	b=nB4yiFPBKpe/GXGkXY8U0NWhPk3KHjvG/YLzYbZm63jFmfrLSirc/kz0yzUiCHLL1G+w
	 e6S8sKXdPka2G6rBMQOVl3v4Bvc1dtNQYvSOrAvj9f7aw/jYh5vUWTrqPkF/54xFRAip4
	 eVW3+DOcpkjYfoK/wja+bx8WXGpGJAcp1zNcJp+dVcFRfsLAtgQducBkhaNA4UM5aTzUm
	 25Co+MMvSXTyFPtt4cPrO8+dy+BGvz8lk398tVjJBAatCC7kYzrxnYZQGi2CkcFJ/eDoE
	 3AeK7NUoWPAZXjH9SU2a2F/4O9UHLWmZNMe2i00uwqkBsTq1gtUhEqYFI+KSg5Ryscg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265191;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=OI+RsE2umMR3YB2hYIUmxpHG29qgfx8lgFFz0ZwqeNQ=;
	b=ISTKOzkwUmCPEnLP7Z0nIhkvYYPHr4xSrWcHuP/woObDDpPcBrFMAqg627utWSEMx3cx
	 wEIzFS4Y1Fij/emVmhU0+pSZdLP+cG0Ih6CnTHbEx7cuVdPiHMaCvZ3YptxyXb6impZRU
	 Im62VbC48mVNngNqsISTNgZvxaifwSY5tIuRstwwZWDu85tPCR5etSgn4At/bee3/9QZn
	 yyuhlBWBwYjYYijYWJRoXrTN6MpwK2alyMSpab76IfHv+kvPAGzwkce5F9wxhupJF1XYE
	 3EA2LaaroiHQXbkN2JVoeDoAncy2+oPWueQZSTXXsrmt5tCJBo9LtAZWo1iOGU4kOdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQfdl9f5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B73606A31C;
	Mon,  9 Nov 2026 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQfdl9f5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F8F1F0089F;
	Mon,  9 Nov 2026 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265190;
	bh=OI+RsE2umMR3YB2hYIUmxpHG29qgfx8lgFFz0ZwqeNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=eQfdl9f5IELEpTiJZLYa5IWrbsjGZ1rb7rRK+pY/AY196vQa8f9A2VrQdPHDnxLky
	 2K5qARnyCRpvLPc/5ntXmqkWIKYVOOpBxQZnwVt7qUlHpkNQYBtx+Z23s0kPmLYrur
	 TY8u5adNVwT1LUYPI8K4Q5fYj7KtYHQ2tsrt3TJf48UPnyie2tr9ErEjlpVoOLMbdA
	 APSDOYeNJbEINQRJGE0W26UXtvVkttBoJWX5G6Xf0zAJ1eytrp9lL7bySkaxtdp9XN
	 p/yl/rycT0JFdp1ovSSWS8XxZqyNlht7AeOxu89PWXlfiwPYqmIVjwWd4wKPbC1UVU
	 VEPfPIaphWtnA==
Date: Mon, 9 Nov 2026 16:59:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: Fix hotplug memory distribute
Message-ID: <20261109225948.GA337688@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109144553.2516-1-ilpo.jarvinen@linux.intel.com>

On Mon, Nov 09, 2026 at 04:45:50PM +0200, Ilpo Järvinen wrote:
> There are a few simple to fix issues within the code distributing the
> available iomem (and ioport) space to bridges (to allow using it during
> hotplug). The worst issue results in violating window granularity
> (usually 1M for mem windows).
> 
> Ilpo Järvinen (3):
>   PCI: Fix NULL dereference when shrinking window without optional size
>   PCI: Fix start of available space for the next bridge during
>     distribution
>   PCI: Honor window granularity during resource distribution
> 
>  drivers/pci/setup-bus.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)

Applied to pci/resource for v7.5, thank you!
