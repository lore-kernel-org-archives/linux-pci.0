Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284831;
	b=Y9ovBbjerEtYYuQbc3vXyk11KyLUYjs8IZZ6j0WKo64thhF7pN5UvVX/Fy1e4azulDLf
	 wWJNdVLyUhwqLGasIQm0rpLIf7urCL3jIjOM7luTpxeXczR4E+KgKoJfeQu/wwfv0w/Pl
	 TseJbDZHJctRUSTUikZcjRTbfL6mU+D6uZcSQUv0gvxPo2kZrIYlUl6uZXZ5ZHRiE6Vwz
	 Ee4TAj3vtb+FaRH1Ks3eNfdZ7X37kaAXfLKCSXzK+i9uLA62lVN+3zmsk4R9ijFg/N4CW
	 h7cG5AfU5NpajkQoLyEe6FPRSw7x3QRnseO1fUM0MIR2zs/4NUNQm7gUAs2LENJfaHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284831;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TqpuVA9oBmyuio8eKkqNIcXC2SzEnAD54RP9Z5KSdl0=;
	b=fVb3bGhiad0VClLNe5cNexKymAk8sAa4cGRYshxpN5NQ1fG7MbviQrrQ8wZgHXkrYLG/
	 SBh/FUvU8fdNDZIj3tcE6k52X4Ll+Q1GNhVHpDisMdYp/ncNLaZrEfUVUiS/tBsgjGtRB
	 cAohIxsYAb8vjRPFdnt3dIuR6i09kFPyzAvy47ngWqpmwgn1HHsTZg43DxNFKfj3g5pZ+
	 Szhn5OOWZxbZH1vWUn6fWKnuFaiU9S5qsYx+c3L0X+IzIyFubuxo0ixGUFPuh5gOeqL0T
	 KKfEimJCPbQnIYNPdeSI6EDG9+y/I5xwHgUj+goYYy9Zyw7ppLc9zS/wIT1jjT+0Cqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jfAj/V4o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC8606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfAj/V4o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DA51F0089F;
	Tue, 10 Nov 2026 04:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284830;
	bh=TqpuVA9oBmyuio8eKkqNIcXC2SzEnAD54RP9Z5KSdl0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jfAj/V4owsW6v06GHQ1B3nd2ZvKlcMfrh6zAY50dBYv1Z7RIaHPG9sJYpdfoppJe+
	 mGjJpArfl2UMJwB9Dnw5n01M5pdz7R4NKtFEyH9cdhS8WJfvghwLr8YZNmmHa/PTEG
	 ZnjmTp++lF+hjyAJRX/N/w0bvq9uNRH342awzu7wQzIZUDVn4Z0+U9O1Hpz5u9XNjl
	 YjtcRQcEn9oqgLIXmBnkTzGhE2EySVMWvqWIG7zjij/JmKzXdIgnQLV5IBVi8b6rBZ
	 42k487+Bq2IKtwJPSFBuczdc9GH+A17JkvrleINwlvsSJ92b1tSVi8BWHgreczxfKd
	 Ia3YTSb+odpAQ==
Message-ID: <sashiko-outbox-206199@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/25] virt: coco: change tsm_register() to use a
 const struct
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-2-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:27:10 +0000
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
> The tsm_register() function takes a struct pci_tsm_ops *ops argument.
> This eventually is stored in struct tsm_dev as a const, so we should
> just change the tsm_register() register function argument to be a const.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D1

