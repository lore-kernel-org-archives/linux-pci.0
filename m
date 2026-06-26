Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82EE19D07A
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485639; cv=none; b=IiCUQOLUYnGsILrIEEftUsy48Df+D1/QKlkkyLj9w41OMShIflw17cbVG1tFSkl15Vf99+8EqweZ47KCankbK8qXWvH3AqWujsRXOc0K1y+2Arjz82tLwjKnZ2zaRwEDmrkfQHh9erzn4rf+4kQB9CpfBUB7DWv9eDV0cqbsaxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485639; c=relaxed/simple;
	bh=ky/CA2O6RC56KEbujWxESCs6Eo0AP0g1YwCbV0Ddly0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RjcPI6zhkM9bjjMxbJSoKSguoB0Tlbk7oaHzktCDB0M3zK3Z+/wYd2jj8BiBcjjUw+ITXUEbPG1JhvIPaL8agRTwCQeTsXf9pWQsLqJX5jkRFDXnMpSqPo/UQKmaudHPYgoCwxeLEouIB2rejXkkRjaotFnSVB+AdB7HCTrPDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiycdi5f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiycdi5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E689E1F000E9;
	Fri, 26 Jun 2026 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485638;
	bh=ky/CA2O6RC56KEbujWxESCs6Eo0AP0g1YwCbV0Ddly0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fiycdi5fEvsc/QmsndPNj0a3nWVDcfptpkfypsMkHUkItbvRS+sKFNTqXPgfIXTYv
	 IRLuSxsyT1VCphMimZtSDzvnBp6niRM3NyAgvHPCjSmoz8e1Nz4034mdcX7kLdt0jE
	 nm3phaClnLe3CVtoHeXKdIKkxrE+ewlCV0+DBATMGxASrlf0B56/MaIyRmXw1BoMYj
	 L6W1A5goxn78k9OG3Inkjn0sqjwo4ogSZlfyI77f/Fmc0KoURelqbfuLAQoLdPSTPh
	 /WGRM4nKan/svfT90610DhvjThcYbsyyiLzDzopBj2yUvZDRBLLLTPO6yHP8xCAaDe
	 gyEh/NJjMDbRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/20] rust: pci: io: make `ConfigSpace` a view
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260626-io_projection-v5-8-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-8-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:53:57 +0000
Message-Id: <20260626145357.E689E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In order to support I/O projection, we are splitting I/O types into two
> categories: owned objects and views. Owned objects have a specific type
> that is related to setting up and tearing down, while views can have their
> type changed with I/O projection.
>=20
> Things like `IoMem` or `Bar` are owned objects, which requires setting up
> mapping and cleaning up on drop. On the other side, `ConfigSpace` is real=
ly
> just a view, as the resource is associated with the `pci::Device`.
>=20
> Remove the `ConfigSpaceKind` bound on `ConfigSpace` and make it a generic
> view. This means that `ConfigSpace` object now represents a subregion and
> therefore encodes offset (as address of pointers) and size (as metadata of
> pointers) itself. The full region case is still supported with offset 0 a=
nd
> size of `cfg_size`.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D8

