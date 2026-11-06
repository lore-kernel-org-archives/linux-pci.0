Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965424;
	b=IeB27DtLb04qaOGg9uxv8muPZMRHhzD+DUp0Il9bDjm2sTS+uO1KP3QMwGpXcGxprkIY
	 c84Gfj/gLMJMi4ZJwc3ltff0p0b/x/D81a6iuzhXA7ct3ZKAyeFEQeSQHEiJMcKo8q6Wv
	 CsT58VbVj8LMGQVsphOBbOEUzSLuA0MRpAGvhE8gBgFbxJj2R2zHbBMxPnVQd/H3VZBRd
	 qG8YUVnVkZ/VlPbepDQALqWGCFY4JOIFV5NNAGP+cxTgAEeG7sLhzKc6mzmggthvLpdyn
	 s5acb0eoVF9tLdd0Xd5KFNyYDlmrKntY9/hb4NYRBaBJst8C/8Mit3wahIL9GoncMCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965424;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w5RZHcMIxhwyU2L8aEreWxu5ISkiy3CoRS60GybIQJc=;
	b=1/sKNrR3BEBACrsQh/fRP3QkHSq3qeB/HWLIi0TRo4qmxtGBhW9YUe6ADq/Abx99crG4
	 Lb5XN1FQX/ZEnnIEsfqE6zsb5c4SrlxOlTdhP/0EQbTsH4GINXMQwRsG31tm8gk4/RBwh
	 9w5nLo/TrtDwAijrfjolDo/Qk4B/aZWpAfK2zgEMzuCOpJ6BAQojPhK6eW03Po04imJ7V
	 0s1igMs1p7fjtownzssigqAU7zjui6QOfo0TzVB/ZpTkVPrl1N4E8+E8x6P8eVTTOXeaU
	 HbMUfMDMui4sgnlM++N++MfDd+R6rb5Hmdbj2pkyNGHThOCZQNzzm2svkaHDiwU+G2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKXEkQni;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFDF606D822;
	Fri,  6 Nov 2026 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKXEkQni
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C771F008A3;
	Fri,  6 Nov 2026 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965423;
	bh=w5RZHcMIxhwyU2L8aEreWxu5ISkiy3CoRS60GybIQJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iKXEkQnidpHs8DsxddX3kdjT3tEUo7P47BQimqfWYclcAK8TUNFEzV3YkifrVbIPV
	 L4mHbKvK3C04CDwdbFJVoxohIOI8Lkt4qBAgSmbWkcUK6NxS4UgohsmfxOe5JgyPwC
	 zfRiy2L9E4Oux+Qvo6CZqjl3zo1xspIowS2j522GVMnawOmR7Vm1K5Z9JGrCVYcl4p
	 99hhoupEPgq7nuqjWuI6DK3M+PJvOOSeu9fSzXND1tJBHF8wvOK6A1q1twCcOwB0si
	 xueDddj2GZrCMSpoMu8P62637ept8x6y002OIC09jKx1DrhfwhFLUBP7VUwBGoqr95
	 e+FwcGfFrlK4Q==
Message-ID: <sashiko-outbox-201341@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/17] driver core: Allow userspace to detect
 EPROBE_DEFER when using sysfs drivers_probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-8-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-8-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> commit b8c5cec23d5c ("Driver core: udev triggered device-<>driver
> binding") introduced the concept of "Systems who want to control the
> driver binding with udev" can use the drivers_probe sysfs to trigger a
> driver bind based on the kernel's match list.
>=20
> If attaching the driver is deferred before its probe callback runs,
> userspace sees EINVAL and cannot tell it should try again, maybe after
> loading other drivers.
>=20
> Map that deferral to EAGAIN and add missed documentation for the
> drivers_probe sysfs. A deferral requested by the probe callback itself
> is still not reported.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D8

