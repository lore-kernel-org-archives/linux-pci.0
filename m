Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417803;
	b=MChVbFDn3nEw3FBOyabCQ3qMbZljwPvIPwd3ti9nQgWS/ReZ5Y1z7k4x63rhdakEMMpt
	 VOQaUxmXRcPYaW7SioIUwS+G51xiTUiaXYRdB3+OenrhlKuMQLqlQju3LH0FeVeCSWFt/
	 6CDKTSFBPj4RHS/57nPMH2pkpWCT8EIAOMjgC3tifbH3mSt//xYOGGPP3dwQwD62UlMNl
	 CuuG1emqbwGxdy1QHRWcgynqq5iPQefG29e+YQdkGmQYbu8RO1jsLoqOaO1m6QOLMZb36
	 0TMawWVgLNs1qDOIDBI8boNEffy+QcVq39QitKbsf8fROo2qS1fL6XdDTr0IyUW8ifA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417803;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kP2wtW62Iu85qfsGunKATJx8oPpZ+1rvxWQmUcX+Q9Q=;
	b=c+de4Bty5jwTX9LdURc0qZhpkE7L0JJ+6vIuI7ou1hwD2ipMmCdVj6YWZ0vrOthkUJ+X
	 ecJFAGU3aK1urZpb88+HncSx4R0IaXsCDLl62gIKsF/SD1QjkbWs1ki+tHRGrtIOBzC8Q
	 kh2pkwIo6Cfnn8NejQG/8/XR3K307TEPQWu5eKB4IGCKlOkWkylcA1Mx/kgbVcYtfA4yQ
	 dzmZRXhn7X4rvPZyc/NOjoaM7U0Q5FUM2Y1CXIeNL7cDPtoUJH3mCXj6mYungHoWoe5/w
	 95/qZXEVMrWdKVpL+qhKqmbKjQouGW2aS2sFWbQZy1HEveiLLmFz6HtV1tbqozZz2eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDTSfLeC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9CB606A32A
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDTSfLeC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274881F00A06;
	Wed, 11 Nov 2026 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417803;
	bh=kP2wtW62Iu85qfsGunKATJx8oPpZ+1rvxWQmUcX+Q9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cDTSfLeC+gvpzpwhkwgsWolwCe4qOwqvOjSs2FkpVZUS7/WhlBAeMwg6XB0j5vMVD
	 FcheSuFXh74EaheZeBkklZj7dtSFgZkq4yAalFqGH0pN4r9FmteXOR0l1vc0xxdpcf
	 P2nQlza2l39nli4BDjp+n4J0ERjEE8ihy+tkJz/rKDecpc13UxNfKUNHJIO7m2NUfD
	 4QvZQdMUjCUCc43r5WYNQZaGEzpmY88pQiRYz9g/OpcC3LGkFh5Zk5R7Qdrsz3IZyw
	 zZdNBmMveqzfAGFceiTXzunRx97Oj0zFXKpnaIq2dgK4Cglp9cHZUGACnoi5HVCeja
	 FnlRDPDB6K/rA==
Message-ID: <sashiko-outbox-209406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] drm/radeon: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261111-vfct-regression-v6-3-393797bbb6e3@amd.com>
References: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
 <20261111-vfct-regression-v6-3-393797bbb6e3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:23:22 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> VFCT records the PCI bus number from BIOS POST. The current bus number
> can change after PCI core renumbers the bus, while accepting a mismatch
> based only on device identity can select the wrong VFCT image when
> matching devices are present. Compare against the bus number captured
> from the firmware bus assignment before bridge renumbering.
>=20
> Fixes: 4059e2f02c8a ("drm/radeon: Fix VFCT bus number matching with soft =
filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-vfct-regre=
ssion-v6-0-393797bbb6e3@amd.com?part=3D3

