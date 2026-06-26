Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE953F822F
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485974; cv=none; b=smy3h3AjXcztBZ2eeDRRdh2fli/ctHwh5uxJSpTDODQVdFOEVuvpbqc1wzXjMe/3C8nfqLIgFFRJRRTp9XCHCfYsQQd3Xt9rQluIJ8Zrv1GlKAs3HfJZDQ0p3NEBO4olhARG1A4PakPe8+QfJCqg2yuHp563rvWpbsXRUsrYPpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485974; c=relaxed/simple;
	bh=rTh09xxTNUQ7wmzvVvJ3mY4veTFxbFJgPPII5D+9y0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AKiTdJGuTb2cHykzUyJjdrtFvdGwKU93Hs3MRGx3bPvjPw0+ZOejO6QHiKJn5m9qmiD2LEnLybJk3aM0S+GOaIrvGBHnUqd2+nUbWj6X6uzvlX+tFBhtrb/hArDOAtc6CWJfZbrTec8E6ICd/RI3+3D1i9+2aSoTEMi4fgKf8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8eGf0sc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8eGf0sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC7F1F00A3A;
	Fri, 26 Jun 2026 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485968;
	bh=rTh09xxTNUQ7wmzvVvJ3mY4veTFxbFJgPPII5D+9y0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R8eGf0scenIWNsNykhG3vkU+J//To3O6jd9YPAhIHza+5ITRp9hDO1yQkmtz0XL6/
	 HTLSZpGatJl3BvaQ0Sk5jxKSSZzRrrucqk8kYBQB5OY9mPT0N2RZ/ckXyA2yxJNoBH
	 Yoh9vi5GuvT0KuBXWgS8IIx+BLe/NVaZfXE2NPQ4Snx7/j78ChdkJCpE2HBnLMLo7B
	 TU4oeZOtw7JHBSKZB+a5O6+1Boa+jrksGv12VpxEnZu++ni42pfOh2AS5GK0/fdf4n
	 pKSdKq+nhoLZEi4G4N1BBaeOxfLulQ8/O2ThEFXKqhVYHQuaKp9T+F8QCOe+CyOTG1
	 rCEcVvG/PUXQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 20/20] rust: io: implement `IoSysMap`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260626-io_projection-v5-20-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-20-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:59:26 +0000
Message-Id: <20260626145927.1FC7F1F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D20

