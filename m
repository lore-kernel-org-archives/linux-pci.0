Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E563FBB72;
	Fri,  4 Sep 2026 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543159; cv=none; b=lbpz2G2IazyJHA1Sgrq4yYk9jOlM3xqfORebeO01YKVtqpaAIruOQ6zYlS+KfTfJw6aKA+lr/4J2ftgHGa21teEtEXaMeVCX/JCTANrnPHbtlyRPSTnW0hcZm5b/+Ry89DbqjBeQmEYZHKO7ztxSeYmw/A+/dr69yqauN3GNtiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543159; c=relaxed/simple;
	bh=t/l4tO1/wIX7Ny+2nzF0+BjM74OCQeMx7zC+az1Q9v8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NK5puYJoiWhColwEeKbo7bkln4gIkVrHBmSOzYAXkxi1hFliYm/xxh6OXkWsj118PMGIS/oxsDimI0KwO9CZCQJvwpSaxKML3w0LeZ76ErT3kbu0GQfi2t4vOcMbvm90n8MizwKIh7BqcZyXVxxglDvQvqgkqypwURK6keVIOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2+f5FcI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2+f5FcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80751F00A3D;
	Fri,  4 Sep 2026 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788543158;
	bh=t/l4tO1/wIX7Ny+2nzF0+BjM74OCQeMx7zC+az1Q9v8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h2+f5FcI67SZsAPVBFevTPDmuZZN8I5YnKraWJJnK8KQgCk5UqPyPn+Vylq4cauvF
	 DGJ/0YUZCfeYQeMoGnJvm0nclXGHsp2FUXnIReVW/HjUYK/n0CpcOeQJm32VJprRmh
	 lFdAObCVuaprGviIaot92gc6++oOL28eykX2EbtnCm5dmZ9eIuQrPtHCKrtuCq/tCV
	 w636U0VcNx2NbncdqT4ch9xj/SFzyFg72cd17f5JK+d2PwdtUFCmImbfNpmxjtc90P
	 HdR1RGvc98ZM8KGQqpSsLn4u/398fw3VdGWBfTkmA30YguiEgiNYFHp/S4j9Sq6OaL
	 eWd96N5YvIAhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] PCI/pwrctrl: tc9563: Switch per-port reset to
 GPIO descriptor API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260904-pci-tc9563-aux-v3-4-5b1449d62ba2@oss.qualcomm.com>
References: <20260904-pci-tc9563-aux-v3-0-5b1449d62ba2@oss.qualcomm.com>
 <20260904-pci-tc9563-aux-v3-4-5b1449d62ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:32:37 +0000
Message-Id: <20260904173237.A80751F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Remove the local TC9563_GPIO_MASK and TC9563_GPIO_DEASSERT_BITS
> definitions, which are no longer used after switching to the GPIO
> descriptor API. Move TC9563_GPIO_CONFIG and TC9563_RESET_GPIO
> definitions in tc9563.h header file.
>=20
> Replace the direct regmap-based per-port reset logic in
> assert_deassert_reset() with gpiod_direction_output() calls, falling
> back to the legacy regmap approach only when no reset-gpios DT
> property is present for a given port.
>=20
> Add the reset GPIO pointer to struct tc9563_pwrctrl_cfg and introduce
> tc9563_pwrctrl_parse_reset_line() to look up reset-gpios from each
> PCI downstream port child node. The lookup is done lazily at the
> beginning of power_on(), returning -EPROBE_DEFER until the GPIO chip
> is registered.
>=20
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.co=
m>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-pci-tc9563=
-aux-v3-0-5b1449d62ba2@oss.qualcomm.com?part=3D4

