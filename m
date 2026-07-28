Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A2355048
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259359; cv=none; b=imvSq8hScBFnHUfW2m+1oy/4WsFsdbDk1tzxEy4CfNpC7DIUq/AXEJ4hKg71zBDfWkH8DGVHBT4yoH3Xohe68hG6cDvL2xWam2am933a3aSBxrBNhzUKfpWEB712ChEV5RJa+AKVnfGKty2JT9X5nZQOzfF2yD4M20pD9vY8GT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259359; c=relaxed/simple;
	bh=UJcjWXc+4UHApFMcCPAeuW6IBHXear6VvPmeU4H1coQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cp45CWBsXJ1Lvi490fpyHdBMogrpdNqiwaPWC14o3SGwyBHib7wjO8wSrfkx6vvsIp43bH0CEa0D+1yJDr3GFvC/Szld7ojq0+9PXnWGKKkFtU2FDMb0parNso/ocUpXX1BBCUIRjTpTM47WxgSqS53fUgFHEAxoCdXXwnGoI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP1wn/WU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP1wn/WU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A8A1F000E9;
	Tue, 28 Jul 2026 17:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259358;
	bh=UJcjWXc+4UHApFMcCPAeuW6IBHXear6VvPmeU4H1coQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KP1wn/WU75+6fth0IYsAXYoFV5Rt9+JvgG/KJ/COJj47dfThcG7sViOaPzK84irhY
	 +3bn1Ggc5x+MtIQ/3ncQressV/MnHUKQJmaVyn/s4voBs0dHGSfIEumfwm2HVNoJ7h
	 x7m/jsnBF+5gnPElDzGvASfe1k0M+i98xOsHW9uccfteDzOVv/B5+IyVhmlkVPBUIT
	 V0CjKaR8KiIeNoAjyZU8VNr4Enhs2Xt7sdxuOKQfKjocmx/Bw50PfUtv3GD/vVIZEq
	 /7EWXqfdzMZv+qtV1znEHgg9Fq/xqLu6dPUkxa5jjVsZxAnBKARMht9JLT0ZhYakHd
	 ctXM+DVGsBG5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 7/8] i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260728155308.142713-8-adrian.hunter@intel.com>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-8-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:22:37 +0000
Message-Id: <20260728172237.C8A8A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The MIPI I3C HCI driver needs to identify the underlying system device
> used for DMA mapping and PM operations. The logic for determining that
> device is currently embedded in the DMA implementation.
>=20
> Factor this code out into i3c_hci_sysdev() so it can be shared by other
> parts of the driver and keep the device-selection logic in one place.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728155308.1427=
13-1-adrian.hunter@intel.com?part=3D7

