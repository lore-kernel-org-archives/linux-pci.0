Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9EE524B0E
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651422; cv=none; b=CrJGWqNsnX6R22LLcRiUjRG7yVDXfKU6/Kxh59AS3BueMQ4SZCgHGqo1mgwUBfexyMZg1H01r4U94LwTBCicVSVOOhLgKeXl/I+KM3XK5V1/srBbmqHyG5jLUyVWXfS6tb/2OOfXCDQlsQoneUD5w9VtFEpGKD64fVUeg79DNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651422; c=relaxed/simple;
	bh=eIl2LbqHlgmHobCb7rIx88cc8l0R/hXkqfBj0isLoL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HR9phtUnns3dQrh1Ar6f+HZTa04SdLL9rFyp4HqtnggpdGryk15yW2w/qbP3htzECohlkMNmi1n4Cfu5XjDfPSCix6JdWv/HtC2onL7GfHsRA5B7fADlpWyH/KvoA4msQF4+YpWAKMxvhvuNCbwXnB0WKjjC8rd1pM4KIrrKLoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeSDCGMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeSDCGMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AD71F000FF;
	Thu, 17 Sep 2026 13:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651416;
	bh=kP9gykbeKywimy4D53EzjtofZciM8yj8rnUThk3qZq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VeSDCGMnq4XumVjfpbT+qptTtQ82IYW9uSKuucwvxhizpV3ZPhd6UZq7f47rVtxxl
	 95twt5DT0GiK6p1pUJzl4ICZKX355Tl6cYar7R63D3bn0XB1eq/CY5v9mkcJjupsyQ
	 XP1Yo1JUq3EXfCGeOSW+k/IENaRghFg+PBh1U21bmosT+pZ9WL0ZIbzml4fi0IFfTU
	 6AHWOex043rY75cZzbkAwa1xo9aUnN9gedYUZ4HSPWPy/BAFLDDDrOJBvF2Qh2KBEV
	 neQwMEVCtKpkQkruvgLShtSyl6ByqJQPUidUHQV6L/ty4SOc4vbeVdK5y75Kntx0dd
	 sclve/AX/0e0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: keystone: Fix host bridge device leak in
 ks_pcie_quirk()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260917132022.2153069-1-vulab@iscas.ac.cn>
References: <20260917132022.2153069-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 13:23:36 +0000
Message-Id: <20260917132336.84AD71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> ks_pcie_quirk() obtains a reference to the host bridge device with
> pci_get_host_bridge_device() but never releases it.  Every early exit
> from the AM654 PG1.0 workaround leaks the reference: when the bridge
> device or its parent is missing, when the parent has no driver data,
> and when the RTL revision is not AM6_PCI_PG1_RTL_VER.  The quirk runs
> for every downstream PCI device, so the reference count grows without
> bound.
>=20
> Add a common out label that drops the reference with
> pci_put_host_bridge_device() before returning.
>=20
> Fixes: 86f271f22bbb ("PCI: keystone: Add workaround for Errata #i2037 (AM=
65x SR 1.0)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917132022.2153=
069-1-vulab@iscas.ac.cn?part=3D1

