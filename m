Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B453DAAC0;
	Sun, 20 Sep 2026 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887305; cv=none; b=LMCIaXmwuS5dcK8jjJuKELNnquneFTvPel8twSss7aXJLrR0h/pSJO+KeT5ie/USR6VYt5FlmbMZ3X+i8y+pc68T3ANuy6i0s2TYp56Zg/HHTGuZ+L6f+qKrFpTyGgpoarKtly2pbCFoFL76TfMH5X/e5kHi5Qy1Ma2ppwKrdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887305; c=relaxed/simple;
	bh=XIaaZtBOASwyTKtjXFj2aO5+vKbghZT1VZdAm0vFI9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OEWjy2Bd1qUI4XDKaNirfrGBoYtbAS+FDinj7oWpQSgJU7J2PFcp6NOrJ1OdqFmi7gJvxdhPaKXC/hR//DaeQDGQKrZ5SayRzUrbONiRBENo3jAsmXJ1g5DbHghHiRoglx5CVl9nHvGFzDDEKwbA0LnFuyFfy4U3UtJf8NbUj3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAm3aAgO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAm3aAgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915DB1F00893;
	Sun, 20 Sep 2026 06:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789887304;
	bh=jphBmYPzMwPlIjB52qdb9Xjlf3297t06mdooQTvMhRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EAm3aAgOrBXh4oh7rsy8h/PBRLbbFow3HWgDVGZCPYwGPuCwEdDLN3CY2zgrA5TKm
	 1zJoVELBtx+KDBpIkwvvuPFOwYHAPg0hWTLLsbbJFrU4MhmiIy0LV8CNlI9T0q4A4u
	 BKcouMU9m6pJzc5JpXvF+NWW5VsNwEYNtTh0KyXhAfroYLQYtM+sJYa4zKsIFYr68f
	 fmJVI5wKc6GqSAMznPMlCm+ax7B8GmO7Xi2Jn0yq/UR0GtM/oj8EO9h3izsEvKuuyX
	 IC/87i05/gzwHbTL4+DVhz4N9+McMywdH23cF+AfxprmZY+nBjNk7N1T7OdY+0pIlb
	 9ND0Y0/I42P/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 12/12] arm64: dts: s32g: Add S32G3-RDB3 SerDes
 routing variants
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIFBldHJvdXMgKE9TUyk=?= <jan.petrous@oss.nxp.com>
Cc: neil.armstrong@linaro.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org, wsa+renesas@sang-engineering.com, olteanv@gmail.com, linux-phy@lists.infradead.org, robh@kernel.org
In-Reply-To: <20260919-s32g_serdes-v3-12-9d68868c1e89@oss.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-12-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:55:03 +0000
Message-Id: <20260920065503.915DB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
>=20
> The S32G3-VNP-RDB3 board wires GMAC0 to an on-board KSZ9031 RGMII PHY by
> default. Add two device tree variants that reroute GMAC0 over the
> SerDes_0 XPCS lane for SGMII, matching the two SerDes lane layouts:
>=20
>   - Mode 1: PCIe x1 root complex on lane 0 plus 1G SGMII via GMAC0
>     (XPCS0) on lane 1.
>   - Mode 3: dual SGMII, GMAC0 (XPCS0) on lane 0 and PFE_EMAC_2 (XPCS1)
>     on lane 1.
>=20
> The SerDes SUBSYS_MODE is derived from the lane child nodes present, so
> each layout requires its own board device tree. The Mode 1 variant
> enables both PCIe root complexes and extends their root ports by label
> (pcie0_rp, pcie1_rp), matching the RDB3 wiring: PCIe_0 reaches the M.2
> [ ... ]
>   - Mode 1: GMAC0 SGMII path up, and both PCIe root complexes come up -
>     PCIe_1 enumerates the card-slot NIC and passes traffic at full line
>     rate, PCIe_0 enumerates the M.2 slot with SW17-2 ON.
>=20
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-s32g_serde=
s-v3-0-9d68868c1e89@oss.nxp.com?part=3D12

