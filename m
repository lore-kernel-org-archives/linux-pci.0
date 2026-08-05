Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6591A682E
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948156; cv=none; b=K04FJAp9u/1sXlKHDfFevGb3ZQfyA8zgckk41WEOEcW/e7Jyv7NazoobCgw9svyzQZgCLCiXAJ0/sl3NSOO6E5WIfwAjNMkUX219R3pUkqITZ8rvtQVsjlWimejQ4JrEC6P1RCdBSFDVW323HXa+037jE2XQTk6HtGwRcRIk1Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948156; c=relaxed/simple;
	bh=/2u50LLSNyt/+SgkTfxkSFIlaocehhSkMm6dT7KM9Do=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GTpBgnikpYekFDMs2VGNj7RwCuPTE9M4aQdxRVMbvVwb+nORhGdud+pgTQJswtJMkaE3UMNg59WoemKendVr81uuoDZCBrwSyK8kH8ru2a/M2k5rs6dupFHTJAvhsV9BZ/3B180aGQbn/vKI4n13LKWbx1JE1D7Rf2K2qUkZucU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D35Wn+Te; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D35Wn+Te"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAC51F000E9;
	Wed,  5 Aug 2026 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948155;
	bh=/2u50LLSNyt/+SgkTfxkSFIlaocehhSkMm6dT7KM9Do=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D35Wn+TeXJH/70D/A+Ajam63GsZPjyKuhOcvvj4/QwyDJ8VlntoJ38MFyO96x1t9N
	 7qOcAsH19aJh9lIl7icilYZcZ4Ofx9F+WWxl34z91ra7pznnL19qa5H38payo9DLow
	 SgVkUCMMsQKe7oIIRpeID3pWMjlQ4fzvcJCTtLEa+FT/5beuheDDZVj1zCgNu6pXl9
	 6I6qZHvU88/H0GeLRZPtSjI+xLhdaHdvb9GNBaXBoIuZ5L1E7kA0gEgthKxZJZWJUJ
	 Bydsl1SFZoXdmNMFjC+e37/Ys3+wLg7h3LumbROqrliW2dtrkhVdGR44x7odJOtBj8
	 Gv7aUsmHOARiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/16] rust: io: register extract offset computation
 to helper rules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260805-typed_register-v2-5-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-5-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:42:34 +0000
Message-Id: <20260805164234.DDAC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Create a helper rule for register offset computation so there can be a
> single rule for fixed offset registers.
>=20
> Similarly, extract stride computation to helper rules.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D5

