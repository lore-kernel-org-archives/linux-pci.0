Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98764562A0
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247760; cv=none; b=sdWpXH9KNOZmceFGEn5Cpr5VTI1p/17upEPeh/KUhQ47M426BAqj7TcTwnMnIvDBNQI7DCAILeM0VH04/0CbeRc3plNjMscdz+du8XVdEfMXN3lZiK+UQb6Lz2i2M5MVJ1WQIhV7DqK/WLUARqvhbC8TFzl67b6Q0tWgSpkQcIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247760; c=relaxed/simple;
	bh=GkPeqL26dOaj6b4mNUMmiha7emxx1Bjxiv4qQgRNuPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OVFiGjxn6tpAU6jFA+sHvfFNY+C309WjWBYR6MFCrsYbRLYPc+x5M3UlnmJW0VCnmG+5st6P822+oWh/3cMwknnc2IjuQHVJXbCNxFnM9Blj0HlJeHqrntA1FOkTs/YE968bQc0YIE9Ux2F3SV21FoB12/0DbhsGrZWCzk7B0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myy4hZw1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myy4hZw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2A11F000E9;
	Tue,  1 Sep 2026 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788247758;
	bh=GkPeqL26dOaj6b4mNUMmiha7emxx1Bjxiv4qQgRNuPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=myy4hZw1zuN+5S9fmj+d4hxjMIAZUSTIm88tF82mnYgs1QdCCEecBCSQT8iTH7mOx
	 PiET1Mvea4ZDxqa6UZBX5RanyDU/KlKZj8L/6vU4yn6SEdfVA/p8CAiVNtzgYAQL1Z
	 Rv1YE8t5CmPgE6J06h1TotNfu+JY/bEb2IiYV08LH/yEhLRAJb+5Fykxklh8QaeB1J
	 d6cTzo+R3EQDK2mafdrNFxrdCxpBRClsvK0hDY6+L5aE0ZD5A+8W7XhIb0IM1w+9Sh
	 /YwdfaH+SjClx9lSVwkAeFkdXqG24LzEzVBaSbom3KssfdaYNKi1/LIrU3GWiGXfmG
	 IBCoXnp1LnlCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] x86/hygon: Add Family 0x18 DF node enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lin Wang" <wanglin@open-hieco.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260901071700.3255382-3-wanglin@open-hieco.net>
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
 <20260901071700.3255382-3-wanglin@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 07:29:17 +0000
Message-Id: <20260901072918.6C2A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The AMD node code locates function 3 for node N at PCI slot 0x18 + N.
> Hygon has no equivalent node-index-to-slot mapping: DF F3 devices are
> discovered by PCI ID and the PCI BDF is only an access point.
>=20
> F1x200 provides the socket ID, SocketPresent mask and, on Models 0x04
> and 0x05, the DFID. Models 0x06 through 0x08 provide the DFID in
> F5x180. The resulting (socket ID, DFID) pair identifies a DF node, while
> SocketPresent verifies that enumeration covers every populated socket.
>=20
> Order CDDs by socket and DFID, followed by IODs, and assign dense node
> indices. Expose node counts, identity, F3/F4 lookup and PCI-device
> lookup through <asm/hygon/node.h>.
>=20
> Signed-off-by: Lin Wang <wanglin@open-hieco.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901071700.3255=
382-1-wanglin@open-hieco.net?part=3D2

