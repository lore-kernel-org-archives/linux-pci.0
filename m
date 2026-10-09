Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A43191CA;
	Fri,  9 Oct 2026 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532790; cv=none; b=uLo6O+DKQf2QMceR0yfTx23gH/7tDqlXBe2nd4rH1WMk2bwkRn6AyMsLXY1GyjQTOJtMGMGFjxWWZXQvaIgBCISwcM0JTJRa3Fm2YIuBKRJaV39plJbA6EtXS9ev09CyTbyKgolhqxD8UofyeeWaSmJFAiXkGHRyWXCPXfF8rfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532790; c=relaxed/simple;
	bh=/af2zvV+ZuNG3llyemOs4w3R4jH7oTw34EaZ8L23g3c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IYfVAkD5zLi5700L7fY/Lk82cBpqRI6PzsmIA9HcBe3O1qijT/faUViht4sEGdpyg9kNn5zK3RXFaRV4zbxJE25N/7jTiZ9vIZrwl5vyuKbFpE2agWYKrphauJmAe28xIZUQZO+luYsp8/oATnxdBeFwR/grFdFZvZxqYGChBbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ10x1FW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ10x1FW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43EF1F000FF;
	Fri,  9 Oct 2026 07:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791532779;
	bh=/af2zvV+ZuNG3llyemOs4w3R4jH7oTw34EaZ8L23g3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AQ10x1FWPmUDFeo8OsBBhN2diHNoCFaToEEfNKTTVpsTKehvZ2ZTrwgg0xbbkZR0l
	 KiOAyV51PAuhZA7WtpUI16Msbym4EP9nZWFRVcp+rQRRHMUlRt+OV4mxzgJ66+ulK/
	 1A79BPB35DBsFM/8KqdeYTVI8wTXf2R9pyrWHi/+OQGxVNlEPorOMZ/fXWa7OBME0q
	 RLZUa7IYVSntwzPyqQSriF3bybmkVlz6CxwYHZcTaZLx9mUlR+4dXcZhD12Br6sYKg
	 0ubL2fUerD7pCKjW6Fo5hGiqZJseZRoyqB1oBnCYTyeE9UjHgPJlFfEmuybH47qNCD
	 7moGZDupJ0hgA==
Message-ID: <sashiko-outbox-165048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: bridge: simple: document
 Chrontel CH7218A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261009-q8b-dts-v2-1-eda11e5dea8b@radxa.com>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-1-eda11e5dea8b@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:59:38 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Chrontel CH7218A is a DisplayPort 1.4 to HDMI 2.1 protocol converter.
>=20
> The device contains an embedded microcontroller and on-chip flash. It
> automatically boots its firmware and requires no host-side configuration
> for the on-board use case, so it can be represented by the simple bridge
> binding.
>=20
> Document the chrontel,ch7218a compatible.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Tested-by: Daniele Briguglio <hello@superkali.me>
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-q8b-dts-v2=
-0-eda11e5dea8b@radxa.com?part=3D1

