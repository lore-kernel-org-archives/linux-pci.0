Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441677;
	b=BE15bwzxyShMtRXFXAUnOductJ+ADDtq2HwozWv8aviKdZoOYIe9Ut2DLChkWK3nkMOs
	 HEN80X4+0vMSuh22lFZ2TkVQQuar2ytWeLZoPLdsDmX8V1IAo0eNwWBbD+X5T04/v9wb6
	 WITZnY3vzN/JXkVoujYPfaWmOoYCx6I1fxVk/3mu1mmh4+vZN/Xfr0ni+XV0rZTrAJcC2
	 hn3SuB0VUmDxzkJHDrP4ny7eh+k0B1hKX3YmNMxJo3tHQFYGq6akGV4bZL7yl/K+3jHqh
	 4KgtEWExT14NpLijcrRJwnciTTE4ZfH8lty/WUWjdk4P1vrGGxV3vBhbjyheBHY7xjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441677;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9iRil8YbAwGP9x6lT3FD1INIcuPlDihTe/ieoBzrBq4=;
	b=WKAESosndscledL+80y5GFmnbgjsNqyfzysULpJ0WhDUdfD/2bITYCxcRD1MDHYeRD3L
	 yDZXawdhUEQahy3vjhfaoZOglP6Rs/kdxJHDtOPAyfx/pLZ6c4Q4O94uLft/rIqMqVgWM
	 aDeG1Yaj6WbzWfCzMz02aNVHhsmEsgCmmT5n5mEZvCEzDHsk2E9qeDWXWVa6xCDK54Llb
	 ruHd5u7yvbwBSaJdyU4oSBl1BkYBE2Pg6iuGPky4321HJsk2Djs7wIql9P5JVQ3RZ96i6
	 Eof9plkylgJEalt8LB/HqQvEyAwJfDuSd0UOZroY8o7GSmVVRg9a1V47hXWMI6gcP7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mr9+8yqx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB7606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mr9+8yqx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63321F00A05;
	Thu, 12 Nov 2026 00:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441676;
	bh=9iRil8YbAwGP9x6lT3FD1INIcuPlDihTe/ieoBzrBq4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mr9+8yqxw3VPlTHUHk3izW7Qk4Jt5JM7FEdqYwjSJSfSe5mnsSEfZKPTY9WBq754K
	 pq5k75IEQ1brN7x425iM0EotBfSaVyr61orcHw7ZV18+Ue5PkWLP9kW9asvDuPnZLj
	 ozG/AnOh5Mp68tOR2mFh3HAhK5hjGCGMSJUIWf8ITELJHljC8TSEQsPnmrD7GbWiTv
	 jNUDNQnKleXNCbo+svrxRpP1DckvaLKvc3EXHQqc4bBlN+GG7Wq51+HoqVngSoJaNU
	 M9pBmlNjnKg/yUUt+XpdrbXIhz5EK5wj/9E2LV8f6CoIy5zcZxW8jpa8Jiels/C2zy
	 W8SuawEyJIbFA==
Message-ID: <sashiko-outbox-209873@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/11] samples: rust: add a Rust SR-IOV PF and VF
 driver sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111223337.508989-12-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
 <20261111223337.508989-12-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:01:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Peter Colberg <peter@colberg.org>
>=20
> Add a sample module with a PF and a VF driver that demonstrates SR-IOV
> using QEMU's 82576 (igb) emulation.
>=20
> The PF publishes a pinned API object in its private data and provides a
> submit_request() helper. The VF calls this helper with its Bound device
> borrow. The helper performs the typed registration lookup, so the VF
> driver does not use the API object or its lifetime encoding directly.
>=20
> Keep the PF and VF drivers in separate files, but build them into a
> single module that registers both drivers. Separate modules would need
> cross-crate Rust symbol exports, which can be added once the build
> system supports them.
>=20
> Unbinding the PF disables SR-IOV and removes its VFs before releasing
> the registered data.
>=20
> Link: https://www.qemu.org/docs/master/system/devices/igb.html
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Co-developed-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Co-developed-by: Simon Song <xinmengs@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111223337.5089=
89-1-xinmengs@nvidia.com?part=3D11

