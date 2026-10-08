Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60B132B130
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469011; cv=none; b=cBQ2M+R8q6ji0q1UhqCw5xbhptTvX29BuIi7fvSDWoSUznZ3qtvVs6AvDpYcjCDDvWyvzjTOLwTVY/TpChXrXCWqnEEeWDnvxhvf8EyUo874iosmhmxoeHcLqxPURk9aP7ehTpONeAJY8RsIh4aILM8iCygp1tx9ywQ+oTn1q2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469011; c=relaxed/simple;
	bh=U/a9vF5rT7FVVPvcxrgWuykmfQIcDTNzaEVH9rL1pTA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FGvUQUUEjfro3a6tBmGG3rybV4Zfe+IS9WVUgZ6nxmn7C0BOCfxd2xG5qY8cZpXyI5M97gE/bAJWjkdU6dmH0XrT/6Ck/2QyM0+CZdHmLXcaaHTH30HZmrmyteTjwRWcNYFg1CzNAwISy4Hkm6ABwFTGpEkeavBZc5HUfOjCmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5bqhkE7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5bqhkE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA091F000FF;
	Thu,  8 Oct 2026 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791469010;
	bh=kSFXHBXgBT/D761IHKsvwhLVoFgwDqt1qeeJiXuG66E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G5bqhkE7x4V89sAwT7z5pwgiQu5uc1FItJ9UbQdG/adOAu0u0S+cG+djEtfJ5xBQ2
	 igAkDFaFU6Cr8cdioANl7gAGFw8jQDVxKu0jmNvCm4vxOymMxmDhIp23xtEX3NxLl0
	 jmYjbpdv3ojqPK8oWZBtCU+3Evx6KvGPOo/TLmmIrbg8OyIcsUliUO8C+58mqKPH2S
	 evGpCnfh2g0NnUQxR4aSlKX8mgwXMDIpJBodfS64tn8GxytgT9Kb288vKUjr/crAwZ
	 mnKVX1G1m2bObI+q4c4sg5aIk0t5N3vwJHYttLZUrme+EPWjYcfsHByr4AH02bzla5
	 2ETfOK4ilzdMQ==
Message-ID: <sashiko-outbox-164271@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/PM: Restore BARs after powering up during
 enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keng-Yu Lin" <keng-yu.lin@hpe.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261008133708.947908-1-keng-yu.lin@hpe.com>
References: <20261008133708.947908-1-keng-yu.lin@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:16:49 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> initializing") added pci_pm_power_up_and_verify_state() to pci_pm_init().
> The helper ignores pci_power_up()'s return value indicating that BARs
> need restoring.  Its resume callers restore saved configuration
> afterwards; pci_pm_init() does not.
>=20
> D3hot-to-D0 may reset a device and lose its BARs (PCI PM 1.2, sec 5.4.1).
> After enumeration powers it up, pci_enable_device() reads D0 and skips
> the full power-up path.  Previously, a device still in D3hot at enable
> time took that path, including BAR restoration.
>=20
> On AMD Venice SP7, two AMD xHCI controllers [1022:17d2] are in runtime
> D3hot with No_Soft_Reset clear before kdump.  Diagnostic reads on
> v7.3-rc6-37 show the following for 0000:01:00.4 in the crash kernel:
>=20
> [ ... ]
> Leave the existing power-up and platform calls in place.
>=20
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializi=
ng")
> Cc: stable@vger.kernel.org
> Signed-off-by: Keng-Yu Lin <keng-yu.lin@hpe.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008133708.9479=
08-1-keng-yu.lin@hpe.com?part=3D1

