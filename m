Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578452;
	b=Zg87xzmfWCbQcSfAFzVrT84h+7dWQVi96qMoyoApnyCUSvU+GKhQrJZ8hicjZlYjvwSi
	 1FwQYDunl/8o49A44N9bF4/DmBUFXlO57XL+YHHsd1n+Hd48NPKL4lGzRp5CbzUjw4HqE
	 BGp+8rPXILzI3UuhzWD5YBmXcS04pyg9XT01ZCOP1PXHgANsquyVamF5M0eJws2OvF3tQ
	 XMBpIxxK61GjjlYm3Z9KPMVJkTN4akniS8leidU6xddRBfVYuvym3eWX0k4spgTq5iWrW
	 +SZwhXnpEOaV7dFxIhJOB8MRJxJ4JMP0FeO66dhUQ9JrikbvBGd8FtU3mHnE+bl8WWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578452;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xtrRYrZ/TB1HTwb6WnP1Xaows0xWraY2S4LGj/N7blk=;
	b=3RoRnTTXSohWKzLIz2+qqj9dH3Lrn1pd0G8dbyt0KRVWL8MYKvDgE8S/62qyyqFiVVA6
	 c9flsc0H9fYWZHqT6sVXvYwpAIauIQmmcFUNkhnA2yHBU334t2mR2S/GKC6QSnL3ynlB+
	 KI+jzOAn9hctawQ1Cbe6ctNci6YgqKhhIXiya2sw6qSzZ90Td7IFLgfIw58BSNhosL6Qf
	 a98CoYMPr7okekPOAsZ1C+uRZWi2RYt9WbEH9HehapF+vndGCDNute6eRm6osWH8s6jtX
	 9L0k1i4FFtL3VjRGHcHYvcpyxyJOagSJaes7ntieVjCqR7EnS+QgzB71d8oHYbbpWdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FwKX+S2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08768606A331
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwKX+S2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF9B1F000C5;
	Fri, 13 Nov 2026 14:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578451;
	bh=xtrRYrZ/TB1HTwb6WnP1Xaows0xWraY2S4LGj/N7blk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FwKX+S2/I0hZTrZFMwmA1faYHbxTCqACP1B2IC5jtL2fkvfSn1MnZQNSEDsOrLnAK
	 00Ps9cD3CtnmEBWhOWTG7tAp/xDiVTpkW9YLBgZy6HLUaBZKv397jXF7jUiHQSMEvY
	 9xzDbzhK1MID7XNRO9CzRSKZ9VC9RejNffi3jAtQR9PX4yn53hdxtIBtIv3812EIjM
	 pkFgIHDz1cuNZt+sbVeJ3KJBb/YMaiWGBnXacCVXIMXjo8kJi0IPh8fXc2DJFQ4itQ
	 d/coP/vvbib7KCuVH9dzdRVMI8CO9wE0+UI+jCUuL3a2O81NT0IL7EcNFOLyur8CmQ
	 So6cVIzvWW9LA==
Message-ID: <sashiko-outbox-212945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW
 to share a BAR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113132935.4152566-7-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
 <20261113132935.4152566-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:00:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Some endpoint configurations have no spare BAR for DMA resources. Allow
> dma_bar to select an MW BAR and place the DMA ranges after that MW.
>=20
> DMA submaps have fixed BAR offsets, so a shared MW translation must
> cover its configured size. Keep the power-of-two restriction used for
> ordinary MWs. The size must also meet the EPC's alignment requirement
> for the following DMA submaps.
>=20
> Older hosts treat the whole BAR as an MW. Fall back to that layout when
> LINK_UP does not advertise MW/DMA boundary support, so that NTB keeps
> working without DMA: the enumerated BAR size is kept, the MW spans the
> whole BAR and the DMA submaps are removed.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113132935.4152=
566-1-den@valinux.co.jp?part=3D6

