Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B53B95E9;
	Tue,  6 Oct 2026 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276751; cv=none; b=E5rtUb4KX7r4KkrhQy3h0e1rKTcj47Ya+dBrhZwOIg/IPBXrGstqAVgQuAT48AR1XG0gIp2iW8kyqQHpPbKGfkwpmawNAZDLhQM+JMXfz6ZuX+B1CIAd2iS/OUByJGhFY+m37Pvm8RuY6yH6ewBdl7TcjM/IhFuQVUmiqon9N8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276751; c=relaxed/simple;
	bh=b3WoE8fFdk1EPk79z/3eFaeEbaOM4n4aBYZs3YMFriI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S7buu65UgY2MYsi0lHUTpGNtqhyzQXoDIgDEYNz12IxxHBK8Yj1lVt6iEQeGYS/UzciuZDhcyx29pW8iGDrmKvpyoOAvE5/om763lG3lt7ocBDR9eCWrxW/g/Jd69fLyJFezxnfA2/3zweoPGmnWukj7KgPgFieB6s8hsAPNhyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMzjKx/w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMzjKx/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA661F000FF;
	Tue,  6 Oct 2026 08:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276749;
	bh=b3WoE8fFdk1EPk79z/3eFaeEbaOM4n4aBYZs3YMFriI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NMzjKx/wQVp3F9ZMjEJVDZXWahQnPaOzsUY/SgLzVkvISL0XIv0XKqPm/6h3IJAUN
	 y8a2OP3OALImU04wM7giNqdrevD+SG1txvMj7g8QWRx/9IoXLw/HjObQ72NYSyI7Ow
	 Ehy0jx/GwwS9O4d9IKgmzeDzjKTpx7lQvF1fFF0RcaZAvMhNdYhftMbVww+Ye/abLn
	 oCN6dgiXE8viCuJr5IPaA7bNzlVv1a+5sPH2qXdM2dFieXoCq7tBRK/OaL7pzDOr/E
	 y5lvV1VfdNPJGCgzFWMaEVnL2bjFeogyn2hy3111s/8d41qBx/248jATR8N+Ya7Typ
	 UTly6IpNggcTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/18] arm64: dts: renesas: r8a779f0: Describe the
 PCIe AER interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261006084638.3821710-17-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-17-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:52:29 +0000
Message-Id: <20261006085229.9EA661F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe controllers report Root Port AER notifications through
> intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
> respectively, separately from the integrated MSI receiver interrupts.
> Describe these interrupts with the "aer" name so the controller driver
> can use them for Root Port error reporting.
>=20
> Append the new interrupts to preserve the existing interrupt indices.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D16

