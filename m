Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714F388394;
	Wed, 26 Aug 2026 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739785; cv=none; b=rUyKeYDTc5lF/pchjuuX4oW1C0uXIKxxkzJDrGGPP9LZduRGbIrtkfv3U56ffpI2+imTLl4rlE1Y/XT7M9P+q/mKXzcvFUE3sylh+Yf5Y/IcywOfdPZMZuxh3eLpfXzRjZBkEMvZQFCcvgmAYa+CPMxdokEf57mgGt8vNRgCkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739785; c=relaxed/simple;
	bh=lSuY4N3cek9acjN6msxVA2G0QNIMRy+hhdkFIR777xY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s/UlOTZTsUPBEciy96b459H5l0rs3jS8u6kKJpaJedaa4kWQddc4DFr5JoNtyNnlZHTRL+AaDGP26L5A1QuOQPzOmCkX7x7g8pcdAfDvBIMbP7n9MW3xLcN7odA6Xr77OQAf48M/e/8qkg42lNqOVhFigzMCgDpqYVq8D/PUklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgphAT/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgphAT/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90431F00AC4;
	Wed, 26 Aug 2026 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787739783;
	bh=LCFF0OKX7+aWdo3GWy8LuhCwooP9TtJsXhf+3xfy+wA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dgphAT/qTQskufkJEZlDQPRBMkuGyeCwibGLm3BOt3yKoswIkj7Zt8dpd5xMHvn/j
	 IfqFc+Q1zApK6obcTC5Y/FifPPl40uTxED4gS8zAnybRRWMcmgyUZGIT6LNn+kCKlL
	 aHbF6i2ySUyWU6HkJirE8p4USFLRl6j9Xsg24JgaU8w0KdQWXcjnhAX1Y4sXaZLlWG
	 QOliOxiIIZijy7+31fyCqS862cMOnKim5JrislDMKvSjAisWO5Qyw+9NVRIvc9V9kW
	 XObffeBJ5pQxLESZsEGE4NNFNEiXSSkTkpcc8d3MZtoSyni7pXDZIOepNb1ZFyiiiS
	 jIMhoCerpsXpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: Drop redundant white-space around values
 in <>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, lee@kernel.org, media-ci@linuxtv.org, mfd@lists.linux.dev, Frank.Li@kernel.org, robh@kernel.org, imx@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 10:23:02 +0000
Message-Id: <20260826102302.E90431F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Correct a few white-space issues around <>, which will be flagged by
> dt-check-style.  No functional changes.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826102044.1429=
86-2-krzysztof.kozlowski@oss.qualcomm.com?part=3D1

