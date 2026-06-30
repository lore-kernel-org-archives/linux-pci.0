Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5740C5B0;
	Tue, 30 Jun 2026 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823224; cv=none; b=YN/4aghcxSjbycdhHVI9D83y8W2YMo4ztAEwuJw5jN3gSpNPC/3AOD2IECLALAfdE0D1ccrnIhBnktU6cDsEGTpmYaobI/nHy6mVBuDHmvpQpCykZyh2Q69Q8qYywwRpsDQYSLvifeyb8ANYePiPR7XgkzIOswsMU2x5DSm68RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823224; c=relaxed/simple;
	bh=rLEOxETaNhnEfcXp3Fz1GLdaUFQ6Efo0pDXRpbhYQto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iVytkRyASkrzkSIFad6XzUYD9BqbDVHOpH3uiC4JpOD4Q+XsXdi7pHng1bs0Z/VMrqZUW8qbHR3cQs1ZRJXhKbu38lvUInSHN2ONTzXqVdOtcQnIFaBsmp2InxPRkUxnlRllA6Yay3X/K1HSbiq5UhRMc4ZJLiaj8o95EzFWjBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfKdy+/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfKdy+/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95651F000E9;
	Tue, 30 Jun 2026 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823223;
	bh=rLEOxETaNhnEfcXp3Fz1GLdaUFQ6Efo0pDXRpbhYQto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mfKdy+/8OsIS2Dteakg5jgJgCjNNbSS5iYE/NPy16UlJg7YieYGh0eoIT/XS91SBi
	 /Za0HtsXnH+RfCHhHFqjHRY4cGLCX1EyCQLWzR6++Y6xBeMlVZLHQBrHpTYrQnsFyr
	 uQ7oIdWmqCPBb65dYlSgViwatFaSR4i1yqGFmTKQmmwyUgfFK6drQFbDwkRDDztVMV
	 jlQ3IjpnwXDLdLFsIuC14wJbPtyDb89CNuxry8e4w24Q4Vn8omkBF+8cskwwsYD3j0
	 lB4JM9RJZy3yDnNaIWW3jH2WooUxUkb8/cphl2YpVYVY4ekKEdxk3UmivZhRryY8eN
	 EutbKTKB2DWng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/11] rust: driver: remove duplicate ID table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, ojeda@kernel.org
In-Reply-To: <20260629-id_info-v2-10-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-10-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:22 +0000
Message-Id: <20260630124022.D95651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Previously, `IdArray` contains both device ID table and info table so we
> keep a separate copy for MODULE_DEVICE_TABLE for hotplug (which needs to =
be
> just the device ID table). With the info being changed to be carried via
> pointers, `IdArray` is now layout compatible with raw ID table and hence
> there is no longer a need to keep the distinction.
>=20
> Deduplicate the code, and remove the redundant copy for hotplug purpose by
> just giving the `IdArray` instance a proper symbol name.
>=20
> While at it, also update the macro to use `::core::line!()` instead of ju=
st
> `line!()`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D10

