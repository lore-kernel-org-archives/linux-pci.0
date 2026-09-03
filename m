Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF08439F68
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425376; cv=none; b=kXJpXpmI+JfY0UKOsXcyifueglVr44Z+zWCkvsAnaNrB5slnlCJSBfAlgTKT2pEJBrmcNmYSW0TBJ8K/OVY84VrfRKssE1Of4ZNIEYYRPqEsnErwrPrn+szF4mEOubtDjhGLmUvqT94IWDOevfcGylsCsTX/TgOzK13E/Vi37sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425376; c=relaxed/simple;
	bh=+bRt6BNeoujLa8yrSiSmK3JrnrT/EWUmOd6eI9HCwVQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4LGqFRDjYF2ksIyDEdJIFi2MMcOVAO88OrPY9R7OYq9yc8fb+x6luyXH1Uz29mxI6orlQtA4N+dnz0CuMha7zrXoY8nhqqvoujdpPMUs+rS8rOqXoKUvxKVhPhZz6Dlh0weD8sQDKFUAoDnLP3exH4w40NgJ8eE88h8w33uhho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTcKeeHg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTcKeeHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943431F01558
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 08:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788425372;
	bh=+bRt6BNeoujLa8yrSiSmK3JrnrT/EWUmOd6eI9HCwVQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=LTcKeeHgzks6ZWYb6Mt9WBbgBz0GQ2/dALRKI9WYPeRGk6lOmjglZDxkPmdBq9O8/
	 TYH7wI3pNawrQgtQFAcQMBoCoNdcc/a9/YaYKXfqnxU3jZaMVTMU6stCZAWO7fq4wO
	 H8eontsp1KNlOMp1QTKjFOXKZn1ViDmVcALfYTrHVxhpZCksIlQxQG0DsdVmBvYHcw
	 VBOnC6O6hS94fbM7PRWdHt3k4iyBeodNbhE5xMZ+vGbmwz3J7FsUb3B+L8B/5Aw6wr
	 IsuodEkku2bnSrv6TeAULjpxZfEpPIZXUaQcXZP05vNCQcKJ1rWcXWWIPQTKEtOG7+
	 XJzp6pV1xt8SA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a33307ecd9so20041521fa.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 01:49:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwe1XVRgnSAbD87DBQMs3tQXrGtBMJqYTzfb77KOeC7MTwZ9Xf+sfxydky1zS9xE0miKs/u+pLrWhM=@vger.kernel.org
X-Gm-Message-State: AFuF++ljl/WzBC8B0f1J2Mr6e1Lxf8hkGi8dt1J/SbuR1LKoKAc2P/3R
	sf28OLkYRzX76tEQ+cqAj41/vwrp41yGoDddHNyssLuTHi140bMlY2fb8PDUBhVv603Kxn5m/0e
	aNZcXUoS9WJwr/UCkAH9Tzi/XxnDvufyHy0i2xxYO4Q==
X-Received: by 2002:a05:651c:146f:b0:3a2:feaf:6f9b with SMTP id
 38308e7fff4ca-3a34fcca0a7mr22424361fa.7.1788425371236; Thu, 03 Sep 2026
 01:49:31 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 01:49:29 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 01:49:29 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260903-pci-tc9563-aux-v2-4-34c625b542c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com> <20260903-pci-tc9563-aux-v2-4-34c625b542c1@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 01:49:29 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfmkZSvKDCNrDTiXaaihfG0fUbjH3c7Um2hvrG2o4FbkA@mail.gmail.com>
X-Gm-Features: AcwNN1W7TZ3lTOrRxg51FDkbXOy--JN56l9BA0M_nLUauZ-LpMpb3HTvYJexQ_E
Message-ID: <CAMRc=MfmkZSvKDCNrDTiXaaihfG0fUbjH3c7Um2hvrG2o4FbkA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] PCI/pwrctrl: tc9563: switch per-port reset to GPIO
 descriptor API
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Alex Elder <elder@riscstar.com>, Daniel Thompson <daniel@riscstar.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Michael Walle <mwalle@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Sep 2026 09:53:00 +0200, Lorenzo Bianconi
<lorenzo.bianconi@oss.qualcomm.com> said:
> Remove the local TC9563_GPIO_MASK and TC9563_GPIO_DEASSERT_BITS
> definitions, which are no longer used after switching to the GPIO
> descriptor API.
>
> Replace the direct regmap-based per-port reset logic in
> assert_deassert_reset() with gpiod_direction_output() calls, falling
> back to the legacy regmap approach only when no reset-gpios DT
> property is present for a given port.
>
> Add the reset GPIO pointer to struct tc9563_pwrctrl_cfg and introduce
> tc9563_pwrctrl_parse_reset_line() to look up reset-gpios from each
> PCI downstream port child node. The lookup is done lazily at the
> beginning of power_on(), returning -EPROBE_DEFER until the GPIO chip
> is registered.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
