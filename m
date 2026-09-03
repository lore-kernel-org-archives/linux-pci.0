Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44B4A6CE3
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439457; cv=none; b=nd92fGeqjf4RZM0ntBtp8kr8Ccd5WDccur5+eTHPZavVakcJ2GPEczywHfP0laOe7tb8kDRUwT2XtQ/JIX7ub26wR0qtR0E5TZ1aUwZtZANlcA8OOFLDu2NyZldcRJDC2+fXu/rgnSFGb1fuvsfnEGlTL4VbsAkvjOU9NGJm0Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439457; c=relaxed/simple;
	bh=kLLGrVA+RkyyNDTSwR/UN6iILepbLIrg3UM1UO1CwA4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irTCR9S2uoKMqPFAIWwmRU9lRsXaRrigQxEJtn65qzOqiE6jUWIDYzxh7pvr7BrIIX/XbkFYbsA+6fCWHhRGGa0KGTdzhtnb5slrclQmworBLpWw9+s00FoZBPRJyHbR0ixgyNMCupNI5cvRaD4Kbps+lpOGw/tMnlQp3n8DDAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPOn2F++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPOn2F++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8311F00ADE
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 12:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788439456;
	bh=kLLGrVA+RkyyNDTSwR/UN6iILepbLIrg3UM1UO1CwA4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=oPOn2F++cAThiUZhLIvp1je7VpARuZhLII2ZuAW37bbBkL9G5BO5lk9KitDHtgBXN
	 1Ivyey28sixN8dnlbtpYe+3Bj+9+oyqTfv9JGIehediIC2G47X3PA4A6S3ZuWTOPcM
	 0gKckfOHr9jMkt6UMeufVMHsQj/oH1wDgqcI7XAGPf2G+1iegTgFIDyG30eGFIcufR
	 YKfXAQejaDHdYospPtXp3hCBQY56472xQ5e75oXMDJFh7ahGiPL8+gz7cdKPtpGkl6
	 fqjEqgLNa5fAGZDaSH2wSS+WpZSqUBDS3LF03OEyxwbGaiiO9xkvdC8EBjfEsKniQQ
	 BKM4Y5+CWVKFw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b4adcce4b1so2662191e87.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 05:44:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwuTYeGyqGEKKWqnqh/ZTaMjXasr0qE59iE7kd44Ublj5muU2qbhWT50k49XttFaEoe2PM6rwoKYd8=@vger.kernel.org
X-Gm-Message-State: AFuF++nL2Fm4XJN5cm88BVlno1p3YFcuvDXv6masrZmIPIlkGh7siZiG
	HikWoanGOmo3eKPiyuRPA8NxqWpaDShbiGWc7TC50hD4xMaR3l3Skt9NxZU5i2ytHHP+pyRAlw6
	tryG2kQLI0s1ClkrHvGt17VUTELViEcuN/tXlKyJ3Fw==
X-Received: by 2002:a05:6512:400c:b0:5b4:ef51:8cfa with SMTP id
 2adb3069b0e04-5b6083370a4mr3815366e87.8.1788439454949; Thu, 03 Sep 2026
 05:44:14 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 08:44:12 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 08:44:12 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <33t3reowiellyer7bc6ipp3n5jhchf5ozbj5imkctp7mcibkq4@w3jbhjet4w6z>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-pci-tc9563-aux-v1-0-dd9b80738e70@oss.qualcomm.com>
 <20260901-pci-tc9563-aux-v1-5-dd9b80738e70@oss.qualcomm.com> <33t3reowiellyer7bc6ipp3n5jhchf5ozbj5imkctp7mcibkq4@w3jbhjet4w6z>
Date: Thu, 3 Sep 2026 08:44:12 -0400
X-Gmail-Original-Message-ID: <CAMRc=MdH4jQjO2GfAnQsvgnEnC-WJ0eBKm2tvXgyWg38TyDbXg@mail.gmail.com>
X-Gm-Features: AcwNN1Ug4TJm6UVVx91gjHTpOxURajwcCx-_f6Le4vDahBEP7qgE7YMsFijrKeU
Message-ID: <CAMRc=MdH4jQjO2GfAnQsvgnEnC-WJ0eBKm2tvXgyWg38TyDbXg@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: qcs6490-rb3gen2: enable TC9563
 embedded GPIO controller
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Sep 2026 13:05:28 +0200, Abel Vesa <abel.vesa@oss.qualcomm.com> said:
> On 26-09-01 12:27:57, Lorenzo Bianconi wrote:
>> The Toshiba TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
>> lines.
>> The controller is registered as an auxiliary device by the TC9563 power
>> controller and accessed through the same i2c device.
>> Describe the controller as a "gpio" child node of the switch and use it
>> to control the PERST# reset lines of the two external downstream ports
>> (pcie@1,0 and pcie@2,0), as expected by the TC9563 power controller after
>> switching to the GPIO descriptor API for per-port resets.
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>

FYI There's a v2 already on the list.

Bart
