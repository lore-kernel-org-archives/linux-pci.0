Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35D8496D5D
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071253; cv=none; b=DvuckiL1gcJMvIHwunpRcEhbolKILWAkW5vvsZtYilRZGIV5k1wGyr5E7stuES6QvGyZJfbF6DotLR7jiLxmeSfnFDRIG3o1ZoDO8E8tMDQeLCgWayHoi+uZgWv/AD7/mM7NKWewLMygNmaCIgQ6xvaVDn45dvMrbxQfXKH2UUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071253; c=relaxed/simple;
	bh=0ZQWmZuSADAI7HwpjWrA2kmUXjjWWlgkX67UCSYuTIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YJqhCTBP+m+JMc+ztcwq54uM76R09DL1TBjJhmg0emkRTgCG77fKpgasf0i37yUO2Q081Ov8mGaz2vhjx3XT5TKvlz7CN80hiH+h9Z0nPR5QovvhkQiV2+87sSqLsra+cLzsJMQ3Mpln6awRj5Dgoiz15xm4FDKfUVnWzOpxCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4w6Qljk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4w6Qljk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456AE1F00893;
	Thu, 10 Sep 2026 20:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789071249;
	bh=0ZQWmZuSADAI7HwpjWrA2kmUXjjWWlgkX67UCSYuTIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C4w6Qljkl0GnNz180E/1biW4OXyeNpxCvGyN80KoycZz1hoFUdn0ZO061yvTJelGW
	 AyBhJAckUzFTgMzr0cpIYtHvC4tMBBfdgUq1j3RUtRej88Zj+6NLHG7ijY34S35IML
	 D6IY0KcEywp0dlE9gjOZOK3cRVc92P77kK6FO98alaT2bDu+ucSeArlHw9k6OaUkMT
	 qYfPjmbwiHbVpnNMylSqSm9KpJlcP/zwRJzIAP+zlAujxLEYpfkv5NaWScS5VspyOX
	 cTFplj3YimQoR7U9gm+aByPOaz58JjnVbkcZpo2mKaOK+RlLLr+aOR9QTlAZ20UYBy
	 J203zzoRrKesA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: vmd: Enable interrupt ordering quirk for Arrow
 Lake
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Nedoshivin" <gvozd188@mail.ru>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260910200539.10862-1-gvozd188@mail.ru>
References: <20260910200539.10862-1-gvozd188@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 20:14:08 +0000
Message-Id: <20260910201409.456AE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Intel Arrow Lake VMD device 0xad0b is affected by ARL004. The VMD may
> signal an MSI before preceding posted writes from the child device have
> reached memory, which can cause the demuxed handler to observe stale
> completion data.
>=20
> The existing VMD_FEAT_INTERRUPT_QUIRK implements Intel's documented
> workaround by issuing a configuration-space read to the MSI initiator
> before dispatching the interrupt.
>=20
> Enable the existing quirk for 0xad0b as well as 0x7d0b and make the
> comments describe both MTL016 and ARL004.
>=20
> Tested on an MSI Vector 17 HX AI with Intel VMD 8086:ad0b and an NVMe
> device behind VMD. With the quirk enabled, the NVMe completion stalls
> observed without the workaround are no longer reproduced.
>=20
> Link: https://bugs.launchpad.net/bugs/2166325
> Signed-off-by: Vladimir Nedoshivin <gvozd188@mail.ru>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910200539.1086=
2-1-gvozd188@mail.ru?part=3D1

