Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F0442A7A5
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300357; cv=none; b=mJEU4rkfXgdvNK+b7h+Af9B9wzBhgDb9NPeY759YR7mBFAWAOoAzEZK3H/rgl41LrXAbllcjx+RnYGi0Z30hs3fGGrgBmaESX5CWPRklGEFqMNbNpiIZLoVB7ZED6/B/62g3LWLKKG2kO1zlGFT9Ay9Kc+81aNAm4CJxnYqGLiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300357; c=relaxed/simple;
	bh=kcQOr0qddCUs6325u7gtQCRT+GO/ZB9+/I9oKPRKJJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kSuBbApqDKa8zJeEondCmBuLsKhE4AvEomoWY41Km0TX2uKM/OIsMi4crMGkmBw6KfpTEooAen3+IusyuaMsE7SN86cpHJ3msqCj3bre3s9Ch3kNTTpM+rPwV+tZuJyMpg+GHb+udQppVu0nJC5Vn9HTuHz+Knjd06KrAnV+5JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK3czwrT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK3czwrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02D81F000E9;
	Fri, 17 Jul 2026 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784300351;
	bh=N+dxitr22xx4KUXP6w6lh0tgqp/wMjv0FSb8hh989bQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WK3czwrTRGt4AcW626spdvzrZTr2uxzP6ewzx9jkf4RxJLJtj5/zjNa4L/Em3R8a3
	 n/2vrAFXnK2k+1RiW1uo7v0JeurNS48FBVJIItAC4xDvx9XkHF2JhnVbf5HCxST1wk
	 oC+6bST/HUEdHntXcbqVuPHjJxS2j1F6884P36erMLTjBCt/y0W1oGl1wvLNsd2AMS
	 NCbvB9Fx85WUqbilvW/HDXz7OW4VP4uRilUi3QOX6OersW6BrwSg8LMAKaxoXV0bwx
	 L2HAI/96fptNANWFEKSKP+1ZtT0KdhIBSL8dPGniGt4CkWVIL0pSC1WaJ/JLHbNI2E
	 4Il3rICPdamcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/12] misc: Unify code style for various *_device_id
 arrays
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?= <u.kleine-koenig@baylibre.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <583653bc7b9ae19707bc28be69a20e66b8c3720a.1784299069.git.u.kleine-koenig@baylibre.com>
References: <cover.1784299069.git.u.kleine-koenig@baylibre.com>
 <583653bc7b9ae19707bc28be69a20e66b8c3720a.1784299069.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 14:59:11 +0000
Message-Id: <20260717145911.C02D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

>  - Add a trailing comma for initializers unless the closing brace is on
>    the same line and for the list terminator;
>  - Use a single space in the list terminator;
>  - A space after an opening { and before a closing };
>  - Use the PCI_DEVICE* macro in two drivers for pci_device_id entry
>    which is usual for these arrays
>  - No explicit zeros in the list terminator;
>=20
> None of these changes introduces changes to the compiled result.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784299069.gi=
t.u.kleine-koenig@baylibre.com?part=3D12

