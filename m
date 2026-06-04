Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C32741B6;
	Thu,  4 Jun 2026 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560000; cv=none; b=rCn9Kkl+XLHEMcyeXlEIWGPzlmuwOx9bM8TK3iNxjZcAOM4C9r5Ol7qda2mFrHSPyJmCX4MF716hTRA8CPqfd7yQJnaUWnKN/gIDHmp9f0t8bxd2w5+J5uQsSPWJo/gp9rCbCDSAD1GOz9NvFbvukvDXrbOvg/ryH9r7pXtWDjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560000; c=relaxed/simple;
	bh=vsXa3Tsz9ZOdJ1/hV1tgpWiHr6LJb2vQPgLnoj2kdjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eVLqESLN5V+O3ecH99+eKqvGckSMMb9/uECVZf4evygPqBjuzhRn5UC9dV0pbv5zQe1gCQ9c6MgCB5cyrqJo9oGMLzqMBzBqd6N4NRqo5B/g8JxQj3PE6B0a1buaTR0t0F6qaIfuJ4GKjTKuYTHboMxZoAqLipARj2ceAamQegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry7SS8tt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry7SS8tt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77611F00893;
	Thu,  4 Jun 2026 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780559998;
	bh=EiEege1qLpPLcLo8Q2GkcX5GrwEPGjJle4bMNZmC+EU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ry7SS8ttWfGim2vsSpXqAXGqjpIZgJVIfIVwGFw1DfT1UvX4dJexBmwrch0jagdS/
	 0AFwHZahaBfB/LmnEXJPiilCkvYpR6JUf8IdfzDfrid09+eCRB/s8soGLSFNORPqeO
	 zenEQvfVS621ftbfEEKP3p5ao787dGGJ2jmCRkRcadty2LkO2YgIh+iy+naKVqr4oM
	 T5EZC7uFTohrM3JSkRgs9wzVyWR7d3+8lmretBU+o9K/loVBkRxkWciiGuOxe04K10
	 7Q0uc5MIZjNE+USs+6mIOwGlhzlWqYOSFOlB3LPI3AuJj62hT6F92371vATdJdFGuc
	 VW856QbN0VlHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] perf hisi-ptt: Fix PTT trace TLP Header parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260604075005.2219785-3-liusizhe5@huawei.com>
References: <20260604075005.2219785-3-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 07:59:58 +0000
Message-Id: <20260604075958.A77611F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Relying on C bitfields without endianness macros breaks cross-pl=
atform decoding on big-endian hosts.
--

commit acedfe06d43ba61d4515f85b3f80767187e8bcb7
Author: Sizhe Liu <liusizhe5@huawei.com>

perf hisi-ptt: Fix PTT trace TLP Header parsing

This commit fixes the DW0 bit field layout of the hisi_ptt_4dw union to
match the actual bit ordering after little-endian memory extraction. It
also changes the hex value printout to big-endian for readability, aligning
with the format diagram.

> diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/to=
ols/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> index c48b2ce7c4a3d..67024f18ebbbc 100644
> --- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> +++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> @@ -75,14 +76,14 @@ static const char * const hisi_ptt_4dw_pkt_field_name=
[] =3D {
> =20
>  union hisi_ptt_4dw {
>  	struct {
> -		uint32_t format : 2;
> -		uint32_t type : 5;
> -		uint32_t t9 : 1;
> -		uint32_t t8 : 1;
> -		uint32_t th : 1;
> -		uint32_t so : 1;
> -		uint32_t len : 10;
>  		uint32_t time : 11;
> +		uint32_t len : 10;
> +		uint32_t so : 1;
> +		uint32_t th : 1;
> +		uint32_t t8 : 1;
> +		uint32_t t9 : 1;
> +		uint32_t type : 5;
> +		uint32_t format : 2;
>  	};
>  	uint32_t value;
>  };

[Severity: Medium]
Does this bitfield layout break on big-endian hosts?

In C, bitfield memory layout within a struct is implementation-defined. GCC
packs bitfields from LSB to MSB on little-endian architectures, but from MSB
to LSB on big-endian architectures.

By unconditionally reordering the bitfields, the time: 11 field extracts the
lowest bits on little-endian hosts. However, on big-endian hosts, it will
incorrectly fetch bits 31-21 of the 32-bit native integer instead of bits 1=
0-0,
resulting in corrupted trace decoding.

Should this struct use endianness macros (e.g., #if defined(__LITTLE_ENDIAN=
_BITFIELD))=20
or bitwise shifts instead of relying on C bitfields to ensure cross-platfor=
m=20
decoding works correctly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604075005.2219=
785-1-liusizhe5@huawei.com?part=3D2
