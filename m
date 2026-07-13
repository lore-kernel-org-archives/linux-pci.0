Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A630DEA6;
	Mon, 13 Jul 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962654; cv=none; b=jFryqu7gWebmqB2DLVxSCqbzI6HxDd2eQYf4gWeVzS+3ZT5A/wkGPprtkI0YYa63COKu900wyDtNBlRQkjVhX7G8SfEpCv/KfKACSAsM49OWk+FM2YAuemC2ArOSW2CNDqoM6Wju/DOI8pZ9rqUaT/KhnnRPe7yCg6XnO37iN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962654; c=relaxed/simple;
	bh=IDOxhm4ksyT9IcSqX57sUadEwDaUrSU78Xa5SY6/XCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hUYLHHScMG4/mAtpNPOBMyUIWCDcQCA02vKSFnxtmIxH3YS3Fw+4dSSpHDr/LRGXvcGcCyfG/oFIQrju8eGpajIiOLXVWn0+rSsc/yc2wsDhx/iX3aB14TRdKJV2YauaWbHhjqbUVsCpKWhAEr29+GQO3oSHHGM8bCIOn6J+FtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mII5MWM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mII5MWM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06E11F000E9;
	Mon, 13 Jul 2026 17:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783962653;
	bh=IDOxhm4ksyT9IcSqX57sUadEwDaUrSU78Xa5SY6/XCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mII5MWM1ga0z09a5R69EpBtB5NDpWJRkz9frbZ+aiYuzgNyV1SQn0WmX5NeYZI12q
	 /6yZY7LHOHO03GkW/RLXwYoSN/IDmFrRqgv8GlBtvYp8NuhBaRP+NCRAwLtujmFzl3
	 WK4wvR+LRp2qfFkF0HA++OXS92+rg2dOM0pvsly4Yhf0p0z41iq8qsnbI6WeknSemN
	 5IGrw4nfNegHyCkDZKdMksbsMmc2uDB20wkRIToOiWiokyD0pJKAlGYh+EZfc4UR+z
	 sIvpjMQpCM9wyBKBxJawtPofVyhYLtQora76/GRznKyi6pa0SxCPFBbooUGGTLCqhn
	 71zY4iyK1TWOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260713-edma_ll-v7-6-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-6-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:10:52 +0000
Message-Id: <20260713171052.B06E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Introduce four new callbacks to fill link list entries in preparation for
> replacing dw_(edma|hdma)_v0_core_start().
>=20
> Filling link list entries is expected to become more complex, and without
> this abstraction both eDMA and HDMA paths would need to duplicate the same
> logic. Add fill-entry callbacks so the code can be shared cleanly between
> eDMA and HDMA implementations.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Tested-By: Devendra Verma <devendra.verma@amd.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D6

