Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425990;
	b=eZc+wj7tw316YkWYCzfWseIFHcz+BH/2nXwLG/qOIlhEeKP2g9AOj1JuppDN25DJLt1p
	 gp6QBmEDRL+YOjRxzJAXIl3n63qyBjoiIt85Jyc7aURk5cypOxT5gn15YF4yiwKqP/7bE
	 DGs5N+Hkj5SCWGcuXKFEozt99hbyKCeG96XXr1T9kHIoob0mdEpB1kzxuzLekGA/q30S+
	 dIm6UmFHOSXffxYMqexpX9BioztgKx2IYc+irgMp/KM+jTka2/zVKuG+tIM+ErIjppsu0
	 L/VTcyz9W4pdbAgu1jTBLLhCgnsMmYz34W3ca4jFIR0Fhwyp++U/c0KXE7nmhA9sCeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425990;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m7iqxzOaOvIy+p/xUqdcUs+aaVf8y8pMTVLLIrRmDu4=;
	b=ApI6BRs5AVzz183UIimySDDuyWN2Kt/RkupRGBcqHjnqJ8mPF0exSB518pg2oxWlCTVE
	 Cw5lIVeBYNgl79neQHZZxGfocJVK/M84xiIzCykAE4IP+Eacc9+n/phx4GMiileQXoOQ2
	 3+s4mpFSyX26KNInJ6AHbzurMK9YI6Y9AXHNLF8M9+veTwjnoudJAjVmKpkSGhvLfJueD
	 lWu2E7ZYkoxdW8/mkL11UNLFHjv53RCN1ENq6BrXsKjt8Bc/KbtD8BCmolWuwUCmIHPQz
	 uHlVLkM16I1GFrlZYTS8ijpEzDu+pCBsUBN0eQ8sFBEtpW7mpTO5yfnUgGCYVUeJZbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d/W6lrnh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE18606A31C
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d/W6lrnh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAD91F00A05;
	Wed, 11 Nov 2026 19:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425990;
	bh=m7iqxzOaOvIy+p/xUqdcUs+aaVf8y8pMTVLLIrRmDu4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=d/W6lrnhaCjxwt4Rz4UBryrYpN2e+kUpAzND4Et3TwDyk2TvEcB7PTm4pjopAPIt8
	 XzgYkSD8XuaBEFdHDHtghAY3ys5f2kRLwhTgEy5cUhrm0FaGMbAnhJapqFyvhjQ048
	 GJbHuAVwv4vNwSsnSBjJh3Z9LqT3Nt92yZ5e22JoHTGd+dmp5wgFHwsm4B/eTCfQmc
	 WPqXK1sXu2jM4n//uNx70lLTXp9VIuwG1r0EyB3ffr8OyzQIZ4wuZLauKyXhUJgTxI
	 J6wMVgsUYwf+RwkFJBUPov4diHHLOpRWG3oyke0N6H7mPrvgkj+7VAAzqY7FokpO+N
	 csedNYZ/rEyKw==
Message-ID: <sashiko-outbox-209582@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/7] vfio: selftests: Add vfio_pci_find_p2p_pair()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111192411.4133780-7-dmatlack@google.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <20261111192411.4133780-7-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:39:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add vfio_pci_find_p2p_pair() to locate an initiator device with memcpy
> driver support and a distinct target device with a memory BAR of at
> least min_bar_size bytes from an array of VFIO PCI devices.
>=20
> Factor out vfio_pci_has_p2p_path() as the central place to validate PCI
> topology and P2P DMA reachability between the two devices in the future.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192411.4133=
780-1-dmatlack@google.com?part=3D6

