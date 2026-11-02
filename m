Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632342;
	b=yvQIZn0vzxqMKiAFJUsvtS0FkIKpxT5fmtEs+wAlRLinI5VTuA9GAAz6sO9S4HqkpkE9
	 q91iNGzFtpi7fel64kCdfUfOyNvUv4DYeXonJrUqEtTtANNBOvgYqjbjTsPiXJnUFn08F
	 IEPt/WaWMzCUlvp1Dm54bq6Wnz3ZdO0ODnXJum7Nc23FDVtw+RiyN+p6s/1Bg4Y0/wgXe
	 7Z6/n/O297YCM1n2yKsWGAQFDM6IUc991b6jB2p1CAAwmoQJIMTyor0f58BR8YaomOiaB
	 JNDZLnVeNfEIM3vZmF7KSzMbigHIIw38siFb/i09fsr4MUwXDIAKKueqjvgMM4l3jKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632342;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nl4XdaZz2uL0DXOtmdE1FRqZ6AJVOjmG7j1+imya4cY=;
	b=rmBE1Yqj3ZZN/4HBW9+7uPfdRMnL18RwS/JKQK0SBBGmTc4GG54YhNMMa5476yAgJeD2
	 IRv9jMBRe82FKKj0dI4vojWv6DnBn2KS2OEYNYDRJod/FTb3DIySQ+y9OZUERLy8yY6he
	 YRlieFjrUjeSl3bgJj4tfpiUQyH6ZvvgFKO6KN5zhlW/6KCCYCygyN6qGLoaxxZwAmD4h
	 rTXpjIrjrzcNMRYDVCaKx8M54Crqw38dwJMVCwWwmL9adMjAKYFq/v9RT9s870qKFoFjc
	 TIqdlxbGjlOznPz3HUsWy7zTEnjEL5GvuqnxWrhFMLiR3o/bPIj3g6gidkqHzL2exyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qdv6+IgD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F5606DEBB;
	Mon,  2 Nov 2026 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qdv6+IgD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E721F00A17;
	Mon,  2 Nov 2026 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632342;
	bh=nl4XdaZz2uL0DXOtmdE1FRqZ6AJVOjmG7j1+imya4cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qdv6+IgDTuLTKP5nlxYiLM/rxYc6GJivp87oY9791L+gMKqtT35mwm66E6piqq7w6
	 xe67kAm5esOSKFvQOGRv6oL0roIbYOjbHNYquK2Rw7AMdHom7rhHekuJJLyco9lZxY
	 Uk7Zj45DIq9BnsoW+5ULnYB81c1wjITcnb4erxgXTn5WuK7A6U36P4DSPi41PG9rUD
	 sC1l6TbS9cMJVyXmr0Z4CvvlHRs39JjIVUXQrlvV8Gh9Kf04OdgobM0g2Zv8jbeHdr
	 PiNSSl1/NKel7/2xSyk7Pyc1bk7FtdmqZ2ty3gufwO4Fe5DH3vkg6j5Y+pcos6AQ2z
	 Q5rZU4oAkCm8A==
Date: Mon, 2 Nov 2026 16:12:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: mani@kernel.org, kwilczynski@kernel.org, linux-pci@vger.kernel.org,
	kishon@kernel.org, Frank.Li@kernel.org, bhelgaas@google.com,
	den@valinux.co.jp, thierry.reding@kernel.org, jonathanh@nvidia.com,
	vidyas@nvidia.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: endpoint: Skip upper halves of 64-bit BARs
 during search
Message-ID: <auioURK_nCpmrgcn@ryzen>
References: <20261102112306.4018464-1-mmaddireddy@nvidia.com>
 <20261102112306.4018464-2-mmaddireddy@nvidia.com>
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
In-Reply-To: <20261102112306.4018464-2-mmaddireddy@nvidia.com>

On Mon, Nov 02, 2026 at 04:53:05PM +0530, Manikanta Maddireddy wrote:
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
> 
> Check each candidate's preceding descriptor inside the search loop so
> upper halves are skipped throughout the search. With the Tegra layout,
> BAR0 is the only available BAR and subsequent searches return NO_BAR.
> 
> Fixes: 27ce1d8ecb9b ("PCI: endpoint: Allow only_64bit on BAR_RESERVED")
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
