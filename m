Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA7F27FB1C;
	Wed,  9 Sep 2026 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966327; cv=none; b=MrOw8QLHlbvfZ86ous5b+8k+ncX/uwdx/cS2bgh2eyEALUkw+nVSbkZbTZkZG0EMFify9t7fWi1I7c1416GPPUHD+NREgqh0HhHWGi8C2dmd5XLf0HYV3Rw6Fnx6p/UF+03uqn7Z2kixsPS0xGf3j8h4Y1QunHhKdkv+Fr9uBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966327; c=relaxed/simple;
	bh=yu7sfIMgjCw/Dr5ZBeA1vya0q90hyY5jLS/7CLrg3og=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kzN8Zh8SKZ81Ts/OIFjkr+SeN4y/ndcYaEXCVogrv/cu0DMcEv2gJlMW6IgAaxxD0I9BBiPj31RtUZb7sBhxVaAeCru1Kv0olLpbQK7a6AIM0l5a7QckcsCgQKsJiM0ozI1usNEizSGq+hRKnSuLXLzREGr7/1cDeCDJDOoVB0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iq2SDDx3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq2SDDx3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459D81F00A3A;
	Wed,  9 Sep 2026 15:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966325;
	bh=yu7sfIMgjCw/Dr5ZBeA1vya0q90hyY5jLS/7CLrg3og=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iq2SDDx32NfMr9gDn1raeiRBm9gbFbkTIizPyh7GIxpUqeMIkA2h06UcKDEtlJKFy
	 +6WkR9wqJ8giWU4Eofg+Z+LlsjDQBMdSyYykwHKrA2+lDsWAodB/72CGh1w/gIJFK6
	 k8ChTGxk9Aj18T2SJRdE8xW9nezF9n5jVyiaLknnMRy88LHXyuhqnXVytit9s04j4l
	 rMIgbh6iS86TKBTD04as5dhegzaZZUhYt+Oya96b0+ZGBFzcP8ASGRP9+uqMWj16vz
	 DllfzLbMSnCxADvogHoxOCwQSxANG+YD9d+bAdKl1HKwTuHKYRdATi+ieD8r+UZmRp
	 Azq/IaY10fsaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] PCI/pwrctrl: tc9563: Switch per-port reset to
 GPIO descriptor API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260909-pci-tc9563-aux-v5-4-c9b33f56c8d3@oss.qualcomm.com>
References: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
 <20260909-pci-tc9563-aux-v5-4-c9b33f56c8d3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 15:05:24 +0000
Message-Id: <20260909150525.459D81F00A3A@smtp.kernel.org>
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
> Reviewed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-pci-tc9563=
-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com?part=3D4

