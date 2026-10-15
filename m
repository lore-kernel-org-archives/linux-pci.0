Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2560528FFF6
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035426; cv=none; b=YZWVt+L3opVOkKrcxhBVheG6KlFHZsy0496Csng9TdRome9qOMJyJNSLxJtjrhS/yPIjjSvhziO/kB9dZhaYSkBzV8RMOGQrEaIkrtizbRh1WqPI97c9qoMKIxCpcgVItDzpY6FZJDV2mJFgoljE168MHth7ZtWFiAU7Lj/AZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035426; c=relaxed/simple;
	bh=lb3nh478HimuIQYX/qd1s97tt045vdWEa+xqQQ+jXE4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MExBKpsm3Z1s0QOJ+YJ4gExuc0aRndSeFPDo+eGIkjxZlFOOfxir+NV3OJG6Ai01O/sFhfreXWyG0fskugI4tAJwhLiv5H9FUXV3UfIZPHIxphFFo/zwUTxlHGwUlOEGAMikfvKFF+eRB3ddJtGPivnrAfNDn9vYLTPi3TFGHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhtJQhHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhtJQhHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03421F000C4;
	Thu, 15 Oct 2026 03:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035425;
	bh=lb3nh478HimuIQYX/qd1s97tt045vdWEa+xqQQ+jXE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EhtJQhHTLEn39bRiWbI3BvHG25kVTg033oZutaz96dNSZDPavecGfhPRbxbqHExPn
	 R1hxnFHRajCCE46xEmXQMofi+S0xItQk4XqeF6l1ckw9+og+jAKv/31ZwwGZo2NzkY
	 bhhN/a5REwQwxgDf+ujFfAnWrSUVc8XNWcFBHD4ln4KG83p1kNQc5iuAgRKLdGeXjD
	 ILVrv6/XKLSbMi1QGFseiyqrboywqRBZFGfMzGI33tGw22TqQQWKaqA4J3D2ypdaS3
	 om7uwNiYSM4zNkR00WaNZKoXSyZTgkrfW2CT9W8lvZxi4lWUCxMrHfwW6l1twnMUk3
	 nKoWGKmv1tNFw==
Message-ID: <sashiko-outbox-172203@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/18] PCI: rcar-gen4: Move deinitialization helpers
 before SoC initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-7-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:37:04 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move common_deinit() next to common_init(), ahead of
> rcar_gen5_pcie_init(), which will call it when PHY initialization fails.
> Place rcar_gen5_pcie_deinit() before rcar_gen5_pcie_init() as well.
>=20
> Keep these moves separate from the following initialization refactoring
> to make that patch easier to review. The function bodies are unchanged.
>=20
> No functional changes.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D6

