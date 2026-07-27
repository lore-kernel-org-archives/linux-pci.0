Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D237F728
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162226; cv=none; b=fz4eKCabGGt56p35fbdDiQPW6pkUQFJWylp8w4V0barmgM2fH9wdv05QfLOClTbag854PiaNqMrtO9ar/zTRgoBNAV0wdRCI3iLUBQAMRTOq/dkzoB9MZxqYWu8i1jHQ2DNV68rC+noSIuOUUS0Ex3kLbc5jwY8KfPMBgLCPnWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162226; c=relaxed/simple;
	bh=OUyQfA5MkvQ41tqNzd1AHAV7z7ChKv7JVfv/7PguwUM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dO/8FoDm+pJj+jdq6BWgxOhFuDXjFrXpM4w9IbScjL500hFOq94CRG8jI+RQN5e6OLTUjKdKVkrIg2x+MQgKT/9dzFMsNeQzjTv4ksRCl+yDtNM9undz+Q1Uy20EbHhnCSHx/vsVXRTNVVhvqwCTtB0Jd6sp5/v+DI7U1iiFjec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeJPliUD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeJPliUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091CC1F01560
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162225;
	bh=OUyQfA5MkvQ41tqNzd1AHAV7z7ChKv7JVfv/7PguwUM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=KeJPliUDQ3MvwP8i6mZIDoCxzTadZPOu/R0rMktm1cyHOY4eeqz+yDnxH9oxTSrsW
	 1/YOrnR16zEqHLWGchPqPnsCWoWkJIDvhcbm/k1q0FD+NGIoEV2DR6scIIr+Y8FOPS
	 muHeEQhckErPETPRiTYv8eMKta3Dth2dn52IoXT7S9/5QHRj3HZmm1HnsJVbwyfig2
	 jd39NG6LQX3rUlRA40L7sz9qWaVCnlbBVJBhVYHGQqedebc0myC7UFWlpHj7ZL0rfF
	 KRrchuNED5Ai9LLoTAkxf1+UAdcHEgbZiaVEVM98ndL5qsygMDMZpKA44qYW1tyT+H
	 UjpYZqiT9l04w==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b01146b205so1631350e87.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 07:23:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqHBNjm8hq7PbW5DsTVSAd/kVvY8O+IBrP41GJvwGmsK/cpIesw1yjHLiZB4dauqYe3izhZi+Yj1/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyftHBg71JZWYAF6SySUZAQWCU1KFkbcM+O4iS22WcOv4v+EyGb
	hBR+ixjuif70qLGc5jrQdAMOskiMgNnfj97zCGbH3w39SXSIRb6TPhOpACyPOlJoKvPt8b1j74O
	2wWab9xFye7AeVK8lSDuLu+MzJY/AhmH0AsBztdULnQ==
X-Received: by 2002:a05:6512:a86:b0:5b1:5a31:86b5 with SMTP id
 2adb3069b0e04-5b2c1b3dc49mr1869867e87.28.1785162223761; Mon, 27 Jul 2026
 07:23:43 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 14:23:42 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 14:23:42 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260725-tc9563-fix-v1-6-ec4286e31331@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com> <20260725-tc9563-fix-v1-6-ec4286e31331@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 14:23:42 +0000
X-Gmail-Original-Message-ID: <CAMRc=MdFh_6rj9fr2RSU=r-HoHWL-O4o8jPZE9oob7vMYV+btw@mail.gmail.com>
X-Gm-Features: AUfX_myL-vz4GXp_601ENVWrvgMcshpVmAONxwAZZXIUmnafuI0NIQ6PBfwrIyg
Message-ID: <CAMRc=MdFh_6rj9fr2RSU=r-HoHWL-O4o8jPZE9oob7vMYV+btw@mail.gmail.com>
Subject: Re: [PATCH 6/6] PCI/pwrctrl: tc9563: Move Integrated MAC Endpoint out
 of 'tc9563_pwrctrl_ports' enum
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alex Elder <elder@riscstar.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Jul 2026 10:59:18 +0200, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> 'tc9563_pwrctrl_ports' is supposed to list only the internal ports of the
> switch. But it currently lists the integrated MAC Endpoint as well, which
> is wrong.
>
> Hence, move it to a separate 'ep_cfg' struct and also configure/parse the
> ports and the MAC Endpoint separately.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---


Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
