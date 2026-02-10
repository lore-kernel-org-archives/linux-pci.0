Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6929F30F924
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770755642; cv=none; b=OVSHLR1rYYK9aJaQpzknvoLKH0ezpqb58QOEUN4ZYcNDxpbi8cP4FayFfLJlZO1qexCvJtWiE742BfQiZwBurcPnIObohdCijD9A8t4r1a/xFV9GSe5zzD26Y2B6fYWogNf5oKZ6glIOSTeT++ToVNaMPGXffaXX9/iw5cjKDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770755642; c=relaxed/simple;
	bh=v8LhdM9wS77jevJ7LszGPJjhdIoPGohp8xvVJijhHN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2jqDoASLfqMeJwGJs44KB9HFqiSIlKO1uCgLgc9o3wFKNT0Hcouu4fS2zYHDYBJnukHcw2yy9AbMF6OKZntRN2+ehh0oZQKFdp07Q1xqIQLOQ9Wi6cm7xW62tInyXbHx8JidskDHX2UDeRE9Vm9aCwVkw5YW07Es3urtyS4quI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qR60QYHS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qR60QYHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1763C16AAE;
	Tue, 10 Feb 2026 20:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770755642;
	bh=v8LhdM9wS77jevJ7LszGPJjhdIoPGohp8xvVJijhHN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qR60QYHSlgq8j7Kw7PJ5oaJWgWBQJKc2xgr27LJK7oqQCWhKKEj2HWkS9DPiHvfHp
	 NZMDljyH1qBoAOZR5JOtA9oQkQyN3k0dHJnrwr44724DUnH3K4i+zs28PUppkByjKQ
	 S1FZ9EATOFQUAAQFyoKaKB3z8bFTHDE80uIy4szc8D0ug1wOXSO+68Edf7GiEMvoPF
	 HjUvS7qlCFIxqh/J4C9zG3VCF+ZuN2T611csyX0xUv2ZOAMSPXbDBA8RdrqTiMC8QB
	 yUqyUfckhnbfpTfgo0kJzRFF1iW7UIhYzLsjjBr2T9zSRslCTqRDUNXWhagdlxnF7X
	 ibC/k1Ag105sw==
Date: Tue, 10 Feb 2026 21:33:56 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Koichiro Den <den@valinux.co.jp>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Fix regression in
 dw_pcie_ep_raise_msi_irq()
Message-ID: <aYuWNOwXO54oYCWD@ryzen>
References: <20260210181225.3926165-2-cassel@kernel.org>
 <20260210193205.GA41950@bhelgaas>
 <aYuToukP3STMF6Tj@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYuToukP3STMF6Tj@ryzen>

On Tue, Feb 10, 2026 at 09:22:58PM +0100, Niklas Cassel wrote:
> What commit 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")
> did was to map it once on startup, that way we don't re-program the outbound
> iATU on every pci_epc_raise_irq() call. Before this commit, every
> pci_epc_raise_irq() call could potentially cause ongoing outbound transactions
> to be sent untranslated. Often the transactions that were sent untranslated
> did not appear to be the MSI writel() itself, but other transactions performed
> by the eDMA.

I guess it could have been the MSI writel() too.

Perhaps another fix could have been to just do a readl() after the writel(),
before the unmap().

If that is preferred, should be simple to test, since the bug is very easy
to reproduce, just run nvmet-pci-epf and do some transfers with a high queue
depth and see the IOMMU errors on the host.

I do like the solution that caches the MSI address though, as that avoids
the extra latency of a map() + unmap() for every pci_epc_raise_irq() call.


Kind regards,
Niklas
