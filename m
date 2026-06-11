Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2B47A0A2
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198141; cv=none; b=S3hq6E+1tMdQ8uS04fPre9RxzDB3P7Dz059n/ysYLGU/sspUXVEloemjhSq5bdT/Ndb6dgIMqaGdBchsZ1POcW5cAApbG0qPGkFFAts5UY6lAj2F4wyGyh9b9lA1FZXxP7SKdtcceiWOUFtSQ1Q3lDRT/nML4wVc10gYemwiL48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198141; c=relaxed/simple;
	bh=QO4yYN8UOAMy6nyviiCynbXrlRqjsDG39CTcdT3ZLxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k4SRQLg4h+19OFNHtMxlCw2dGg5hHljTA3Fde9TyQORcy8QN4k+e5F1Ac6LTQJwYZJLF/I6fxiZKfe5kW+CP2/aQixFHumIuX+Mn7v9cNYNyTH/oXegjo3ez03BAD/HYSt+3+xjpIuDOyjngpUeERAfxp1yYjcrwUX0Og282m1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnsOUic6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnsOUic6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C9C1F00893;
	Thu, 11 Jun 2026 17:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781198139;
	bh=JLvdfWSCm/54x6keqqqX23HM8ntLWBTzs5SmYTGEFOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LnsOUic65IMYyuSdcKTt6UP2YGpm+frbZvhqgwgIJTN6HqIvFRxNBhJAVmlhZah7I
	 LoN1UC4VQSJD+fUbuGJEXLBHF1Z2DYsXbnAFm+gQNV+Ak5XxgegwAFyZl2cv0CtYNL
	 4xxrxxAQvN8s7bUS+ObjoJML4Mbyc6iBOVbV1X2jPshBEEANcJ1tTteJY4DLg/zJed
	 WnNFXUZ2v242+Ih+2GJbdAHsxBuGGdklQ+E4ISb5dGJturoTVVBZj6xscmKRVmkcvh
	 0V8TlOnpzQqV7zK9Tb8yUV3tko+bUVtJ3VHx+P6IgOeVme5XpoBY6fBnQy4K6c2puo
	 5V7/5+B7szUVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/20] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260611-io_projection-v4-5-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-5-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:15:37 +0000
Message-Id: <20260611171538.B5C9C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Resource leak of I/O mapped virtual memory in `IoMem::ioremap` upo=
n `MmioRaw::new_region` failure.
--

commit 341339f8ea263586994f368a12f84cd531475a2a
Author: Gary Guo <gary@garyguo.net>

Update MmioRaw to use the dynamic-sized type Region<SIZE> instead of
representing compile-time known minimum sizes directly. Implement Clone,
Copy, Send, and Sync manually due to raw pointer usage.

> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index fc2a3e24f8d5..9e15bc8fde78 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs

[ ... ]

> @@ -264,8 +264,7 @@ fn ioremap(dev: &'a Device<Bound>, resource: &Resourc=
e) -> Result<Self> {
>              return Err(ENOMEM);
>          }
> =20
> -        let io =3D MmioRaw::new(addr as usize, size)?;
> -
> +        let io =3D MmioRaw::new_region(addr as usize, size)?;

[Severity: High]
This is a pre-existing issue, but does this early return via the ? operator
leak the mapped I/O virtual memory in IoMem::ioremap()?

If MmioRaw::new_region() fails (for example, if the device's hardware size
is smaller than the statically requested SIZE), the ? operator causes an
early return with an error.

Because the IoMem structure is not yet fully constructed, its Drop
implementation is never invoked. This means bindings::iounmap is bypassed,
abandoning the raw addr pointer and leading to an unrecoverable leak of
vmalloc space.

>          Ok(IoMem { dev, io })
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D5
