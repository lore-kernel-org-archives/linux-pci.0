Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658088;
	b=afqCwMGg4j18VNwyi/q3CPT/ky4BsE+iAJ5wq9ckRtgZGoDm/GPj4P2xbVeoGdlJMCQ9
	 nBWk6fRx9IHaR1FSa7pNVMRXsa4hNpnnhPerWOQbXe9W/B5RTafJ4alwxfMf++rXfSLOr
	 nXnBQFCRR+8s9KH6qugnG6WZq0da811khLGPaUuq1A3ZDJNN4jxxqXC/MguuZKWdUqfqC
	 K4dCLkMJczhl0tYWEXUT2HxmDsG4Sbo4ZE110dS5lIwVpt1ovG6miRRVCWeQyXgDoMB9e
	 eite6E/317UkvcJPmMogKEHSeaLLHQysqQDi0n48Yadk8CEjHYbX124tSEdGPsUPC7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658088;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TDijoXqVL9OIsPo4Cdj/mpcE1DZssYaW8qYJ49UVyUw=;
	b=R5MVUMOYOK98jla7sOI1i6g2UTWBSLqm64Cg/5kXYjb9iMKQ9Z4vExsf7xBIOPGvA6Oo
	 DXkKiAdmLK8XYIMyfY1f2BwLFnDqnMa/Bgv0pBOHQpVnRCpLapEcROXqutKSsqfIcrx6R
	 naIIIh/q+c03X3vPQa750j8dy8bsSl8ksf/o88I705Z/5j66Jeqptkdmkds7onevTRaoB
	 od+RONnxgpHddIpWmQcICMdBzyPKE1QVYgw0ReFUDvDXA3atk2uMuIHX3nTroAYyvzFyZ
	 ER/jncVM9O7IxW6Ngk8FsLkE6O0i5jat21s/RwWXKgdor31MBOKQPSOgjWiFsNx33iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEUazSvH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD18606A31A
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEUazSvH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906831F000C3;
	Thu, 22 Oct 2026 08:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792658087;
	bh=TDijoXqVL9OIsPo4Cdj/mpcE1DZssYaW8qYJ49UVyUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cEUazSvHro0+0W2syCZzD17niP0yqeoxYclMn/2IQr1iMcbYtIxNwP/wCq7onwQ+7
	 uQxsfGMISqe1NHX4v2+oxgVoVW6+X9WNEzWFgZTR0ykFba8cKrM36UGfBS8VHYFhcs
	 ROgAom0xTnLQ4e4fvqWV7p95CMz4J5JUhyZiv79RPprBZ9jE9YsmFxtYrKHoB9dPPr
	 QXCdwluJKhKf1cKVUqon94GncBYtT08/CHG3UVckVfFp2GtHSwrzlhftYISjWJNxjR
	 8/xHvL+HsL4HkS2HYW02xh+8GLdZc/JTNikXxZ4/gOdgSeq8mUfcM8uO5ZBeijAZZ1
	 j3aZ/5C1bqTeA==
Message-ID: <sashiko-outbox-181186@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/10] NTB: ntb_hw_epf: Support DMA and MW sharing a
 BAR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261022082230.3164834-11-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:34:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A vNTB endpoint can place DMA resources after an MW in the same BAR.
> Limit the MW to the advertised boundary so clients cannot overwrite
> those resources.
>=20
> Advertise this support in LINK_UP, including when DMA is unavailable.
> Older endpoints ignore the argument.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022082230.3164=
834-1-den@valinux.co.jp?part=3D10

