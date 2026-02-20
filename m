Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DF2C21C3
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601079; cv=none; b=dFPXmX8y8lq3Yy41Q+pUZm8Qh+8B/4wM6U2W5nx/IdrjtA72Ow7znx7Ehu83xVp/y5X6XXWPU2JSWstkL5aPMugOxYyiv/iRyFD0N10cgrc6o0WI/p8VM9Zfgk0eJWd8clvcBbW0ERNV1eeCHhxzR0LtnlMyNzkLmdAM3/h0sTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601079; c=relaxed/simple;
	bh=C7UX1vN+PR4yVE/b6ioZbNxAI5raDGvTJL3T59+50rc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfD4vyvaw/XtPyJx974PWLk1t3sCf1n15v9bI3cy6GhmM4NdOWzAxJWIOT2k+dUU4llb51rdHwDDNiUufJ2ClDgPnYbjWodwioQiVFkmrvEnzaPP/LPLIhDkxPKljJTf1A3Z7TlwmRDl3G9g0jM4GkoSn3Om9VgTlBrv2EVqBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zj6lbrWo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj6lbrWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD427C4AF0C
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771601078;
	bh=C7UX1vN+PR4yVE/b6ioZbNxAI5raDGvTJL3T59+50rc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Zj6lbrWoNtXtX3NgUCv8t8Aqzk96pk/8iJ7xCesAttEZz+e9g8iRYtx4s3wgZO/id
	 RiNNn1mO0oI9gWItnOHmLzHDlSwplX/pr0rStOuc2IkUjIG5oxQGzr6YG/F/qTzD3A
	 7Vb1ElPO+JiklSS3BpryRjMBbAd/3Q5S/Ufy62h9bQ/mRckQtMYxWcRNltJagKN9Cc
	 JmyfF3MxGWG6v3fCeU8bBj1mhQw8EvkVnQzAM5g4IOeJ1VmVAXzQ3ccY8W2JNezxLY
	 ZQ+daIQw7T77hgthQuBbSPsvwWJqyKq2zRQQXV8ikOWPGA+wN3dwbdOQNo19IKTg+d
	 olVsDUFy3En7Q==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38706b63929so20275851fa.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 07:24:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRe0gUrYXOdJoS8jOWpq8Rx5f93CmVozcMFrbo9q8iCQybmfsOpGJo81LDZExpr0IiccHXuX5lazM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn0rFzW+fPWnpaDyTDK180aNBu7zR4nFyWxZC1cZtyejHcYKjQ
	OzX+F/p725vntHaWplINeVV6obu952TWM0LicFBzje8MDMD0KYzBeaikOSUT3aZz/nivLFlap2v
	yWoUvIL2B9XjsOlm+tHJS6nqmh3yI1gnDxDl6F4pKFg==
X-Received: by 2002:a05:651c:1cc:b0:388:f65:57c5 with SMTP id
 38308e7fff4ca-389a5ced562mr256851fa.4.1771601077506; Fri, 20 Feb 2026
 07:24:37 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 07:24:35 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 07:24:35 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-8-1ad79caa1efa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-0-1ad79caa1efa@linaro.org>
 <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-8-1ad79caa1efa@linaro.org>
Date: Fri, 20 Feb 2026 07:24:35 -0800
X-Gmail-Original-Message-ID: <CAMRc=MdKNbxtg=UssdXqjkSaJ6rW6zU8fR0wuWCWzYOzpbsvzg@mail.gmail.com>
X-Gm-Features: AaiRm52MKuxfYPtBpaRkXvDxtG_cv_dL03XUQqwYZ3j9MikHP6iuFkoiT8NsO-4
Message-ID: <CAMRc=MdKNbxtg=UssdXqjkSaJ6rW6zU8fR0wuWCWzYOzpbsvzg@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] arm64: dts: qcom: sm8650: Add sound DAI prefix for DP
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Feb 2026 16:04:47 +0100, Neil Armstrong
<neil.armstrong@linaro.org> said:
> Sound DAI devices exposing same set of mixers, e.g. each DisplayPort
> controller, need to add dedicated prefix for these mixers to avoid
> conflicts and to allow ALSA to properly configure given instance.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 758f87a10d8e..6705922c4d45 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -5960,6 +5960,7 @@ mdss_dp0: displayport-controller@af54000 {
>  				phy-names = "dp";
>
>  				#sound-dai-cells = <0>;
> +				sound-name-prefix = "DisplayPort0";
>
>  				status = "disabled";
>
>
> --
> 2.34.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
