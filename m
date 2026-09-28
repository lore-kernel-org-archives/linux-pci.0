Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130C613FEE;
	Mon, 28 Sep 2026 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559707; cv=none; b=AD0Rs33z0Br6vPSW1lnKc7BCscCkVDbBfsSFVTe0G1BZZr5RYmvpokGhWhB1XRyoVVeft/dfA+ZhXXv60ZKCPErv6rpHp8Ciav1rMht24a9WC4lyh0XoMDiaWEl09RAUnahIx9c8rKlRKjnD3iiant90u9hBAO5l+iswPnW6/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559707; c=relaxed/simple;
	bh=3lmNbUy9Obh2EFwh4JkLS2PuZqp3oevZJ4MZhvyejV8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M/Ftyd8l5RV6a683w8cmE/2uh5aeBoXBh1GyRApQdejh8+4Dcc8kdXnK1ESxdGLLzDfC8aAFPNTDrA+Ws4L8LKvv+u+ISEduqN2qy4UyfBRQUifA7nDNVw/RVrVTpWvLGtgaoKwp5Km0gPkn42x9dOVs2edG8TM6B2Ki1sbDK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOp92PYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOp92PYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CD71F000FF;
	Mon, 28 Sep 2026 01:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559706;
	bh=3lmNbUy9Obh2EFwh4JkLS2PuZqp3oevZJ4MZhvyejV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aOp92PYOSzUJ+ra53vTWffS2mUtykcPytN1JT3A+vNNw/VZ+JuMXxrLwc/pfsTesU
	 3jlfoA0EXQ9IcHOfB0lWfnxxcw9Wqy/lAo7ghNKCuxUSCJ8TgQqc8FFB62aJcDDo8k
	 ng8dCR3Y9R42Ce0bGkAjhUS9OKO+0dydm72mY9+KDvfuYhUs/GVQKnzuja0HeZfG2d
	 4uSki+SPgbP+JXX1Wof5WB70pmxkJXFGxM3n7T98x43/IuwmOPHTanCJWEg9jf12gF
	 We0ppSKjUGh0cI06I02eo1SwtEKAiqKwLAZ507wmCwjjZ9VQgHwW54Q2BPl5xvIeJo
	 VjtXhYpAT3/zQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/22] PCI/TSM: Rename pf0 to host
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org
In-Reply-To: <20260928011123.450800-12-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-12-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:41:45 +0000
Message-Id: <20260928014145.A0CD71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Rename pci_tsm_pf0 to pci_tsm_host (and rename variables and function
> names from pf0 to host) as part of converting pci_tsm_host
> to be any device that knows how to speak any of CMA, IDE, or
> TDISP.
>=20
> This commit just renames the functions and provides no functional
> change. That will happen in the next commit.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D11

