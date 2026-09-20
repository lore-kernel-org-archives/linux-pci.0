Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFEF3603E0;
	Sun, 20 Sep 2026 06:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887294; cv=none; b=V8TyH54OwJz3foPQNj+GFGH+Qcxzx3E5LygQsDtzWZXUuf9RjvmRIMEOaAMPs8onWHMUAS7OaRWlBabZzGUCTuueB0DNRaXYLjZBbc1uLHmsr2GFEsHjnYx402xQ5t4+VXto9aT0pTMcU6xTcP4W0CZgGWcY01XFrioHUWlyB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887294; c=relaxed/simple;
	bh=6mN/FowLjmR0/UbkgfuwKru9RQN7sEsKwX9on/rTlSQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BQeev0YO6T9okGS3Ug9OWGP4FNhGvHlLx08lFLei2aVqQI4XcYFMgpiw0VKVJZeQUJy32y9BxEH9hs/uCkXKzVgbuuJ7CprV+ApyQOM3mrobitc2WAd/HmUOUkHk/nGb7+38RaPg7ca8HyjvQpMywKzsReBriW/Vx2VnmEKwbGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba7ntHvN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba7ntHvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E191F000FF;
	Sun, 20 Sep 2026 06:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789887292;
	bh=KEuH2EAzfUqyNX9a68w9H4vTMXeVGfHbJWfU3V+VveE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ba7ntHvN+gDZfWbdyyP7ukRrMIOv3vx6EaM1bdQ9fOrQjfuu5F0RPXWeXDlJYb7Tj
	 4wtOfOa3R0jk3LytOSOHvCkQtd5sX2iEEloklggpDknm0SsOy407b0ZIA28Kr5QG0t
	 3GgZKZCLPDNtTzlikiSktzTybF+OsDx/i/ZJZF0NDxKVZ//keDyKPFCN+yWJKDL5Ej
	 noBrE1ap5/P6s7tvvI5uX7VHrI7owqXbuyqot6uJu5nbqz/lfMF14NmosLni0vbxi9
	 9iO6mjLUwvhMxwjSNyBTJHQAFtQRtMCg8GeE45c+GWXzqPj48B6GVO36KJrU95qHun
	 iaC52C8SX/T0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 07/12] net: stmmac: dwmac-s32: Add SGMII support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIFBldHJvdXMgKE9TUyk=?= <jan.petrous@oss.nxp.com>
Cc: robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, olteanv@gmail.com, neil.armstrong@linaro.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-phy@lists.infradead.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260919-s32g_serdes-v3-7-9d68868c1e89@oss.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-7-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:54:51 +0000
Message-Id: <20260920065452.02E191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
>=20
> Wire the NXP S32G SerDes XPCS PCS into the dwmac-s32 glue layer so the
> MAC can run SGMII over a SerDes lane.
>=20
> Changes:
> - s32_gmac_write_phy_intf_select: replace the hard-coded RGMII selector
>   with a switch on phy_interface so SGMII (0x01), RGMII, RMII and MII
>   all programme the SoC control register correctly.
> - Add s32_gmac_pcs_init: obtain the phylink_pcs handle from the SerDes
>   subsystem via s32g_serdes_pcs_create(), keyed by the standard
>   pcs-handle property on the GMAC node pointing at the SerDes XPCS lane
>   child. Propagates -EPROBE_DEFER if the SerDes driver has not probed
>   yet. There is no matching exit hook: the device link created by
>   s32g_serdes_pcs_create() covers the lifetime.
> [ ... ]
> Tested on an S32G3-VNP-RDB3 board: GMAC0 links at 1G over SGMII and
> passes traffic, both in SerDes mode 1 (alongside two active PCIe root
> complexes) and in mode 3.
>=20
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-s32g_serde=
s-v3-0-9d68868c1e89@oss.nxp.com?part=3D7

