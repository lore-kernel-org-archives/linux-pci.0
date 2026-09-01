Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC739B481
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282127; cv=none; b=Cq6RdoffhdgjT8MT4u+mLL0YNxVGtB90wJNISAL93OaGO1MhtFMKB9UTcTZQCnDMYN/s/3BBX0H4GhIyarzTS4hghhOzC0D8mUCXSH/raT5D4MFbfHRZgFaDVbH4WMguQZcWzPi4Q+WeWMnuffXX83h19aaYzuD4gOwr8Z/MyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282127; c=relaxed/simple;
	bh=RzSJb02HAiI7ZXWz5/Frw1NDIqIy6zNSBRQbsI50Orw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m19evm7+H3us9Snyej9/4pZYwxFilQfmvwx2c3I9+mGPSSoD5+n7RXbZh36FS9+GWiRsocntGtw+DGE+sg0wDmsE/1bANTVu0lt6ig05+10jHr+gkh6EsG62NIN/ZRqxbOo3XQvupCOEw8SAB+ZuwJ53IX8fu/ZHmDAVGvcSG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6qsq9L5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6qsq9L5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDD41F000E9;
	Tue,  1 Sep 2026 17:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282126;
	bh=RzSJb02HAiI7ZXWz5/Frw1NDIqIy6zNSBRQbsI50Orw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V6qsq9L5HMg4Hgr6ZtUIqxBHI3JhAtH4y3HlljoZ1vKxhh1i+qH1dKezF7Ra/EfgU
	 ZayHZa1oSK6unQ5Lodcb7i6Em8pBLxT7n8kiNiB6yqHTNFKAd0nM465S9qFUZ7z2ns
	 P1xtA+tcyyww6UPsuKMV5m+IISoC61rXtsqqiHbB8ZwgIx8gt07luBsOv6holggjZU
	 RpyMe6Fo/IxfL6EZgrTwySk5Muf+FHZmcYQ+nR+/srEpP1z4tjdg4qaFOToCBoLm/5
	 TfdIjhjNuRyPTAZMb78ns5EeUeqFlecnOTBE7AcfK58LbWHSXscOWQ+AqrZN+63MXw
	 rsfsyiPe/xaPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/16] rust: io: register: support fixed offset
 register without bitfield
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260901-typed_register-v4-11-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-11-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:02:05 +0000
Message-Id: <20260901170205.BFDD41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a rule to allow creating `IoLoc` in `register!()` using an existing
> type and not create a bitfield. Add an example to demonstrate this for FI=
FO
> registers.
>=20
> This rule is also going to be used to create subregions for registers; the
> example of doing so will be added later when relative registers are
> removed.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D11

