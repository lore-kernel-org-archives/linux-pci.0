Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499790;
	b=ZQvEIUNLKWT1aWhktpz7uR9eHW7p4YQ65n9t7Lve3ELb5YGV+fvChRrd22kwK1rLR1yu
	 K6BKNHXU2hl59JZckrnxF5NMYPJBZDnHwYJ/yYhnH2wDb9/qNRnNICSD4ODIm4Q0DY3WR
	 4d3hPkr+5LMipCt1C74nUMnwqLo8kVop8pdV7Mw0p1PUXJ3gJLT45BLYvrutCs/PJJIlM
	 lbaXeyYq5Mf5emIAKS/1qzTH0s//pcbE5v5HQnnoRwmS5YStl2n0ex//OZT5QHwyfMFp6
	 EmHQnD8AWEsNmfbiniTNwll4bcD8lREWsN4tlP2g/Bjr3N3AjsX/uEvyleRIJ9amzig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499790;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GGCrjHv6NQXXfXzkCzwLWYEgOONtBDr5UvPtgRbBmxU=;
	b=Ap+PeW2bUbhne0BSO4JykoWgF04Iz10K9PXuq3MCqC7LI0z+gfMbuevBR9oeaLD7Pvjy
	 diy0n3asKqbDC4dC1f0b6eO/Or2jswK5o5RgnUgy5BpDulxANVmD5fGl67v+kDuti+q9u
	 A/DnNU8HARQuBdcc0rQD9r3tVOFCgn9aRN/6JjAfnDgJHupiKZXOaGIbOEN+w/mylWP7L
	 qrBMGMMC2Juj52tqaAV2pC9z8GYqWxwGPuorSK4aldOxDQ3LjjWfhhtiHav00WuIdQp/e
	 Hif5wt9c1DXQyt+SKgEgPyaeyXhH1o4K3HqRFH3vZZXVS5eXxV3NuXmxu1ctNo70hPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsFwPqHb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE933606A31A
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsFwPqHb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3912A1F000C4;
	Tue, 20 Oct 2026 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792499789;
	bh=GGCrjHv6NQXXfXzkCzwLWYEgOONtBDr5UvPtgRbBmxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jsFwPqHb7ynLNFmQYHyEfRP7OJTJx9fLFHDIVXHZiK/ivQAbf2bs/0JgRiUxVlK66
	 tFyiG6ThwPprFI9j/dQAZeWrFr9RT3sf1fiJhb3C38erRkPrBDtmsCmkQ1kiJf/Mqw
	 S1ml8aeK2ygc0R1R6WXHauaYpYVmFpVzvSOpKFCWQxLWO5XadvMDtfjYW3G7PE9+cT
	 dm2aQgXrqNZl5YMi8csyzC6d8oWqahdlo8mBgiclSvFdOQvUhGIa523SNmwz4EhdhH
	 90mCqRQgbHSauf2I6SGAu3Eq+UrIusBqlEdPDsv526qsYNVGKGYG+kJn+0d4xGS55X
	 fnutiJ9XeCZFQ==
Message-ID: <sashiko-outbox-178952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] PCI: meson: Remove redundant MPS configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020122854.1500883-8-cassel@kernel.org>
References: <20261020122854.1500883-5-cassel@kernel.org>
 <20261020122854.1500883-8-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 12:36:28 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Hans Zhang <18255117159@163.com>
>=20
> The Meson PCIe controller driver manually configures maximum payload
> size (MPS) through meson_set_max_payload, duplicating functionality now
> centralized in the PCI core.  Deprecating redundant code simplifies the
> driver and aligns it with the consolidated MPS management strategy,
> improving long-term maintainability.
>=20
> With meson_set_max_payload() gone, meson_size_to_payload() is only used
> for MRRS.  Rename it to meson_size_to_mrrs(), update its comment and
> warning message, and drop the now-unused PCIE_CAP_MAX_PAYLOAD_SIZE and
> MAX_PAYLOAD_SIZE macros.
>=20
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020122854.1500=
883-5-cassel@kernel.org?part=3D3

