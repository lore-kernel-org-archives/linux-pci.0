Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D13346E57
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515287; cv=none; b=n0dPNaQslDa+xf5sCGJUKwqlFgLVSxAigcGILcpTs3uIDWwP36xLi23N5TTeyaDB10kXBmOdA7O8pRV3kJWbfAVLihk+WxXtH7pQuKtBF5seQGM/tTDoEp33vQcBwnC9VR2hRVgQYckacQMXNc63iCuW1x3zVHLpek0020wuf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515287; c=relaxed/simple;
	bh=pVOvWW6/8RbPMOuNt3in1cuWQXC6AAst+EwzEiwLSEg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfCQoXS68Jb87C/NWKAhi/SoEJ0qxDXp8jZUBYt4Kee1IqP0tbJvRzgfTyJuxgOglfihAfZgE18V+IpqHgxQqc4Ebzisoei1uVvSKTnR5eDcqVFgHBv4XfdOLY7YSKQ1zymLs4CqHSoabXy4smN6LDDIoOgGOOpRJVNtNDIfy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV/SLegR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV/SLegR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C523DC2BCB6
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 08:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774515286;
	bh=pVOvWW6/8RbPMOuNt3in1cuWQXC6AAst+EwzEiwLSEg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=TV/SLegRcizv12x0IPKzeUfFQMf/dB5JF4rfekrIVqdFxc1pV3wJFX09vTg9axUIf
	 HRmdBRmn/vr/bMZrXHq9PP1CwSpuBXn1xMa5MA6FApmSWD2WTTEO4pvtMjPcQoEFHY
	 yT8wNkSsgjShxxZKrv43HGqPR/CYirdJnlCt+/Nr2zGXQI/du1BF42mbn3JSG5EHRV
	 8BnD94NZlKhwewW8f0gI/fRQKvpToaiRfFN8q7la93cx3LB0fdwZJWIyfarmBIMZtU
	 D7aM3iq0qJBwONhxvqF2/aXh0y94jrdJvjD941VUGT9FpNCMEMI9uBTphlpQ49esNn
	 q9GyByiYDeJbQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59e4989dacdso912987e87.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 01:54:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFnZIU7exR+NHZ4rrbAGkDD6HKegsl3qEYn4ZA3HS0Qo/tMrnN76zP9avJ7YhcmLvgUp5eAyvBHTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7YViPL0Cq2IQHj2mQAi4vAzzpS0cmrFYrXxETyfKEfT64hqng
	HRCB9TwxT2dZOjvREdOlYHB9Q7eaWr/wMU67GygBRfqNOyKXxoNDJlEm6fnHCrIOWKRCwtvJa9S
	tV0borbHIx9jEA7Gq/i6Kqg2m/PDf9l3PYORBbWpuXA==
X-Received: by 2002:ac2:46f4:0:b0:5a2:a024:e6c2 with SMTP id
 2adb3069b0e04-5a2a024e734mr805672e87.44.1774515285384; Thu, 26 Mar 2026
 01:54:45 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Mar 2026 01:54:44 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Mar 2026 01:54:44 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 01:54:44 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeFPpO77ew4pbPjqo0E3fjos_B=t1AgooB7xrF5CWPeJA@mail.gmail.com>
X-Gm-Features: AQROBzCb320XuFwbgeojakGVPIHtnFnx1cQ_VrqUrXaxSXRJoOgSnNC2mrU3j3w
Message-ID: <CAMRc=MeFPpO77ew4pbPjqo0E3fjos_B=t1AgooB7xrF5CWPeJA@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add support for handling PCIe M.2 Key E connectors
 in devicetree
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 09:06:28 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> Hi,
>
> This series is the continuation of the series [1] that added the initial support
> for the PCIe M.2 connectors. This series extends it by adding support for Key E
> connectors. These connectors are used to connect the Wireless Connectivity
> devices such as WiFi, BT, NFC and GNSS devices to the host machine over
> interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds support for
> connectors that expose PCIe interface for WiFi and UART interface for BT. Other
> interfaces are left for future improvements.
>
> Serdev device support for BT
> ============================
>
> Adding support for the PCIe interface was mostly straightforward and a lot
> similar to the previous Key M connector. But adding UART interface has proved to
> be tricky. This is mostly because of the fact UART is a non-discoverable bus,
> unlike PCIe which is discoverable. So this series relied on the PCI notifier to
> create the serdev device for UART/BT. This means the PCIe interface will be
> brought up first and after the PCIe device enumeration, the serdev device will
> be created by the pwrseq driver. This logic is necessary since the connector
> driver and DT node don't describe the device, but just the connector. So to make
> the connector interface Plug and Play, the connector driver uses the PCIe device
> ID to identify the card and creates the serdev device. This logic could be
> extended in the future to support more M.2 cards. Even if the M.2 card uses SDIO
> interface for connecting WLAN, a SDIO notifier could be added to create the
> serdev device.
>
> Testing
> =======
>
> This series, together with the devicetree changes [2] was tested on the
> Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the WCN7850 WLAN/BT
> 1620 LGA card connected over PCIe and UART.
>
> Merge Strategy
> ==============
>
> Due to the API dependency, both the serdev and pwrseq patches need to go through
> a single tree, maybe through pwrseq tree. So the serdev patches need Ack from
> Greg. But Bluetooth patch can be merged separately.

I think Rob Herring is the man in charge here. The power sequencing parts look
good to me now so with an Ack on the serdev changes I can queue them for v7.1.
I can also put it on an immutable branch if needed.

Bart
