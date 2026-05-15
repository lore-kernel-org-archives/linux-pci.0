Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C43E3D82
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831112; cv=none; b=ZSIqYk/b1eBcWFHshqNanZiCY+BV0aYLjZa7lkKk48ljy3XF0VKdW3pfZuq1z65Cb/NNAaJjpCDfktzSacW4DgivZfTyhFtZSvNmrMDfihCnLA1W01fzUdttn5k263+pBisFPmgeAp6Rbpn603LT2jrEq64EW6UGsTZYM7tuFL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831112; c=relaxed/simple;
	bh=cdpVN0OdIZQKhvDD+A6vzx/Ujqoy+9t4M94GE4vNgtg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LUUZjAxBOnhz0uD76AfeWpCt8ttrOFA038dMaWPNiEfiWErHRKVjMVTxs2Rd6s9DwPnu0nsgAyskpMi3omNlYxi/Xwt3jNfx6sWEXOG+2XosKfCrLAe5BQjByHPMSbEyK51S2I0Vx3BnTOoxUTvKk41plKstIEqjdm3F2BqlR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttFf6kmm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttFf6kmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D727C2BCB0;
	Fri, 15 May 2026 07:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778831112;
	bh=cdpVN0OdIZQKhvDD+A6vzx/Ujqoy+9t4M94GE4vNgtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ttFf6kmmGb2zAKai6E/rk7nQ3flXDhd/N1rdfGe0ickmDmHHBaqjTAbHOUikFOhvL
	 vAwuMrsZZCQB30/m1vm+DLinJkP7qXhArdvp6ZSanIteDF6ei9oKkt0o/i0vduWwDf
	 YbG7vz2m6cPO5jKGAfdybdHslSS//sfzRZ3fHvCt6mMVpVCjtjUnx/QuzrwRU7Cq5l
	 phk2vBYkNzVDysfMPlvfFOpQjieCil/kFzyMnh6sDhretnK50tvcs3ihB7c9q1y4dc
	 qIaoSnOG151gTulSBo+J3817yFMIMl62YOdKB/b6YFvTMivUauRtycv/co9+Z68b5B
	 Fe4afksQSxj5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] arm64: tegra: fix aspm-l1-entry-delay-ns L1
 latency cells
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260515070753.3852840-3-mmaddireddy@nvidia.com>
References: <20260515070753.3852840-3-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 07:45:12 +0000
Message-Id: <20260515074512.7D727C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Modifying device tree hardware descriptions to work around a mat=
hematical bug in the driver's latency encoding logic.
- [Low] The commit message incorrectly states that the driver converts aspm=
-l1-entry-delay-ns to 'whole ms'.
--

commit bbff94096c8fb5346fe688ef1d463490a2efe6df
Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>

arm64: tegra: fix aspm-l1-entry-delay-ns L1 latency cells

This commit updates the aspm-l1-entry-delay-ns property in Tegra194 and
Tegra234 device trees to larger values to adjust the L1 entrance latency
codes programmed by the driver.

> The Tegra194 PCIe driver converts aspm-l1-entry-delay-ns to whole ms
> with ceiling division, then derives the Synopsys DesignWare PORT_AFR L1

This isn't a bug, but there's a typo in the commit message. The driver
uses DIV_ROUND_UP(val, 1000) which converts nanoseconds to microseconds,
not milliseconds.

> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index 1d659454a6f9f..7bbf0e892724d 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -2382,7 +2382,7 @@ pcie@14100000 {
>  			nvidia,aspm-cmrt-us =3D <60>;
>  			nvidia,aspm-pwr-on-t-us =3D <20>;
>  			nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> -			aspm-l1-entry-delay-ns =3D <4000>;
> +			aspm-l1-entry-delay-ns =3D <8000>;

Does this work around a driver calculation bug by modifying the device tree
hardware descriptions?

Device tree properties are generally expected to accurately describe physic=
al
hardware in an OS-agnostic way. The issue appears to stem from the driver
using order_base_2() to determine the latency bucket. For exact powers of
two, this returns the exact log2 value. For example, order_base_2(4) is 2.
Code 2 maps to the "2 us to <4 us" bucket, which is insufficient for exactly
4 us.

Could the driver's calculation logic be updated to handle boundary conditio=
ns
properly, rather than artificially inflating the hardware values in the
device tree files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515070753.3852=
840-1-mmaddireddy@nvidia.com?part=3D2
