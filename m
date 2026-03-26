Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A26E3C278D
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514913; cv=none; b=a9DEzQd+tu66q7VyZ4TlgK0qVN6NKtDFrGm3KPVwmfskWn+Fuur3hIodmcctSagOp4jIvqr4YoE63w5ZzGxAhgz6y6vTM2MPwCJznpCNuDQp8J1nt3bXVGVRyjFgfb0dEFtwS0ecoyJswW3ZGJ4V3X7ms6CiyszQFOq0zkgOHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514913; c=relaxed/simple;
	bh=xDpz5toXT9+YnrNMtuCC5O0FW4S4IE6N5NmMAjyruQI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKU3BabBRS7yA22rXJoUyRyZeuHNVNqbOQ50cS4ovh2rSZAkccBa/wLD1bcWJP95bzydf4sFUutUYO4GyPJ8X9Oc+PX2B88vLgWCXEECRRdKHLU3Jwf28Cngx9DOT41+MBk/f+5LhQWmVNco//dZaDGA4d0Ga4jngeIBlWcVhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls/2dVtd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ls/2dVtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34C8C2BC87
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774514912;
	bh=xDpz5toXT9+YnrNMtuCC5O0FW4S4IE6N5NmMAjyruQI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Ls/2dVtdnHLwYF3B4kiQyaJlXONuHLts6cQQ2mr0Co9Gd7w6hr3oBtUh9FXdCpEE6
	 Dj381/ZxqtIOPm/DJCvMGnojS7YqXZEod4NbwHmQSkic7lpdCuoIUl2OXM9CXaj3JZ
	 ugLAAGl/BZSvCm18UbxX6kBY9+4MtpC5ShgNgcm8eolJ9VOInYpscluQhuQ/U04M4X
	 VzhdvUyg3zHF7Mdx/zsdQoA1m32bYH9MlCem+iPgAHU0x0c3ktkLVnjdET2uiJsjuS
	 iG692SrWU+QRlwyhq/emAymNL5sodIdQbUS4RXjgP2RuH28Cht4Z+5orRn4rjsyFoN
	 J2Xl2A5mj/sbg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a23dd61c1so5325611fa.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 01:48:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBVvyecxOYKjdQMsYOb0FE55jmZbh+5uQPDSrLxb4yRoSOS4w38CtlXZ5qy5CfEcHjX2gBFqLaXpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrKQGbqT5ydzjqolGgyfC57LqasEAD1a/4oXrws3QDGLK4wDMd
	HMkulFb5uTCtD0qClLkARTkomNNBhLQzWEsgVn7ZOxCGNcyoRz37PAmmFXSMWQSXAa5wNo6uT2P
	WoAcj1G9F+xT41eJOBcb5maWEOIPF4XtxcwLTCXrDjA==
X-Received: by 2002:a05:651c:1587:b0:38a:332c:777a with SMTP id
 38308e7fff4ca-38c43206b02mr27254831fa.34.1774514911324; Thu, 26 Mar 2026
 01:48:31 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Mar 2026 01:48:29 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Mar 2026 01:48:29 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260326-pci-m2-e-v7-5-43324a7866e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com> <20260326-pci-m2-e-v7-5-43324a7866e6@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 01:48:29 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfcT2hLOQ6yVQrvdgimsA1oDzGM3e_7nAWyUAFoOyhH6A@mail.gmail.com>
X-Gm-Features: AQROBzDDnGGEISO25bRpZEkvayXNWHPvGoERJaG_tDIkHVVI5jwB71NCISyV7hU
Message-ID: <CAMRc=MfcT2hLOQ6yVQrvdgimsA1oDzGM3e_7nAWyUAFoOyhH6A@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 09:06:33 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> devices. Spec also provides an optional interface to connect the UIM card,
> but that is not covered in this binding.
>
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
>
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
