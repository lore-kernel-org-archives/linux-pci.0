Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8D4C9567;
	Wed,  8 Jul 2026 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536049; cv=none; b=OPkxiI2izouB1RtiH06+hOleqHGRrgfUUpTxokVnI52G9xLwue9fue4Almxaxp7IpCX6ip7/HMcwTeNTzkzN6GlIoqGhegHt8gtOMZ6OcMkFRHcAjWmN2HykB160iNQmw3ShI2qF0nVIrqkMnMiV+GImxS2nzkI9N1LOZhB3K8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536049; c=relaxed/simple;
	bh=Hr4FxmoXIEhCHsu37hcfXwRdkngPh6Gwemw+mzy4DZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AX+LHyRrSo4K/Is51AqPXC4XsQevrLgijY5+03dpowQo2DsQyNgPVtqB1gjx9SktHNgpDQqTAU2d1AUwfCa6uGPx9upvoj5TG1lYE68fgkgJzbKTsvfPJE6riS0JzEMyTT1nbyXiN7IbasewjpW75RzWYkCaEjNkbMKDbFq2sPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9wtyLUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9wtyLUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F9E1F000E9;
	Wed,  8 Jul 2026 18:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536048;
	bh=Hr4FxmoXIEhCHsu37hcfXwRdkngPh6Gwemw+mzy4DZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B9wtyLUw5dSX4yoaX0Qe4tv27yoBSotvh12rgQrcqIvdV+deKKi351cg4UCxGZ0Z/
	 lO1bD4n/d0YAbxswUB1H9Y97M2snU9r3tQhPKxTozpb/v0AuVdapKghv2kj7Wg38Dw
	 Q05E85NegmJa+E5S5ZL8ZJmz/7aq6MPWb1a+JyxX8nsowfZBLHVWKKAFrgSoa7z3zd
	 r/IadBTY3mDfuo1up3ecJWyE83FnMVtHtZZj2mvca3XoGgYhwAg2/2hhX49qd1mL5K
	 yKHxPkXmmHy4cHZNXx+nsOP0vZMVkSJ5UyAwq5jBlomb5viYjYtDuf4V/rbI7Hi+fN
	 OUjp4rg7N5/nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/10] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260708-edma_ll-v4-5-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-5-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:40:47 +0000
Message-Id: <20260708184048.20F9E1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D5

