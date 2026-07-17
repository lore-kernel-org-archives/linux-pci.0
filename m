Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779E3C4175
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280921; cv=none; b=XTbnxZA00V1sEssVCeSwEfxN1sieYX19PeqBTdjOFz/dOIA6ylPi4cg7MoDC/NFjgCPQwWb/NqMo52Rfit3th7JlDAkAkGvoDKSx2t1DeY/ZV/fmzX8jgIvY9kiNdOcY1/+wmord8lJ/ZLyFSkjkUfvYdLN730BPRUfb/Y209uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280921; c=relaxed/simple;
	bh=l42R8Ls491yD9Wb5Jx0AEjyKjAWBRazoH8vk0nswRL8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2IlRMQjnq/FJ6lTEtqJ7bHUqZzH6N4RZyMqEtir0opgmR/LjqspYiK/6mBp2eeZJGZd+Ugj4cO4KCknKPgr0ovNwek7Et+wvzZ3qy+qgIRwD+/M/c6RbUmAbBGdYwwxOgZ6G2vixd+thK7bfsTmSj84FAlIdWAB1tqdo/MOV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA5l3TmG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA5l3TmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E8D1F00A3D
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280920;
	bh=l42R8Ls491yD9Wb5Jx0AEjyKjAWBRazoH8vk0nswRL8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=PA5l3TmG7i/mFMbW2ouBb47SRAql+I3WtQvbsiSIZfWYe1hchDRRAoGcEeuR3Vpc+
	 sNzi6p2hMLsiOWkC7E2M1YJacSzmQN6LrHCxl/F9Y3aS2zWTFLlyYFG4lshiDgpZdI
	 fQOMqQek24f1GrZ0Jx7Ecpkdx32I6ptImkVM5efwX8rtnzXT2rgLyDMU7pZgGAgWuj
	 jMBCkQPfJKrTVrkdket3y2k2nDVq2MWSbY1K1ijv0kUuSMqEPLcen+9JGEfNvwqhw/
	 RDRYC2EKbQb+yu/dH+Ry2pTrMra5xdRU8IVFsZbLIAikRE1ui11EVSRqP2vvTfx+xZ
	 v+uVfaMKRirJQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeae350e0aso8415459e87.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 02:35:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YzP9+ulS3Np5q+A/k3TyWlNMTc+S/ffJNo5g1vtiHSSNTAdcC0E
	ddNDPwU/2fg5WvJv0/5D5gn9SGwUNJeJXneuoHMqzAMBoUgZlCPBoRx8m/7ERkthtu7nZWfPXft
	RjeEtQmsNYpKZiCgDFb3pRGX6ipXQER1durn1SOu4JQ==
X-Received: by 2002:a05:6512:1390:b0:5b1:4ecf:728f with SMTP id
 2adb3069b0e04-5b28fabea90mr448373e87.58.1784280918932; Fri, 17 Jul 2026
 02:35:18 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 04:35:17 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 04:35:17 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260716-monza-wireless-v4-11-9b02e6f549d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com> <20260716-monza-wireless-v4-11-9b02e6f549d7@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 04:35:17 -0500
X-Gmail-Original-Message-ID: <CAMRc=McO3Fy_Kxy=b+U+Cib7uDGvtVVR6BYQJJwufOLMUnxkGw@mail.gmail.com>
X-Gm-Features: AUfX_mwxw__9LRMmhTKcOI7MdCyZmfpmcqbEXBsYWTDL4S2HYpyeYgMPQRfyb8U
Message-ID: <CAMRc=McO3Fy_Kxy=b+U+Cib7uDGvtVVR6BYQJJwufOLMUnxkGw@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] arm64: dts: qcom: monaco-arduino-monza: Add
 QCA2066 M.2 WiFi/BT support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 18:18:28 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> Arduino VENTUNO Q board. The module is interfaced via LGA and is
> compatible with the M.2 Key E.
>
> Add wireless-lga-connector node using pcie-m2-e-connector binding,
> connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> the Bluetooth interface.
>
> Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> the pci-pwrctrl driver can acquire the power sequencer and enable
> the M.2 slot before PCIe enumeration.
>
> Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> (gpio56/gpio55) used by the power sequencer.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
