Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795428763;
	b=U5NQby6zHzHCocQe5tCfgdFY/gT4fPWq4pY3/96pjlwixEm+uM7dCOoDfbhGpqL68EdJ
	 JOYrg16YqYC1fu9aZZr36BiA/b39xiMeRwGlmQ/Qg04GdRQnLPMDy3y3ITWEPjofCcHTn
	 u4JaVWYtk3Z6nrrrdfH5S0RYVIXY2Q6tm/upI2aCoYz+fYQ+wmhhCf+fq8gXro4ogIR3z
	 t7/mwjwms+4l63LjiT+3Us99DVNPUBEGcLjCZmVKWQ5Uk9ecefSB+762YYVcwt1YH9bEi
	 dWj6xmmBAtcRo7LrKm0c6BNHszPH9gu10v8h1mrWF2FnHuRTxV0Cg30owJr33ZSCP3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z6PZb3pWfu3DBOMyeBvBYRTT0i6m3apihG5iiqFet2Q=;
	b=ZKgQYCkVPNBnSceKO22fmLGfrGZWxb1Cfj9lFGK41r5mv5hYQf6Lsq9wFzz7eIjYL3Ui
	 a56MOe02GbVV/+E3sTc/KRjup5qm/eSOX/e1xDS2eO0yaEyCI2HWtcs5Txbgd4gfyA0xy
	 H7BCXxTTVDac6oTmou7wDiJTMmCXhY5lEqZrEjYf+6zuhVe9WSERA2X4p8/WMchkxQ1FO
	 ILg8sTSmkxa2qln/yfePqse+Hq4dltFBSJGO5hVURdZhjGqLsiPqfSf/MO2AhDpBal95h
	 fRdmMoaBm7jMCAvnZioCbhf90PaQ2edNBR++XrrEFscW6dsOjCpddHG8R6eHXFTC0Pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=MqfY2WR5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C0606A32C
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC8C0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=MqfY2WR5
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c516a1623d0so171241066b.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 02:12:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795428761; cv=none;
        d=google.com; s=arc-20260327;
        b=TTTVAA3DxxochM8mRUUiZpNK1puOYHH46b9djBQFK2xvMUYccDvKJoXq1q5g5/l0HI
         hpWG2Wf4jvCtnZIoI6x4ZxvqFxkjp5dSJbEed3eZ7bI6iRNFrM71DtDUr36hrM6KDSL2
         5HtMb6JVoYCZi+5vO847OLRbkv4YeT2XMIjJMilccGcblcHfj/JSIHOjiipsU3v5zyMg
         NElrqhcZP1eTAZk8O7AD2IpgKyWZ7WA+wOhN0J0jQdgu6A0QmLEC0awWEXlgjd7GhXsq
         0qq4LSsn41VP3GRty9RHKK3613E+Ql23nm4ykG8amAMpWEwEaqEeapDDUKgyr9ACc5kM
         M1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z6PZb3pWfu3DBOMyeBvBYRTT0i6m3apihG5iiqFet2Q=;
        fh=ZZDyk6uOTZmrgwry81HxYkG/djL/tSwJaSrnKTYQlyU=;
        b=UUaK4zLy38HoNlfp35GNTcNcTdqMt+XitBA1fDqbA4anwScwbUkXiwAEQRAfex2omX
         4wQOyjYrBDCZn/pRoR7aa//WlUL1tSJQ+c47Iua/e45TTEqlEU6UNMxsxllBKqVKLpgH
         mgbZBw6LraxyYX6z1EMrMqM9PRp0rfJwpxQQfTmlk6mRGhxfdGcMoOT1i4fbCVtGC6X+
         k5Nlw70BnaSBmnXJSsC/iqjuSGuuMvj/Wf9EqQBXsJgjaFW0tmG/4ve8ZsUX98KBMeWI
         W2MUbdLnWS51coyqWpdpNcY2rZqn78llWjmQEnSS0Z8j2GvuiECUm6b7pJIZoLn2to75
         q5gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1795428761; x=1796033561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z6PZb3pWfu3DBOMyeBvBYRTT0i6m3apihG5iiqFet2Q=;
        b=MqfY2WR5A+tGruAVHjRKrDw5GIaiKkjvwm6WEch6FTIYRq8BLizWLXn5zpDnFwRRwA
         kwN6xPmj02C+f4K6Pesc/ipxTUWAJ/jX7Z2eV2g3S3/G9Ri2i5mYzwiFBYWE4mKlYNib
         JaEKi9jzGkUyZfJGjcv+VdtMrCTPstBpK7aXngyyd0uzeK44uGws21jQUKMvEPyX72E9
         nu0okVVQrxrFvL6Nj9PKzFOum9ntDS1PavLl2r5c/4y05NfY1cHnTTw1MJUAQvpESx1Q
         qXotT3VmYjML0hmwFGL+p+w5OsqphEiy5AfG0/ACGnd6E2yJhxynpmSns7W94umSVVpc
         w4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795428761; x=1796033561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z6PZb3pWfu3DBOMyeBvBYRTT0i6m3apihG5iiqFet2Q=;
        b=hkG7JVuEuop7OLyivjt2vM1p2+Db2J6Z5D4UJOe8S5je6Wywj2udDt0KD5x98TqPyH
         Za9ul7Tb6J1o7HlJjRnTPSDu8QdtuKaxZ1Y5F1CK1sytCDe21wko4DlA4CxYihrgCWhc
         IeIgWSURT9HbrRyKxk7Ek+i1S0IRRyf9L57f8Xva5m2AMG70Dg5lKmMpLGScVjgkCnDs
         zKQDTGKOEm3N2aOdiXhVJzb3VCI7uHkNbi/WRenB9H7a5aQKdSbz+i5a2cZXLYZ/OrHc
         xvCvkNGIxLK5VEyxtnnjdaGJT6iAX53yFUnIB4ECpfYimmGfq/DuVrDi/95tJsOVzVAt
         Tl2Q==
