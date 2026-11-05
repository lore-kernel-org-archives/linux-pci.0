Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905654;
	b=gAxXvhrjQkp2kBfwp2tax6RljjIWYOsNjAKsqnh6jfDp2JKqsYseOEJ0UTpCBhSF9cxC
	 n/+N4lG9w9KZCWzh8V4N0QQDXzKAWrda3RXhrI/6gc7lgRwNzxdyU/rXIHTTd98s97Ksc
	 z09OoMYT+8EsSUw5VlJZOvgJ2OO7Yk1DtYkV3HFEENHIjsQWu06XeCnK9lSbaHNS5G+7o
	 oC65A/ENWeovY27lVcDgwwEoDHCbVnGtImA2FWMaa93UE4p48Mqn0a7JtfATIbzIr+C7D
	 yHJ9mJWEfpUlkY2nCRf6fCQnhd1UlukZjmseZrehCU516c4cxn5QQG2J9JBuCHtZGRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905654;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uT9XJkWxSXoJd3Cg6EUziYLEhyYsL0dIsON09Ial4LM=;
	b=09sk2oz+bFy4lVtpw3hkVIKIQj9oXYJrCed9HvtzX0Q8CIa1qVesCCcHUxRtRL+rkUyS
	 pssxOj/pZCoGuPV593iHB9/asRS6ekPwOfqufR81cNPgNupBd4hMpJh9vztfmyyvZ7TyH
	 QoC8r6IRa+ssRZR5BZfogJocJb1j8DzZCXNdgsmJlwtuP5RS9PdHv/70zlbndj/Uu7Zcj
	 n76GuftBKSHFoC3RMlYgVNZEhu0dgMUXw7VI4wZJzMPZoiZxiA2mXRfJJjyrJ2vu23EJf
	 3aefsIDjoeVH++y5dTV/fsjpvPKGByq3iE8GjzT+GlJbdcy9tMSWA9iaTip4KnuOq0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBQ4Cp3U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED88C606A32D
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBQ4Cp3U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9481F000C1;
	Thu,  5 Nov 2026 19:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793905653;
	bh=uT9XJkWxSXoJd3Cg6EUziYLEhyYsL0dIsON09Ial4LM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jBQ4Cp3UTZPELNYC8qj838rnWXQ7VXKGGxoAa0N4YTyWu6pvMMBHsgRQOnqrxXxc5
	 8E8NlWG5ugg3gUFbX0Rsf6PQLrMRKLQKC+a00LEzm/kBCkwt3Jy1DVVZiHmAsKxfh9
	 Tn5WozD8XPeWUdN8VH+qu/GdjCaIAyhft7G/+hW4ePUXGE82/ovYgzX0QYPHT72mbV
	 /x4QdcOPTKER6frd+kec8KCTFqbuet75jJD3aSxp0WvVmM0ZSGRQnr8w2sT209VuG9
	 +XZqTAEQEXmMtb++N5CastdPMbOPnjw4kiFdMy93RZJnaV+X7h26lz+GSMJuZU0Sg3
	 AqubetYkcTCNA==
Message-ID: <sashiko-outbox-199810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 04/19] cxl: Embed decoder configuration in a
 standalone structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-5-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:07:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Define cxl_decoder_config independently and embed it in cxl_decoder. Upda=
te
> decoder field accesses without changing behavior, so reset snapshots can
> reuse the configuration type without struct_group_tagged().
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D4

