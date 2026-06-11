Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D84968FF
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203062; cv=none; b=KdptG5KlkgJ8+NeqSwFYYXinp1bPYebdaQldfi0KAP/lbuQzt6R9a6LCsU/Bcmc4gMLheO7DxXMsljOtC5oEHAbmBCNBUQv6m4SQ1NWXWu4gkC6l9uQ35vKWplZdKsoV/Olnh2JOnny+HS2394AHgRIFVGGBcFf2xQQ6mWmYUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203062; c=relaxed/simple;
	bh=Ft1ihQMfKPgKz5iJY84BNeV3QYrti5OcakjOiiYmEkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vEfLInpnvSZXl/sSnBO8AB4r/vhPCBMXtNVaBp/xUCrVDmvdVnSh5v69a7Al1Qiw9tc7ZLyds62BIAyFR00kf+1CB0oX78SYF4sAbQ4Hma/SOCX4QMVWW+ZPIGN7U6/TM0O4gQz2btgNHI6rmjgE8/lCc3KOPfjwhWqAIT3yGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0azF+7T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0azF+7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C70D1F00A3D;
	Thu, 11 Jun 2026 18:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781203060;
	bh=Ft1ihQMfKPgKz5iJY84BNeV3QYrti5OcakjOiiYmEkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K0azF+7TawBPLeB5u8uUV1+lNWrFKIldC0TPXUQLjhxgc3utwp0sFjatFDOByMJnW
	 llQ/wZzvzP0bES1hw/Q0TWzngCl4S2JZBCTuLD1dRJxs29eFQccEktbGvJvb+ImyEX
	 S9+1tCZaS0KrP8Pia4y6II59NvNO7UIBtas1Xu/A5Gheqdgftjb7RbHvV70/1QsT70
	 RUOtVQqUgs+7ydfGTMrfvnf4js5J39nT3ZjdpKpBFXg1lp6uzYQbk/HQAb5gExTCop
	 JqZCs8bEH92S2S/3x2fzSAy24WWs0jo8pfpwpDS4laoHYYJx49XUJPMQG+M2o+AcUT
	 Yo3tEkigMjcqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/20] rust: io: add `read_val` and `write_val`
 functions on `Io`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260611-io_projection-v4-16-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-16-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:37:40 +0000
Message-Id: <20260611183740.8C70D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Provide `read_val` and `write_val` that allow I/O views to be accessed wh=
en
> they're narrowed down to just views of primitives.
>=20
> This is used to provide `io_read!` and `io_write!` macros, which are
> generalized version of current `dma_read!` and `dma_write!` macro that wo=
rk
> for all types that implement `Io`.
>=20
> Note though `io_read!` and `io_write!` only works if backend implements
> `IoCapable` for the type; which is typically only implemented for
> atomically accessible primitives. `dma_read!` and `dma_write!` currently
> supports them via `read_volatile` and `write_volatile`; this can be
> undesirable for aggregates as LLVM may turn them to multiple instructions
> to access parts and re-assemble, even if they could be combined to a sing=
le
> instruction. Thus, `io_read!()` and `io_write!()` does not fully replace
> `dma_read!()` and `dma_write!()` in this scenario. The ability to
> read/write aggregates (when atomicity is of no concern) is better served
> with copying primitives (e.g. memcpy_{from,to}io).
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D16

