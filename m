Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F00306744
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798864; cv=none; b=T2dSsARXlXnkHjQKQKdzshPmYoffUGx5wGjyOum0h7oUzjB2fC1W9B/YfN2A+zFXvYmahrs92Cb8T688yZoD67KXDFrDED6Ho8ben3y5KauD4O1YjJZ/1ast2rcuYGlZBFtxfAT1MEsJroFtg4FAQEelz8LLMluF9B6oiKILCxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798864; c=relaxed/simple;
	bh=sz6JR/aCDYYdnugzy27gLdhBs0wrN6xZOVsikFfDYmg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GDwlsq4WxM7t+uiKG/yJgK4ggP8JlPm7+ccToDUObqoA7iM4XmL59j8hu35Kec9m6WrLba1sV/KIvFqjbjhJMBbwHUb2b/nx8300ugut8Ks13xVFaZvR1EY+FL1Xzs3Eicp3wZ43oX9oYnDe520jw49Fp6mI4OpmIrzUdj6Vvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlXNRMeT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlXNRMeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F471F0089B;
	Mon, 12 Oct 2026 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791798863;
	bh=sz6JR/aCDYYdnugzy27gLdhBs0wrN6xZOVsikFfDYmg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dlXNRMeTjGTG6JVuWEi9KAfPJrc0LmSCVSzfGGo1HUu2C7F7wWKh4H+EM5sFbyk4j
	 tHcJ6BJwf4xx5gQMdsctXp69qNENf+hCJALG9dnEAbijRHjHhmzWx70VoJyoQ7SsT5
	 EcnvU2LvquXi9PG0sxOxpYrXP9F7tJIcOhZMXcb58gBx4qgzovy1hSJhpRhALPTHZA
	 uwubKj4hTMB2DoqjJYlsysOBfsalKc/25trI5zxMihFV358h7QS9D1JvMagXV4o2d3
	 Q0SBfA3PYmukp8jijlPvTHA9v4/bPS7eyTX0Q13dX8L9jAmQzSznXBVEkbcavbgjpa
	 Fae29BcK/fUmQ==
Message-ID: <sashiko-outbox-167912@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: tegra194: Use dev_err_probe() for PERST#
 GPIO
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261012094815.28160-1-phucduc.bui@gmail.com>
References: <20261012094815.28160-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 09:54:23 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: bui duc phuc <phucduc.bui@gmail.com>
>=20
> Use dev_err_probe() when getting the PERST# GPIO to simplify error
> handling and properly handle -EPROBE_DEFER.
>=20
> Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012094815.2816=
0-1-phucduc.bui@gmail.com?part=3D1

