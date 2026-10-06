Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FB3B8D4F;
	Tue,  6 Oct 2026 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276645; cv=none; b=ivOMItGiWP/M9TAi9Bqh6hP9owSlNFiuujAr2+6vsctMVIEZadxPrHe5YbnMgvxo0FEfh8x3m65J4vaGsrSDXh6ac9M54P3xOmh0H5ewLQGpmYZaek2yq8XPZ57GYVc1Lik0f0Ltfih5isQmj6aAoAIDx0esFxkS7nTAz6QfKBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276645; c=relaxed/simple;
	bh=kVzDmezynu5cP+BnNo9Ugdivv7VcZQtVpmeMKHLqTYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQ/d0vLqsdf4SoqAFtPzGwIw4TwB6SN7OJclIUFyYos7S4FsJl2n3cE4I6zGNMkBFsmULojwH2cu6nEykRvhBbhbuPLGJ0QYGpjezsjoknWoJVKoYtlRkj4yy70YcSYeFOozClydTzfUZj0BBqaYxdVTVwfI2Fr31cNWQz+J5Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0hQGXUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0hQGXUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4041F000FF;
	Tue,  6 Oct 2026 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276643;
	bh=5/wACKJ3G24ZOf/SdXfl7bWReHeWcJmXCTvAnVuAFSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0hQGXUFqBpQ9WPPwbz39q99EbPRg31J+I3zIGOn2lkWVz/hq+5kvmkEu3Niu224m
	 nr4GaRl0sZtb0UuXnRzhXE9qtx7JYc4FGwsv4D9Qqb2nMdTeMyfV4mNzAHjK91/2Wn
	 Uc0B9xKazSBlW59inLudMAUmr6poh3+9Hm8Wjc5kOylgpPD2Vl2aHLooIW/+RWC8D4
	 2GAilraPFjW3mqZDumDKG5xQqceu1O7aRzxZkWpsXZq7prXPNh7fK0PbEs2dwvccQn
	 YrTmdJqvqK7QtiphLw1zbQRBWkGDg4nuHxM7TxSiJw2GWM9hZDCA/wYiB5BBYslKAO
	 JltyBRAHn5Kaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/18] PCI: rcar-gen4: Separate hardware setup from
 resource acquisition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261006084638.3821710-9-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:50:42 +0000
Message-Id: <20261006085042.AA4041F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Factor out the hardware setup needed by Root Port recovery into helpers.
> Recovery needs to reset and restore the controller while keeping its
> clocks enabled and the R-Car Gen5 SoC PHY initialized.
>=20
> - From rcar_gen4_pcie_common_init(), extract the power reset and mode
>   setup. Leave clock enabling and Application/Local reset control in
>   common_init(), so recovery can keep the APP registers accessible.
>=20
> - From rcar_gen4_v4h_v4m_pcie_init() and rcar_gen5_pcie_init(), extract
>   the SoC-specific register setup. This allows recovery to restore those
>   settings without taking another clock or PHY initialization reference.
>=20
> - From rcar_gen4_pcie_host_init(), extract the Root Port register setup
>   and PERST# release. Both paths need this host-specific sequence after
>   the per-SoC initialization or reset.
>=20
> No functional changes.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D8

