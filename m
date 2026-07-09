Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34411CBA;
	Thu,  9 Jul 2026 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559694; cv=none; b=JEzL7TJibi0U7feOBvKIw6nreTQ1u/8kdc234U8RW7+blceotK5nOfbzLKvK2WYm1RxOPDOnObqPRyK+UFS3b28Mv45P2bgfX4stYEKfKNtcw1w+exclflLKs61JtGBxZcJYwWDnlizDR51ng1y9T4NsWjh55feD1U6W1HywmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559694; c=relaxed/simple;
	bh=zIzKhP7FNNWvUm/6tuk5vLAbYEF8/YXg3cqXNaCNC1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tJZdnRmfU3oqz5JdMkA2L8bUo/kZeCPPYKjd0dpBE5nyvh3wcaOHuQhjn4G32+jkmkFu2GvUg+bn6PFANZdmAheg49/1JxPM4TpuL/2mEMHTR1+Vozz1JmUpHqbF0iRcyIFlC7wxqi04ceohmf7PTqRQCbVhI766Eoa2j/g54HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3+fSEup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3+fSEup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D661F000E9;
	Thu,  9 Jul 2026 01:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559693;
	bh=zIzKhP7FNNWvUm/6tuk5vLAbYEF8/YXg3cqXNaCNC1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n3+fSEupWp5eZlmT+m/ON6yab1DGB3xrOhz7mjm8MDXkJIuafn/h8EJIBi/YdjMrj
	 92mkjZWmZj9/49X+XVgXFBaxvu0xFDh9fuifJNFnTbKZl8txYIp9IvLTKuz+j/tvx/
	 sYmCWHYiVVHrUWDoXCapJdIFYl0taZpUzcV5S47e9k413nwi2AFc2cXAH5H8TqNhmH
	 kNYT+Rb6Id5p2EoHlxpm25hvXEKqusG1rHwsuj4GyhGaWbeJRzr70ZwrFDB+6NG0UI
	 sWhwEyBYeUSfBcILYYd4GkEa/cdqLwMSJen60upi8fHDJXdh0fweo61Yd/D/cSSxuF
	 k7D8p/Lm0e0Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/11] cxl: Split decoder programming into a reusable
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260709010304.680422-2-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 01:14:52 +0000
Message-Id: <20260709011453.15D661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move common HDM decoder settings to include/cxl/cxl.h and route the
> register programming sequence through cxl_commit(). This lets reset code
> restore cached HDM state without depending on private cxl_core types while
> keeping hdm.c in charge of the existing commit policy checks.
>=20
> Build the low-level HDM helper under CONFIG_CXL_HDM so it is available ev=
en
> when cxl_core is modular.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709010304.6804=
22-1-smadhavan@nvidia.com?part=3D1

