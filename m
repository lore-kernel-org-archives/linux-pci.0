Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821023;
	b=nXt4pqr6Xj7V0XgUyqJSZaGfHxREluAhqM0+rBPvCq835SUJ2yuR2WnQgGguEe3SqhNv
	 CERnPmC7OI6iHfBdhZlPCKnZaVE536TQRcH+9QAhM9+3O0iqjwc9kWSR7PIXvl324s309
	 PPPTjkNGTNeENt3MKEXIlnJx46qaAQ7eySEZezXqGc3YnAiOpGlSKgc2YVM+gzTK2s8qF
	 +iunQrkmeLiHtAnmmoojbkjvoanfNbalGpQKOYVFEqsz/pNMEHbaA49YIPfs4w7TJT4zV
	 CA+we0yyJZjo4sJhGF0Z4aeJTDwsBF8I2nwNtOD3dlJK4ZHiGGfGs0j5dNH7lGnlUqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821023;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PeG1Jt6q4kwcyW/AYsgK5OvU0mewu4kQWv5V166rLJ0=;
	b=jeo/jo8gxhAz5Cq1QwccVeko4P5hIeJf+a7IziqEm3KcUkCK8Q9WBo1IKogCFmlboDf0
	 3fpkHK/d4QLma1cszAr0R+JFC5kgDt1EbD4nwAxSx779On/Z88MwYC0E+XLXF7ZXCV6fZ
	 +rC+929PJwYhuytcMb08CplEG3LU2DJIVHNILph0QAicSYYxbZoh+JA0z2xEhWYJdJ4+E
	 I4NZ4i3OPAjxbn0wGJKIPPqVh1JdwToe80vRN2cKnyRMVM38mZx8Dll7tcb458wUDQEIN
	 qdh55unBtDNCK88ANSeM2tumNwZnnQSIeO0g5dPGrm5JYIOb2gQn8JbLVZ8x4jMgyOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lw3NtkFV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F2260A2603
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lw3NtkFV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDE71F0093A;
	Wed,  4 Nov 2026 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821023;
	bh=PeG1Jt6q4kwcyW/AYsgK5OvU0mewu4kQWv5V166rLJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lw3NtkFVHF/DnvgqVxDlDd3jn7DBtHRwdlIMsO+X7fbha+4XTExGi0O0XXbd3owXa
	 5QDpcPTNkYzmGLNjmW7oNk9BvOeVjFXoNxwz5xqcaf7Ub1e75MomyetzxzGcAEki4G
	 1aQXUeJ9dK3Oa03ac5dj28TGNUNtqcVyq03YVdTjDh6nyW/gqOYeT6AAJAh45Ck6aJ
	 EAFkSlKqfDXnHUcqvce0n9GlyaUemqkeqKNfH6/ek1zk52t8dOI+4BogBy7tQkJV92
	 nRFCdHLcJ/UBWa+YcrIwddAUkflF7+fQhg6vJcOiL5a+0IxDTytlYMhHX6dhz9iW/y
	 OoQx0KL+JDCaw==
Message-ID: <sashiko-outbox-197965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] PCI: dw-rockchip: Add pme_turn_off support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-7-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
 <20261104-rockchip-pcie-system-suspend-v7-7-6ae6875939a2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:37:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Prepare Rockchip PCIe controller for system suspend support by
> adding the PME turn off operation.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-rockchip-p=
cie-system-suspend-v7-0-6ae6875939a2@collabora.com?part=3D7

