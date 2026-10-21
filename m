Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587409;
	b=YvDJaapIc7bfp707SzYe/83ZTeHb892oKF5jj68nw3Eq6CIzNqactHnoiFNCi5OskrlG
	 01kR5HoOMbEWpHS6idXdpJCKwe9tsGOprHY4km6UhonqsiJOmUxPzVATk2nza3F7IEjl3
	 D7TfwkjgQxbkA9mPlP7UmIu64/Tw7t3jqKMNMceV4+oWfCOdi7yfJIV5QTwoNXEjduQzL
	 HzJL+30qtNwlclUukk/+YPoPAlgoC3qkHeghXQ32l/T/cmTBRXCeJeJtm7YQthXeqH2S3
	 LrPnwpHmhc+O+f9ClNgBnz9zZh/bPely7pS6XCR33l+15nOra8kgy/g+IEnfQj6VhUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587409;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Srnd/blVANrSlLApqKVPKXg5SzM+4sIuRjiRVD8tR/M=;
	b=I3wWKVR+HMfF/N1Cgdvj0UKrcYc2QqkBYqwZtcGSixyDETkKblmXK3AQ/QOvMlCntJIa
	 QuMDyVcEpaT1DrppVD/h8A36kvVN5PIx1tdN30gVxJrAaUSjwScKKROH/we8Z5VCUapJk
	 uH33v4tcsKLQOO8e3GxLSMsLw2EHCi68/wyUdTX1O3RHJM+c1fatiLIqahSdGXpeMhH0q
	 Cs35buxia8lz6vW2XQ5LAANCE/RWSjN+OcPUkyubiEC1J7wuTFtXk2c6EG+xPygrsNkqD
	 JcnFDorgvpUBGOPQ2j7zYk1JLX2jaIIlNnOYU2BAUN8R0cokqcp64Fpu+ZsdLci6mCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msHLYfsO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B389A606A31D
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msHLYfsO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303A11F000C7;
	Wed, 21 Oct 2026 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792587408;
	bh=Srnd/blVANrSlLApqKVPKXg5SzM+4sIuRjiRVD8tR/M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=msHLYfsOBQ9v+ZQKzthcptQnQbtEpo+N0TcfdBE50YpUh38oS4k6z+KRTRQJrNH4n
	 nk6iOs5qPGyE2IhjW8iFferHnZQ6pv6zhRgfbMbkHcXUA3Q/9x9ocbSiGzqjCSbfWm
	 POYX8m1Yyj8zQXQcaMfsSODiKCKn/TYH5I6uHv9uW5OCpDuNmWYVA9FrchJEA4SKeE
	 4JiZd+AVKT+ETd0LT36pS+IxfwoIfKLmz5ZHfKo14kHnRNyChW0x1lTkZFbf8FIAlO
	 cJ7+T5SE508RMamhRERCroj8TmefxQBEjYLtkyXl06ucXkPYPTcUpp+1YrtiUW7hej
	 Fsoymbc8vWyBw==
Message-ID: <sashiko-outbox-180282@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] PCI/parisc: Clean up resource debug print & use
 dynamic debug
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261021124956.4250-3-ilpo.jarvinen@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
 <20261021124956.4250-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:56:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Remove adhoc RES_DBG() and use pci_dbg() instead.
>=20
> Remove printing parent resource as the passed is a temporary resource
> not within the resource tree so accessing ->parent does not make sense.
>=20
> Reformat the message to the typical format used by PCI core. Print the
> resource using %pR.
>=20
> Correct format specifiers and remove non-sensical res->flags int cast.
>=20
> Dynamic debug prints can be enabled by providing dyndbg command line
> parameter or through /sys/kernel/debug/dynamic_debug/control so this
> is more versatile way to debug things than the previous compile time
> decision which could only be enable by changing the source code.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021124956.4250=
-1-ilpo.jarvinen@linux.intel.com?part=3D2

