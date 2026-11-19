Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116577;
	b=IbgFJrjJ8x5pLgC01pyyPYSPBTTUSQAqzOnJ3wyGWuZVV0LjILZe9dJ7pxvf0fqTJOfH
	 dvgNvREP+DtAWI2j0TMKtE7jy1p3Nz/eM2fjZsxs/6+wZrx1TiiJD+lvbSDZstMSNgOx3
	 s7enUjy+A/gDKTt5eGzoX5CvKXWulVwqiWdeBPpwQZBSalX3E5ZoPkB96eLgkClLgzpsR
	 FWvzlHT0n/oApNsv4C93aC2IgR8OgPhpw5EqIsMOQ/hX5A4JWM6G658pDQio8EaJkoErE
	 jeLIK+mz5wTpwp91lUmSlNLwDuzuEtAcs/jKLxKAEZKBkfn45GgSg2BJUdHspv7ChDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116577;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4v1xgJ3AWjIZBw9Gkp+x1Du2jvaYn2Q8eN/irrMGvOU=;
	b=KN0ub/RzR7sheBWyY82Lx+lrUU1MhAf786N5vMsbZarvtiA/FzhkI1QVyo8ME3q76lh0
	 r4N17qa+ZKWoFgjeV3u96Tnf/zT3EwZnwD00qgkzdiry7mFumm/5PVippGACFrQ2E0yXv
	 ANRS73D3/u1KByeS8mC4GJLzYGTs6S8BvHI5NoagOgZNxUPWi1V+rQfbRwB+tuF5AnjSM
	 waJ2cY9SETUEHjLO0cpG/Nj+vejMk1B/OCj+R+X2A1sm11QEUHoy6FLWvXUGA+Jb/MFm/
	 sin2wFuoh+H6j3YnmIp/78+hDZiOWdg4PkcyG0kGkXBLPfu7dwWJumfZBqxCjyvWNng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aPWB9/iu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4C860A3827;
	Thu, 19 Nov 2026 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPWB9/iu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F621F000C6;
	Thu, 19 Nov 2026 19:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116577;
	bh=4v1xgJ3AWjIZBw9Gkp+x1Du2jvaYn2Q8eN/irrMGvOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aPWB9/iuHMm13ixH16cXpU33HNprDDyPmLg+NtWtBBGYExWZ9BJdUYbRGvR5LeyY0
	 lVU62Zc7cXw9QYS+qk2OIV+NVXLInvUxmt8URNSP6OI8oHcQLvB6zKL08FCldy1C3E
	 zUI2lmb11rIYIJ2M/LfwcQ7H7Y8tHYpQCFs71aEBm3tBk7bgVU9Z5hcBESm8+CpkKs
	 oNO893vnDTx9N/GlfChWvKQJuqCPVHU/pyiTOZSt3LPetPAEO9hHB1bkQAoFPGcah1
	 HzOJ7KVaUunUDNyKZ/YfsbYHQZ1xdUQgH+SkkNEbstz19GFGa4YpaOCpajtr4gjwwG
	 nspMp0K7JqCrQ==
Message-ID: <sashiko-outbox-223904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/31] net: phy: Use the compatibility driver
 attachment API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-18-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-18-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:36 +0000
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
> The generic PHY fallback probes directly before publishing its binding.
> Device trust admission needs to precede that probe without changing the
> caller's serialization, so use device_driver_attach_unrestricted()
> to serialize the generic attachment.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D18

