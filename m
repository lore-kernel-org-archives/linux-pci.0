Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974791;
	b=nHl1aaZmrpuLK4nQPlYWrESJcI50QnP05CFD/b0ZXTZ06qBGdJKusblbBZWKErtzqXzD
	 VA8UjIsgeEN1yUVnUzmO09oOP1QDQ80PkKDaKe9JKN3IdVpmcxU5bN3xYZNUbgHst0zo3
	 9n5r/k8+fMbQZcXfgHl4iZXAwzA8bDCwV9Bt8dzkpxx0NbsyuqgwZjkmGIrpwtsuUhuMk
	 Rv8bfaHc8ZVG4fsTQ/m/D17gbNVw8AIswuFyokURfxcfUNH9x3fzTQY6ItrmgTvfKxprd
	 Egsw8QnV+pEGP7LwQB8SC9KZW4fRl+vHEUuH9bG23vgq0Vp2hwbhc4g7CQ8EEkzTiBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974791;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oNiNcvNOOmm29lVWmVuWWrtk62mGJSmxgr97KUVSu38=;
	b=C1Fcm1+O6NH1nkqjRNb1eoZpJlZnVZ6yR8SJKi9TB/Ew5Xr2plxsHvKdztL1gE9Z7YrA
	 SYIDpSvIQ0xwrqBOoaP6ii4Y8o10uS5MTWMQVEVEOuk1zE5l7uEIZ/z6RNaTMw20Q+AVc
	 OAYJJXvY+zIgWvoVg/jsJqvJFXJYQ24SpIg37t2/JC8HTa9q2jSN/2BbRV+dzdStrBKLv
	 b88RQaDXhlENxJNoVjdM1fOtt/x4OOjHj0zCMW61l6EKKTxcQ9k65I0qCIhtP1sawp7Yl
	 o5k2I5fmpolhwAwHz7clbA3TB4dEQytIx6D1NbgULjOq937J55SaQ5Bi6UQkMdkZmyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RW6ym5g0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D973606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RW6ym5g0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B511F008A1;
	Fri,  6 Nov 2026 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974790;
	bh=oNiNcvNOOmm29lVWmVuWWrtk62mGJSmxgr97KUVSu38=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RW6ym5g088zDftQlnC2MMh5u3ioQcucKb7gvJP6APYzfHzI++4oo0y27YLqdC3QyZ
	 8cK9r9NxHoTQe4BaqWcuIM/5mrjV12tdJd1GglTOeBIvCZjK5/JPVSGk/bi4FsV028
	 OBGiPJ8ZdCVT20lCFbCjxGE6QOb8DCPBb3AzGlQCfK+2mjTvOJi6YrZl0lS93D1J4l
	 K1wutPQWjKad9j1vrudKFIK9gWikAAgckM8abvjMV4WnyobbYEf7WlTKSRBT43FkOa
	 khpIqlg3Qtv9wTslA5X1/jeDAJWpUmQtWPm6Y4WwBkahubUIqPqk3lCF4qqPPFMDWY
	 fcHzPKIOQfc5Q==
Message-ID: <sashiko-outbox-201566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/14] linux/log2.h: Add 64-bit
 roundup/down_pow_of_two_u64() variants
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-7-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:19:50 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Generic sounding roundup_pow_of_two() and rounddown_pow_of_two() are
> internally based on fls_long() that limits types to unsigned long. The
> type limitation is unexpected and undocumented.
>=20
> Worse yet, the typing seems also inconsistent between
> __builtin_constant_p() and __roundup/down_pow_of_two() branches, the
> former using full 64-bit size and the latter truncating type.
>=20
> The most sensible way seems to be eventually changing types such that
> the return type for roundup/down_pow_of_two() is the same as the input
> but it requires auditing all the existing callers that have mixed
> input/output types.
>=20
> As a stopgap solution, add roundup/down_pow_of_two_u64() that do not
> unexpectedly truncate 64-bit input.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D6

