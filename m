Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300640;
	b=oQjwihRIJZqkB0IVQOWRt4TfDLrKi/oDD7LzRX1j2T628PMRdY/TGje0UXgH/UnwAyHO
	 aQuzLz68JFPsJG3WGOLKedPDfD+AzKaTjMkQEyRCV+W1OPvxP4+WfD3+SAwsRVBpi2b3Q
	 ralvjS7f5j54B7elGOlvD5vOIWnTlDYGXUQHBvKzMK1PZd2lIgRSKP98sJRNO2Ug/7JcV
	 wRGmNzski2Wqb1e+gLcpe7KU2rhB76IG8hHwu13Ho69lz3v3z/Eut204iD272/Lepvsdq
	 ViPGiFlKQpga4AkSYISHIMi52uaKg6yfX0W7rCvBnGTCtTn1uKsVyiRwYvqwvJUAc9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300640;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bmu09YCM3B0f7iPIV9QACx+8SnU/r/NTv5+O5dh4SDY=;
	b=nMxu70Jn+cgoqidq/tlDA2pySW8L+2keV8XVEnIf40Jmx9AYgYjm+ds3PruFYnJh2ihg
	 3/uDO4K3v9b3iopX2lTHY3SXfNjAKVJHnl+0RF8ZY001QatMUrZZnduFxuKLGmcGT27BH
	 fUV8VDmpPTZczbs1eWEFHOj0KiTiRJTvpjkJbjHHqic1mpEdVuXF9fDf7OCRRdYSci0+R
	 ty92nuqqDImuOa2y7ZA7K/6ZdtjmLphnMRQ4MpSeO+D2yXGGa1w9Ar/DdOdKkAuJO6g5C
	 Yms46MTU7AL7GhUEuGnAcTqXXis7VW6Ka6QlM2GReiicZ5mYIBr8omHpPTLUL3QMoZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="id/O6Juz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCFD606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=id/O6Juz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161971F0089F;
	Tue, 10 Nov 2026 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300639;
	bh=bmu09YCM3B0f7iPIV9QACx+8SnU/r/NTv5+O5dh4SDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=id/O6JuzukFE/YEUPS+ndmObu5PkEu4an1Y5ZO96nsRLGfngkdJU93Ncb2XmpzMvu
	 xL/Z1IN925FtCJ5rAvnnO0guxNVfz2FsjeBePA6BBQjqIQe9GSVC6FTHqpRloGZtBO
	 F1zHIxq+FXJuWMmCUV61gpADtnYtyRAWunF/jj6pbO8YZhxtYSd0HpJRh2kDTD1pVl
	 RjYN4GoELRzQHB7amL5cBYk/ghU0si6WeJnHoAgZ3R+VwJOsVysbhkUbP7pmMIyNv+
	 ucEcgrCGYgrGbqoWcAU80wUkQhNAjNgzut4cSMAVk4vIlMhO4oy+C7GGFNdGePe+P/
	 SwLRZ0RWqSqzQ==
Message-ID: <sashiko-outbox-206668@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/10] PCI: endpoint: pci-epf-vntb: Export endpoint
 DMA channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110082459.1798763-6-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
 <20261110082459.1798763-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:50:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> An RC may use endpoint-local DMA read channels to transfer data directly
> to an endpoint DMA address once both sides agree to use them. Quiescing
> an unrolled eDMA channel disables its whole direction, so reserve the
> complete read direction and route its interrupts to the RC when dma_bar
> is configured.
>=20
> Describe the controller and per-channel descriptor memory in a private
> control-region extension.
>=20
> Add a dma_bar configfs attribute. An explicit BAR selection enables DMA
> export. Leaving it unassigned keeps the feature disabled.
>=20
> Keep resources already assigned to a BAR in place, and map the rest
> through the selected dma_bar.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110082459.1798=
763-1-den@valinux.co.jp?part=3D5

