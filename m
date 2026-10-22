Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657531;
	b=Ytte59yo6UVd8xJudxZ6LghXN1yc/Z0us/RtPVf1EcS+3ME6tKGrEBafruap4SAyX6TQ
	 XpBNXKnxT4LT4QH8mDj4GbPoyVBO4QmEMxXbgaMe8ko4lVE097LFGBqHnNEP+09aswiVe
	 9f599x/vDeuV5g4kZ6beiPc8DSr/YLiD3fXzVvVQeEduBEBaPAEbDmiOxaUkellZCxjqc
	 PF8bpR53g7xZoL5vyMO6/R0CNc/lFF8e6bJM53mMXnhViG7Irpb9jApG4erkb9e/mQ2q8
	 vsXaaJ5G3q3nAgltDOXyMyURQYddy9uevS3aid4+dHIwPC9+EqZ3Gx9y52/7TCu90Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657531;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ix6PtMUhR8s5TvCFmCvzRh6qQmj3i66cc8lCneFEDjI=;
	b=CuGbnBwziGBjR0V+3XNXabSeKCNKte3pix56ukd1CUWy3FsYf0sjadhIm+mZFd1YLVKd
	 9ar2A0J4FIEv42pRu8epnNR3sCdDuQN5juR/lpiiDW60xyIG8jBJkyFrtZK+Qlv2gltSZ
	 SBfwW3VUcdK1BlF6yo0mb/t8tcNdbdWvVEelBVar1Y3XH3eM3+wy+IGns8Os1dV+sP7Ng
	 xUSqakGiDGzG3dmbFilD85ddiTkDnDFi1CsEO/Ijx1PHdkWbCzxWsT5x4lNb3V/pCGkmL
	 j7INyKMhjvV/p0VfGImz7qjQbSWCDpvXzaDiif7o1WBqJQ6aPvYEL0ZYUDMCJLPG4nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+VBN8E+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3436606A31A
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+VBN8E+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469181F000C2;
	Thu, 22 Oct 2026 08:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792657530;
	bh=Ix6PtMUhR8s5TvCFmCvzRh6qQmj3i66cc8lCneFEDjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F+VBN8E+gV7AsXlMbDTrTerF9pii91aBuW4GPB5iCfv4jAkxTbSVNd/RWle6s2mJR
	 o1z50kbcD4rk5I7TD5/SjcmQxpE7U6CekFf7CkDmKvzWM0+7CSqB141YhrkMPT6Ib/
	 3B4Ktxmj1WnMrLHQceSbjhQHsfsd62fKUtZuRJchPU+cT0McGUSQbUtDvaCK/YSHsm
	 fipk8C0GN/RoBOv33d3SFbbLtWsM3qoXiaF/QV2M+AAjWGSq+OHnAYbDb8ZqzccitX
	 vyWbOaG74aMJwIOHc9NaLQswGyDV85OsOCyERO2NEheOh+hlYaSYc/8xmNGvtUBDJL
	 OzjJS+XUZiB8A==
Message-ID: <sashiko-outbox-181162@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/10] PCI: endpoint: pci-epf-vntb: Move
 epf_ntb_is_bar_used() up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261022082230.3164834-4-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:25:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move epf_ntb_is_bar_used() up so later BAR selection code can call it
> without a forward declaration. No functional change.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022082230.3164=
834-1-den@valinux.co.jp?part=3D3

