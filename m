Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9BE231836
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035833; cv=none; b=g1FPm1aiuMtE3+MRlICmQsLnPM/Cg/bC6bRHzc3zRErHowtYld0a3takqj+GW6S/6U8R5EGbFRbgnyUXt4CqNBSgsHO9RJ41gGy08Gu5ITgl+loG1ELV38hOLI6wgVRUiuyuNhnKQ0uJBVrB0bCNRDFtOJ5r6wfKyWjs8h4QuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035833; c=relaxed/simple;
	bh=cwT/0p110pDJubITVgRo6aBrERb8AF5JLc/DYU/qd3o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mHWTihI5JK/yi7Np/oYKHnhEdJid5Xfo6Ui6YFHd2jr2m3nMWG4hz9zuGApr7UCVYZKHQvtxoPXnDqpfRPtuKo9N5bT6MkSeNuTskJpVcTCE7crsEZXN3dcjCG7Pgw+CkMqdy5D+ImAo2hoItGIqAUOFOVsc52vdpcVtduitQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7PP49nO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7PP49nO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A181F000C4;
	Thu, 15 Oct 2026 03:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035832;
	bh=cwT/0p110pDJubITVgRo6aBrERb8AF5JLc/DYU/qd3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h7PP49nO49Jx7Vo1Uqw5aeTgxrBuvC7ZR8uHOMi57CGiOJLDr/cN7iKae7FugGHA3
	 xuKtlIMqLZjdozsL1+W/wbr0eOpZ+tBLqyvblz/bDGPyIkvs7Vqx8Y0B3SV5ao8yqV
	 aM0oeOUiToLfqb2yaNPoPEY2wYkWLY8Bjo5aCv6G4zG0NGA/eQdXIJcPj5XdluJ7fG
	 jr982MEUEZ9NU4dBnIUm4zZppCMAsDXIqevJiDrOrUTPdZD1Lw2SG3GcI5eWhyURYr
	 ATSDbygcDy19mPDMVHgbwKflszyzXMTFjg/LQkAwrtD/W3QScIE3eSpGnF22dw6Iis
	 xBreXMWbDSnfQ==
Message-ID: <sashiko-outbox-172219@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/18] arm64: dts: renesas: r8a779g0: Describe the
 PCIe AER interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-18-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-18-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:43:51 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe controllers report Root Port AER notifications through SPI 454
> and SPI 461, respectively, separately from the integrated MSI receiver
> interrupts. Describe these interrupts with the "aer" name so the
> controller driver can use them for Root Port error reporting.
>=20
> Append the new interrupts to preserve the existing interrupt indices.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D17

