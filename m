Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A63A9605;
	Fri,  9 Oct 2026 05:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522548; cv=none; b=DxWcXc9sSRHm7UGwSrLKEjq+9qawdf/fZ3eJjuX4LJnJ7tOzrYCfJgxZdrZzBK3wKq55wWKWhxO+0ek5/66BacUsL0qVjMKtblMBGZ46113J2Of5iqekp7ed9G5FGyiMOZ9aza48wsxsNK8qQLDkdSlI97Zfpafi59saNDx7aFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522548; c=relaxed/simple;
	bh=qbgoUwTVF4FQiDPrAyhdxFL/c5cw5QqqK5EQtZsiGKU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aMfVv51FMTom/S1P0zfSlmM424+nikC3NO9fNnyq8rQrzJAVxrDyefzLZXLnRgxNvflGUrfvXkhxNknEHkm1nfl4fdXV7QTNQXH+k0VDMlsy1v9TrfTDB2o0liYLYjVRd42VKYh3LOKGfMlKlm7NQiK9+xlEJNcXcjTUKOBIdws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmgMYU5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmgMYU5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167781F000FF;
	Fri,  9 Oct 2026 05:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791522547;
	bh=qbgoUwTVF4FQiDPrAyhdxFL/c5cw5QqqK5EQtZsiGKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lmgMYU5IE4Joq3EjrmokZi+WpXwKOYDsuuhA83UuEiks15u6lzvpQRjq2z5Amgu3t
	 AhFK4UL5vGlDww3qo3FB6heMzrce6bTj+XVqzeJw4pPPaSO4g0zaIdFHdIFzB8xwes
	 YSP067zKgCm+KNsAm3BUG7jeVkDP3sjbqJ3LpNEW++m/x8WVo7cWzdaaksYIwInUKE
	 esYGTJ08D1pIgutFex4mTw3qHwQ+C4xMJNara176WUpVW1aRaCNv4UiZAIk7+P/enV
	 xICGxwy94SNvi85ql1mQVlBXpJHLYn+wzwacL4qolxsZNuC0nX8lDEUrRZIcjVR9TT
	 npT3tG/kxFK2A==
Message-ID: <sashiko-outbox-164869@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/7] PCI: endpoint: pci-epf-vntb: Move
 epf_ntb_is_bar_used() up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20261009045949.1109871-4-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
 <20261009045949.1109871-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 05:09:06 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move epf_ntb_is_bar_used() up so later BAR selection code can call it
> without a forward declaration. No functional change.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009045949.1109=
871-1-den@valinux.co.jp?part=3D3

