Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91509446062
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370613; cv=none; b=h8uiUR0EAHVeTbp6gdGT0ybn2A4FZrPxDeYRaUfxeiNLoHc2f8/4cFvTnP1Ss+sfccN/Y09ieR4MutMhwIlvF/toONccu8uZRhOIPWt2TihjW1VDZ20lWIcqoVqu+/CWed7hz2QUZvHLPhklaTJhoCePOkZ3yaVYU7i5V+3Ko2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370613; c=relaxed/simple;
	bh=mZGqMqNl7o8oMNf+zGp5Qxrt0tzg22iSVX/TeJANTU8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PxAuwDVrzbZ5czQ4E/D3kEoLqqDkgj/XI02k/7U4qiM/wb4vN1/8Et6Kum+HLhYOdtvn7NPU7qu/WV4XRXBfeqJ3NDKJEylTuk9n71YtIH6ELgJy2wiQuJ2t3L/lersh3cgGxMcV2qmaJR5l3lu95Q6e1mXPJhHO1Lhza0xCeX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJYVsMae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJYVsMae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726081F0089B;
	Wed,  7 Oct 2026 10:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791370588;
	bh=mZGqMqNl7o8oMNf+zGp5Qxrt0tzg22iSVX/TeJANTU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJYVsMaer0D6lyWEP9tHXkpaPojwRV5PLNAz2Q5VKraQgYSSo27X118dfrVSBks6k
	 kvw7rnISvNcPSiD3iT/tVfb9rDC849xFNQEbRzX6F1k+Akh2NTn4vJo9RO7h0KeM6C
	 oLNthPYKMNmki2/5oFzhYFz52XviIFhYM9uZ2BqKQNELOneYNsomkFMMIp8U8l4UY6
	 p7Bf2l5ArKa9H5phlA1ymiGW2mX5wf+9ZKSsnaurbPrspegltW2X62fC4g1ktONUsu
	 0dbUp+PtJEPBjYnBH0ibIB+gAhiNxDhCUQkNPaQHtjc6TH5XsEypNCm+d2R+XD84UE
	 Z3KhWBUxcgT4g==
Message-ID: <sashiko-outbox-162893@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: tegra194: use dev_err_probe() for PERST GPIO
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261007104847.507776-1-phucduc.bui@gmail.com>
References: <20261007104847.507776-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 10:56:28 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: bui duc phuc <phucduc.bui@gmail.com>
>=20
> Use dev_err_probe() when getting the PERST GPIO to simplify error
> handling and properly handle -EPROBE_DEFER.
>=20
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007104847.5077=
76-1-phucduc.bui@gmail.com?part=3D1

