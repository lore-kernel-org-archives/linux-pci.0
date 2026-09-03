Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61677421241;
	Thu,  3 Sep 2026 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469305; cv=none; b=UeA0hv8eKYFR+skNIfgWZa329kP/kxn5qOBsZtuO7rbUAbvGtRx8bu59+Lqwpv8ZPz8MZ1oLEYxZiVcL58icsP3Y+qqHpMyPJKzhxFL9KP88FPCg1BawGcK+R73L2psOn+qGAYZExzrNqB+kIz86lCI+2D7Y4YlfaTMGVD5DVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469305; c=relaxed/simple;
	bh=jma+xTlv2sm5UdHQPB5tIW2sujHNqqZiJ+1/ponjuhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jaEzq+dF9p8Hro99yrIZTuauNmi355h/ydSwbpYw9x0b53pJFk2xMxZ2xaI+UVORrMC9q654i2KtZ1GA4MOqZv1CNtdcdGOtWimDMeOL6E8TTIGu5zzIaMYChj6TIYCwzyTwu4PrS+cAPTE0KB8WpBClH/pTJDxtvggiYEB4Bic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlIAZako; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlIAZako"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016721F000E9;
	Thu,  3 Sep 2026 21:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788469296;
	bh=jma+xTlv2sm5UdHQPB5tIW2sujHNqqZiJ+1/ponjuhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UlIAZako3VJvSi1E+xO5tY2JWuCg+Y9UC9xcVhfPU9fJPifO0e7rLR7btwrjtP72/
	 14U2VcIvFvOPFPy/avwjR/hybYffzt3DrW3KsyGEEHfk3oTLb4gqE5/quNxxDXCWAc
	 Y4EO2ztuNcb9cokKYGW6mRhBnskb32PLI58f+6nlNGyJzmEwuFKmMuM45yQNNPKvoZ
	 CgvhviromqoSV3SCPDBBdMOqlwRi3ZEcC/mA8bJOK/H64+j0SeiW0q4I+tHUtx0A9W
	 MbPp35F45EIbKDmCdbHNc4t6EJt4V0vy+HKU1ABzatTg2uam4kZixA//JZcQNfu9PG
	 xPVkFMOKfVY0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] arm64: dts: renesas: r8a779f0: Add PCIe
 Application/Local register reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: robh@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260903205153.283553-4-marek.vasut+renesas@mailbox.org>
References: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
 <20260903205153.283553-4-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 21:01:35 +0000
Message-Id: <20260903210136.016721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Renesas R-Car S4 documentation R19UH0161EJ0140 Rev.1.40 , Jul. 31, 2026
> chapter 9A.1.1.12 Software Reset Control Register 11 (SRCR11) bits 22
> and 21 describe PCIEC ch1/ch0 Application/Local register reset. Add the
> matching reset into both RC and EP DT nodes of both PCIe controllers.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903205153.2835=
53-1-marek.vasut+renesas@mailbox.org?part=3D4

