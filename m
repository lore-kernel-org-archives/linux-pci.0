Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E763115BC;
	Wed,  9 Sep 2026 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788920342; cv=none; b=j+e+uANVGMXZ7v8rpqfn9JtV8sFKdPY/nBQbROtfWzMlIWTx36vsGMHsUS0+aDxKz5RVj4sGvT7HBq0ghL3w76Obp5X+LZnMLWOXQFiHQd7+8BLY7feIPvrtZThQtTuOHXn/s3WDVn+Wy+i44c1efGjOUpiuMId3R7DjOplXL9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788920342; c=relaxed/simple;
	bh=YGhvDfLqpg3qNdmM+d286nvy9H0IDi77oRRH1qtmzxU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MzQ3w2wzN+4/f0FzslZXMlC4y6pWQXxII6eFGBZR9nlwW6SPBq+4CRcduOrfDyQAkC12oq+0xbN6IQlXDxkFybr+i5Z3PMYGYBbIqY6Vwox30tjyfQaha1um7B0pVMXc5JzBPhh0DySu2zp2fYeaGEXOT2qVmYse4+VGzXU3od4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzNTmxPI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzNTmxPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF261F00A3A;
	Wed,  9 Sep 2026 02:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788920340;
	bh=TvOCiT/s0h92YvRxP9N0Lvx7xKcXVY9E34+CNjGQ4tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=CzNTmxPI9jbJl3ZpaTmwpLZuxbXLMFyohPASVireKnj2v29CCNmK5TJ2bV+rgTOYC
	 12V/4wD5omb6uyrV5yY71i/Uy18X9Ec6rptWG0NwfktearkyybiHjckAthvgvwfmly
	 MGEmQCGDENdLH3h1Fi4OqRVGh/CX0PzO8e/QBdzmieoYHId3id4fCqjpEPQpYzeYOO
	 R53B9SBXefskw3AHAyHnjc736rh5+BGDSn+PLF0XNHV4O9mH7RdzhpunZYdo7oe1kA
	 g5AkxotriM+ZcnLO0tiTzDacTUiDFj2saaL3/y3bGb64F03iZMOJY66HZQ7h9zNAjq
	 Wjg+SUwp6MJjA==
Date: Tue, 8 Sep 2026 21:18:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tushar Dave <tdave@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 5/5] PCI/P2PDMA: Gate the host bridge whitelist warning
 on verbose
Message-ID: <20260909021859.GA159841@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830-batch-p2p-fixes-v1-5-5044e8dfbe2e@nvidia.com>

On Sun, Aug 30, 2026 at 02:16:23PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> calc_map_type_and_dist() prints every other diagnostic under its verbose
> argument, but reaches the "Host bridge not in P2PDMA whitelist" warning
> through host_bridge_whitelist(), which it hands acs_redirects instead.
> A caller that asked for a silent answer still gets the warning whenever
> any port on the path has an ACS redirect bit set, the CPU is not
> whitelisted by cpu_supports_p2pdma(), and the host bridge is not in
> pci_p2pdma_whitelist[].

Not in this series, but I would like to see the "whitelist" term
removed from drivers/pci.  p2pdma.c and pci-pf-stub.c are the only
current uses, and I don't think a change would cause any API issue.

There are similar "blacklist" uses in pci.c, aspm.c, and vpd.c.
