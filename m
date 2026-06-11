Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E697346E56
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205215; cv=none; b=qd8eRcqiq4vmGy9HER1KfEbF3PHdHLwxKqv7NfvUebhSAdArrhKPs+9RJP4/rMyNvl4kqbeBDusKo0cRB0NYq3RysVgZuJD9+D2wpB8MU/GLWkHr+f8K5HN6Wrw9no1sDEivpLRHYRdYee1gCE05Knu3NbIVtyKNdTiVknsR3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205215; c=relaxed/simple;
	bh=iCtrLGLeaHuKj5zHjis2MgS/7XpFHZqDvQ5PL9vwLts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cX2xqZU4SChzwy8AV4poMG9J2BE+UaVr4LKBFkPHC7WK9jer3Zkbb+1cLyCgGk8yU31AiIEMT5wOteiDLiuWcFmlITosGKXXeht75ksQIhh4AhOawolNEZcc5ZB+oGpieyW/2IoXd5db03giX7U5DfWHq0JJmmCZPlbT7t04SYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EccGaNFD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EccGaNFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14E81F000E9;
	Thu, 11 Jun 2026 19:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781205214;
	bh=iCtrLGLeaHuKj5zHjis2MgS/7XpFHZqDvQ5PL9vwLts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EccGaNFDGxNT4H7ojB/6WI5pXsuObDhvfIo0SbG/VbkMp+DKCErMXcfgPRnoEYXYz
	 EHHrIuO9MzMBIa7kbyJDKBvf7+PDnbxb6OR+iNkxNIE6/QOsQfKO4G3znLw8R3KXe4
	 EiyFjpv8C84Hc2sgl0WUM+rl5jwGG9dILPNjC/NdJ3bdiYdHpEaWIlsngrIwdIDGMC
	 ue+DcQscLnB935ZxZYjIBDWmmINOC3d3QjopdlcvYR4m8urXdu4Z9H0+IGtt+b2V+p
	 LzPGQEj1Wo4F+Dhn18tKjBaQdaa3HhTV8L5tup0mT9jgfuDt810KXcUB7nmExA8rSH
	 bCLDYsB0rynKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 20/20] rust: io: implement `IoSysMap`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260611-io_projection-v4-20-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-20-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 19:13:33 +0000
Message-Id: <20260611191333.F14E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add an enum as sum type for `Mmio` and `SysMem`. This serves similar
> purpose of `iosys_map`. Thanks to Rust's type system, all of projection a=
nd
> struct read/write can be handled by the generic I/O projection mechanism
> (i.e. `io_project!`, `io_read!, `io_write!`) for free, and there is no ne=
ed
> to provide things like `iosys_map_rd_field` or `iosys_map_wr_field`. An
> enum type also makes it very easy to construct or destruct.
>=20
> This could be made more generic by implementing on a general purpose sum
> type like `Either`; however this is kept specific unless a need arises th=
at
> warrants this to be generic over other I/O backends.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D20

