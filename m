Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D575809
	for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787998003; cv=none; b=dPvvRJhnqdNTV2yL3fz5W20c/ZEyWvXSCwYsxci0aIPaUzO0Ntsp9BW/5pkWD4AtJPo28H1XcvmWIub+fJZC4OzExc3MDepJzpvtMi1yVkaQ89tP7Bi64O1KbfcPFby+jgSCYV5p1ItJpoCXq4nGWQ9OsVOHQpBeuvWYkQgykCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787998003; c=relaxed/simple;
	bh=26zFjtrPp/XsMiS4dwDx+AmKu0N0lNYEkgW3FJm5XCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M3x6SMp4YBRggOFSyxVNUymQCNlD+1onOFaPGkHeAi6i1yoPziSEkbX7lF8UjyEzFgEtFi2vcuz9AFmBPwRB1Mspc0yzgdGCs9ZVtmHj32fnURGLtFh0+UA9X2ELsEH+DvRPuKtuHwPKCHwP/vXzoHwKmTUljl/Q2gCPvFaeDLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxbBIFry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxbBIFry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642771F000E9;
	Sat, 29 Aug 2026 10:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787998002;
	bh=26zFjtrPp/XsMiS4dwDx+AmKu0N0lNYEkgW3FJm5XCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TxbBIFryAwf+RyS+4hSy9MFXfLMRaMu7rW28qMBem/n498socvP2n8bshBfCZNn8C
	 ZJCYzeJj8xhNIXp+sxNZXkvecmDDWO1b2VnF6JFc5FkM2JX15LX6zr+RxCxsfqelmP
	 KdqiuyTnGu2hWl2ZSpKOGxIgGWsjit67LrMdqA52jkQX3Lnen4TglhSoPDti3fDf9I
	 TZUDLzIXwZLL8PW4qyO6LwkxvoKliYbXgFTqfh631dtstcaUZ/gAtLDj8tcUxf82yL
	 +3cCG5P2lgQ7NPSrunTLrd63gTdAODue3xqywI73RSC0UMy+NwBc7qLcSZaOeRhFnx
	 NUuYFyvmDMC1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH wireless 2/2] wifi: iwlwifi: pcie: request a product
 reset when the device is gone after resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Navon John Lukose" <navonjohnlukose@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260829095437.44716-3-navonjohnlukose@gmail.com>
References: <20260829095437.44716-1-navonjohnlukose@gmail.com>
 <20260829095437.44716-3-navonjohnlukose@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 10:06:42 +0000
Message-Id: <20260829100642.642771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On platforms where D3cold removes the WiFi module's power rail, the
> device can come back from suspend completely absent from the bus: config
> space reads 0xffffffff and the downstream link never trains.
> _iwl_pci_resume() currently notices only a subset of this (scratch =3D=3D
> ~0U, and only when the device was enabled), then "hopes for the best" by
> re-initialising over PCI, which cannot work - the hardware is not there.
> The result is several seconds of handshake timeouts and a bogus
> ADVANCED_SYSASSERT dump before giving up, and the device stays gone
> until reboot.
>=20
> Check whether the device answers config cycles at all, and if not ask
> for a product reset, which power-cycles the module and re-enumerates it.
>=20
> The check is deliberately placed before the STATUS_DEVICE_ENABLED block:
> that block is skipped entirely when the device was idle or down at
> suspend time, which is a common case (e.g. the radio was switched off)
> and one where the device is just as dead.
>=20
> Fixes: 9673c35486d4 ("wifi: iwlwifi: implement product reset for TOP erro=
rs")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221695
> Cc: stable@vger.kernel.org
> Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829095437.4471=
6-1-navonjohnlukose@gmail.com?part=3D2

