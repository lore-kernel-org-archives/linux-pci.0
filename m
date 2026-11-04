Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836526;
	b=qTy6E/lIc9l00mMHX2S3/gVErVfP6PxShBwm/hwMr+ji/uLXHViGZAzRe9nGPa0Kvcj+
	 DC0w6gc4zhjsSpuYAojqRw0ys9st/wtdF859pfBsHfCBcS77e8MIbmOKP/1zWuUFD1TOt
	 CVECeAtc750VcHkuBIl0Zioz+6JmSjz1sy15oJHJXBKo9I7sSiiD5m4cygthUpE1y1g44
	 vyiZPEgJ2Vq5//MSgyGfRVrTcVRVL0TRcSAaCzxYfXEc+tsXmqsonDDQxHwe5gXd1uxG0
	 t7Y5fkBv2zqdUQ4NAbiCkzG1y+rOvnduVcW/mwHd3NXtbNYQRNLZ2YCdgqmQ/+q1I2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836526;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=43g75szGokdn4ruwoSaU7YsMm2qWeQvbFq79UnD81TA=;
	b=an0yIUHEPaum0qKJAwDZLA7rKrJdRnf7F88jeACOTpdf26bGV+FRmdzCzMjnP+gNJ3Ww
	 rePzZWAg1QSw980+TMCTMNiki2/EvVs4ked8/AAPWkMY9/uvI8fFHRbG1NEor4wBB3leJ
	 fGAuUz8R6fyFPPbw0YELVVTOtl8NVXS9GVm9zffedXbDhXkJ5ZjHE9S2BlfY9KfSCE2aC
	 YTuUR+32yqQb2eU4aLsyAPRcIgkG9amHZ3GTzfn32LwoQFdzbsR7g3sZhY+YecWNznO1q
	 nC4N+8CSH0cN9ach/2jigKSYLxD5vqXxtDedObkGZaz1HvNEHB/UldY+nYEMFwD/zsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAx4waEe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594FF6082BFD
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAx4waEe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B206E1F00A26;
	Wed,  4 Nov 2026 23:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836525;
	bh=43g75szGokdn4ruwoSaU7YsMm2qWeQvbFq79UnD81TA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CAx4waEeLuRE7LJT0FYxcbzFWvmIGueQYxXKh1V9JsKS+6yaPCGgN7fP67Y/EC7Ej
	 KJurmBs9jCSFt5gmhE/+7wwkdXlrtHPHFIxWXIYHQvVxnU8mHXVC71HaIK9nIN8g9O
	 xTygqBTZvjCsAO3zlYtslapPm94rgRkkEoWM97JbrTbg0R7QL5ydCqMcA4pXmJdC7H
	 7bFie3ja7IFmAer/1QmSnMa++wLiI9JGhPK+HCV/mN+c4Waf7/BlK+lCBdHlScYH2o
	 tyEYV8na5nhaJb1tpDLYr8PleXrxwLK0i8+eW60XRDA22qdsWSfKCwJKrLf/Wf91dB
	 U97W0J4t/dVBQ==
Message-ID: <sashiko-outbox-198320@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/9] PCI: dw-rockchip: Move devm_phy_get out of
 phy_init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-3-0434b4f373bc@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v8-3-0434b4f373bc@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:55:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> By moving devm_phy_get() to the probe routine, rockchip_pcie_phy_init()
> can be used to re-initialize the PCIe PHY, which is for example needed
> after a system suspend/resume cycle.
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-rockchip-p=
cie-system-suspend-v8-0-0434b4f373bc@collabora.com?part=3D3

