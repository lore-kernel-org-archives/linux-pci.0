Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F84314B0
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342275; cv=none; b=bKDY/zg+HTYSsaoKsGD7LwMH75ZAZYs03NrlViweMFsDkhCFjDJPgpIs5ck9m/2OSxLwfshxxrT28hr/xcqfQSrJ7Dnswt1hS+Slq72BE9IVtmsIcyo2HoYCWe9lLBUWpNMagCGJNoraAYu5zCsod5R8+14sk5EC4bWLaViBH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342275; c=relaxed/simple;
	bh=X+2qgwVuOVgbZOSZiRUEmxRy75ATRaztorH5FdNs/3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=usa+3IxU9Sw2nf/BKuro/FODrUYmQC5qfMSryJG+6w0dJouLjSZVHzJizQA8HwpwqTVIHF+QPxudcqpoTSWNPB8NvtdXmRgCWaNFeczFyq0Gph56Wt0uDp9FNH/tvBCApBTyu9lxXz4GrejwpwGMBeuyaFtsreBpi5X0wY/JM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCMC/T8g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCMC/T8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9611F000E9;
	Mon,  6 Jul 2026 12:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342274;
	bh=X+2qgwVuOVgbZOSZiRUEmxRy75ATRaztorH5FdNs/3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lCMC/T8gLWac2RjtwdWkYaYX61/99bB6Ji1ciMMj/d31+7J+ctti4H+lp5SgFFL/x
	 HXa8HdeUHbJUTsKo5Io8yAKrDs2z2VNCpAYQK2toRmjzSF09NUCm41bG4wxJB/WD6z
	 2D6sM/qblHlvntbsonVkKxy6O2yfucd3giB03eNLJEAEEmNyLfg8smtCGm7lQULA6C
	 a/HkADaSaiO8YuxFRCpbLYhix7fPuVCha8hlCxmJauqVrn3le1pVT3X9YuBjCIzz62
	 TlIsV5qMAHeh8ojwR3tjXt33qPHeKQB0iK0scTvK5YQLPDBS9B1J2koJ/qWfByK8kd
	 frVvZ4c/NWkKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/20] rust: io: move `Io` methods to extension trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-io_projection-v6-12-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-12-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:51:12 +0000
Message-Id: <20260706125113.AA9611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `Io` trait now has a single required method with many more provided
> methods. Provided methods may want to rely on their implementations to not
> be arbitrarily overridden by implementers for correctness or soundness.
> A good example is the `size` method, it may be relied by unsafe code and
> thus must be consistent with the metadata obtained from `as_ptr`.
>=20
> Thus, create a new trait to host `size` method, extract existing provided
> methods to the new trait, and provide a blanket implementation. This
> pattern is used extensively in userspace Rust libraries e.g. `tokio` where
> `AsyncRead` has minimum methods and `AsyncReadExt` is what users mostly
> interact with.
>=20
> To avoid changing all user imports, the base trait is renamed to `IoBase`
> and the newly added trait takes the existing `Io` name.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D12

