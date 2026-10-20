Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484016;
	b=jBwV3VCVBzU9VZ6C87WC6cgZtKHHH29KMwXHeKfhSFz2gIEq9UJnFIVWKyHgZFJe5IIH
	 quMURdbnSldNEemdURGCei8D3ZXX1QwRh2U1A01+4R8xH2B7Nte4d47m/Zfh08/JnJ7/P
	 9ubolFKluZa7PHWhVqGCg2oGlK6UYSyoN1liPFJNWxewEcm2B8cBgCnsmbRMsM/KqbD+A
	 kOicbxKZvDbWAGgIe2UsKsEQfAsO87sWsqjmZVemj/scX9FtT0eqq0fdjYxXSPvORpa9m
	 rSkFT5LpdPuQLdXFXKC1uwO/dzkrzpgDNoNTlI1HHmBLd3uIj3DoU1J/MDSgr8u7LuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484016;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ftXmXGgk7rMRAS/qfijLIrIgEU+U65CyY8/rE+wcJsM=;
	b=XcYBf8JuH4ODF64IF84jiq4mCWju0mm2kRG5t3c0qnz23SXfYMJbbbz31+0801UAbYF2
	 JALCKXfbE3ADvQ14bsxKqhg8ugsAQuh0YjAkIX9B/ar8OQbwi3uQk1f1TuMwAlHPvUeRk
	 HtzjHOty8ylKHbhPGwhXaIRt5UBwMZadkf8iGT9/PsMa394ri50Tv6rFyTia7coYBbA2D
	 x7InFS4bZEpvzniWoHLkz1EpEIesyydYW2REB35FalJLyWpFbttKpoqthZsOAke8JMdAK
	 dQMq40m9JUJ4gov+08C8IiguuL5jGoYzTcKJrmJ4M2dRd+MklhhIN/RFg/kKKMV1xrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dUj7/Hs7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6806D606A31B
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUj7/Hs7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3FE1F000C5;
	Tue, 20 Oct 2026 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484016;
	bh=ftXmXGgk7rMRAS/qfijLIrIgEU+U65CyY8/rE+wcJsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dUj7/Hs7WcjRqdmRN40yZd5VAnNKvo1EB0fWjH5XfKeIFzTGXMdfCItTYZRUCERNQ
	 TE8JGjV4Y16VyOj5lMf0N6z8y1hNAMqi9QuW2MKqfvKuqDDkTtq9eBJMa7SV5Ml1IU
	 FVameVYJH6KyNjyJmJ0s9R6P16kzeRaOUsK2kgff0g0myt4z825GhPDuNyLZedqczV
	 9gez4OKpz0f59bMSNBgpIe2MxtJN2cRLdjBCQHjfG7wX9M+qw27A1YTHZIhXlJIcnp
	 ONcc283dDkqdSHcFcTMRVRknckwRv/blDSJbnUu6LK/FTEytS1Dk/l/ydzcELmFL9O
	 R9Hct3fbqEAig==
Message-ID: <sashiko-outbox-178496@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/17] dt-bindings: PCI: rcar-gen4: Add optional
 "aer" interrupt for R-Car Gen4 SoCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-5-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:13:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The intreq_pcim_lperr interrupt carries Root Port AER notifications,
> separately from the integrated MSI receiver interrupt. Describe it with
> the "aer" name so the controller driver can use it for Root Port error
> reporting.
>=20
> Keep the fifth interrupt optional on R-Car Gen4 SoCs so existing device
> trees remain valid. Extend the example accordingly.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D4

