Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375752D3EF2;
	Tue, 29 Sep 2026 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671283; cv=none; b=k/AI9UQuKLpFkv0S1OU/yhIiqI7UF+rQqNgtClEkFovKVI5hGbV28Aiwf4LCCK0oQgFHzsLBR2HYuAJH0wsC/iNj3p4nkLQ4RhP+/PyHwUE484DET1VYO9/86FigfMN2V04c6ymgdmPc1ebx1MJoLATm/rgT4u/EY21tFMxPawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671283; c=relaxed/simple;
	bh=wpe24yYcFSaPfgZu1Fk9tsanH5Yc9z1eRX+O4v4sTRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BgDdMVq49jgbRnOFPzPkBrzTgPmHZ9KD81w32ndTeDhCCZjhFLyguGy9MkUlbCstYkaWVJd0NQ21Q+KsU2VIGUC0ZWc++HpFy2H8MarB35XI+gpcMKZhga9rhZGBECjl4jMdeO6pBGJ8qRWk1EJKnGmAedBJGnZl/qXCVR62SY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8ILdfLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8ILdfLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2691F000FF;
	Tue, 29 Sep 2026 08:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671281;
	bh=wpe24yYcFSaPfgZu1Fk9tsanH5Yc9z1eRX+O4v4sTRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G8ILdfLN401vWEyFetY9YVJhpbMAdka+FThAXtrbw3YcydhGHXPAXpi4bV1FFYVDI
	 XqPU7yhPIY9obCRv0PiE290BTL6QpHc3EoT16VuEkb8DoKKEWVL3i7nmNY/oTPjjQr
	 n7b8OaYyjO51QHd7F+dZBU0aPisjG/JcdW54XBo865DhwrhNJYjf/28TojlVNCZnQF
	 ohZs1Yedq6tEGvLtWiUhTgz32zrnzBJ4H/dshmgMRsq8WMVPAdOFeD7FYbTSuLpu3T
	 VssaotgoHFen+8vi7A8xdjO0lmLcVcdxtH89YKBOUQLmITAJzyv5VBqUypUNTVtVWo
	 AaX2k1uh8J8ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/6] PCI: spacemit-k1: Add device data support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260929083755.458238-2-inochiama@gmail.com>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-2-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:41:21 +0000
Message-Id: <20260929084121.6F2691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
> data to handle the K1 specific logic and make room for the incoming
> logic for K3.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929083755.4582=
38-1-inochiama@gmail.com?part=3D1

