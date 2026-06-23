Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB452E7F39;
	Tue, 23 Jun 2026 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198096; cv=none; b=qFgDZjgi6m/Om5R0chC7CFoc8q4tnB7VOwYyndRnkLHDMnoW+xzTIxbTcMYiuYkQdBqLVqdzp4RNEbI56uNAwwyLEwfS40ET97PTacEwH6agRXDGTdF7DoBInmwQC7o8a1syzvkru91Q0i2h3krqacyM+3883f5Wr/QBkcDKIs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198096; c=relaxed/simple;
	bh=7NBxM3voBFbb5cTTxn6ZQe345j6qr+oyZIH1YXnBrsc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TE7jXu5+I4GdlsaJqWZb2Wt/F0UGSPc4xrukRHdx9/xghZBWOYyshFn92BR1w+wICxqsylD/60s01TwW2wEwcB1RDXOFZM48fEkecWuiIVnr+94E2oIqclO8YwP6KvL6s1bSRVQKesue/+g1E3DTbM+UWuKX0BDyjlC17QVdJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZwck+tk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZwck+tk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B5F1F000E9;
	Tue, 23 Jun 2026 07:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782198095;
	bh=7NBxM3voBFbb5cTTxn6ZQe345j6qr+oyZIH1YXnBrsc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YZwck+tkoe15spSmFuhwp77ImNeepMyP8eiEQ+1QbK8JxORe/gtIgP4CxyEK5q3Xi
	 yNXza35aNr0avLtJjaTins+WQpxhq0aNOuOgwK4ovrRHl+XQ3N/xOmmN4R0hnrcuot
	 XSXk+JIioaaxu9A5CazQfH9wKZmVdo/dTW3eFdT5Wl4y44z2Fj9jOw1B6ryTWKfc+M
	 38qe2D+ykaO13Bv8VvygSbsg/xipRuwT6Zc3/5EWReGgTRAvejM4Kri8dEMeHFJaS1
	 qOQ66snjixe/hi/fAGOvyHiAttUnWe2w6eeMDMab+YDh2KWIvMQjU3/mt1/dckCdPc
	 zhsu0xthct2ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/21] rust: add bindings for hash.h
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260623045406.2589547-8-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-8-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 07:01:34 +0000
Message-Id: <20260623070135.00B5F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Make the functions crypto_shash_descsize(), crypto_shash_digestsize()
> and crypto_free_shash() available to Rust.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D7

