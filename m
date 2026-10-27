Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104395;
	b=KxCuRt7ZaYk9+rtMCPgidZi3amlyt1XW/K1BN0xjnrBzv/R++hNzHYyy+TByATJ4t1y6
	 SXxyxKMut5e3S6jvITgYJf5mOQ9VF7X7F0jp5scOlIjR9MN2BrSTzZ47WOCKRVAXOG//x
	 /IVyGNVxXqjv9adrsRsgdz94cIKkR19HIPhK/1p9yUGbn6IEJ+W+y/VKbYF5VCxDR+lNX
	 4B2/eBG89zhdoM5iA1DoOW0b3JD2ctB1prCKiE8/XvnpQHCeYJurnq/laRO5je0HWalP8
	 NIKs7MZ9U3Dl9Pf5iLxxGC4XWy8CGyPV3G98Rkv9jdVjisx3PnbGHLyKK2XKZif/vdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104395;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HajeDsTo0B9cIhgONiMSBAHrY2UE6a9IhWYVL7Il4MQ=;
	b=1rR2nAhvBeB+r5ZdZDyT8JkIr+n9UNzr3EPPoRk6+PuzvHd4/aU704XX5/FdiidbjioC
	 Vhn3CSZNGXeW6iIjl1IzQ1DsUf3p2XU6cLivPbs++bhixEA+k28Sps8ZpMrrKMwrx6Kyu
	 rfqPzovXa+vO/+1JBCoz2w0TvH+oKpoCzw3w9VaPjtfXJhvyCu0fswJI/smzLIVTz+5Rq
	 sVkZKidVwXBqb5z2LshFpSC4MbDoyAtP3E5Xx/uaDynRly4wiihryfTTfOtIyOMa6kB1L
	 Sw53tU5vAqfc3LmHI8nUvlPmOwUHuMCr8wrQIYItc8eCecZ/EJfbdJPsVi94Z3s4E+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cuFOk8ZD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8A606A32D
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cuFOk8ZD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3001F01825;
	Tue, 27 Oct 2026 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104394;
	bh=HajeDsTo0B9cIhgONiMSBAHrY2UE6a9IhWYVL7Il4MQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cuFOk8ZDeVFLrbxQyVpPKUqV07hwAQoDEBU2cnHH5dSTnc6Yvy0YIDY2El6HWMf0H
	 DRYNTSzMX+a4GhQNmGIOsB9tDY/sTLdTAq1n5d26o8ke5WP97pYEqCjWwYJOQwkP50
	 6OTFYBGWMLnB+EeRUMsNJ5KZMoGvRb38vH0ShtnMWdb0TAh8a/v7W00SxVwgDNwjX/
	 /n9kMAIwtDaqMYG8bw6dIMCV8NSEn7lEut5TMJOq5Olk5ta8Y1sok6Y5KwDwrM62Pu
	 NfP5q8C3G7kmG7zHBXj84dCr3uSIfmQqvheihWXFKgpFfXR05qoWyOZfaykcH8ZbCS
	 vh5oqSZmOtXWA==
Message-ID: <sashiko-outbox-186560@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/16] PCI: dwc: imx6: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-4-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:33:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace the two dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
> imx_pcie_ltssm_enable() and imx_pcie_start_link() with
> dw_pcie_get_pcie_cap().
>=20
> Both functions run with the controller powered and clocked: they are
> reached either from the host .start_link callback or, in Endpoint mode,
> after the PERST# deassert path has enabled the resources. The helper
> therefore performs the DBI read at the same point as the replaced call
> and caches the result for later invocations, which is useful for
> suspend/resume where the link is started again.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D3

