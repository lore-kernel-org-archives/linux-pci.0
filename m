Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15113D886
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787214136; cv=none; b=so58NUpGx4oN0NDv5wwToTNR3Vz0AGtLO/6q4JG1HdiU6MhbEjNMA6TEglTWA7G7Vrs/V+hBhIE7j21qHFNRUHneHb46ghUpDUKvAIWgbyiESiZL8ilPQJlmDASb8eoZ2naB6I7nV2GSSy0xeHqpCCd8kIY7FuTCn9H8VEltfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787214136; c=relaxed/simple;
	bh=GK0enth/hgE9YglrB8BF/1gratNkii7LVGV+7G+IAec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VrfVYF2C5aR4MMePfrZr0I60Zxv/TiiOv7iioHUGZzhopwJmWoNh+KvNKlkvaKp1yS1D58ieXu3TdvgWEyqCSqXQT3H1wGa5VNh4u7PmF3b/yGOgVYSKLyOb5FRFPn0/7CXqTY6tlU1fQS6Q4+5XiWOByQeWJTFgjGGWfeWQx5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCNuSEHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCNuSEHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738AC1F000E9;
	Thu, 20 Aug 2026 08:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787214134;
	bh=GK0enth/hgE9YglrB8BF/1gratNkii7LVGV+7G+IAec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aCNuSEHsxHkXTw73RD5sqArTR4iCwD1zZloX2MwX+HZv/fB7j/xYTsdPIOCfCC1Rq
	 3czfYxNnF84MkNfG+42QoWzy2u36nDfpfwGdKbIyE6Y6Uua8TAzCuP3Vssz8XUM5qo
	 RydRdZhyPO3hcuw+216Z5840ImwySecakkBARCinZcEZEWd3Ng9pJkkfyvvp8Bowf1
	 OPNO57gMKu0eqbZvFzsMlBNRj6xJ3u2hj19MZ5POWXj1aN6MSwDv0a48g8Zq2xjmgj
	 WLZUvgkZCEhlO3zelTWW9xZEt37RT1O0E/8hTvVD22CgCjZosxmhgDpJq07B+MphrS
	 5HdplQ/S0UlCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Pericom PI7C9X2G304 switches
 [12d8:b304]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans de Goede" <johannes.goede@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260820082041.13470-1-johannes.goede@oss.qualcomm.com>
References: <20260820082041.13470-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 08:22:13 +0000
Message-Id: <20260820082214.738AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> According to the existing quirk the Pericom E5 errata for ACS P2P applies
> to PI7C9X2G404, PI7C9X2G304 and PI7C9X2G303 models.
>=20
> The Arduino Ventuno Q board has a PI7C9X2G304 switch (verified from chip
> markings) with a product-id of 0xb304. Add 12d8:b304 to the existing
> list of quirks for this erratum.
>=20
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820082041.1347=
0-1-johannes.goede@oss.qualcomm.com?part=3D1

