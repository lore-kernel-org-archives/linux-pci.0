Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760899;
	b=aomaZgrUa/lGT62whakWb0CWCM1t1LaH+ARXTp+b5W4aX6zeX4E58cOCKhCM+Vj3hsRY
	 3o1pS5F7lVfSob/JExohAziLMXe2lu9u4nfSQUgZhbbYy/OJmKZLEuKMJw1P6PDYXC+Ay
	 MmFl97F60xbUZSwpbNXISRKusQ/goRKZhQnCzdpZnb+TdLzbjh2cdriMUQ9eRHqkdmUTe
	 Ztsj9OtJBjpXc9UUqzRZUysrZyaMyTkD/WkUfpN9YBwyw4evpAiAtcEoDBkLUJsdzSnz1
	 EDSFY0lWnD2WwAKvnozdhJpljyjWs6nDcDgKPkmj8JCW/YHGQE0A5kExRfbgqDvoWYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760899;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DwQVCtaGZLEhCrp7ir+4oyNgvTmaUgS1QbZ+jPNp9Rw=;
	b=0xO/5Kg6ByTzK9KPfS2/Ms6DEY0AFtjH5rHqDFPX9LTJ7MKaN3QhEGENtqIcYlRTpUbD
	 kZMqG+EdfRxdt6XuxV6dFDIZYmYbHwA30ecb+WveNrUCbYN2wu9vNNwtt+pVSb1iRUB8e
	 zQQbXtf0rD+sZ9pYJQhjndbfInHFXzav/DXmqEuHIAlZB5wUWk6EgVH0H7nR1Pv4wV6Ed
	 gVijG96o+KpSO9gV2Vk5ANh7QO9vR8IUzKTbBCKW5DRmHPnFosxnUwKd6ECfzD2/j/aAU
	 qhLlPtCzN3yPeeOXMAbx+iy2slf0pNviN6vnA2XX5+0r6deEbEAhjg52d5IBoUvK/Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzibyZvF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9475606A329
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzibyZvF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E681F000C1;
	Wed,  4 Nov 2026 02:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760898;
	bh=DwQVCtaGZLEhCrp7ir+4oyNgvTmaUgS1QbZ+jPNp9Rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KzibyZvFYKxdeLcS2JlggUl2tCCuaKW1PI7yZVn9ANrrB2qbaaibmntUnPJ78eHyf
	 IsvuNgaFQAkOonGRHk8dZ0qDL/j0uP5lj0j1PdYOy80nJY13SkW7U/wBx/722t6mjR
	 Fb/vW6XoZaMY2U5QRqs56RTxWWgry5jQE0leaKXG5a5ldxMFzxYyphIJZVEZVp6U8t
	 ObLW+gDVVxWEc7+vQ3Z3IE2Svg8cdib6HLy7VIKpHun/dbocTzPw4A5rPGiLsEytIm
	 sOkC1om1OKt4j462IA27KyK+cDSJr21Dmfx3LLMn+l7XVCfqxdUux3ljjr62WFM/0a
	 7Kz3laBy1o3Eg==
Message-ID: <sashiko-outbox-196544@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/25] dmaengine: sdxi: Feature discovery and initial
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-5-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-5-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:54:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Nathan Lynch <nathan.lynch@amd.com>
>=20
> Discover the stopped function's version, doorbell stride, supported
> operation groups, and context and buffer limits. Apply the driver
> configuration to MMIO_CTL2 after function preparation has removed
> inherited state.
>=20
> Add capability fields and device bookkeeping. Report the SDXI version imp=
lemented by the function.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D5

