Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD55A4C754C
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642176; cv=none; b=XlDeLF/RIpYDkVeLWsa4LeZMW0gb0+NLHRfNPYiDLu4EKujaemDeFVK2uLhkVxsKYDPOyS9tEBD0N7TuQa7d3Le7V9E+VhpsqCs/Gc5msm5ZQTnlV6AyfjrND4z8RgJbzpjg14iGSYKElwa9QRlgQRvByQbDl/oRCLFdZZ0H8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642176; c=relaxed/simple;
	bh=nbHLk2mABjAWyG0zClYon3duE2xNczn9GFAJpMezeVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ka6cKZZU+tJuphhXnY5VT0I7QQ6gijocYiVN9a770G810BSk3rGhdvel/zr2z1tggOoT7jUbIdu4yzRoGGYe5UTnasrYzB8IQd22UpTXPp/ZpB3q8Pfne5cjqUwtmHyfIFF+vQGgOKnB8F0GYXTkxl+iTj5Y9fTzdTirueIh6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPKey93/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPKey93/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB0C1F000FF;
	Thu, 17 Sep 2026 10:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789642165;
	bh=KyMlv1V00W9ui3KEHLGllsbacXO9/4fxieIYCbkTaa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IPKey93//nY/pGuhbqwU9q/oPXW9PbrmYLj/nogdFbig/RaMJhFMkTe4hjBeEIkjm
	 8xypLaCIcZ+VDy7+jPXbzAlmmTu+tbG9JI97G1GImpLmq8sZR6GPbT5AFw1iYKXhxo
	 I0yb2E8oAbr7xXxUHl6ydEGiEEaR0ZYuOdpkBMpZHrkZoSU32KdDXigd+C+dE0mWZp
	 67806yqTKGsE3mA3aj1VMzsA1qbwuVHOTmP0oDdHwM2f+l/4PjYCp+MJXR39BfL000
	 7q8/pnR/kNHacqOHNSk7iv4WgGGD+8WpEcXhKY43JYISeExAM2OZ8WN2v535VU4IIJ
	 SK772m/mj0qCg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2] PCI: Work around Pericom PI7C9X3G606GPC Port 4
 BAR erratum
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmoy Das" <nirmoyd@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260917103814.1985144-1-nirmoyd@nvidia.com>
References: <20260723161010.2638956-1-nirmoyd@nvidia.com>
 <20260917103814.1985144-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:49:24 +0000
Message-Id: <20260917104925.1CB0C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When the Cross-Domain End-Point (CDEP) function is disabled on the
> Pericom PI7C9X3G606GPC, Port 4 exposes neither a BAR resource nor an
> MSI-X capability. It still checks memory requests against
> BAR 0 + 0x7f000 and BAR 0 + 0x7f080, the MSI-X Table and PBA addresses.
> With the internal BAR value at zero, reads reaching Port 4 at these
> addresses receive Unsupported Request (UR) Completions.
>=20
> The affected system has this topology:
>=20
>   0002:a1:00.0  PI7C9X3G606GPC upstream port [12d8:c008]
>     +-0002:a2:04.0  PI7C9X3G606GPC Port 4 [12d8:c008]
>         +-0002:a3:00.0  Micron 7450 PRO NVMe SSD [1344:51c3]
>=20
> Diodes' workaround is to copy the upstream port's BAR 0 into Port 4.
> This places the Table and PBA addresses within MMIO space already
> allocated to the switch. Port 4 accepts the write but still returns
> zero on config-space reads, so readback cannot verify the mirror.
>=20
> Firmware can apply the workaround during boot, but Linux BAR sizing
> reads zero from Port 4 and writes that zero back after probing.
> Resource assignment can also move the upstream BAR 0, leaving the
> firmware mirror stale.
>=20
> Reapply the mirror after resource assignment and again after PCI
> configuration state is restored during early resume. If the upstream
> BAR is 64-bit, also copy BAR 1 and disable memory decoding while
> updating both halves, unless mmio_always_on is set.
>=20
> Assisted-by: Codex:GPT-5
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917103814.1985=
144-1-nirmoyd@nvidia.com?part=3D1