X-Forwarded-Encrypted: i=1; AL+hErEKVzoiofgRIUMHe11nrttWuy/ss2e8vws725jhcrJjAtTV8u9imCm87Q5Vrb937mQGEJPwvDj5M88=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ebPxbzg7/IorCQjpAPxFQxGmxeV9+3rJ8zqNnF45Pjfb0DIri
	SGa7W+CnyYelTdl/PTwO+kZjJJd+7STsQjlPiDL+sboKIzB44Qk0g6Sd7j/7sZp4+jqfXAuqAIe
	VsFggcYihvHaajltZuUYwLFrDlMcF1PB5tHbqxBiDXA==
X-Gm-Gg: AZFdTZcEjtw51mWqYMk3nf/fW8+5FVEem1mIE3VZ3lvAg8i47j2SUO8GGhxHnkKJZyG
	Yjk4T7bhlIUC6UOjFU8Ru43TVrf/HcNEQJ6DHEIAJXi7Dr0SaMxJz6y/H5CNY4Nmprx3o54nKSJ
	iOp8DimgDSNA4lmOlO3Ef0gPlVkYWuWR3uWH8ZSMjc7sPbNHRJ89jMssYW/yhMSXLVRkzEa5i4z
	Sco5xjnFd/UxC0WVgXVWLkiV4SK/yuMvER7/6xa77UpQFlLU8moLKxrGzICsH/20agBPi0MUkBJ
	LUdn8HXxkX+d5+vvwC3/g+qwuFezKWd+IMGIPyn2ceadPk100PQj99Y5TssqvFFST25mBuSJuSe
	BoD5wvDa9b3dvmpuc0dJpq2A9FBWkzVtPi1U+QbR4xt6p2/mh2kyaPloEi5/mw9igTXfR+XhWEn
	/c0xbsILE6odGQEfI=
X-Received: by 2002:a17:906:115a:b0:c3e:ee86:d2c with SMTP id
 a640c23a62f3a-c513a866684mr820899566b.27.1795428760997; Mon, 23 Nov 2026
 02:12:40 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com> <20261122-pcie6_fix-v2-2-2e0fe615d90b@oss.qualcomm.com>
In-Reply-To: <20261122-pcie6_fix-v2-2-2e0fe615d90b@oss.qualcomm.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 23 Nov 2026 14:12:30 +0400
X-Gm-Features: Aa3M54q-Xar7VXEu12WPkFbFHzHu90UHCgQbyjxEoWpDnyAZhVgjhAvqOSDzA9E
Message-ID: <CAKTNdwEuu75UHA2_r9FLmximPjXVHp05Aztk201AjnFGcGSXRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] power: sequencing: pcie-m2: Add support for PCIe
 M.2 Key B connectors
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

On Sun, Nov 22, 2026 at 10:46=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> Add support for handling the power sequence of the PCIe M.2 Key B
> connectors. These connectors are used to attach WWAN Adapters to the
> host machine over interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB
> 2.0.
>
> Currently, this driver only supports driving the 3.3V/VBAT power
> supply along with the FULL_CARD_POWER_OFF#, RESET#, and W_DISABLE1#
> GPIOs as a single "pcie" target, since Key B Adapters expose only a
> discoverable PCIe/USB interface and no non-discoverable bus (unlike
> Key E's UART-attached Bluetooth device), so no serdev creation is
> needed. The other signals described in the binding are not supported
> yet.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 70 +++++++++++++++++++++++++=
++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> index 56c5d51293c1..8af4a059b596 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -39,6 +39,8 @@ struct pwrseq_pcie_m2_ctx {
>         struct notifier_block nb;
>         struct gpio_desc *w_disable1_gpio;
>         struct gpio_desc *w_disable2_gpio;
> +       struct gpio_desc *full_card_power_off_gpio;
> +       struct gpio_desc *reset_gpio;
>         struct device *dev;
>         struct list_head pci_devices;
>         struct mutex list_lock;
> @@ -135,6 +137,45 @@ static const struct pwrseq_unit_data pwrseq_pcie_m2_=
e_pcie_unit_data =3D {
>         .disable =3D pwrseq_pci_m2_e_pcie_disable,
>  };
>
> +static int pwrseq_pci_m2_b_pcie_enable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> +       int ret;
> +
> +       ret =3D gpiod_set_value_cansleep(ctx->full_card_power_off_gpio, 0=
);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +       if (ret)
> +               return ret;
> +
> +       return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 0);

Can this signal be exposed as an rfkill device instead? Otherwise the
pwrseq driver hogs it enabled with no way for userspace to control the
radio power, and WWAN power draw is quite non-negligible for portable
devices. Ditto for w_disable2_gpio (GNSS).

I'm also wondering if the WWAN-related signals should be skipped
altogether for non-WWAN module configs?

Best regards,
Alexey
