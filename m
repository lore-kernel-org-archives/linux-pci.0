Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC56374169
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827116; cv=none; b=hQYmF9T9OyJpYyL2t8jRpuayww4OvcrFfEU2XFfJt8t5rSuVmyuafMucEiLR+9Rt4EmozAuGSfCFfLZfNhLpypFFuVbOs1bTIulogCIXG/eZgWXV9YdfJ1pXk2OKRZBMIigt3CdybHQtFTcMtZyz9vbEgetjV5NWZB6hskuJ8QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827116; c=relaxed/simple;
	bh=cXkZLky5MbcU6eBwYE8DRO40KCrg10MY21CbpzC75Ao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WFyInsPDcmvznwdzfv6KEYjy7sOpFOl7aOWPLNWZ8BHSFwKo/c4Lf6hQ7CZh9xsV0WJO6Kw+83h8MEJDfDIdEBU+ZDvuTdgNI4d4Qf77NUasPEjykBF7IkRzT4OHssC0wNZYMnUgTBQPJXfB7pfUiA4QSK0nPoFky6mUnU+kEMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cogIiIs2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cogIiIs2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FFF1F000E9;
	Thu, 23 Jul 2026 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784827114;
	bh=cXkZLky5MbcU6eBwYE8DRO40KCrg10MY21CbpzC75Ao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cogIiIs2guG0XrCYfytxDweNmRXVYTL+vCpyBxgeAqlZUvVYcdXEE+5y2atWwILxF
	 PTPhbwXwcro6RfhJgqrsdDVRygjZSepp+S0M4yIjo9NueZ8jPTSHfSjOzTS7BsccJ2
	 nkzrKVSJVYAW6IosDXqkBRQHLEWDy/kYrepNTObTePdRVLoNKuO9r5tk/zuYBV3C3k
	 1fagq9VLlX93nga0HVL9fu8aFSnYZD6RsARATPFrjtKMaUTjMRQNUuR2OEiHLK4CU1
	 zWfpwcg+h7DAiK07GPG6S1ZHDkvHNymgaA8ujx0kSh5ISIHcDmdBFSW02QJBtbb0v7
	 WnXYP3gcNgVOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Fix 32-bit config write in Intel RP MPC ACS
 quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamad Raizudeen" <raizudeen.kerneldev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260723171203.4892-1-raizudeen.kerneldev@gmail.com>
References: <20260723171203.4892-1-raizudeen.kerneldev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 17:18:15 +0000
Message-Id: <20260723171834.17FFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The pci_quirk_enable_intel_rp_mpc_acs() reads a 32 bit DWORD from the
> MPC register, sets bit 26 (INTEL_MPC_REG_IRBNCE), but it writes it back
> using pci_write_config_word().
>=20
> Because bit 26 resides in the upper 16 bits of the 32 bit register, a 16
> bit write to offset 0xd8 completely drops the newly set bit. The quirk
> logs that it is enabling IRBNCE, but the hardware never actually
> receives the command.
>=20
> Fix this by using pci_write_config_dword() to ensure the full 32 bit
> value is written back to the hardware.
>=20
> Fixes: d99321b63b1f ("PCI: Enable quirks for PCIe ACS on Intel PCH root p=
orts")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723171203.4892=
-1-raizudeen.kerneldev@gmail.com?part=3D1

