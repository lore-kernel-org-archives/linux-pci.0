Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC8480336
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199970; cv=none; b=ohz38+j2waKTO6T08uOUwAFGHKyt4AudOLSzLTByHBFkFZLhgFp71v5Y3UL8Z5aCA2hMAzhunJDtT9GIP4TPwduOx3YM9qGbuigzSWUqGfbtklN+1Kc7m3+ea3n2Byhur8CHu4vNBYINYYWrGJFgWhxbn3nPd0uGdNoW2fSPq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199970; c=relaxed/simple;
	bh=tJqbP7Pqgv8wTQVr8/KiKdpcDKGcbwu2ETXfBiAKjYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oi17Vlt5WFb3IiTHlUdkUIe33lUFtm2QDV4DmRVKI746pbN/2bEcpVaKb28YFrJxhrqodLwjKFwqBeLwM41Yq6HdpbQMpryIWTucb4RU4LJpZmn2ogjbVVdJScffVV0cvm1K4j266uL/YyCJgaO8Ah+DkJrGZTlKOmQruYYMYuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJXEE54c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJXEE54c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5665E1F00893;
	Thu, 11 Jun 2026 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199967;
	bh=tJqbP7Pqgv8wTQVr8/KiKdpcDKGcbwu2ETXfBiAKjYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QJXEE54cDBNpblcxg0efzfnqoz8Sx3unObSqcMj1KBjJS9NVZlG4PGoZihIDzuPBy
	 7rH3j11XMeLgBzVy2bg0U6x4wzYQXs6/f9XcYNrhzmzna/dDvex/77Qf15JOcG5PGY
	 V4iN55N1/NXuAaLtfgBY5E3Kele4pckwA82lqqGrulennmcIuQwUoFlYCJmr3f1wHa
	 DhlHoXjbY7NV2//KTF/AThSrfLx5n9xld+d7kY/p5Tkfv5H+m8Vm6AW1hrhLLudZq5
	 ZvG6hURnBXZOt90IJgL104o8XoiPB/e9oTRwiN9s54jbA/g6Lt5aPvchuTN7Tw2eLp
	 AEnDoENHiH1Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/20] rust: io: use view types instead of addresses
 for `Io`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org
In-Reply-To: <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:46:06 +0000
Message-Id: <20260611174607.5665E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, `io_read` and `io_write` methods require the exact type of `Io`
> plus an address. This means that they need to be monomorphized for each
> different `Io` instance. This also means that multiple I/O implementors f=
or
> the same I/O kind needs to duplicate implementation (e.g. `Mmio` and
> `MmioOwned`).
>=20
> Create a new `IoBackend` trait and define these operations on it instead.
> The operations are just going to receive a view type and operate on them.
> This has the additional advantage that the invariants can be moved from t=
he
> trait (and guaranteed via `unsafe`) to type invariants on the canonical
> view types of the backends, so `io_read` and `io_write` can be safe.
>=20
> Note that view type is needed; addresses are insufficient in this
> designk, as they do not carry sufficient information. For example,
> `ConfigSpace` needs `&pci::Device` in addition to the address.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D9

