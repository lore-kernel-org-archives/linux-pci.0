Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F737BE8D
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138620; cv=none; b=ZYgpPoCqXau3dqGyZYyrjv2dAsUDX5IrGmC1qc0tY5xcJ1PFSvumTt6zmGEn6cJ+lAzdTO+UBMwMKlSOH+u1esQHJulnJ/ulETMjAQOGOEQ0ZtssxxxB62j5NByZTf/9wcwDJ/CXDtUG7jlTK0nIEFpQ4jkUJIuyOPCAAbDXl34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138620; c=relaxed/simple;
	bh=1mKeqtMfgNu27MUTT+aYhYybzVZeTQnCiMXDTo7DdSM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dED42/1gWtffiXP3VT8HCu5Se/Vsm4bc078eW2DphabkJKVu5ovjBScgiutMwyaWOQTWA+4qQVsPjacYNdR130HqKv019HGZr8lOo5Jzb+TPwQ1AF9Z1DVpjKl3UI8jTEK/jld6oDMduOEZ5f9czDfKxOZ2rbzcB113HnmQLhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHbxXJaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHbxXJaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB8B1F000E9;
	Wed, 19 Aug 2026 11:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138618;
	bh=1mKeqtMfgNu27MUTT+aYhYybzVZeTQnCiMXDTo7DdSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gHbxXJaWJWx5pybesc5Q/EULRHKxuCuVTKhjPOnazhpHfN+UggNvnesn+FRQyGC2g
	 vF/4giQqo7WlvrJY2l4bKYYf3d7r/uchnq7BHRkQqn06KQpfppQNXrI1b4AgIWb4CG
	 cctWkUBSEm3YZIWS8+aNbl06WGSOINf4StTr3ucJYKftfad9PdEhtW/aHpW68B5jh8
	 HEjjDtVFqCkZXPFrJPCPDYtv4NKchmsCvw+6XXw1DtYKz/Kq8m3wmRF5WKmeqoHTRh
	 n+iHS+40+KoyGjsH4hic3vKSc7bPCgiLt8qDDcilP+Fkeu1FCzfQ52NguiknIpx1vL
	 ggHp2hBCGp9Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/16] rust: io: register: remove relative registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260819-typed_register-v3-14-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-14-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:23:38 +0000
Message-Id: <20260819112338.8BB8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Relative registers can be better served by projection to subregion instead
> of ad-hoc handling in register macro. Projection composes better (e.g. it
> natively allows relative registers of relative registers without needing
> additional support).
>=20
> Remove relative register support, and update the documentation to
> demonstrate how projection and subregions can be used to achieve this
> instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D14

