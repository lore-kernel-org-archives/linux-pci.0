Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E6A4F55B2
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564506; cv=none; b=HPUARMbDk7hNcSNadzEFZTShGBikokgQLoYS+oMRPP0cxnohpUYxOlzp6JsflzmtvzTN+LqQTxJgCo7KLPvnCAUPCwHqJNCri0vWjQiStHlhU3mRpCYU8VGA+wm97V3FeUU1MQaMTVLx0XELc/lheP5KE5KY6pj+985kR2k5Qbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564506; c=relaxed/simple;
	bh=oNYnZX2UBCSp/tvXl18XeMRCJO6e6jfLpgd4ZUSJ7jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROqZpioPbhLb/Ir6AsFz/PvbUqE8r535Uoi8mnfuNbr/DA3nWt5D9q0j6T2rAPR8r0e3qejwKi1EAnXMDvS2uF1DxqkYap3S6T+FeocRsHxO5WyxmRICGwMb98d6QxAMMg221Ts8pxH/ceYzK1CPsdU6UUBsZpyHVvJ5swa0PBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6PL8XKO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6PL8XKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF5E1F008BC
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 13:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789564504;
	bh=oNYnZX2UBCSp/tvXl18XeMRCJO6e6jfLpgd4ZUSJ7jk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=G6PL8XKOrkIn03t8JqQWPJ2NAC39e0Trk2zATbJOoc9TFl6FPoHhuQL4i3yCn4qqo
	 WgTt7FB712Ztn/32IukjjAUOkuYQTVDgdP6Rwbu++RbkdZtUj37WzBa7msnJxPdaOq
	 BYt0nVrPYUo0temYhkYJ07JRD8KbZ2W+FzRYcTe2rBb7OZM1iae9Wa6tJYp5QgINdI
	 buYQlE5FOc/CezkIvqCbymEQ8bqwPaeTTgLKINYVjm8Biulxx1r9VgQ6v3D/TGjzpu
	 VlXPZWdQRYY4YkRmfPRNi5VHuO+IapyNuWWGv4g/MmbAssdB6mP8tFtNrh5FseFNPm
	 oWt1eKkIKCk0Q==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16c81so896914e87.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 06:15:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy1T94UwBs0fBFlA+fM0cNNQJIaQL3+C5ydmxtRQPfC2a90mexFP4N42BnY3pjWpxOMq6bEqXnLaBc=@vger.kernel.org
X-Gm-Message-State: AFuF++mGB6kfvoc0z4A3kH0beV8nF/AwHVs1Yr44K1JxxEGCJFGisQI0
	7ZKH9gFUUUErK3lI1YV7TEps6OJJGfjcdJo5cTlvwz8jRxFLxBAJ+QLkKhAIGs818iwtn7biA2D
	8e4yRzUp8LWDk1krXxlonBlegTb+rD3I=
X-Received: by 2002:a05:6512:6c8:b0:5b6:1a7c:fd7c with SMTP id
 2adb3069b0e04-5b8b66528fbmr794684e87.34.1789564503565; Wed, 16 Sep 2026
 06:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com> <20260903-pci-tc9563-aux-v2-5-34c625b542c1@oss.qualcomm.com>
In-Reply-To: <20260903-pci-tc9563-aux-v2-5-34c625b542c1@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 15:14:51 +0200
X-Gmail-Original-Message-ID: <CAD++jL=bNxOwFVkGjcv+Ux7LbUDD7EwqeMbp1Pvb_p9G4e5XcQ@mail.gmail.com>
X-Gm-Features: AcwNN1XhOMGQi9DQBoWhea-391wB_SiJ6zDiVvp77goi9CMg6KcYgTlkBlAoV8M
Message-ID: <CAD++jL=bNxOwFVkGjcv+Ux7LbUDD7EwqeMbp1Pvb_p9G4e5XcQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: qcs6490-rb3gen2: enable TC9563
 embedded GPIO controller
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Alex Elder <elder@riscstar.com>, 
	Daniel Thompson <daniel@riscstar.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 9:53=E2=80=AFAM Lorenzo Bianconi
<lorenzo.bianconi@oss.qualcomm.com> wrote:

> The Toshiba TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
> lines.
> The controller is registered as an auxiliary device by the TC9563 power
> controller and accessed through the same i2c device.
> Describe the controller as a "gpio" child node of the switch and use it
> to control the PERST# reset lines of the two external downstream ports
> (pcie@1,0 and pcie@2,0), as expected by the TC9563 power controller after
> switching to the GPIO descriptor API for per-port resets.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
