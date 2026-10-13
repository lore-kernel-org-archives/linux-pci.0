Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307B50C2B8
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901806; cv=none; b=lYbvZfV2IVVxoGh9xWemG+mZpp7/kbEQACX0FMrxv3EPjTtlNrFNGlflSszbe+ir0VqQMCrmxwCJNBADgl6WmXAqna0wHpvCvOGegbo/NQNpa8QMVBQQ9tRqpDXg+o88+GkhNm3wA0Iu/Euml39AkSQ8JxInKjO3Smjs6aYhFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901806; c=relaxed/simple;
	bh=0za/P49CnCMaoIYpJN+wKPAjCafKcB2N7A0tFrwromY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=m4PosaAy6+FHv9LezKkbJ1J1yZ9UJEhNewFfVMYkjC0YmnD50Zus0IbvSCMQV7qSog+g5PoJEiAQa7Yb87Q/Q72nD2wQMAk2ODyLwLb6I7EBW0/YCpbF2Vkn76IueKjhdPaAsEFlcPyAuRzyZNiPB2UoFO4uHV70zcPyMezx7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDL3zwFv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDL3zwFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079361F000FF;
	Tue, 13 Oct 2026 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901805;
	bh=wmfmD0jmZX/SF5uUU8TAj3ufuvCknbeDJnQbhrQOHV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gDL3zwFvtiae9+JuUAFGHDc4z21yTi+ZNKrRHqyGMNIrxaNHemgn3DRDcg157ilHi
	 c9D3wfVffYOJUAB2x/+Ad2Iu26VrQ6U244CMgBALQIwHOUWk/XJzUgpN7VyT6dBrKz
	 CR6sN3WCeysl+Kj22x5DJXObQ+eE2lzR33HKpzY02WY0FrcEUv0Zadyt4RqqR5n968
	 RrNH6OsY/teQXsfN+TKpjurZf4RtFRrbNJw8EvF/swZH7h43rueTikFnobOig2odHs
	 a56zwJ0H2kJZTWi8Yst7mkcYYV0UFdNRDf/ll16zCiMSd9gU9N7hoMIB3feoayAuPe
	 46JKIf/NjiD7Q==
Message-ID: <sashiko-outbox-169911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Revert "phy: qcom: qmp-pcie: Skip PHY reset if already
 up"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Burch" <me@michaelburch.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261013-qmp-pcie-skip-reset-revert-v1@michaelburch.net>
References: <20261013-qmp-pcie-skip-reset-revert-v1@michaelburch.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 14:30:04 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> This reverts commit 910b828b22b7b91054b3bd4be676a017444b0e00.
>=20
> That commit skips the no-csr reset assert/deassert (and the 200-300us
> settle) whenever the bootloader already brought the PCIe QMP PHY up:
>=20
>   skip_reset =3D qmp->skip_init &&
>                !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
>                                cfg->phy_status);
>=20
> and states its own assumption explicitly: "This relies on the assumption
> that when skip_init is enabled and the PHY is reported as up, the
> bootloader has already configured the PHY correctly and the link is in a
> usable state."
>=20
> That assumption does not hold on the Dell XPS 13 9345 (X1E80100).  UEFI
> [ ... ]
> QPHY_PCS_STATUS still reports the bootloader's state, and the skip's
> precondition never holds. Revert it until the rest of the series lands.
>=20
> Fixes: 910b828b22b7 ("phy: qcom: qmp-pcie: Skip PHY reset if already up")
> Signed-off-by: Michael Burch <me@michaelburch.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-qmp-pcie-s=
kip-reset-revert-v1@michaelburch.net?part=3D1

