Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EB41F8691;
	Thu,  1 Oct 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866068; cv=none; b=HM2K70hxRpvwNIw2QgHNHD8Kkj7d9dR3/Kyev4Ns9AN3oiQC/eXerLCs78lQyUoRsDnrekEBNOAbO/J461ZPDm4yyGho+dpEwTy3jt4X9/GQf46JLJ86RfzzlC6Q912bteOh2v6qt902lEL91Ei4Wt3LNb0s1L5a7x4yzztQZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866068; c=relaxed/simple;
	bh=io+LVio3mhyXKo8GFpcBXyyMK/Nuv+u8nCXPhiUqK0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LIwWv/ibW1fEzbhCwy643fhtaqGvZHbUeZDIe0D7OeZG1AkERWaND/FPlUAJ/cBWeMvGAsA6cEWXHG/amT05SaJO3yYkJhiN/4EVEG5K0DTw7NYEl+eTA0RUJsZ0NZu+2l7kKyn80/aKvAoKbQFSjdN4V3aq+ZTH0VFc56cCl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8R1WJih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8R1WJih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE52D1F000FF;
	Thu,  1 Oct 2026 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790866066;
	bh=YQWaMyV8inYUSdqjSJ38Qsy0u03OlWzoghsp63wRJjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8R1WJihUOpZin+cYwChMobmTNXUrzKJ95ROaxH/5F8IabEAEvE8Joei9pirdcEFi
	 ahAwFbOxURAE3CkN64nhxgJhw4w/z40qeUPxijL60DgQMWtZcL+oWBeBxm7JhxUlyI
	 J0YbzVrqXXpAOzNqZNy+OPuAryYUq6susVirNeXOj3YHV2PouvJzBR6mCWWFNGO0Am
	 8TLlrvDH9l18Qs8WAQNNaBMtfjQ+A701m84OeXM3at5x7tUwKrDaUMcD3WTkirISmX
	 u0W9+5E+bchhDMiMtUC7em36DVQGRovx40rWxU6E9VYhJf3BgRxdMP9R49UxL+oXOh
	 91SVl9gp64LKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 09/10] PCI: of: Remove fwnode_dev_initialized() call
 for a PCI root bridge node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261001142815.277550-10-herve.codina@bootlin.com>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
 <20261001142815.277550-10-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:47:46 +0000
Message-Id: <20261001144746.AE52D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> During the instantiation of devices described by a device-tree overlay
> applied on a PCI device, devlink displays the following kind of debug
> messages instead of creating the expected links:
>    'Not linking xxxx - might never become dev'
>=20
> Without those expected links, the device removal order cannot be
> correct.
>=20
> Those debug traces are printed by fw_devlink_create_devlink(). In our
> use case, they are all printed because the supplier of the link has at
> least one of its ancestor with its fwnode flag FWNODE_FLAG_INITIALIZED
> set.
>=20
> The culprit ancestor is the PCI root bridge.
>=20
> [ ... ]
> are correctly created.
>=20
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001142815.2775=
50-1-herve.codina@bootlin.com?part=3D9

