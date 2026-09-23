Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB4344B681
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148589; cv=none; b=UjtMoputH7ZIGOvv0eyfjy3AbwgbZCJ/GD8TFggvYY8lItAM0+2xlj1PTe6YuDPiODXS96bT1oe2qBjWEnE5vsOZ/IKhf+BcyqCcaM2Fp92pf3xhBzJeoP3tUVCrgSASRpM8JD1s+Us2bFS1sM1LPDStVirAaFYo2osiyldBgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148589; c=relaxed/simple;
	bh=KoubuHQOi1r6pMaclV+XyOvlxENfVl7Zv9dFB+H4Qss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GQcSajYC3tgh/PANL+OcV2sSIzRbOI8df6rVx51vt7pAaDG6XxxYpKiF5CwOCedQVGfF1WbdFkaC3Rx1jZck7L2i5BEnbw/OJvFQEZ7u4XduvzvqkWdDlQJBeAAnrVhSYdDjSJlFJ9q/JL4HnLpzVmQ4SWYZ3MPZx2OKJv0U1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3M/+aT2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3M/+aT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6561F000FF;
	Wed, 23 Sep 2026 07:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148587;
	bh=KoubuHQOi1r6pMaclV+XyOvlxENfVl7Zv9dFB+H4Qss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W3M/+aT2m6EZOglyzbsdd6cyKfgV6LdLXK5nHVsrTHTr4H8GortIWa3yYKtg3HoqI
	 qJwAQMnzj/y0uX5OAVudmK1LceAjWkAcwuhE8fvuAFP/s79fJr5ZbinC990dW7RQxN
	 wqe70TnSSTSdUaYlTA0PrbIteC5PLZblZ4S+0TkHi5A8e4krt5nm24zZvH7kL1AeBr
	 fO8ofaBHfxAeR+zREAKhUApnC/2fEaWnINVzwndOOIrsGp7mJChHzIegIT+xQhyRv1
	 xQUyvEHWbL3qZOvrI1xh3TBwrNUiOPPlQUQtlhKw5agW+Nux1qYigS/9f7aieIZcsw
	 9u1/FX86xutnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] PCI: tegra194: Use standard RAS event selector mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260923071706.1134320-5-mmaddireddy@nvidia.com>
References: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
 <20260923071706.1134320-5-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:29:47 +0000
Message-Id: <20260923072947.AC6561F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Use the common DesignWare EVENT_COUNTER_EVENT_SEL_MASK name after the
> complete RAS-DES event selector field mask has replaced the old narrow
> value mask.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923071706.1134=
320-1-mmaddireddy@nvidia.com?part=3D4

