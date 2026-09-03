Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC9352017
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425433; cv=none; b=LM1S2RoVAvnZFUeLcHixOzGdWHULRrXF9Hr8qGDpmVr0yEEP7BjzyhAG2ma1SQOn9pRbhZVUyGmTqBvrdXT3+XqFw5FIczI1tqbBTZJtadI7cmPIUAnKAL/3egB+T0YV2azEzrlrWqG+tcq4aL00afQUSeomqe9scFrphYdk9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425433; c=relaxed/simple;
	bh=b/J2tIGkuu9cYQXNDh0K6oZrkOSsiyfDgQIMW7Oe+HI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVO/ZGixeMith6PFDSFAYI2RjM6lpThOT3gHCwpgZNC03q0ittFzLQdSLNJZBAlTb4ApciixkR8fXOvY6ovSc++axdwk2LWUxRHzqIhdonfKjwsGynkS4MQKlGmoeyuTYdCzXj2Meuz+BhdBBXvsDrhBF04vb9rMus9aGclgWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT4cM0tI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT4cM0tI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA53E1F00A3A
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 08:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788425431;
	bh=b/J2tIGkuu9cYQXNDh0K6oZrkOSsiyfDgQIMW7Oe+HI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=oT4cM0tIMY8qyjZycMQ1KC1OA9HeAuNsWE8eSQ7UNKQMJi7XC5FlAerfCFKzWrEyI
	 vXxCSTqoPzZv0khmvzkVbmrx1CHLNsWA3OkM3GEVnIvLanfNv1wzDpquoVKmEYmfwp
	 LQs3v9GMN7nj6CzG7L/elqhH6A9CdIbJ+jwj24yik9MF3Ejv7I9n9/2vtx5+KWWsyB
	 zKmDCSif1D0Bbp4IzTunXXeKhp0G5o60u/WmMsbrE4j0chlZ08A2lCjC6RX8XbuQIv
	 wgEKDxl81gtddzue/pPVIMb7Cp5Rin5gyBDQdNpwR5e4GkC/MYfGIWOx1VNRwYA2Zg
	 51Gm3opiaZwwQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b45f2e5f58so1914705e87.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 01:50:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByveEAIn4ePzvwWo81BhpiLW+8swo905WBNbMtbdH1KdOMKi04+BCbDsJUJMxf3NKw/8KtseVMx2pc=@vger.kernel.org
X-Gm-Message-State: AFuF++lgE8ESQ2KPbeW/ud50NNH9WFXmw2nRubwkLebc9AhrZFuzQlp4
	VbAuixd5C5zTGbgFDgPhfjzFRJOrsiSxarmBLxZqTMlQ4VWt+o6AjjZ2OvnhyrAUs78rHUXvBYC
	x2XL4psyyX87i/rm8qTlUz40hFXxRvOolc32IQ8BbNA==
X-Received: by 2002:ac2:5696:0:b0:5b0:eda:de25 with SMTP id
 2adb3069b0e04-5b609197069mr3452281e87.6.1788425430612; Thu, 03 Sep 2026
 01:50:30 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 01:50:29 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 01:50:29 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260903-pci-tc9563-aux-v2-2-34c625b542c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com> <20260903-pci-tc9563-aux-v2-2-34c625b542c1@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 01:50:29 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mf6-7Y7nDvBA-zpw10_EeQ9mr+TkLfr_msBU7EU58LQ=A@mail.gmail.com>
X-Gm-Features: AcwNN1W8ZLKq45YYD-0C3nOhQX4esCxMfLaqxcHvxZDmgjB6oKaZzyXDqsJyCzA
Message-ID: <CAMRc=Mf6-7Y7nDvBA-zpw10_EeQ9mr+TkLfr_msBU7EU58LQ=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpio: tc9563: add support for the embedded GPIO controller
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

On Thu, 3 Sep 2026 09:52:58 +0200, Lorenzo Bianconi
<lorenzo.bianconi@oss.qualcomm.com> said:
> From: Alex Elder <elder@riscstar.com>
>
> Add a driver for the GPIO controller embedded in the Toshiba TC9563
> PCIe switch (and the Qualcomm QPS615). The device implements 35
> GPIOs using two register banks: three registers control the first 32
> GPIOs (20 and 21 are reserved) and three more control GPIOs 32-36.
> GPIOs 22-24, 27-28, 31, and 34 are input-only.
>
> The driver is registered as an auxiliary device driver; the TC9563
> power controller creates the auxiliary device and provides a regmap
> that gives access to the GPIO registers, so the gpio-regmap helpers
> are used to implement the GPIO chip.
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---

Looks good to me. What is the merge strategy? If you want Bjorn to take it
through the PCI tree:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
