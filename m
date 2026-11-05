Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905582;
	b=EzzJ1LVzeHIQu+RrxHBeP+/cATWkYE9Osu0DY95SKLDjTcgHPHHk2hlf1OlCwbKNvrUm
	 hZ2x5TsEElQkJpMaEWJIRFd5EscvLBAeTL5iyemMufAks6rDUNh+w3nvp4HvJK42l7rrL
	 Hz0JwHOaP2xHlfNlSLcmjuxYgiupkYEtAdUoPrWAzG7Znqz/WdwEPrIx7bmNUznYNsJdM
	 8GtWqT57z7s5HYt9AEwS8WdN0tcOoLA8ydiDwMHgPcOYA6BL6a/Es/YGMmbiNuW5o9Aws
	 w+KGvmO2WIZW2ZvTuhWdBmRx6ofH1g25nwAhuQ0ONADZW15oMvw8ZyQr0s48gvG4p5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905582;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ul5n9RPjoHsAHmuvW9LabX/GCPZ4vIhWxjLIuYFDM8U=;
	b=Z6znjmVaHwhk1fIc+aVayRVgWfEqvFsV07rz13KPIje1yMR2YjIeX62g1xEMtrU4y1KK
	 p3mW9KNmM+6ALfizOeq9iF21eX/E1FA9Rqk0ngUxYzdCEX9S9nAnzMQ7F0T+b8gtwWP0Y
	 Ubd6Mf8VclzBrNaEaIhTmR0dHDWmLLAKZFJmMqeTzmT1VCJqmLLHIwgjL9MPNis8kCyIt
	 DYpNa0/ypqYn5uwNs4Z7upjfHpxV1ivTIHpxL9ccO/9aBTGK5TB2En3yn3QAbjOsxGUwK
	 m4qGgMUs8E62cYqPhuNjxVtPK6c8n9VxoPVFglqRvDatHTUL8m7f3kwFm67ceLiexGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lddVdij0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB51606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lddVdij0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EFF1F000C1;
	Thu,  5 Nov 2026 19:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793905581;
	bh=ul5n9RPjoHsAHmuvW9LabX/GCPZ4vIhWxjLIuYFDM8U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lddVdij0f72MeODOq7NIpm73sMzCU2rjIvVZ7DGMvVi99AYAv4PU3tCcRBcsxuW1q
	 4DvFpg4maVpGAEx8ODwe8YXS96sxjt2+6EJrVVAlEtcZfQYpXCEJ4Lve+/GLE1RIWA
	 AM0eFrNI82crPFWOR4dreGeRPCPdBXdhFZaIzp7uU96h/IgyWMi63sikQ4pTjL1Wdf
	 eBynXi0xL4SFFHKBU0j0CR3+Q+9BDKf+cQ7DGQazc6Zx9oPPCuGKunzDJU4m06jTPL
	 Kny3nf3AZl1fTMZ6QMPSFSlBUpWHGR/aaeCAQ/umlwW+OiibRYqj7m2O3UB4iNxDhk
	 ckJk9DhEA9eIg==
Message-ID: <sashiko-outbox-199809@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 03/19] cxl: Move decoder declarations to shared
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-4-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:06:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move the common decoder declarations to include/cxl/cxl.h for use by
> shared decoder settings. Preserve their layout and documentation.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D3

