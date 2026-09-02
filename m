Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0819F27603F;
	Wed,  2 Sep 2026 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336042; cv=none; b=Hk01m1hzvp8/NPnYJR2G4Okx3SwVdCG/+vMCYlfTjONvaIezpz2ow0W7CaDu9MuvmZTV+v3IipUGxyxIoOzJSJO+9D9u0m/y29pnQLRhg8ubBojZy+r0WxKpIAGqr/Ei0U8AG/UYE4vL1g3aC/vzglhjtjrMU+6lC5H2DxFO6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336042; c=relaxed/simple;
	bh=A7NeeyIsg1vNs/USnbzrU6h3oCd6VPzPkU7+28hFdt8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iatGQMA/uuE8bmN+6b3KSLwsguas+Grgjr/CMWYbAo4PNQaeldtRhs2sF73M+C94NewDRZixz+0eJP8VQmctlsra1En9qhz1icI009in1spBExRgiwn5cDC3VCBqmqB47VDKqsvvLulBEyl/0KYe4Bdae3oiGZT493u83KrQ+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0+lOXsR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0+lOXsR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642751F000E9;
	Wed,  2 Sep 2026 08:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788336040;
	bh=A7NeeyIsg1vNs/USnbzrU6h3oCd6VPzPkU7+28hFdt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P0+lOXsR42haasWh1o6/r/ABqz/0DqpDsetxe0C7C9SrCVn67coYyBnPwe1OwFxCw
	 l1x+pUgMFGnsEdehJ4OR6mEfHY2kvTwWl5eBfx9kaoPp7mNcLCH5h775Dq5TBpORxy
	 0KgamFaSwuCZ+Ni+rjlNF03X9b6ZRE2Y96qSHWLnuI220tkv/zBvadWiDbSNN1pKJ0
	 /I9qm5uNMFFDyfk9oh06vPaNyHIbyXgmm6K0Lw37/feEUnozIWS4VfjoYDvwAQWOb/
	 3Rz0ocz1fVHWsQ4C7F3Sx/gJvrDVjLyxedxz+Ll9uPddDrNKcH3CTWiliX0wJIxFhh
	 NM/Y8ANut8rQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/12] cxl: Move HDM decoder programming helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260902072804.665639-2-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 08:00:39 +0000
Message-Id: <20260902080040.642751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce struct cxl_decoder_settings as a snapshot of HDM decoder
> programming state. Collect endpoint skip and switch target-list state in
> hdm.c while holding the DPA lock, then pass the snapshot to generic commit
> helpers.
>=20
> Move the low-level settings-based register programming into resource.c so
> later reset restore code can reuse it without depending on private decoder
> types.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902072804.6656=
39-1-smadhavan@nvidia.com?part=3D1

