Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F052420877
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342630; cv=none; b=YTkF2SzQJC0qKrw9OJ7GTrZ7zOMbV8NOAQOXeOl4GvRVi/KZ/2yNo4mY4mYU6dzF/6Ry8rSK0k7fLouF7q9Sbk5wZnrMa+QuJiE5LzctBsaTe2M/vgehgsJlMYEcLrkxUHWWBzYEmbDFwIYnyqW/BHAlyDx7ZKdXxXIkx8NfmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342630; c=relaxed/simple;
	bh=iJ2HSN9/NEIPB1aDkoCJ+eBaDaZcG3QsvKmwsfgZIe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qNLkKTUjGEyfSujq+semdwFKbr8L4tfYifl0rRK0iM/uwz+Gk2PO+ZO9sAMBzA6DLP0rZzAkd8vGYocio0OaG4g6rxYNZnN9Z6RwEd36msk+5FNtxP42+kBZbb7NTW8WLP13amhQmA5OApGlHkk39B6s9YWp4IfFhdU/JDFTie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsYJYwel; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsYJYwel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3461F00A3A;
	Mon,  6 Jul 2026 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342629;
	bh=iJ2HSN9/NEIPB1aDkoCJ+eBaDaZcG3QsvKmwsfgZIe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WsYJYwelsGO+05RxMuYbJ2aL+1qIhCxWwJFi3hi1N1on4FmWLZydp5KIBkRZdSbmt
	 kt0EulDReoQGR9INMrIfMpro96/ekItOYluTIJ1bbGHRgZT9Dk/Pm46o+XrKr8PxvY
	 MYvbF11Vtv4A5e3vmqRh6E4LK8AcR5h+l0t7KI7QmZqmWKQxjGAz3N5mukzcM/H8Zj
	 5/7ujmqJpWXpVBJ4X69JENHY2cZ4d33Aw7hMZNXxhsGV8YnAPP0jGj9F2Ad5ZRGJBi
	 4hmBRCixH/K/4tCN8RZZjKbRFNKAVx+FpMcIi5oQa+K5Ouhg5dJy9BOmvKyWAy80Mr
	 AHWysw28fReWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/20] rust: io: use view types instead of addresses
 for `Io`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-io_projection-v6-9-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-9-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:57:08 +0000
Message-Id: <20260706125709.1E3461F00A3A@smtp.kernel.org>
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
> design, as they do not carry sufficient information. For example,
> `ConfigSpace` needs `&pci::Device` in addition to the address.
>=20
> `io_addr_assert` and `io_addr` are renamed to `io_view*` to reflect
> that they operate on views now, and make them standalone functions so
> they cannot be used by users to cast types outside io.rs.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D9

