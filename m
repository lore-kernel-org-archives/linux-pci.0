Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639452594B9
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601055; cv=none; b=X4xs9XDegzpo5+k/D1XAYC6O/HvuZeEMgUQ4QYK+G/zXLxupFpCpebBiJyB14HLJgjEltaRkyA6HbUhceQlmvgUQWl1gVARqwDZR8svsCwJz5B42XeDG8N2eAeAsz5y1U2Ji6R6I9EOXs3c/GVa4kHr8thm+1lYGyaUzkW6Y87A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601055; c=relaxed/simple;
	bh=qIvYrYW+rc8GuY9xW6YzE63wQF3sIs9QH4lNKLGbtzY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7+yGK7/tS/HGOyP4x1Ms1gga6cCFZ4EMKiZD1m1iHX1D+PO+kZfL3bOyx1iJTSAB3hQrktIzhCSrcdRI97c7WPA5xrqkb3tRfsNfttzR2Svn3XgUH1DjJNbcmnvo1h70nXKiE5scbDopTG4V8PlKiwATqFjvnBwVSbmoQGAqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhb1r6Xg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhb1r6Xg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424BBC116C6
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771601055;
	bh=qIvYrYW+rc8GuY9xW6YzE63wQF3sIs9QH4lNKLGbtzY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=jhb1r6XgjtlRNex9BBe5m7YvXmPbbINSaeB9w9YYYYrnDhRKc2SBaBM/hXQOGuSr2
	 RfgNViU1KJm7L52YxhXc6XHfyLf1Ju4UZm7Mj0eBmYWYTJ2L9IRMb/wqu7Vy9G1TqZ
	 jgXWAKFkNTmI3uvtv91FUsGExef4lilaDUAnXkicLsbcUuf4Zh0suAyKbsz901FZgn
	 YnWjTsu8sZ7RP4Et56vZpYeqtPSmNk0g9A8xbBo40Z9GlMKwEiSIMS1R1GrBEc4KLN
	 RSBUeYzedcioDAEB+oCcekviaXWC4/VDIoKSfUCdnwh7m5RzoezNDOPqDgJknjuoSo
	 pxZ6BLBd6A+xA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3870902760cso19610171fa.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 07:24:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXcDmnxdcaRBfPIVNFRcen8BwhwDjvx/WS8uqVklVT7XXSlQrxbMNabTr1wnY2NkNqtdQKatYjv2Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNG+VtWebyzDq3wMWDYtwrQcEC1ssSgN37/8FCPusGTGFRWIVI
	JHd6fJwL78CKzEY44+EHPJLTCbq6EgN3REmaj/9I+4LK3FLgPEP+EW/+8a79+Y0GB9ZZh8g5Zo4
	nRyh4dV4aO61U6e+M24M1sdQOVSaEcLu1JSz/GqKj3A==
X-Received: by 2002:a05:651c:e0a:b0:386:fd3e:bfee with SMTP id
 38308e7fff4ca-389a5bbcb3amr397501fa.22.1771601053946; Fri, 20 Feb 2026
 07:24:13 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 07:24:12 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 07:24:12 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-5-1ad79caa1efa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-0-1ad79caa1efa@linaro.org>
 <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-5-1ad79caa1efa@linaro.org>
Date: Fri, 20 Feb 2026 07:24:12 -0800
X-Gmail-Original-Message-ID: <CAMRc=MeQ1z429Op7pBAzDVm=o3ESr9rorvVoRBnh6+yv6VWHHQ@mail.gmail.com>
X-Gm-Features: AaiRm528kM56Lb-rsCV2ZgK6S8evmsET0I6kE-_utCAK-NkAUbkBiGPKIsD0gus
Message-ID: <CAMRc=MeQ1z429Op7pBAzDVm=o3ESr9rorvVoRBnh6+yv6VWHHQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] arm64: defconfig: enable pci-pwrctrl-generic as module
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Feb 2026 16:04:44 +0100, Neil Armstrong
<neil.armstrong@linaro.org> said:
> Enable the generic power control driver module since it's required
> to power up the PCIe USB3 controller found on the Ayaneo Pocket S2
> gaming console.
>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index b67d5b1fc45b..0e8b62ffa7db 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -258,6 +258,7 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
>  CONFIG_PCI_ENDPOINT=y
>  CONFIG_PCI_ENDPOINT_CONFIGFS=y
>  CONFIG_PCI_EPF_TEST=m
> +CONFIG_PCI_PWRCTRL_GENERIC=m
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_FW_LOADER_USER_HELPER=y
>
> --
> 2.34.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
