Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6EE3E1CE1;
	Fri, 28 Aug 2026 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907273; cv=none; b=TcM+sZewLLhTcbn9oCgUO0V/IZywfpGGpywwU1UcplKniujPqvwbIAhVhT8VuX06b2Fi4f7PA/37IpK2qjn0PRk/91LMhYn89r9oZwDSDEPe+56strIMfUYrG7zlgvZNgtAEZ0hZk42t8olxmGiXtqT9eNBQkF7vE5eafNi8g+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907273; c=relaxed/simple;
	bh=zGIlfCrWZypKtawg7l8tdA35q/ldWHqoojDNEx7dEqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IaVJNIzqwlWkHxvACkLJ+Q4Tcdir4zjC0ognKz8lHaa0Ly9hhfwYK79t8awrOF/DVljSGrUPFi04iBnHt5+lHjOoAHLz1FgXaKyp4Moano1s6cooqwbI7SfqvhHvGpCPVmG6VezMIxMUtKWa6xxzVNvtoujUNe9RUwGsKnLSZ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWANWYiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWANWYiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96491F000E9;
	Fri, 28 Aug 2026 08:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787907272;
	bh=zGIlfCrWZypKtawg7l8tdA35q/ldWHqoojDNEx7dEqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MWANWYiIeEBCqWXk7wQYnkBg/CzdRsFhveACb5bu45BVTdXX4p1dkZLEu2V+we5/w
	 RKszJZvzgq6ygb1z5D0sgYsNAAZQMQcPG2S2n5dYFmI6iNfxwLZzGNkPQKrSffuf59
	 VpjDiZdg+T6fnvhNkr3rzGzMQWGpxFZUuxGhIeYY3ECzoDou3FEP2WVKE2ceAgwNih
	 MMfUecbhPX4PCjH5gaeLnl7EccvqJJWQr4QppP3mgMBeQ9xaOlICHn7Qt06WsdCIRn
	 5Fr/b2DkNY7lH3j77kK4jo6sSYfB20DOm6WUALI4BAJg/gGrgekXyW5m/cvOssFOsY
	 QDj45nF08GJ4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe
 multi-PHY support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: conor+dt@kernel.org, neil.armstrong@linaro.org, robh@kernel.org, olteanv@gmail.com, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260828-nord-v2-4-18bf59d19d6f@oss.qualcomm.com>
References: <20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com>
 <20260828-nord-v2-4-18bf59d19d6f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 08:54:31 +0000
Message-Id: <20260828085431.A96491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add support for the Nord Gen5x16 bifurcated QMP PCIe PHY.
>=20
> Nord has a single PCIe PHY block split into four ports which can be
> used in multiple lane configurations: x16, x8+x8, x8+x4+x4 and
> x8+x4+x2+x2. The active topology is selected through the link mode
> configuration register, and the driver exposes the corresponding PHY
> instances based on that mode.
>=20
> Unlike Glymur, where the PHY is initialized by firmware, Nord requires
> Linux to program the PHY registers. Add the PLL, TXRXZ, PCS and PCS
> lane initialization tables, along with the required power-up,
> power-down and soft-reset sequencing.
>=20
> Add per-port and grouped PHY configurations for all supported Nord
> lane modes. Also add support for regular PHY resets in addition to the
> NOCSR resets, and handle the shared PHY power domain by attaching it
> once at the multi-PHY level and reusing it across segment groups. The
> GDSC init is now done using the device created for the PHY itself
> (devm_phy_create()), rather than the parent multi-PHY platform device.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-nord-v2-0-=
18bf59d19d6f@oss.qualcomm.com?part=3D4

