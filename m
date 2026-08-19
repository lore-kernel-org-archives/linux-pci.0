Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2C3C09EB
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138380; cv=none; b=UpAybegWJw0H2K5SPsFoB7W/bvoAPg3kJcYEz+fjaNFHcx9YDRzTQtY+1Mk4jzQI/soRBAOVJO+jkMSWRlabzmjTvB6jnJDkR6wSo7qX6/xTx+u6BwGVbTGF/sbNGgCzZjxDDxLPrWcW8FLmBUSWpgtYTI6wUgUZ0dHrRWJjaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138380; c=relaxed/simple;
	bh=EJNavLRUDqh51Rf6Zu+a72hzHpND8iF5ZF2vJGMiFb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ePoY/ZNZGOLWg2KcoMEJFxh959wP/Tfw8IPSgP4K5PuQ5PDst4tkGToFCKRA3rdFcwWP1r8YE5TU0y346a29Q+20mMKsepo7UtnGsVRpkMHnHR1HSiOEAkh8xgJ4Fr/UIh0wIfdrUxsVTbc9tevMzCncUE5NRqVc6XKWMrkiKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdmBVHTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdmBVHTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615A41F000E9;
	Wed, 19 Aug 2026 11:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138379;
	bh=U90PQ07lMGeV/S9hY5g+kSc82c9uxFtg9ufXoq+8+PA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BdmBVHTZP3NrVRSbodBAmzCo4+jVsV1Ckk1exrq7zS9L4mQPQgvmFIql9pgF4q8//
	 /seok4becnzoqHb+fHuHNDQbw777ys2EVLWqTQtlYmzl4n4p7M3EWO26t6zykxvh/G
	 +2ho/NEwvQ5kzAgk5iHMQD+eLfQN1Ew05c9JxDESp8brtQNgR4rdBP6PnhMWBV/mVD
	 yEmMj2AkcfP1DKZWobVUAyxDfwKSJDeHA6JE2EZsF4dZY3kEcp3vuzo1IfSH42dXyT
	 e7QFxTA2VdXyakv+SuaygTn0crpe9dFIj2pHaD6Jh5W7zIt9kAr5+2izaJCiKryQQP
	 dUa4KsOyDlu+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/16] rust: io: perform conversions using `AsRepr`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260819-typed_register-v3-4-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-4-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:19:38 +0000
Message-Id: <20260819111939.615A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> For types that are layout-compatible with an I/O capable type, we would
> want the ability to use them directly for I/O operations. E.g.
>=20
>     bitfield! {
>         pub struct Foo(u32) {
>             ...
>         }
>     }
>=20
>     #[repr(C)]
>     struct Bar {
>         foo: Foo,
>     }
>=20
>     let mmio: Mmio<'_, Bar> =3D ...;
>     io_read!(mmio, .foo)
>=20
> Currently this feature is available from `register!()` macro but not
> otherwise available with `io_read!`, `io_write!`. Support this by
> performing conversions to I/O primitives via the `AsRepr`/`AsReprMut`
> trait.
>=20
> This makes the `IoLoc::IoType` and `Register::Storage` redundant; thus
> remove them; also convert register methods to use the `read_val` and
> `write_val` instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D4

