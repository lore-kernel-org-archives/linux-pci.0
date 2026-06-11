Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1036A004
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208842; cv=none; b=A0ZI7ohyhp5J0WfdTQXFc4hHg9IPYMsnzy6txtoLZnaIoL2RHsufchopmH3BTcGgZkL8Iti0Q2Ss1+s7/6EkjLmPQeFIqVz2/N5mXmNwGosUEE5TKzb/rtEl2WpOCkymj3A4pMHMexuwrqXKQs8j0XEawmDRuXxh1OiBtDHZQaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208842; c=relaxed/simple;
	bh=ibko3wzQebDdC96iEvgXLnpnVoNEhP4Jf9PNoIqMwm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=esVaPsW+a9sANgUdnorEchgjlCtTxABEIrC425HQpOptuRhpOe7o3MNDtrsLsJwGNsVOv+HNfTZH/+72hifc53S9gTuyOkC5TU7t2Gp0E/nvaznglhKKmR+QDDBN5tOM1vtznLGM/bzOvIlP3W26uD1naAT46QR0Y3FgcXzScTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8DFd0VJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8DFd0VJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD6A1F000E9;
	Thu, 11 Jun 2026 20:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208841;
	bh=ibko3wzQebDdC96iEvgXLnpnVoNEhP4Jf9PNoIqMwm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D8DFd0VJEGe6iCVsBkzCA2nT08luqJG7FwnCTgmoG45GMicm+vJmDX1bCW5mVRrnu
	 nwjGvUuixRY/DNjZ4hTXpkDcTl8+tR8LUs9UDlYIN4yxqA3fYOiFaWxBOOjgdmq0r1
	 q7ZXRRgEGwZtcgqTTyuvr0jIeREaEKNIwk5pMD56lM49O4LFEV/Go3UIVGrBWIW+NC
	 W7NB5oQONMJGooHrDc8KZ9vm0zCWPOO5HrdwTtXd0xj4vUZqQrasLmQqupJnDo2En2
	 iXhAM296AdgCwaJoIiKKOqHwKaC91QDIzRWXDxH70TLqXE6BKebEBYc8tg8BUN5Y9m
	 4OGNdUs0mAL3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] PCI: rockchip-ep: do not attempt 5.0 GT/s
 retraining
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <76c828d29b0f05df0970b3a862ee1af8c96faf17.1781207474.git.geraldogabriel@gmail.com>
References: <76c828d29b0f05df0970b3a862ee1af8c96faf17.1781207474.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 20:14:00 +0000
Message-Id: <20260611201401.1FD6A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Drop the 5.0 GT/s Link Speed retraining code block from Rockchip PCIe
> EP driver. The reason is that Shawn Lin from Rockchip has reiterated
> that there may be danger of "catastrophic failure" in using their PCIe
> with 5.0 GT/s speeds.
>=20
> While Rockchip has done so informally without issuing a proper errata,
> and the particulars are thus unknown, this may cause data loss or
> worse.
>=20
> This change is corroborated by RK3399 official datasheet [1], which
> states maximum link speed for this platform is 2.5 GT/s.
>=20
> [1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datashe=
et_V2.1-20200323.pdf
>=20
> Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@ro=
ck-chips.com/
> Cc: stable@vger.kernel.org
> Reported-by: Dragan Simic <dsimic@manjaro.org>
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781207474.gi=
t.geraldogabriel@gmail.com?part=3D1

