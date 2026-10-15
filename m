Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2133E5A17
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035708; cv=none; b=epgydSaLZ5vqPOr9vZbx5Tsqe9bMEgrRY8TbYJhR3csEwIVw5J8xljUExWkHWgACgRtyAx3RTfO+UOEhjzZkGQioi4HaYeSEe4j+vgp0Ia1DPPeX+/VevxdZA3nBW76u7Yf7+Pl/7a+EXDbs+Ik5/Z4hr7ai0QyNQTQvprafUzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035708; c=relaxed/simple;
	bh=NOo3f7v/48bh3MlDJpDgug94P8LKvOgfYc9FEW2wuuo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MlDS7tz+6ZuM9j45ESfsjxFygEd1YW+m0jIlPCZQeDzlLFa8jVhy2GDFnnPls3utBAtFuDgstx3S7gvx3ZAypPkc9OyI75KT4VuBrKQw+z6nUXHwRByiUhvoco2PYwCC6y0rdMdbactmrI2tyd20qbVSs6M1DiarNZDo762PQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkqvTTlw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkqvTTlw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747881F000C4;
	Thu, 15 Oct 2026 03:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035707;
	bh=NOo3f7v/48bh3MlDJpDgug94P8LKvOgfYc9FEW2wuuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bkqvTTlwxr/mAR/SGAxqPRN37YvfRn8owYd0hUL79HCKraCTRIEwsUyUZSukdOsZj
	 Y8xSdFWgqpJ6R4hIzJ2DzngNCNcMNeDUFJFtn3Is0TSCKVanVNYbwtw6X9WMTA9mij
	 XzEEDuRlpTpna0ryoXTTLsgQIldSQkzYeQIDOw45FLxF+3s7GqCqQKQ9dX9DY6Vvq0
	 ZGCYtnZxVjQJlxAoiGuddrU4K/dHKOK4HCGMffnsSEm8RPjkOhPvHlA6KL1lJWHoG+
	 wDyMl/u2zTli6XHVXX8YAPN5DMyUz2/EA3QU9WG8WrmTVYuSSDnv+t7qxieMSH6rR/
	 9sUFVMOs8E5ig==
Message-ID: <sashiko-outbox-172212@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/18] arm64: dts: renesas: r8a779h0: Describe the
 PCIe AER interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-19-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-19-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:41:46 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe controller reports Root Port AER notifications through SPI 454,
> separately from the integrated MSI receiver interrupt. Describe this
> interrupt with the "aer" name so the controller driver can use it for
> Root Port error reporting.
>=20
> Append the new interrupt to preserve the existing interrupt indices.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D18

