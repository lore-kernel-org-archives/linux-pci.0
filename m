Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D13BBA01;
	Tue,  6 Oct 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276927; cv=none; b=NEFrY4Jfqz2eG9wCfkERb5cctasx2ZN8AWHCAAc7iNcqjJntH9NCuj0ia+dyJgeEddyjcYK+ybXApIhSh+cfNtj8HCiQcACCX4iu1Q9tJCmIshqVCTEBT66lMgLJwEQQ1NxKhNAzwZKS2xKAf6P2InZACtIbXThiqDgPEcxKSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276927; c=relaxed/simple;
	bh=pMsOVgZ3Mu8XUdmvXLR2GtSjjbVAancpcEW4H3aJtok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VgChhOhoVrGMbXE1TjxydcnB3sPTHrWOqjYjl4qXOkpzJX2k6r31VhgAmAP3vWmH+AJ6BkPRpnBPKCwCBHb0HPiiufPFUmwZinrJFch6kmVcrkno6kYi8TRFGZkJXIp9EJ/1wnfZ8hrce07ZnqXa2TnyA11ica0THdsNlE5RcHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJQmg1pD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJQmg1pD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF901F000FF;
	Tue,  6 Oct 2026 08:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276925;
	bh=pMsOVgZ3Mu8XUdmvXLR2GtSjjbVAancpcEW4H3aJtok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KJQmg1pDtSDlu9/CMFfj+Ab3xcyasBu6zeNM3lTwr13EV4CRKx9nOWAZoMQo1HrUM
	 E4dWWdB2h8nav0MJRd/XzHE8ODF++XQNTh5R/ZjjdWeQMvMlVv1tPYyqcobk9QtiZ9
	 FX+gf6KNA06vlmUog5mVjBYw2Deo6FpV8RQ3KFE5W6kbRie4XeCVxg8CPEiLsnQ3Ef
	 CHWWLOVt240swkkdBf8ls8m1UXlCW930OeLq21F2+ANJM2ts0F/+JBQ4cTMUw6l0Pm
	 RqOl7PeoUl7M/H9bebm8bQzgnG5jpLi48U7ec+gXx7g0ucGq0B1NFyWFSQgQKljSzM
	 ThByXEn2kpwpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/18] PCI: rcar-gen4: Add Root Port reset support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261006084638.3821710-10-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:55:25 +0000
Message-Id: <20261006085525.7EF901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Implement the host bridge reset_root_port() callback so PCI error
> recovery can reset and reinitialize the R-Car controller. This also
> provides the reset operation for the link-down handling added later.
>=20
> Reinitialize without going through .deinit() and .init(), which would
> release and re-acquire the clocks and the R-Car Gen5 SoC PHY: split the
> SoC-specific register setup that the power reset wipes out into a
> .configure callback and repeat only that, then restore the Root Port
> registers and restart link training.
>=20
> Rather than tracking which APP interrupt enables survive the power
> reset, derive them from software state through a single helper. A flag
> keeps the sources masked from the start of a reset until one succeeds,
> so a failed reinitialization does not re-enable them against an
> uninitialized controller.
>=20
> Reject a reset while the controller is suspended, as a failed resume may
> have left it powered down.
>=20
> Track whether the R-Car Gen5 SoC PHY power-on has been requested so a
> reset retry, or teardown after a failed reset, does not call
> phy_power_off() twice. Continue to ignore the PHY power operation return
> values.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D9

