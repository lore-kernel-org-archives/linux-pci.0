Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B690489880;
	Fri, 31 Jul 2026 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533875; cv=none; b=EHV8dcqtZk1n7ITlD7sESNHxtmlYcwbtnji7jwXgDO4I1rcVZOyT14dYp68Od4AnYiVeC68X07wiRLvqjvZUybYU7gkwlByEXgJOmMzyZiligmKuISFABS+RuJeYhhlPNWZSq539hvtcgx4+92OKclLLvF4gdKdyphPM/DMoEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533875; c=relaxed/simple;
	bh=ybKNoGvghGU0Ou7ZOs2A2D+Qwu5Isjo95hKQIoRo/sE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B/KfLU489yqyjeBKzWO3cxDYsIA2HqhxZwtS1MoLo1/WGAco0uQHPdNNgwWDUa6a+9OJtBo8FpXARNzFokJpEqdUoaBT8pMpbcemw5/9ykdcnXwvO7IFV0LdgWDXJ327OiQZ8UensyzeZSnEE0YNfcqkK5SIUO0aTdC6zKSndLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh/09H8f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh/09H8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CAC1F00AC4;
	Fri, 31 Jul 2026 21:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785533873;
	bh=ybKNoGvghGU0Ou7ZOs2A2D+Qwu5Isjo95hKQIoRo/sE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mh/09H8fR6wVeJeS3nzsbPGXz8qk2WT06AkpgN1tZCsafBNrPdkiYvBrccl8+nbVO
	 oTnz/jSY7LfAR1TW7CMUimSN5l9EH050xq9AyG67O3v680byvosPrEWmyNF4J2SDv3
	 v+Lr18aaqZ1GT6sJeUh4y7aAhhnKE2P8j08QaLMcUShWBj6ErfQFhrfMfvTF+qnh7S
	 fFEczbIa+CoQYHomITvXnhCWHVkBrYzyIeTlP6xEyG4pXiKvlZeB57arxcq9e3nMbj
	 VjqqusauSV7u457izThVk3AwFhSGFWk+KfNM4FsNRdgvo800ubL1RNtJym8LWGj3Bv
	 +KwsCXnXEzH2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/5] dma-buf: add optional get_pci_tph() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260731211601.3033906-4-zhipingz@meta.com>
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-4-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:37:53 +0000
Message-Id: <20260731213753.A0CAC1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add an optional dma_buf_ops.get_pci_tph callback and a
> DMA-buf importer wrapper, dma_buf_get_pci_tph().
>=20
> TPH is PCIe TLP Processing Hint. 8-bit ST and 16-bit Extended ST are
> distinct PCIe TPH namespaces, so the importer requests the namespace it
> can emit and the exporter returns the matching ST/PH tuple or
> -EOPNOTSUPP.
>=20
> dma_buf_get_pci_tph() is the importer entry point. It requires
> &dmabuf->resv to be held while the callback runs and returns
> -EOPNOTSUPP when the exporter does not provide PCI TPH metadata.
>=20
> The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> mlx5 as the first importer.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731211601.3033=
906-1-zhipingz@meta.com?part=3D3

