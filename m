Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD538A714
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784686751; cv=none; b=LOWBUcGByOcYa6wc0edFsvoGf63pcevRIxZ9Uin+TWO94p0OryKPHgxFltJZJIVhPdq0zxwoCAHErES8rd1D2r64OpIpV8wWXJT8/QhGjzWBQOw0+wBCv2ak1CWkZQmQepv19mih9RFQZWomVuCnzwOApUCZuvu/GIIQ++InVb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784686751; c=relaxed/simple;
	bh=fPwXqehTDRMZ3CX0ffSoIWYn3YSPf09qHxQ0DdaUclY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q6nofiyZCCcFbW3kqYwg9Jis3cLabL8UOymlsiEiUjGfi/Q6M03vN1QNxnv3cKtrJrAjfyusBGSWN3UY4g1hKV/rUPu1bKQKzXyUPG9WR6dbwVl/il68e7H5VMbgbwsOjDvbEwYgd0/sZZREDwipYJUCoTbfmtJnWIJTc2skw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYZpwm2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYZpwm2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62971F000E9;
	Wed, 22 Jul 2026 02:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784686749;
	bh=jXXlFkO+NpqONSwduv1AHH47ZV5KFxLopK4fvsSCukw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IYZpwm2XvSQnJe9MC6lK5ASEXYLUCI150SJbFBdQnRPopm3dz6GG5Jcqb9tM4AaRe
	 QeA5DIxWHDRMxEuz4HVZcPbUpCDTo99mIMvY2Q2yjrDApPMQhlUEC1M2ejsWZU6Ufl
	 HgY3d45uZgmZQrEtXw9fH75OTYYSkw5G8P/qWJ6uq5RtIJwW9REXbs6XwkpvqYzSjM
	 EQ473WTV570NzDzaiWF3cafH1iNnFbxlmdC1qXitvsuyiHcRswx+W3/0S41lZdz+rR
	 1HFLXwFY7ZQeuU/kUhHraBFYxwrwkfRfK610NL7v5cby6wArPBdMteAHV2P5zpLdYG
	 Rj1dMvwxATU8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/PCI: Disable D3cold on Intel BE200 Wi-Fi on Lenovo
 IdeaPad Pro 5 14IAH10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nika Krasnova" <nika@nikableh.moe>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260722021321.68902-1-nika@nikableh.moe>
References: <20260722021321.68902-1-nika@nikableh.moe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 02:19:09 +0000
Message-Id: <20260722021909.C62971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On the Lenovo IdeaPad Pro 5 14IAH10, the Intel BE200 Wi-Fi (8086:272b,
> iwlwifi) fails to power back on from D3cold after a suspend-to-idle
> (s2idle) cycle.  On resume the platform reports a successful ACPI D0
> transition, but the device is left unpowered: config space reads back
> as 0xffffffff, the firmware reset times out, and the wiphy fails to
> resume:
>=20
>   iwlwifi 0000:01:00.0: power state changed by ACPI to D0
>   iwlwifi 0000:01:00.0: restore config 0x2c: 0xffffffff -> 0x00f48086
>   ieee80211 phy0: PM: failed to resume async: error -110
>=20
> The device stays unusable until a full power cycle; an iwlwifi module
> reload and a PCI remove/rescan do not recover it, confirming the device
> is genuinely unpowered rather than in a bad software state.
>=20
> Setting the device's d3cold_allowed to 0 keeps it in D3hot across
> suspend and resumes reliably, so the platform does not correctly restore
> power to the M.2 Wi-Fi slot on the s2idle resume path.  This mirrors the
> untested-vendor-transition pattern already handled for the Asus B1400
> NVMe (see asus_disable_nvme_d3cold): the reference OS does not appear to
> exercise the D3cold->D0 path, so it is left untested.
>=20
> Add a DMI-matched fixup that forbids D3cold for the BE200 on this model.
> Match on the product rather than the BIOS version so the workaround
> survives BIOS updates that do not address the issue.
>=20
> Signed-off-by: Nika Krasnova <nika@nikableh.moe>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722021321.6890=
2-1-nika@nikableh.moe?part=3D1

