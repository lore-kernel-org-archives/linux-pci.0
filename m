Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601701;
	b=wvSvNsC9vupUMe3PdTevkihz4KMPV8fEw6PHlAwIAMl064sWAEq10Al3e95jUcOnfs0O
	 /z4cS+yOCa1/vy9ACsJU0LNsa4NEkgGd7rlPavNmnzBjVqIJJ7DWzdwe6S66nuZmxy27M
	 naB98pT4oPkXiUrOG+srQrj9mBLj+v8ehukFMDxvMr38htu0mf4Xq1632B+eO53vmTg+k
	 lsklngP+fDjUvGVqmFDGY0keQaSk+yzXbWlOF6uNEXctsmRXHoYeg0WYemI8xFgnthHsE
	 YS6PPnG15kJjQ8ui+I+Zw8HIXQcFwZO7aMICbYO8IjFfKcVxUwkpD7sTgAqZP95QKgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601701;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WiKceO1dwbfD+8EqgIx6BHQIjk8n9LvnRwi88yPOh0I=;
	b=2go67uQ1Aau6ngFB1vtwmsSKWQSDcFkvsXTkVAZlk1mlPiawLPSxGYla7qAbdOPwnAjR
	 9LsQeA/BRsIdMWgubrIbaGvpEZ3za+8TcHif4eH7G1bTls8CO12Yf2dz1T2EKUa5wCKrQ
	 tZ/XSjpNw20XR7/JIObqx7eXoXG0VMtpEYLib6ezPe8LlOxpxdcIkmEwjKZmBzCr+EH5E
	 vYHxPAX+NRzGMrVXgn99SIVMuEN/GtjRFJAboFfWxwRlt4Acz7v+N/+YdHiAAjhBZ9m8B
	 1nxfhdPWeNVf+WqfkvV/pBTDPvOOE4jheqacYfHnJ0ZyQMc2vRlHwmqAlBbo0OZ4uyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=et61vvxM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F90606A324
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=et61vvxM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B376B1F000C1;
	Mon,  2 Nov 2026 06:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793601700;
	bh=WiKceO1dwbfD+8EqgIx6BHQIjk8n9LvnRwi88yPOh0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=et61vvxM2vOZbGsUiCLYOTrg/Lcze9zaJ4IVivaBuEIJSGGun2h1yn4JQNSYJSYfU
	 36Mcpt4ngr+kyOdix+jCPlbLgDtExkkGJwZR4IY6yIA2+xPh1OFSU836tv2/sWUQBI
	 jImPcwSq+R7AofaL4Wu52SPOEQwE8/BhtMvJ3sNmcA+bIrFKDr9IgC0QoliNoiL8pO
	 RPEqeiHhBam4eEoAul6DuF4+u70Rvfltc5qEtk/jBs30FXnaIXgv3uryVmR2yMru6A
	 donh4ybuhMbF+Qr1lKWn3v9pbsSe5VHD+6CPKQ8QjyXgA7ujGAD+hKYCDnnuiu0Tf5
	 Q65K0pe9BRtCw==
Message-ID: <sashiko-outbox-192963@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dwc: tegra194: Clear event counter masks before
 programming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261102063835.3831940-1-18255117159@163.com>
References: <20261102063835.3831940-1-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 06:41:40 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> When programming the RAS-DES event counter control register, the code only
> cleared the event-selection field before OR-ing in the new group, event,
> and enable values. This leaves stale bits in the group-select and enable
> fields from prior writes.
>=20
> Clear all three field masks before programming the register so that stale
> bits are not preserved across updates.
>=20
> No functional change intended beyond ensuring the register is rewritten
> without carrying over previous field values.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102063835.3831=
940-1-18255117159@163.com?part=3D1

