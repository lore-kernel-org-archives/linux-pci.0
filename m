Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C33101B6
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007229; cv=none; b=Yphg+58Pnss1WnQ28VUuNFOQuShoGu7rHlnvKMlSEUmJojcgkofzPmWqhSi6LFiKifVbydjnIHkgJKEDNVq+7aUO/JrigvNRopc19HuIriP8wIopCFdI9wxAiRx16L+N7TxL1x38UcC42wzA5kYxiFD4csWdZScaS3cs/rZbzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007229; c=relaxed/simple;
	bh=yUGoA5Mdlzfvkphr1VZ4u6c5zcEyJv1/BZWrrk27NlQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXzujMFPpiq7jNtMzFVFwVJlQQQD0lMQUQcae3vcrljpuNAog5NM+v3pyZ1Nnjz5RQRFJHowAtP/cSTsigzfqPgclwuCBeRntk+JtezNDoaAfF9gW1DGN4VfXBLeaiMkKn1ZYkNvyIQXTUq2KYR61NSVXas4mu3chGfgLVed4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1KW1w1N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1KW1w1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98954C116D0
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772007228;
	bh=yUGoA5Mdlzfvkphr1VZ4u6c5zcEyJv1/BZWrrk27NlQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=a1KW1w1NP0SkuWG0/jC6/7GF6KsOUR1Jc9ooB1NefXY+vLKECYAtkuw/lpJC1kBLr
	 qWxlsEiZ6K/7HM4e3ba/q9fc3PZUw66mBnkKFiyc+gGc5sSExWeJn2JYWO5mEwM0p1
	 2kxoJHO8KuKScsV1zlm4CWaB2w98Dj4tjt5f7gxEtRebBvi7k96l+HKCa1DNOiDVOB
	 H2U2gQu9yrg42zKjkFMr35ODOv7oYVk+v0azDNLAfQf75g9AmJmW9D2Ry0vrVVxKbg
	 xpF+Ear+zia6bwdUAxT2XTjULZDAXj0GRRGhlFDc+DSPpMzCfLJ9jBPaRJB00CIVd/
	 pvONpBxcBy2pw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59f850cdeafso6597952e87.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 00:13:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfxzMJHGXEyB34KpfPTVRZNEEUh7nIKFJMPF0jKZ5MdGwlVtTnCGIfoKzIZLTeq22CmaQs1d09Ml8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2xPv64QlcNz1FArqqXlSsZpnhNVyLoHAtuYBqGgKkvMwwjMtN
	sr+bNONHIU6Y8xWUG4ZQ0wMt108yu0bxvF0QC7VGYiSmve+eZWH3GniT37meHsWALjy69vf04q3
	GQTtscggRzbLetscQ2LFLfmf+MyVieaJXvEYRmFYLSg==
X-Received: by 2002:a05:6512:4010:b0:59b:6d12:6bd7 with SMTP id
 2adb3069b0e04-5a0ed99fae0mr4879974e87.40.1772007227325; Wed, 25 Feb 2026
 00:13:47 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 00:13:46 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 00:13:46 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260225072225.3345307-4-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225072225.3345307-1-wenst@chromium.org> <20260225072225.3345307-4-wenst@chromium.org>
Date: Wed, 25 Feb 2026 00:13:46 -0800
X-Gmail-Original-Message-ID: <CAMRc=MdH0_JVRLXtc8fWkdr1qMBERCc-kjp58nbyzhVuMnCgrQ@mail.gmail.com>
X-Gm-Features: AaiRm52AQF02eEDkSj7XKJdKxnJmEy0P3IRZQuLjGUKE0XqIuxZJ88cZvI40wzQ
Message-ID: <CAMRc=MdH0_JVRLXtc8fWkdr1qMBERCc-kjp58nbyzhVuMnCgrQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] PCI: mediatek-gen3: Split out device power helpers
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Feb 2026 08:22:20 +0100, Chen-Yu Tsai <wenst@chromium.org> said:
> Split out existing code that deals with device power sequencing into
> into helpers to allow cleaning up the error paths and integrating the
> new PCI pwrctrl API,
>
> This change is purely code movement.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
