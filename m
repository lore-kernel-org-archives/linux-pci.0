Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079339;
	b=Xnb0vUSJFN7LYSZckDPdxtHszm6kgQQCtaMrId2HJi/D4XJsMQXZriGQ5vKyOAXXTyC8
	 DSfCW+uDECh8Awd1P+WRRa6araInMUPq7VmFYG8lTulr2ydsZhNfgQWcVJnn/mqk2xilV
	 tnJKT3pr4fTdipSrTwwslz68TExuhK3SoTr92bj97EuNSnQtx1ilZ/W7c8yxVQ4npfMKn
	 OFsxJg5iItoMPUnrWpydb760WysfvbgS+TF9XIJcL0TFB0goCDz1gzhQ0cQjXLbYO5zOO
	 Ep8V7RtMmQvoTd3Nj3a0iYQXbi/InXQ2NgYO7+LXk4BJPNQe09bLMLsGq794m/9lw7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079339;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=POdcUv6nbKzcrXTHxGUK5syo5pasbn/CbPrdtl/Q91Q=;
	b=hmnwG5Mw+BKTySpMQ5ygiQ3+DyR2IFCFp7jQyDZBklN0SoW+R8MUvIb6dswtrSsz/nl6
	 jVTzUyZW/BDKBdGKvqipwN5k9scQRNt9Utmg4GgDVAVUq0pRRqAoYoNRLteHabDS/dafX
	 7/0eCgcxv6MteZxIFbSNP1DFs/iPbOIrYVWKqdnoL2PrczuSBE0xKkXcX6qw8JFxm2xnm
	 KDj5Fg13oewaxhvmWhB3WyABShlwqdgmrqtyogBY79IN9bwW0NTYGSQ2KUpN3zbF85mQ3
	 OqEqs05ISrQUiIHIAPVU8uoA/8buIv/JCAjX31N35X7/+wYTQdnls+vyYKowVMPWlEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5Knr7MA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFAA606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5Knr7MA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B4B1F01825;
	Tue, 27 Oct 2026 05:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079339;
	bh=POdcUv6nbKzcrXTHxGUK5syo5pasbn/CbPrdtl/Q91Q=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=m5Knr7MAtnJtI6Sj8GugHCTofOCoz3Wh7IWhCOKkdw15imtmvk2gyKCClMU71sCAu
	 0q3fKduLOxjGcHacweseoXTmmKtX9jMY4ae4pLpOiJQwUXaOXOA9nuKuNJpDKCswWP
	 27TXjcYVY3IFo8c8vPIhyGPvfunBnlBkvTYKJBkx5e2CICjGyaFD2S46Yap4SWxbyQ
	 DBsx07ClJ2QIsj3K7qan9SXyvWhdEOnAbvC5jztD7bevOEXLlqJT0eXwMi0Sb7OVMZ
	 C/Mv4euNajXyK1WW4X96BMAssKp9/Q7ZXogWd/d3l2itlp5dAKRjbTLkU1fZRYm84X
	 Lan18iZ+a4HQw==
Message-ID: <sashiko-outbox-186126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/23] lib: rspdm: Support SPDM get_certificate
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261027052536.1722081-20-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-20-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:35:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Support the GET_CERTIFICATE SPDM command.
>=20
> The kernel will send a GET_CERTIFICATE request to the the responder and
> then iterate over all of the certificates returned.
>=20
> Certificate validation happens in the next commit.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D19

