Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6BB43C7A4
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769468; cv=none; b=ZdMKh+km8N5hDfCLl0PM+irIdbztAexjqsLYYB01/LPqFOpBXeoN+ofVvWnvMHhCAimA5weCC5bpcGNoVb9ZlbRkrnn/UYjCmqpDF5vnPkSfsmTbze6qfotk7Q3uX5kWwE+iz5rCIUWXPRGSZglvPdh9QrX/u1st4pbmvUxMZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769468; c=relaxed/simple;
	bh=f9D/f9/Msk2r3HptDaE/nYy9oLfZ4kQYJeWBm/OXe9o=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIWdrnuppYjr4vC8WvFd9AUEk+m8fpV0vm9vFQLe3oT12nlE/KpfxCYW+u/0Iosdl8OQ+z0I10Zl9ofCQGxPHTWaMkV8VsbCw0RkXOaQJtmITFTLH+QPzrsJsglVa5c33/kY3kYbuZ7YyXpgj+5AnV6tgyKJxhcFBwe6zlWoS7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECtwvZ/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECtwvZ/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50A91F00ADB
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 08:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788769466;
	bh=f9D/f9/Msk2r3HptDaE/nYy9oLfZ4kQYJeWBm/OXe9o=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ECtwvZ/tPqqe9+tvbVr0SV9LwqeLgiQcCQS5GRkPTBfceXDOkJx1iSebbRb4uBlbu
	 tZqKnjYUdn2p579pqxzrCFDZ/5duq5PYIrUiEPl55638z3QD3c9HHoxy2+O+W2Yf2c
	 niJjuGEiIrXdNyBmndjHX8jREMTUsnnje1+XmILONi23tM4lA+3U0veIQTvC6q/Sca
	 b5GawXaBbhbrTzWTUcb9x6pKR67/8ppopbupgaDqiQmcPDRyAg84xMDFisvAbRXlT7
	 wuVSDjZG/p+ge/77iHAdR8bL8t3DhdYIhnwQ6kg6NaF4tfefjJMDU/fD+YLPifxRSW
	 IO3J4bC8EHhuQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b45f2e5f58so723376e87.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 01:24:26 -0700 (PDT)
X-Gm-Message-State: AFuF++nE6QotEGQVwKs/kPqVAQoM2+6anW3AJs66RCOsdhOJ7mijVwrz
	4AiwNhDLPAuwMr03ueJdc60nDL7iQr20S/I/KP4JG20g+TwuLUimm4hWSJ+Mwq1ZrLv5RMMKHOJ
	qY3tdse9C4Lv0afkugvkh3kIkuVJuH6A169ULsyMWRw==
X-Received: by 2002:a05:6512:3a93:b0:5b7:518a:fe57 with SMTP id
 2adb3069b0e04-5b7518afebfmr1598087e87.39.1788769465277; Mon, 07 Sep 2026
 01:24:25 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 7 Sep 2026 01:24:23 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 7 Sep 2026 01:24:23 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 01:24:23 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfDAiUMzOYRWioK2NDM37=yQqb4pQ5ETZz1PVOKQhhdug@mail.gmail.com>
X-Gm-Features: AcwNN1VYTolJaulJOWI5brRRYqQCVvQ9onzb1Qz2nu8b0jNsz6dPp5Ss9rumQy0
Message-ID: <CAMRc=MfDAiUMzOYRWioK2NDM37=yQqb4pQ5ETZz1PVOKQhhdug@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] arm64: dts: monaco-arduino-monza: Add support
 for LGA WiFi/BT module
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Wei Deng <wei.deng@oss.qualcomm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Sep 2026 17:42:15 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> This series describes support for the onboard WiFi/Bluetooth module
> present on the Arduino VENTUNO Q (monaco) platform.
>
> The board provides LGA pads for a wireless module. On the VENTUNO Q
> these pads are populated with an NFA725B module featuring the
> QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
> the design is functionally compatible with the M.2 Key E.
>
> The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
> Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
> signals, as defined by the M.2 specification and handled here via
> the pcie-m2 power sequencer.
>
> This series models the hardware using the existing pwrseq framework
> and connector bindings, allowing coordinated PCIe and UART bring-up.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

What is the merge strategy? Do the pwrseq changes depend on first two bluetooth
patches (I don't think so)? Can they go onto an immutable branch shared with
the BT tree?

Bartosz
