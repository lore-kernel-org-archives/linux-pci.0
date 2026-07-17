Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A95442B733;
	Fri, 17 Jul 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300295; cv=none; b=jNuiIL6xVKW2NcFe4SU5DIievxZfP+iMdAQho1qQ/uLbqtpuWFGQPHi/StzDlFHjAL54sNYlLG4APPNVwgdg9gyWYDxcda93u15RSKPFRTFrHtPEdpKF4ZbQiLwe4GaMjXEw8T3VICNhEm3wtZJiddsNxAfbGxKylGpZl0Sqgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300295; c=relaxed/simple;
	bh=UPJqxENbOSMaz00/udLzL5SgT9l9mZPJG9ASuHS+xRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nQHanFCUl+q7mjp5t8IEigdjJKQnW4Ur8T4NO0EPz+jXTxnH4tbqEve5RZYf6s8uL/QuxoCdoGL/sQKtrXOpUq5c49TzH4H0q7mlcjceTBMBsmfxORnnTC7FRVoi1V/qhyV9hm/KX/jJ4F6SmIFL6gzAu3d5BjVvEUDuR1aQQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6gxsWA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6gxsWA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9601F000E9;
	Fri, 17 Jul 2026 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784300288;
	bh=UPJqxENbOSMaz00/udLzL5SgT9l9mZPJG9ASuHS+xRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X6gxsWA08whog1ABowRorTquSyhb+V8CtsqOaTHWvy/mum311SD6wstgtKA7HUW2w
	 8Msvct+2RS0pVhlICoxUpjVIpkIaEgqSXON9D5fwJfNiWoBqC24XDmQ+1D8VYtQbgc
	 tvMxZoFCA3UmWfEl6ZLr42Xpo18xrG62YkAohaLXQCnmNWiLiOdWgKGQdiGnCFX4Dl
	 oaXcPQ7TapcU/UfKVMAKgZ1GfbBvif3hFuLVP77QcOsmrP2w8NxkIfjiPJImXk9dyg
	 xssmfaeJG7NKiEw0WdhAqHIntXWMDjTlClEZQFM+YHJH+iLvwNtB94/sb0ybFO6Lp6
	 4+Y8keubrudHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/10] driver core: fw_devlink: Introduce
 fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717145147.823749-2-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 14:58:08 +0000
Message-Id: <20260717145808.AB9601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Setting fwnode->dev is specific to fw_devlink.
>=20
> In order to avoid having a direct 'fwnode->dev =3D dev;' in several
> place in the kernel, introduce fw_devlink_set_device() helper to perform
> this operation.
>=20
> Having this helper allows to hide the fwnode devlink related stuff
> behind the helper.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717145147.8237=
49-1-herve.codina@bootlin.com?part=3D1

