Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6548CD4F
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402183; cv=none; b=oAx61qjn9/LMB4h5YzmEpi43HWw0pTEKv1GMwHofKxtQZsfuAL8JH2ZfhNMWslkmv1UTKxNUM9tQyUxBbapYoB1KRGda0EccyOxyzEKCaaNUsmc90qHq6/LV4x6iu5NcI2vd4rbakFtmLXqobsPcUom9yNiTeUwIy6Od+/08Ezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402183; c=relaxed/simple;
	bh=yuae2793E31cLBl5XgqCVr/Wauv9fRX4n/mPmSmvMLc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=vC6q1YUtmiieAgJ3miAzPQUSC3gfVo9suGuWL5JrNpFtXASXVKga3YGIfOZlR5NUpj9UWj3gZgnxMCBvHy2ijDUjlxh/vnyZXNNrQO5lBK9qRgXzkyIx0ar1IGgy6kBYM7xcwA/gMsQt8Nxk06o8h0GTQV4qxXFu9oHjslu54S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4lukXdR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4lukXdR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60051F000C6;
	Mon, 19 Oct 2026 09:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792402182;
	bh=yuae2793E31cLBl5XgqCVr/Wauv9fRX4n/mPmSmvMLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d4lukXdRV/4JZK7LQ7ak5DTMr5sLCIPW/ru9xHL6ynI3X1W4NP8czur3cxrAjcOLu
	 ktpdJlOKKDbwQz8Oc1eW4yhV2vtklCPzTvF28DG9PiOAeIrbPRftixaHnF4ROUYkz2
	 clNaYuRtdn4POgBpRSWB6CKyAVDAlSB1oI116zgG9t4vM+ewqJHcyLtgk+1ZTJH0is
	 IJIrCOcauNkGoWrx73d8fy3V8+SWFphHeLFxAH559QJzVbmbkpN7/4unW6D04B3jSC
	 Ayeg9VVHLAbjhiH1VEtfwbIY68pI+CkHUUyUT5kpXiVVyh6uBkim55maZ06KszJKnx
	 NaAYfCgna/dYw==
Message-ID: <sashiko-outbox-176907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Add qcs8300 16 GT/s PHY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019-monaco_ep-v2-1-852cb9f5d012@oss.qualcomm.com>
References: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
 <20261019-monaco_ep-v2-1-852cb9f5d012@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:29:42 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The QCS8300 16 GT/s x4 QMP PCIe PHY was previously described using only
> the qcom,sa8775p-qmp-gen4x4-pcie-phy compatible, since no QCS8300-specific
> compatible existed for this PHY. This was a mistake, as it left the PHY
> undocumented as QCS8300 hardware and indistinguishable from SA8775P in
> the binding.
>=20
> Correct this by documenting a dedicated
> "qcom,qcs8300-qmp-gen4x4-pcie-phy" compatible, with
> "qcom,sa8775p-qmp-gen4x4-pcie-phy" listed as its fallback compatible.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-monaco_ep-=
v2-0-852cb9f5d012@oss.qualcomm.com?part=3D1

