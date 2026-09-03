Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60A456E12;
	Thu,  3 Sep 2026 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438952; cv=none; b=g61ruvMc2z+Vtlz6CIUukkzJErwgBFjXKjCNAc2m166Q+7YdbG1gBZyHm8neiNqHaxm52VfozymsdhMQOaYXmPh5zr93D/yGKr5wP+LkyMP8qFWGdY5JLDyxxjQI3TOeSK/ak3g7Vgb0BYDXOMy06ClxLW5hV2h3Vac6oHFXODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438952; c=relaxed/simple;
	bh=MnLJbSGPcmjfEo9BMkHsvwXsd+XL2IgXm6qI5/O9GTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5g0OPS/a37LC76Yx9ksqeW2O62jBet4CYpr4RtZ6kl+MAZyUmZYDe+rCBZlYFZtAc+jp68i558/2rJ18kv+TkJS/lkbRxpsMfGDJD5Kvf4ja1nAt/VTX6DwoTE3VAtkmeME04hoACM0ZzDATFPHDBG5Hy+flGNQibTmqyZV/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZAZ1zm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZAZ1zm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB951F000E9;
	Thu,  3 Sep 2026 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788438950;
	bh=y3V+7uMRfnRdyanOSMgHTTGvCzLHmifBko8jlgoRIVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HZAZ1zm1RdkGbnsqhCrWKABPQcL0ZZDPvNL/ji0y0N2ZFtkJpTewen3Ls9/gna8qz
	 tx27ZDTFscva9bILlikP8dxPVw+6+ysYDillpUnMZWOFbo7vRal9+WsMkc58dTNDQB
	 e5moD0F6ecVHVtzp1I0sARJhHBn6ZUh633hR/9rxayCrHsbM3RqsoDb5A4zkepfupI
	 E/jfrce2qAnNbZqoUM8Vysi+aYe0bUKMxHV1vcvuhBnahXHTf3nPWwHMv2yBXkWW7j
	 LdUJ+S8aQKP9pB6+DFmeCHGugSsNcv2n7b/E9u50GEYlteA0Eqzs1xrVgLjhLyZfoU
	 CGqdXOPFiB1Dg==
Date: Thu, 3 Sep 2026 14:35:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
Subject: Re: [PATCH 5/6] dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow
 gpio-line-names
Message-ID: <20260903-elated-ethereal-ladybug-eaf509@quoll>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>

On Tue, Sep 01, 2026 at 04:47:58PM +0800, Xilin Wu wrote:
> The SC8280XP TLMM GPIO controller exposes 230 GPIO lines. Allow boards to
> provide descriptive names for these lines and constrain the list to the
> number of GPIOs exposed by the controller.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

