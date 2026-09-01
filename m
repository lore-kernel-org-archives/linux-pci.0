Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0D322A1F;
	Tue,  1 Sep 2026 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225425; cv=none; b=SmwmWbxU0Uof/psT8wnnBYEWwa3z3a3rrXGsKGcwsnXH2Rl+25kJQxcdardjTxOyKkNcHLJu96BAD4kuT+OlTF+vlSgqNUDOF3SCG0PABrgHWxClO1dAAA7FNkUgkPR8erex7A3uM2nMWOLAssWUHRKWI1HLY+XwE1xgq88tXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225425; c=relaxed/simple;
	bh=CgoHL12CI4GYpJS1BgmKJgWQiItkwgZW4O3psQlVnTs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kD+4GIMvH1XgVvCXn3ZdAZLzZ9rC5Fpm8xlJjZtA/K2ItJGEUwqjraiwXNHf2muK1xjO7swOFrTrsYzx3LKSkgINGvltFMD4B6a/Kq5CzV7JImczV3tbraY8vCi+5OTtLo8eRtUrOIRiyZWntAypCYH8cyS76yTLfaevtyz54aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVNdcePi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVNdcePi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9F71F000E9;
	Tue,  1 Sep 2026 01:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225408;
	bh=CgoHL12CI4GYpJS1BgmKJgWQiItkwgZW4O3psQlVnTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hVNdcePi/RTzkXMfjAq8FqyZTV/ngw0xOylazjgUUoOVx8/Pf6EMKf0pwtdUDCu3y
	 FjSihrbGxKcjb6/hBzumhLS5ThQR49BEQQu8nuo0lcCgTR5D8oyjxtxb2ZDyeuBdKY
	 iXX4vP0TVC5dxIdVXuHSA0K6bG8vmQj+JadMiYSub0AHoYk+UxFK9yT0nZVggb3IU8
	 iVCp0MRHxgQ4GSXqPTULjXHsd5+7rTQoy09UAVtGVpopM+YMW6Q2Add8Oc+n+DS9Ky
	 0EjycjfGQFbr9mFHMAX7X/wb2pkTV2dZmkOy8t4gb5nME9fALfMUkcp+jli+S9kop/
	 KlQujVO7x3fQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] PCI: of: drop the reg_num argument to
 of_pci_set_address()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260901011338.1323243-2-elder@riscstar.com>
References: <20260901011338.1323243-1-elder@riscstar.com>
 <20260901011338.1323243-2-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:16:47 +0000
Message-Id: <20260901011647.DB9F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The reg_num argument passed to of_pci_set_address() is always zero,
> so get rid of it.
>=20
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901011338.1323=
243-1-elder@riscstar.com?part=3D1

