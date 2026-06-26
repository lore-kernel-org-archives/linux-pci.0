Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55963F411F
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475599; cv=none; b=Qbrl3GQZKQDhb2aqXOX2ccTl8YL7KvnWQ/AStq9gIi01niU5g04FE72JbaDNEvleY+LJaa548ksc8PQkPm2NkD3tA9fvRasZPSVeBq2uLOkuFkWJO301DzBPOAkQQSUcMJzorp262NeCBruZ0NsxGTuDnnLULTVNIJ/rzf4jWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475599; c=relaxed/simple;
	bh=c6N4Y8dYVGHjF1jSlBCnl3zkzSvsvF2JtwH93QQvtPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aZJu7hyFzH0i/+r+Jv20S32zBGblgCuALYrSWrYsp5OhB2bJhFdq1Bx6ai2v7iQqFM41S9hIP8/GqucENpNzF4ZG2bhq/IR3MazSxNrq0z9fsqCGbUp5Rp14cGJIcOcZctK2SWiYUmYVbENPrVUFiwKcXqaxovIYRKIjC5JQw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvxIEU2E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvxIEU2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9831F000E9;
	Fri, 26 Jun 2026 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782475598;
	bh=Ebfyh62a+4cmQgbyCZOBJwwzYGPxadkF96xyvQ5+pd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dvxIEU2Ehsl2WQSBqM5ZAF29JJ4jUDbsb0bJivkBUy5ZE/FlpnNSdvESnrpXD+fLw
	 vOVGf259zwZDeRFRyDzAeOglbUSgWVXyz6Nbp6N48nlds5A3nhwX12LyRdjPUsS4Hl
	 YckIOZMfCgLb+VQoNyEa+DZivFFZCQndpw9MGpDg1BKT94GszCvMK5ct7DceC+n84C
	 jMU1stoWnGlUmGdGXMJEk+iz0mrMHd7rHlHOMxYlXbmt8JslZCWXGHbfxfrbfwAcku
	 DXciuAvnEBc6wi/4WsRzR+9r+Etmj76O+TU1TdwSZJwNg9Nz0NCN440Hz1e9HaLVsv
	 DRnDa5tP2CPpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 5/8] rust: rename `AlwaysRefCounted` to
 `RefCounted`.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260626-unique-ref-v19-5-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-5-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:06:38 +0000
Message-Id: <20260626120638.7A9831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Copy-paste error in SAFETY comments for `I2cAdapter` and `I2cClient=
`.
--

commit c7fe859c40ffae9a22f5e5fa80c3b5a426e7197d
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: rename AlwaysRefCounted to RefCounted.

This commit splits the AlwaysRefCounted trait into RefCounted and a new
marker trait AlwaysRefCounted. This prevents the unsound creation of an
ARef<T> from an &Owned<T> when types can be either reference counted or
owned.

> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 624b971ca8b0b..02b2c9220eb11 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs

[ ... ]

> @@ -435,6 +436,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>          unsafe { bindings::i2c_put_adapter(obj.as_ref().as_raw()) }
>      }
>  }
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `=
ARef<Device>` from an
> +// `&I2cAdapter`.
> +unsafe impl AlwaysRefCounted for I2cAdapter {}

[Severity: Low]
This isn't a bug, but should this SAFETY comment refer to ARef<I2cAdapter>
instead of ARef<Device>? It appears to be a typo from copying the
Device implementation.

[ ... ]

> @@ -511,6 +515,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>          unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).=
dev) }
>      }
>  }
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `=
ARef<Device>` from an
> +// `&I2cClient`.
> +unsafe impl AlwaysRefCounted for I2cClient {}

[Severity: Low]
This isn't a bug either, but is ARef<Device> also a typo here? It looks
like it should refer to ARef<I2cClient>.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D5
