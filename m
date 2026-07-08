Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF3F175A8F;
	Wed,  8 Jul 2026 04:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483588; cv=none; b=ji0p7wXUSi3MiKmwPNj4dXclIfEEQ5PcVhYnUp/kz+7U38M2ri4h7msPAX8NnJE400szxiUoVCFDIi9or9yKiwPs361VZUf+S2NxaZUpMZkKvFoc3PvS3zUKVuk6Dt5kokjuLaHFvjVE3BaRGPnl/y4qP8jt+re8cElx7eA+foM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483588; c=relaxed/simple;
	bh=ScQN+/HLF2GrPiPvGJEkHuUK4IOPQ3GQCHyGP3go9/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=roYL7zMTjut7bHJSv3o+20DI0McHGkeeyPJBs3mbwFpCEci1/3oeIx4kne+eqA1kH4Qd65ZOne+jgMOGdKAJLsE8RgNQpQYDkSGM343lChV9YljBRwUa00hOJ0Nj6dsTWupxNsoizYgHV376NaymqcMZul1Kvetj+abLbcKmMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltXDizsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltXDizsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D541F000E9;
	Wed,  8 Jul 2026 04:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783483586;
	bh=ScQN+/HLF2GrPiPvGJEkHuUK4IOPQ3GQCHyGP3go9/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ltXDizsyi/4GBE8K5Ftsqn8QmRCaYDmnSj4GZerwgu9Ahe54E/EUeKUjTt1YSksTH
	 +GeCnWRVb5V8yvQvLgE0BX/QZ6xCO321Ixi88+svvMUtQONmMbJiUH2FARks1xC673
	 J7WhU9eQRfY1nXExlM2nvcGxbfSqDL0CEUKGldcQkR9L8YyJXYduUoAMAFkhezQzrJ
	 6PZQhX+syupvnjrrHvmRrtJ861rwdNeSbS0vo+ZZlZm60TelFC1QagohQUZNsekQd0
	 df/zUdRX6d8LyIED9SBYEIdWMIYt5IuqjWPWexY6SngascdK0ULZDaMxsiK8rTmqyo
	 GQOtrjhpC4ZMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260708035928.580236-2-hongxing.zhu@oss.nxp.com>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
 <20260708035928.580236-2-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 04:06:26 +0000
Message-Id: <20260708040626.A5D541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators=
")
> introduced a boot hang on i.MX6Q/DL variants by changing the initializati=
on
> sequence.
>=20
> The issue stems from coupling PHY power (TEST_PD) and reference clock
> (REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
> managed together, the timing between PHY power-up and reference clock
> enablement cannot be properly controlled, leading to initialization
> failures.
>=20
> Fix this by separating the two concerns:
>=20
> - Move PHY power control (TEST_PD) to imx6q_pcie_core_reset() where it
> [ ... ]
> This refactoring ensures PHY power is controlled during reset
> operations, fixing the boot hang while improving code maintainability.
>=20
> Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators=
")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708035928.5802=
36-2-hongxing.zhu@oss.nxp.com?part=3D1

