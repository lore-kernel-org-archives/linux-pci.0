Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC141F5D1
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377587; cv=none; b=Pb59Hpg377HempF881BslFWVz9y3WYj2PLi0cVpJrHj+DG/tDRzzpbTwmlWwsXombSrnkbjjUKx1KHLrqP5K5bkb9wBWBYp8Su+hedBjvK0k1qsImOsBpYciqahpIt2p2c+5in1ey3JkHzGVeplPv0ENNJblgE/MgQJsEmTLKlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377587; c=relaxed/simple;
	bh=U3pL/r2KqbNMXRGJnUmPkJJApk2sbtDKXeUlDg0CFvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iI2L8fTVXy7ywTRDRxSFxDH5mBsBmjl+E4CfPK8NpaZ41OB1Uq/bgIA4VO2oA5zkDwkJeyCoiUmPTLDHo94S9Q/K05AlCIPE817iU+paUIfKOv/6/dBmtILDiNc37+jeEIPQtuq3Wdza+DFFn3rPiOpZw1qeBnooaB1DNy8Cm1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAbGaJCP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAbGaJCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697611F008A5
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 09:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377586;
	bh=U3pL/r2KqbNMXRGJnUmPkJJApk2sbtDKXeUlDg0CFvs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KAbGaJCPl2pwRqgiBaRisrfDVljxF5095JbDp8UIKQrO5J9nnKk+Du0GCV4KjtMMz
	 EMA5cYVMRtdNvEaE+4g8+JU+d5RxtO7phG9dhj0bd5usp4mw/KlezO1rxG4ntJjNAg
	 6mBeWxgHyV5yQiAiz01PNutlVK8LvFV4FE9z4VGg3TQYYkVLoXrrQNd9xekgO1xqt3
	 zbt7E0NS4LZaVwcnawmUGAgKi2DGQgwWY4okUNKiZt/0RKIKzFroHN269/ql15fCTu
	 t4xQpG6FOY0x70aNy7DBPwxaVdyoP/UbfZ5W2EnIjaAKZolrSNS1J++HDS2Fd7+RO5
	 54plOCxxtJs7g==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f12so1942762e87.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 02:19:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxyFuK/B+qXPI86hXi6JMnBOQfUKM8mkKUJOKIJaiXfZfvWeohNcqpF1jbcZYg2+DGE5bkZ34DcGno=@vger.kernel.org
X-Gm-Message-State: AFuF++mVJtCYWWdz4fpFX925MilAWJOfUq2VOGDdxjVmvaHxjMGDAaUG
	cz1OLXoQOY1ewA44cgHAnHi+ZoGoSCS5RqvgoOZGK7q91/gbYvLycx/2bytfrq00Wc6wEDqg4a8
	XQm0qOuM5atXevjZlrWsDCXJ11tGhvFU=
X-Received: by 2002:a05:6512:12d4:b0:5b8:9a25:b546 with SMTP id
 2adb3069b0e04-5b8ae6aed1fmr805374e87.16.1789377585071; Mon, 14 Sep 2026
 02:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-pci-tc9563-aux-v1-0-dd9b80738e70@oss.qualcomm.com> <20260901-pci-tc9563-aux-v1-2-dd9b80738e70@oss.qualcomm.com>
In-Reply-To: <20260901-pci-tc9563-aux-v1-2-dd9b80738e70@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 11:19:30 +0200
X-Gmail-Original-Message-ID: <CAD++jLnsRzVpGg7Ei9DEavSEM=0i8p86aSBRV6D3ojSVFa+FHw@mail.gmail.com>
X-Gm-Features: AcwNN1V4jGPTTxI5JmI2XzUeicCVIST9ICc88T_JW0Qobpl2fqYclH7UfnYqw8g
Message-ID: <CAD++jLnsRzVpGg7Ei9DEavSEM=0i8p86aSBRV6D3ojSVFa+FHw@mail.gmail.com>
Subject: Re: [PATCH 2/5] gpio: tc9563: add support for the embedded GPIO controller
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Alex Elder <elder@riscstar.com>, Daniel Thompson <daniel@riscstar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 12:28=E2=80=AFPM Lorenzo Bianconi
<lorenzo.bianconi@oss.qualcomm.com> wrote:

> From: Alex Elder <elder@riscstar.com>
>
> Add a driver for the GPIO controller embedded in the Toshiba TC9563
> PCIe switch (and the Qualcomm QPS615). The device implements 35
> GPIOs using two register banks: three registers control the first 32
> GPIOs (20 and 21 are reserved) and three more control GPIOs 32-36.
> GPIOs 22-24, 27-28, 31, and 34 are input-only.
>
> The driver is registered as an auxiliary device driver; the TC9563
> power controller creates the auxiliary device and provides a regmap
> that gives access to the GPIO registers, so the gpio-regmap helpers
> are used to implement the GPIO chip.
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Nice use of gpio-regmap!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
