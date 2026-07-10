Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2528153BE9;
	Fri, 10 Jul 2026 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702565; cv=none; b=FUnTyPmhcLhY8yUl3Ti2/9aYc6Zbx+oppwglA/Fi1BBAcgDpU+86oJK9tMai7GNTaoY3xBftVyj9dF1Hy1aAyMRuHXNFawG+dC/rTh997gfAnDqzDc2kQXja8HhTE0d3faTYHZZVt+XgLrGGfSFzPhhI+DFZfAYCdiN8phgxMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702565; c=relaxed/simple;
	bh=PCA7U5UyCoo9aH7jEkw03B7i/KEXkAQ2WfuHLu1WOUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XbT+86qMadBEWpXaN/o7BvuRwApqqlBZGwce8idNmEquCN79lyKnkajJzfemqXHSTfX+/9jhlIRe/J/RsouH5EQC3eDohvqwZVsyaPJWx4+T/egx6KLk9TyGCJhnQYkt3QyCyU9UbkXFP3p0Hx88FZYkwDzhM+U0L4SJrNfp3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj40yLpy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj40yLpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFA51F000E9;
	Fri, 10 Jul 2026 16:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783702564;
	bh=PCA7U5UyCoo9aH7jEkw03B7i/KEXkAQ2WfuHLu1WOUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pj40yLpy8ioVaVWwmoa+7wp9MaIDLzYOQs7R5UBg628ZFgD40OBUC0CCkUjj9+/vW
	 TAdzvPhJXIVV6BF6IrnxBerpOFGmsb2mYlC3x61tP59jh/neNtJ0whRee0hYjJw/Og
	 TkVNp2ODW90qdlbDB4vM0n5jfmyU8yvg+GyQJANe6rLVflSe4XGQUeFE+25lghY/VI
	 esRp68aLQOP9k8d3KcXuEr3JIujGPypuwDn3eUlRhNnWHcBuVUoH3LO/ERuubY0fty
	 pthu2C0D14OPKcri16wRZZ8+w9El6omISU/uw/CxVfyVHZx4t1z0DN1pc4uU8fZQ3z
	 yZjruz0kUondQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/10] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260710-edma_ll-v6-5-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
 <20260710-edma_ll-v6-5-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 16:56:03 +0000
Message-Id: <20260710165604.1AFA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Move the channel-enable logic into a new helper function,
> dw_(edma|hdma)_v0_core_ch_enable(), in preparation for supporting dynamic
> link entry additions.
>=20
> No functional changes.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-edma_ll-v6=
-0-1471d278b73a@nxp.com?part=3D5

