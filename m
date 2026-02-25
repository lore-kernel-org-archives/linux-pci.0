Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70A2BD5BF
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007582; cv=none; b=tUf/QwuPRh0VTMTeDaV4Ss1tuF3V8PzXl5pdIWKLeNlMvi7ostqbmemVpu2E339j5GaGUwduGRprFcgohzhlc9xnR/ONxl5ifTf+N5Yu8riDGPBdDbPcowlNuifHSWYTYWrR6F/DDKML6QsW226MRUdvYyOpMALgpoWR/vA0SoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007582; c=relaxed/simple;
	bh=izXI3LMXbG6SsuVnD2N0XUXouX15pyDqNUn3MzXcNkg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkhzIpyqu23bhTsUY1B3ldbWTxaA+oSQ0vAtdztK9hyovcweocWPNM56jifPkPkXutvnLwAX9XycKCItGnMvlurd7EAwACB4ODNXB3CqPFvfZRCbblsy/EtxwyDxYIerQI9DY4cgnNOZF9eHRrNDXd97c/w+p4gPgmnb1SYTexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkoF+QGt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkoF+QGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF6CC2BCAF
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 08:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772007582;
	bh=izXI3LMXbG6SsuVnD2N0XUXouX15pyDqNUn3MzXcNkg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=nkoF+QGtHikINmdkO+WRITa7gjp5vxoaDZ28534DqKhZv7NtsLJqwRShUxCdnO3jk
	 udphkiXx0bZvUj0nmyHDG2dMr9POE3NeLvmBYsv8L+Uuuml8ssz8kpiHkrUmHakMAz
	 oSYAU+r8aAmb8tReB6AmGiIDGLDPL32tgjaRESAJpSSJryOXpEk3kephw4Kr2xyD2s
	 xvp5hN7pCNdZ9oMPYBU3AtSsVDWHdOpA3jO1TsWjElTex6cWKGuTEFn9VeYZVLJCam
	 TBFGQ8oxg1r17xZJJvkwp2nG3h/frmQfl8qDPEHdMrKpOOu4Ie9wBYgZjd2hShHHM1
	 VX6X+WPjsHjDA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3870d178a9aso52124041fa.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 00:19:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVHIoSpaKkOcqLQWhtoea7GYASbcqzwgyJXFRLHAYPTX+8XRbHA+2xXApDAzcX3aVfaSBqDJO4e54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwn0vSxGi6HO2ROu5fqngHxx74GUiGVDGq/XtQYNIxgJlBaVhq
	d4dGTy1rpVGHYBS0cxFdhiyxRXhw8rI4vzmhcL2RqKrkmy3gZrEG/LDiQkqJjPMMHO6+R4AJRT7
	JRjboh5NzIqvOdbK6LVAHEmIPUinE3WY070p9D3K0rw==
X-Received: by 2002:a2e:9a12:0:b0:37b:a955:d497 with SMTP id
 38308e7fff4ca-389a5cdd726mr40354431fa.17.1772007580872; Wed, 25 Feb 2026
 00:19:40 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 00:19:39 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 00:19:39 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260225072225.3345307-5-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225072225.3345307-1-wenst@chromium.org> <20260225072225.3345307-5-wenst@chromium.org>
Date: Wed, 25 Feb 2026 00:19:39 -0800
X-Gmail-Original-Message-ID: <CAMRc=Mfti5FqPsC02zrvY_YnrHrXj68SLDA_tCc0q0qAzRQawQ@mail.gmail.com>
X-Gm-Features: AaiRm52KsedqHnZlertAD8iUGS0ywXhPRvuHDAYeVDvIELIFM7DO1igrITzeqTk
Message-ID: <CAMRc=Mfti5FqPsC02zrvY_YnrHrXj68SLDA_tCc0q0qAzRQawQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] PCI: mediatek-gen3: Disable device if further setup fails
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Feb 2026 08:22:21 +0100, Chen-Yu Tsai <wenst@chromium.org> said:
> If further setup fails after the device is powered on and link training
> succeeds, we want to place the device back in a quiescence state to
> avoid unintended activity and save power. This also helps with power
> state tracking and balancing once pwrctrl API is integrated.
>
> Power down the device in the error paths of mtk_pcie_startup_port() and
> mtk_pcie_setup().
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
