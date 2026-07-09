Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1A422556;
	Thu,  9 Jul 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611927; cv=none; b=M7/HaJIbKWcPp6XrpgN5cvqVC1r4O9yB9swcX34O47pfpD4SFa0pWSsx1vnwHyWxpK2bnJaaQB6jlVNsIdZfaGE7NoB3TDIw7MpEzUDf5Y3I+RYAXs8otxDv9carSKJeWmPRtPob0bSBtIdWK0TTK1hG1Q/oNx1o24r1G3d8wMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611927; c=relaxed/simple;
	bh=GVOLE/aIvubsxSreKHfu+73eEScRrzBG95Hzsu6szTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S2k6XLZ5iw5MkbfXUkcqU5r2FC6kDHmeNaJC8vVBP6jM4O2CqzJIQfojuwp9e4+RHqqf9wQmQL9FMOR9lKR0hCC+wXEe7sIdsbBPaGK21+k2HtKvUUfxZKt2gGR6aNcWF25D4qx7FcgMdlCmlcLjzu3qgmIBYj3R2mGH5c8U4hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzxvDmHF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzxvDmHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E92D1F000E9;
	Thu,  9 Jul 2026 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611925;
	bh=GVOLE/aIvubsxSreKHfu+73eEScRrzBG95Hzsu6szTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dzxvDmHFD0GyihMtLIUuvXisNGRy/BSRx3v0xhnL+vU8LxffbMq2wnsL7LY+wSCCi
	 TDcm1xnA74UpDIC0+OB/K6I0wCkKWuHP1DbuLezEHvyZfO1EDtlA6LvLyOH2z9kAki
	 VNN7gfjHJq2om2Hub+rMwKZuMCZLc/dbNnYJLqkKHv35vuhm+gz+o3SEAv8E1lOHvI
	 f+KKa+dg30RTLnp8Z0lOKtfnWhbtXscQwBnCU0UdRbNFJqNivmUFcCtZ2x2vWLgWTh
	 augbyDWavVKrQZ/u04too7k8YaxYwnMGgkYKeTSL2yMa2xZCGaRp/4eHZwOkStTzA+
	 UTi7cuNuO0y/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/10] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260709-edma_ll-v5-3-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
 <20260709-edma_ll-v5-3-e199053d4300@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:45:25 +0000
Message-Id: <20260709154525.6E92D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> ll_region is identical for all chunks belonging to the same DMA channel,
> so there is no need to copy it into each chunk. Move ll_region to
> struct dw_edma_chan to avoid redundant copies.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-edma_ll-v5=
-0-e199053d4300@nxp.com?part=3D3

