Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D92D7393
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466279; cv=none; b=DnLUeGfcSt2+TgML8q7KNoJ3wMZeqAIZ93v2zO8FECELZN+szISYPYWlRuPP1oqIv00VIYSUwd1JyIAbJ2azlYkG32IkPxWPqvJDhKkvWSusBPqW1cpZ3xSz2UK3Zv5TGlCEWfCekgPCRjeT5bap1Fpr7oS9R+ghjdt+emRa6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466279; c=relaxed/simple;
	bh=rpux6yDT16ic0wS3/2Ry77dxAooCngnSjhcLkmuwQiw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDvua74U3Ft4OrUVnyjTI3rp4q2MhMSzqGR9chMoThRvTZkmcxWqrspsZoh1jeOg/kvBwpclVslwQd8w8gWw+G5PDy1/dlugy7xMQ1GJ9d30MtX1p74uBUT9IP3s6z49jARBqa6PudT4txjyP+EHYjGju8SdRgB6eS9p8gOobA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G90fkQMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G90fkQMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E6F1F01558
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 09:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782466277;
	bh=rpux6yDT16ic0wS3/2Ry77dxAooCngnSjhcLkmuwQiw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=G90fkQMuun1t/Wp6zxYOeg/D7HZpVsMjn2FtnyT08x7T2P9fKKpfMiKyVFCjjJEBS
	 Hig6i16MdG1odZcB4+x6A2/k0sSgT9JLL6kJYmNRbi0ovj6S6U/95H0JPruecT/nzg
	 GMLo/fiCJUZwUmKeZiNuW0TqlXkPl+EUcKMy2wfAj15asrA54TtrLgsbw6d9OUZX0S
	 PBRTwPDpQqTm+0YQdVTlhqOJfvV4P1xZo61IESQB8uwQARBjReB86geB9bm1X4/Xwk
	 WYTjJauAiiZDs3RWrF1oBz7lq9ItbvNMff0EeXgbfY4m1CFfoGfdloe9mSRAE+dBE5
	 UnfVQGI8Eh+Zg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5ad583dc41eso645157e87.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 02:31:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrG15IwGxAV7kKKaStOb1svTsjOxyWp0bT0sWl//qHF8etQegkS8CpWeqUfP64nO0dL+PdO5NiPayo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWIEOCHFFBzqUfPEEujGrRi6wjy/PfUTzxPoGpcF3H+DyKPgDN
	oyLn0Spk4jQR5Nn6Tx/y6wHa5T/5APuzLc2p5QyL03UjMjUgaJ7BfCjBY82aqTtGquDz8fgfg4p
	D5fopib+vN1xc8MbrCV9vDZUqV3mM5AdoE8j7C2LVYw==
X-Received: by 2002:a05:6512:70:b0:5aa:6f89:9378 with SMTP id
 2adb3069b0e04-5aea1f4cc51mr1390413e87.33.1782466275655; Fri, 26 Jun 2026
 02:31:15 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 02:31:13 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 02:31:13 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260624-wakeirq_support-v11-1-120fbfaebe59@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624-wakeirq_support-v11-1-120fbfaebe59@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 02:31:13 -0700
X-Gmail-Original-Message-ID: <CAMRc=MenARGtsG9EhF7zVgcOeQGAYVRZc906j4tBDHQzzsc0hg@mail.gmail.com>
X-Gm-Features: AVVi8Cf30tKZqffjS3ZAp3xIi5Kv5KtWMy22eC3tfJBlDmG5o9u1ykXsqyuQesk
Message-ID: <CAMRc=MenARGtsG9EhF7zVgcOeQGAYVRZc906j4tBDHQzzsc0hg@mail.gmail.com>
Subject: Re: [PATCH v11] PCI: Add support for PCIe WAKE# interrupt
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, 
	quic_vbadigan@quicinc.com, sherry.sun@nxp.com, driver-core@lists.linux.dev, 
	devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jun 2026 13:25:49 +0200, Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> said:
> According to the PCI Express specification (PCIe r7.0, Section 5.3.3.2),
> two link wakeup mechanisms are defined: Beacon and WAKE#. Beacon is a
> hardware-only mechanism and is invisible to software (PCIe r7.0,
> Section 4.2.7.8.1). This change adds support for the WAKE# mechanism
> in the PCI core.
>
> According to the PCIe specification, multiple WAKE# signals can exist in
> a system or each component in the hierarchy could share a single WAKE#
> signal. In configurations involving a PCIe switch, each downstream port
> (DSP) of the switch may be connected to a separate WAKE# line, allowing
> each endpoint to signal WAKE# independently. From figure 5.4 in sec
> 5.3.3.2, WAKE# can also be terminated at the switch itself. Such topologies
> are typically not described in Device Tree, therefore it is out of scope
> for this series.
>
> To support this, the WAKE# should be described in the device tree node of
> the endpoint/bridge. If all endpoints share a single WAKE# line, then each
> endpoint node shall describe the same WAKE# signal or a single WAKE# in
> the Root Port node.
>
> In pci_device_add(), PCI framework will search for the WAKE# in device
> node. Once found, register for the wake IRQ through
> dev_pm_set_dedicated_wake_irq() associates a wakeup IRQ with a device
> and requests it, but the PM core keeps the IRQ disabled by default. The
> IRQ is enabled by the PM core, only when the device is permitted to wake
> the system, i.e. during system suspend and after runtime suspend, and
> only when device wakeup is enabled.
>
> If the same WAKE# GPIO is described in multiple device tree nodes, only the
> first device that successfully registers the wake IRQ will succeed, while
> subsequent registrations may fail. This limitation does not affect
> functional correctness, since WAKE# is only used to bring the link to D0,
> and endpoint-specific wakeup handling is resolved later through
> PME detection (PME_EN is set in suspend path by PCI core by default).
>
> When the wake IRQ fires, the wakeirq handler invokes pm_runtime_resume() to
> bring the device back to an active power state, such as transitioning from
> D3cold to D0. Once the device is active and the link is usable, the
> endpoint may generate a PME, which is then handled by the PCI core through
> PME polling or the PCIe PME service driver to complete the wakeup of the
> endpoint.
>
> WAKE# is added in dts schema and merged based on below links.
>
> Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
> Link: https://github.com/devicetree-org/dt-schema/pull/170
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
