Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83FD2E6CAB
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485554; cv=none; b=sF+WIfACu6ufGJpxQtf8kmej+a9j+EMaATFLqDfeyec7KczxNfvU6Du6AMuk26lB1az+jmXxxPzzELU6dj27BW4Y3UC9R66u+cgsbxzNN1KkS6E+LF/E4AvRhmfCgVBXZIQERV/tZbPTw7Vxj9Ezsz0LjRnSbmWgukl3UXc2AHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485554; c=relaxed/simple;
	bh=KC0Y/EKfoL/rayFhZcOfTRBo++E0m+tQKSgGudy3Fpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AS51vsqMDgIVuMF95ECWsq4rqHy80N1KP8XT4A1INL7TootqX+tlZQxwiqMbh9f6o4L4SiCWtd3z83otTGuS1+2RU2ZBF4Kux9zY6nYmd6Jh3mHhHwwOrz+nXrAW/Km2ltdW1tDee68ZUh3nj1RP291SAZCwVX6xYqTDyQigG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiWoyCYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiWoyCYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC7A1F000E9;
	Fri, 26 Jun 2026 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485553;
	bh=KC0Y/EKfoL/rayFhZcOfTRBo++E0m+tQKSgGudy3Fpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WiWoyCYOs/9J9RZ5Kvv3bvHpwnal+Bjoxg3Rwjc0pIPZjiVqlAO59vo3Kq/gnSnO/
	 fIKWkNcLsCxmHy5tCG6n9i91t4usbj3KzLf8/UahbOB8mUps6CBi7KRsHmuvqoZBx9
	 aM/Exy/ICvHZzWTeCVmZUNvoA/jbr0i+IoA4c3ZHkx5CI0harOrxU/fCWe1Wcn1qh0
	 tmIYnULhcUGzNHPEuz3cHHp6vqHXyJLJCvBgfMphFcRX5qrJ9Ls7WqHTK3YPnIaBge
	 VvlQX6zLaTSr1XaxQGTs8LrwAPEi1djxkVHRP87019Ayc/PaFblJ2ypx2TvLdgypLx
	 V1y9h/hMF4Rxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/20] rust: io: add dynamically-sized `Region` type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260626-io_projection-v5-1-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-1-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:52:32 +0000
Message-Id: <20260626145233.3AC7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently many I/O related structs carry a `SIZE` parameter to denote the
> minimum size of the I/O region, while they also carry a field indicating
> the actual size. Proliferation of the pattern creates a lot of duplicated
> code, and makes it hard to create typed views of I/O.
>=20
> Introduce a `Region` type that carries the `SIZE` parameter. It is a
> wrapper of `[u8]`, which makes it dynamically sized with a metadata of
> `usize`. This way, pointers to `Region` naturally carry size information.
> This type is required to be 4-byte aligned.
>=20
> Expose the minimum size information via `MIN_SIZE` constant of the
> `KnownSize` trait. Similarly, expose the minimum alignment information via
> `KnownSize::MIN_ALIGN`.
>=20
> With these changes, it is possible to add an associated type to `Io` trait
> to represent the type of I/O region. For untyped regions, this is the new=
ly
> added `Region` type. Remove `IoKnownSize` as it is no longer necessary. U=
se
> the same mechanism to indicate minimum size of PCI config spaces.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D1

