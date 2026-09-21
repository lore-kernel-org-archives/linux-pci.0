Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852248F010;
	Mon, 21 Sep 2026 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990261; cv=none; b=D4Fp9001XtRTaJFJWSFjSqyxBL56frdaZoYwrgqTxG++Bndq0FJmsc8C9OzpdJLW5dPeTrQJgqmtsEoD8vOY/munJc2mfznqpqvMyzENLVou50D1R6FR7bvtFMEkjG8n5hQjJqT+TnMMKpjzIGLoOAOWHgCGdLsT/INCGwAIn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990261; c=relaxed/simple;
	bh=reX35WPOw8SQVnDpR4qqsiOje7vbBxcXR/izIjNIKL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GQjAFwZt6haMW8Ep9VMY+e7QOXVsIMh6tTWDM1xzYfzbbpT8NYacllMbVGTVWFNjzTdeX7Wo6gset5g4meYQd/U0H2XcQzFMV3Bap9YjtiFz7PyMaARId7iV2Le6UwEerG5IizmVevaX5/NW+eetOSgWJsabYIoXNP7xObkyDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6AHqRmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6AHqRmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1D81F000FF;
	Mon, 21 Sep 2026 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789990257;
	bh=reX35WPOw8SQVnDpR4qqsiOje7vbBxcXR/izIjNIKL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E6AHqRmKjcZWV1Wdscb2SmTIbZfcIeIyO+U3lmN3+y5/bddByyvF8/Xk1MZlsHROv
	 W9+fSXLDoV9mYaoCDt1L8OpzcQGJlCI2/WK7GGriB8ADI/HS5dGG1iVnHPIDfgt9mG
	 VgPosvAHvDztkDGF2i3++Hhoq/jFtrBb2Jt9kjU4p2Z7XLFJ21xlnVbCQzFH7k0GWS
	 OjpXg50bquZs7JYStqmPf9rRpVo6LXtlYzwfN82wDERG184WSVjezYcjKyTTO7Dtts
	 sQf/HFwMW/nG3iK1sg47fIQssxQ/hkKUc+66tbYN0sL3+Y+GHlNvBO412fMzogQDYK
	 bpu/nWdqdzb8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] arm64: qcom: monaco: Fix pcie1_phy compatible to
 list qcs8300 first
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, olteanv@gmail.com, neil.armstrong@linaro.org, robh@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20260921-monaco_ep-v1-5-63c5282fb0db@oss.qualcomm.com>
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
 <20260921-monaco_ep-v1-5-63c5282fb0db@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:30:57 +0000
Message-Id: <20260921113057.8D1D81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The existing pcie1_phy node only listed qcom,sa8775p-qmp-gen4x4-pcie-phy
> compatible, since no QCS8300-specific compatible was documented for this
> PHY at the time.
>=20
> Now that qcom,qcs8300-qmp-gen4x4-pcie-phy is documented, list it first
> with qcom,sa8775p-qmp-gen4x4-pcie-phy as its fallback, matching the
> order used by the pcie0_ep and pcie1_ep nodes.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-monaco_ep-=
v1-0-63c5282fb0db@oss.qualcomm.com?part=3D5

