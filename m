Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579563;
	b=MCTbOTNNzi83dmKxP/IPFwIT4nvM7HPWDq5Tc1qcF6thx+6EmuAltW54Y+7C3qIpXEQC
	 q8siNhg7Fm68WkCb+S6TTMQ9elY4fgXHq5/D7X4o6raKQ77vntbgRsGQlNsNGi+SE7C4v
	 LOoSQ6wpY4BSAbUGWu6E3XC9n/kgcco8IPaGthHzkH7oN9AZfLPCcFNKOoR9lOq3AgEym
	 kQaMRjZG6dlfX+ySUNdcs8R9HDvNXV6i0EGELRBzFlhLX7sa0ssbCxMKaByK/2T+8i11T
	 R6tsXfLeEQiDab7jE18Y+oYTAIy59vURQipvvHPc3TwLYM8wDiFHo4XPNrmzrkZYB0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579563;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=l2rxQ/cue1QRgY1CBYb6HcLs6Po78m3h1LJug5FfbkY=;
	b=NTYFwmKrFJsN/JEcQ+Y1N6XV4bd3TiLxkS4ta5iS48kMEwogX9IXjWjnqn4MwjKzkgE0
	 zUZ1iMrqD/KS+hPCKuM1wwTxBYxhQpZXusIf9XzQxfIAtemS0cYwrMXPqay1dE5dVOVNO
	 9dWiJp2HJDxxdcWt9g87VVJ3kOmyPcg2Fp+TNfOQlqCraqGFGG/WXdVmwy+VS6wG8tSJN
	 GuS4jMBGSEOdM42gf9yZ0w9mCsg5URQBbReDbuJQJ7gVMw6s4tLglnq1IV+zEucPI9VEg
	 G0Qj8EPMz5LYMCYKbhpD1g1xzUOiXAYBqjhx4BP3148PXzq1Oq/SCpYXFTtlIBTBJeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQcSQ7QN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD11606A31F;
	Wed, 21 Oct 2026 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQcSQ7QN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED791F000C9;
	Wed, 21 Oct 2026 10:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792579562;
	bh=l2rxQ/cue1QRgY1CBYb6HcLs6Po78m3h1LJug5FfbkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WQcSQ7QNd6/XSXlk0Tu/4bfE7GME4LaHNy2j80yskogRanONZCA8x584IEVjgR6ai
	 yfIZb5lOxHBlCVveFf9bc5ae2KBzZlvugIR20pSpVdVxjTJ0E+w6lFkkdDeC1Wv7rP
	 WiuV5icaI6oTVG9W9YDS4pyeGtMkZuzuOP+nDbkuVoXQd98JjLan/J0b9HV59/t91h
	 y1rHB0717fqa3syrUAo4eqgUGO+qZI9JB5UIwBHddZtxHGqkHeqzMPOIm9g5gaQrIW
	 BdG1aPbbCXU+O3CMGjpBVa/Umtma6A+8bT0MrWCOGJzd9+cZr+ZTMJLCj7OiCyUL4q
	 nNmWaUfxHjQTQ==
Date: Wed, 21 Oct 2026 12:45:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: mani@kernel.org, kwilczynski@kernel.org, linux-pci@vger.kernel.org,
	kishon@kernel.org, Frank.Li@kernel.org, bhelgaas@google.com,
	den@valinux.co.jp, thierry.reding@kernel.org, jonathanh@nvidia.com,
	vidyas@nvidia.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: endpoint: Skip upper halves of 64-bit BARs
 during search
Message-ID: <atiX5UoJ0qgV0wGN@ryzen>
References: <20261021080644.1346549-1-mmaddireddy@nvidia.com>
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
In-Reply-To: <20261021080644.1346549-1-mmaddireddy@nvidia.com>

On Wed, Oct 21, 2026 at 01:36:44PM +0530, Manikanta Maddireddy wrote:
> pci_epc_get_next_free_bar() skips the upper half of a 64-bit BAR only
> when it is the starting BAR. If the search subsequently passes a
> reserved or disabled 64-bit BAR, it can return its upper half as an
> independent BAR because that slot has a default programmable descriptor.
> 
> For example, Tegra exposes a programmable 64-bit BAR0 and reserved
> 64-bit BAR2 and BAR4. A search starting at BAR1 skips BAR1 and BAR2,
> then incorrectly returns BAR3. The next search can similarly return
> BAR5, causing the EPF test driver to allocate and program BARs that
> belong to the reserved hardware windows.

The 'only_64bit' property tells an EPF that it can only configure the
BAR as 64-bit.

BARs that are reserved are hidden from an EPF, and can not be programmed
at all, so the 'only_64bit' property does not make sense on reserved BARs.

See:
9266514689fe ("PCI: endpoint: Drop only_64bit on reserved BARs")

At least when I cleanup up all the properties (including tegra) in:
e01c9797c0eb ("PCI: endpoint: Clean up hardware description for BARs")

I made sure that there were no BARs that were marked both reserved and
only_64bit.


This also matches the @only_64bit kdoc in include/linux/pci-epc.h.


I see you changed this in:
12a22fb38cbb ("PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as
64-bit BAR_RESERVED").


I'm fine with this patch, but I think you need to rephrase the kdoc
to reflect this new reality, because currently the kdoc is confusing/
not in line with the 'new' meaning of BAR_RESERVED, which can contain
MSI-X table etc.

(The old BAR_RESERVED was renamed to be BAR_DISABLED, to be more clear.)


Kind regards,
Niklas
