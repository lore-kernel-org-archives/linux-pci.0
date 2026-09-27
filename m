Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D62EACEF
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533838; cv=none; b=nXLRNJf5oF75sxdTn16sRyCek+Zrtx8s2xB7QDe207lxyv+16mAGlibGz0xDmx3fcTngQ/Z/6yz7cLLHkyb9U8y4LSD7Dm7oG3E9LNi/F8DktqjXqrQRLSyAcb0KjQyipwYGwbL5362ZWw7FR2wfBtNTdeVwlO8/zEGhGj1JL64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533838; c=relaxed/simple;
	bh=VuGYL/F26xgkh4dDnLv3ycMb1jFPav3PVJeyAKzhC0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UDuGwtf6xS9m44MMpoUymYl+6QKWONEZ+szUfHSdvtruwX/TWF7F16BtoxQZdnSUrdNwb/qSHWfV9JTwXBJcOoPk1dRTS22OlnEX6p9Yc2r6R6MUPCtd428vrr6Gj5TDTL0nB2E1x7yRqMppdQiRqU2YqU0gZuWuiJr9daqq0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax4dC7tO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax4dC7tO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C941F000FF;
	Sun, 27 Sep 2026 18:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790533837;
	bh=VuGYL/F26xgkh4dDnLv3ycMb1jFPav3PVJeyAKzhC0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ax4dC7tOTqyuzTTpzOaKM5whUt+VSblNBEeT5IdN+N1xkATizKek69JRGyUDv9Zfj
	 Hi2CPktv4q8DVOWs6J6Yhj9NzhHWHPZrvy1tZVuktttiHoI1wJanC3sdaXoXP36wwH
	 +OOT6ZeTTDj6Q+lfUXsFGHiSYGW0x6wMBeUZnw2SaJSbbPvIr1rTCYpO7YP+VI5tWk
	 RSBVG30nd6zNTIe+MEV0gj1drBYvcT2tA/vzdF9sBdfGod5mHGKukhvNdZLhU6kprp
	 6fNBqh5WAVkAh1cfQgwu9CK4QT0pWHckDgk7cKErh8iU/7pC43IFDaG/Z29zE8Difp
	 JXrX/1UxDgUWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] PCI/AER: Move AER capability check out of
 pcie_aer_is_native()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <6a21637111397810d75679d1ca597766f3bf5605.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <6a21637111397810d75679d1ca597766f3bf5605.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:30:36 +0000
Message-Id: <20260927183036.D2C941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When firmware grants control of Advanced Error Reporting to the operating
> system, that not only encompasses the AER capability, but also error
> enable/status bits in the Device Control and Device Status registers
> (PCI Firmware r3.3 table 4-6 bit 3).
>=20
> PCIe devices without AER capability still support baseline capability
> error reporting through these enable/status bits (PCIe r7.1 sec 6.2.1),
> but the bits must not be modified unless AER control was granted.
>=20
> pcie_aer_is_native() is unsuitable to check for control of AER-incapable
> devices because it implicitly checks for presence of an AER capability.
>=20
> Move that check to its callers (where needed) to allow using the function
> for the imminent baseline capability error reporting.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790531238.gi=
t.lukas@wunner.de?part=3D5

