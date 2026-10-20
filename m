Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484047;
	b=ANov/ULuEOjFunSe0yBxU9WWVWXGJMQNjN++GbO9LKcy/H1ld9iIZb48JxF5qdXTrWUP
	 gDl4VRVTyx+XTjOlQcy1wNNmNvSuYDWhasIPMHNPRtRyl51GQK+qAwLTm5S+hB5vEjCIg
	 iZAoPpnNsKNoERCAGnlRIeeYGbmThAkgK0aU3P6STK7peDqjshr8p5wVrqw31NCcjH7zP
	 dLFXkTz2i0le4WxRshDlRsc1SCbsO/Nf5ltKrPQHc1aYFMcAkZQojo6yCDVH8KDZCAzt8
	 cSzw64Qn0dXdzCJKm05yscFVh5SFck+TMvLKwd8Y+hbzV/1V1l3H7MiiaalBN5eAF/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484047;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lhfUrP0aHAeyu5VMqdYhWytgHI8DAEuvP7R+wi917hU=;
	b=bUf4Yxj1DeRjvg1hTIed/fRaq4aFwEY9iOOCXobN5XUakIllqaK3qCIOyLYVL5ZOZCm6
	 ij0mMkvEcVoyDF+/RCTvScU+JG9t5oQ/OAAUM7BpIzle6uNUSQ63UdLqYeB/rkhOMytiF
	 28+uRQhf6noO8fnFTXi+enV68D8PDmNZ2xeXrOCxnBPyzjo+kxZ+w4uSsHub6IZYbCZuo
	 1uZTzqyrDPRsmj17QrE/CNwEu12Q0XMLvXZria7C8CF+23YHKkVhkCEfxFDW68VaWjr9/
	 55f+R6Jx6rBPWczOfNLD8kwfK5ECdp6gpLlz4TCn/P6+xdf3ZljswU+oGsOiiHskWUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TrAq/dnS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BB3606A31B
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrAq/dnS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07231F000C7;
	Tue, 20 Oct 2026 08:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484046;
	bh=lhfUrP0aHAeyu5VMqdYhWytgHI8DAEuvP7R+wi917hU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TrAq/dnSAOGJ6zCYV3KubmOf1x13Xujco99papMKk8+39aAcg17aghRSlCaMbY0Bk
	 4rVXZc4XlpNBjmTR7vyBeg5vHda4GvVbiPCcqy2G2u1ZOAGCBwPUzYC9KEFm9suLgo
	 C+ly36u1zAPTm3kPq+CNVA0aFeibmvzYx41ojN1uDfg4L9p0ri31kEa77zs1Pk53A2
	 /8TcE56hyYHq7pHtGHyxfdGVUy/60l54aQ3jkeRxh64OGCW+T3eMw89zv8mzvj8/Is
	 Hvb0zahjAZVQXJxoAhxXPEfaUFNIYTUNId4p5SZpW3Q/FfSik/DqB506YCeS+oCi4y
	 ufC8MpqysYg9w==
Message-ID: <sashiko-outbox-178498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/17] PCI: dwc: Export dw_handle_msi_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-6-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:14:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Not every platform brings the iMSI-RX interrupt out as a dedicated
> line. On spear13xx and keembay it is a status bit in the SoC wrapper's
> interrupt register that the glue driver has to check and clear, and on
> dra7xx it shares the line with other sources the glue driver has to
> demultiplex. These drivers set msi_irq[0] to -ENODEV so the core does
> not install its chained handler, and service the MSIs from a handler of
> their own. spear13xx and keembay call dw_handle_msi_irq() for that.
> Both are built-in, so the function was never exported. dra7xx can be a
> module and has an MSI loop of its own.
>=20
> Export the function so that modular glue drivers can use it as well.
> The pcie-rcar-gen4 driver, where both situations apply, is the first user.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Shawn Lin <Shawn.lin@rock-chips.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D5

