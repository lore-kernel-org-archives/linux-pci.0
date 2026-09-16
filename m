Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4D4A64CF
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551607; cv=none; b=jJb/C4LBiNQROymDZ2yvlJ3egMm+f2zq+qUvGjs8LTqXOi0Dkk6FM1J0l41eAFpOfNEB5OF6LmPLBf26BF/Hp5B9skSnwBZ0+AaInXflF+XB9IFt1Jl8l63ySxJOyzpCG4zVNbCJLkCrLUzXo59n4THaybU2GcH3EDllzfI6z7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551607; c=relaxed/simple;
	bh=2yuKCjIDyK/x4MOE4g5o5qI7ddhrFfbRopnIqh1iLi0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFFlQs8oTm2Zl54mTky60Kv+jgi5+0IP8DrFStV9O+8pyNV3zdRdWxQWDzSKRK98vEtYMVUTC8xs75TeEsuIM58A6+N8jgTvEgMd2T9WrY+3EmyvAg0ZeaAR0zPY1Krh6J4Gmafxkg/2bAzW6gnuA3+bblT2j0ly/+GyHouXEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEa7+TAC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEa7+TAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762361F008A0
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 09:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789551595;
	bh=2yuKCjIDyK/x4MOE4g5o5qI7ddhrFfbRopnIqh1iLi0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=kEa7+TACmQw9LLtOKBXcr9+yyNyOsC76QAKqMJLa5QYBQgs1P38YkG2xbJwqH0Z0v
	 F/biy0p2Go6mXtf9m9RtdBuyc4v6VevPJqTGYqMxZzcZ2GHQsphNwBJHzxbjU2o0I1
	 cs1uaMTRAqTSs0X1LckGEtVGXBMo2OaDflQ0RLRiVAe2Lih6/A+DaM07Xxb117pcUU
	 gZrV0rZ1TjCEh1Nmp2U7L0+X6JkNN5hLxa05isdVkvKBIoBhWbGayHExVo7TjfSzzm
	 QEY0PmQ2SKX0GkatvrL89n3HvaTRnRB8yGSneD01ZhNdTPRPzoY3cGfc1FGKs88Tz6
	 vmSepgBDmXi+A==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a302a4e42aso5706421fa.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 02:39:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzLe5B990sCcQ+Hl2Ti9RDOoUZDyCpDXmMJVmU8qFv0X3O9vK4Q+WxbL2L0K3via/qvSE7eB+lfEBg=@vger.kernel.org
X-Gm-Message-State: AFuF++m7StpirhtKyLHDpTABs0VWqGX64JSpVRhQWSclqjNci+eGQ7V+
	GJN9RfTwhG7l74Ede77O1vlqVq0KCcsl7agRMOFqecQAPcRbwj1mHIW0xDoaET2a7miZArwLXls
	Z89ZAYWQmHfFW9u6Pr5kHFL3ZlH9m9Q5n46yjSs47Jw==
X-Received: by 2002:a05:6512:1107:b0:5b7:de2d:191a with SMTP id
 2adb3069b0e04-5b8b6616213mr571469e87.23.1789551594053; Wed, 16 Sep 2026
 02:39:54 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Sep 2026 04:39:51 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Sep 2026 04:39:51 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260915-pci-m2-bt-rework-v1-1-3c7d9cf9c010@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-pci-m2-bt-rework-v1-0-3c7d9cf9c010@oss.qualcomm.com> <20260915-pci-m2-bt-rework-v1-1-3c7d9cf9c010@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 04:39:51 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mdt7+xYGJTDpYfLf+aKT1-h05qznuuz5eCwLQUa3WU1ug@mail.gmail.com>
X-Gm-Features: AcwNN1UHyIe_E1G_6fwzRWv11gNibMjjztMru9LJ8H2caU7qReugLOq9coLS8D8
Message-ID: <CAMRc=Mdt7+xYGJTDpYfLf+aKT1-h05qznuuz5eCwLQUa3WU1ug@mail.gmail.com>
Subject: Re: [PATCH 1/5] Bluetooth: hci_qca: Add auxiliary driver for PCIe M.2 modules
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, Rahul Samana <rahul.samana@oss.qualcomm.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
	Neeraj Kale <neeraj.sanjaykale@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sep 2026 16:24:02 +0200, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> The QCA2066, WCN6855 and WCN7850 combo modules expose Bluetooth over
> UART. Since these modules are attached over PCIe, these are not described
> in firmware like devicetree. So these modules are discovered at runtime
> over PCIe by the power sequencing driver, which allocates the UART serdev
> and creates an auxiliary device carrying that transport and the power
> sequencing target to power up the Bluetooth function.
>
> Add an auxiliary driver that binds to this device. It reuses the serdev
> provided by the producer, brings up the controller through the existing
> UART transport with hci_uart_register_device() and drives power through
> the sequencer obtained with devm_pwrseq_get().
>
> Add a shared header describing the auxiliary device so that the power
> sequencing driver and hci_qca agree on its layout.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
