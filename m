Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079211;
	b=X6riQBqHYAD2dRbCjPMhtTuJrDHfz1mICcq93tqwqq6IHObT5P0YAjrNFQdlsaQE6mg+
	 ozTHvpOxUiNg1rKsTAOG0XrY+8dAXsLecroitgkBcX8Mf1aaAS+KkiDiEVbpuQf8jDwIu
	 pPT8BMvfIMkTfyNM75boFTkGPtFC2OucCVgRa8qIZQwi4UVu7wloCK+V0r+Ry+/L4vmte
	 O9x2y9u0sZ8hmxeSwBk1NCd8PhhIGEa6j4e2qz9oErAnbY/aWyjXje9A/kBLf6oMmkAgo
	 rgiVk2ULK9+gGfJnO1rzYDVBQxyNmq2c9iys8XMc7z62MOPt49zfn6zfp3Nt+TLElVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079211;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PGTSSLwXXH0GZdgMDEe0ntnGhB5Ms2vJcTvm8jK2P90=;
	b=Gqt1GMOKywmdyIjkmk4NpwlktLTWSJldeu1FiQW8CmDZHBsLGgJdToLTly+bc/1HavW9
	 mG3joGSV+QzIJz9ZRFZQ2QVsHe16yGjynpuQ5yOq/PzUIjJFCuv9Zvf/XBUcNA1HP/hxc
	 qTe8zQE8WDyMJ2r+fM2x+ENXXwlIpmHttagd3fRhUPjlvNzPMOraSb2ypHIreDN/gRtF3
	 kdqjm8DesUaIUcrDfBkOeVWtr8tBSJQwc0xlijTlV18loQP8HEkH+4g15BgO3QZPHHsQW
	 hYPSy3qhWf94yQYzZ+kQXl1mSDjIjlYlkQkxjkqd6M9frFdfiLDFxWrGFRG9rin2PlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArcEi74A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767A606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArcEi74A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B091F01825;
	Tue, 27 Oct 2026 05:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079210;
	bh=PGTSSLwXXH0GZdgMDEe0ntnGhB5Ms2vJcTvm8jK2P90=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ArcEi74A831nfINYuMwnevMJmrejLdsE1DSYNoUKQR+XWpa/NJp3TCbyiTHPy2zGO
	 ts9g4xMmBm6ModJBvjQ9bBNnQh1Q7QBSOWHv0gJJWcuwfjnx+MnDyMUdN9xwSXWPj5
	 rGJBUA9/hea+3pIrMRdsKzR+qkk+OgnpEKwZ/3l1Oe/f1VsatnC+lN1CVJl9rMl+uT
	 /FhZ0J1jN3uZZVQqjNGejgodY9kTNnl4prCf7q809UFxr59M4T46WuThdj7Z4jJ1t7
	 VBXd65LmJcjvTxKlb3QRa7zQoshLGH5ZsX3T36Biexjk5YWbTeB1H6s1EWMtoYZ7jk
	 lUcSQYHqWl/gw==
Message-ID: <sashiko-outbox-186122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/23] PCI/TSM: Rename pf0 to host
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261027052536.1722081-11-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-11-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:33:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Rename pci_tsm_pf0 to pci_tsm_host (and rename variables and function
> names from pf0 to host) as part of converting pci_tsm_host
> to be any device that knows how to speak any of CMA, IDE, or
> TDISP.
>=20
> This commit just renames the functions and provides no functional
> change. That will happen in the next commit.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D10

