Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B17389E05
	for <linux-pci@vger.kernel.org>; Sat,  3 Oct 2026 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791019211; cv=none; b=KJKZjUQr6aIr6S07ZZhH6b36uRQs09uVywtlkB/R2Zrcy/xwajstTZhsWGwyqXyAqOToaVHf3/O+tnZ3/tWgGrac75tc8v2ex7JS4mA6++smsnl70ENCihESRpg+OkDuOrwwHujD6IraSomJ6DY42T2nsSccGF2fk+EluDATctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791019211; c=relaxed/simple;
	bh=AaSV1eUxpcIVigkO5zKuZQWOKCxnJiCy1nP8Qtw4Xb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kw+JvKdT8H+0LGwdCoqRKs+74THYhBpP8mEmioJoRkjrs9oV2vhnbtNYuog4AYBHaL/PlLoBCQJgbAgab0Ts0B0Gu36ovnRovjGGImZBV+m59aRl6Y4UTmpahbaQ0aLd2WTDomP6dvLVP/32Zr9zBHXnYIJd8R81MOUFoE86FNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceRBT754; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceRBT754"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB17A1F0089B;
	Sat,  3 Oct 2026 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791019209;
	bh=AaSV1eUxpcIVigkO5zKuZQWOKCxnJiCy1nP8Qtw4Xb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ceRBT754G+ODknIgosWuGp5E5RlEjCxxcEI+/j6JAiIIMFsmYOW0JzEyQXWgHMCSJ
	 qJavYYWNyu1uXfHhVvK+qJ3Dd/GJ6oCI9uNUVaZDY3fBxuR67iPZnrQmlQdMSaH95Y
	 PaB20c8Ydm8/4r/CLrKAQewqyw9SX1Mlnw3RjatlfKvhx595LZwXK3n46qnAYV2Y6W
	 7s7aH32ZKeWDa6KfBvNS5UfNeJgH/LkQJQPuoL4ov8BVusGeK2pxfcZ8mTdtklICQg
	 yrwCArGkqUhWJwPLrEtsG27y8KJFXMPNM9WQWPb+7vlNGml0XtGoeMHusy7TYn206l
	 hbtw44scWDoIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] power: sequencing: qcom-wcn: power off WLAN at probe
Reply-To: sashiko-reviews@lists.linux.dev
To: Franz <franzelfranzel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261003091451.4727-1-franzelfranzel@gmail.com>
References: <CAPjyS8dY0Q_o3XmFjuKZZsjhzhoSNL+ZGJtw5cQt8HiV3sUtxA@mail.gmail.com>
 <20261003091451.4727-1-franzelfranzel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 09:20:09 +0000
Message-Id: <20261003092009.AB17A1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The WLAN enable GPIO is requested with GPIOD_ASIS and then kept at its
> current level, so that a WLAN module left powered on by the firmware is
> not switched off. The FIXME explains why: toggling it would take the
> PCIe link down, and the controller driver could not recover from that.
>=20
> That reasoning held while the PCIe link was trained before the
> sequencer probed. Since commit b921aa3f8dec ("PCI/pwrctrl: Switch to
> pwrctrl create, power on/off, destroy APIs"), qcom_pcie_host_init()
> powers the endpoint through pwrctrl before it starts link training, and
> defers until the pwrctrl driver is bound. That driver cannot bind
> before this sequencer has probed. Power-on therefore always comes
> before link training, and keeping the firmware state is now harmful.
>=20
> On the Microsoft Surface Pro 11 (X1E80100), the WCN7850 sits on a
> PCIe port without a PERST# GPIO. While pci-pwrctrl-pwrseq is not yet
> [ ... ]
> Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/off=
, destroy APIs")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Closes: https://lore.kernel.org/all/CAPjyS8dY0Q_o3XmFjuKZZsjhzhoSNL+ZGJtw=
5cQt8HiV3sUtxA@mail.gmail.com/
> Signed-off-by: Franz <franzelfranzel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003091451.4727=
-1-franzelfranzel@gmail.com?part=3D1

