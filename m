Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F43CB57D
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968720; cv=none; b=jYCb+0TanL/qACBxWWhABUppQLrviwkobg3GNv5BAT635cGdnd/1eNqPfstqIyRk5Xg6TVZEZPcdAZvHBpnx6zjQ5ffxX05Y/OUmp44xxxurN5G95ysaS2lG+XhO36v+u3COaXJJJW3UsBjJA+YbS7phqEB/wwZdKOZTTMcumC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968720; c=relaxed/simple;
	bh=jsedZLxYBjeRK5DRFBlUwUDOw3C1t+5s3b7lh0/hqDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxnYa05nyDB0xzaSdvrYM4XTt6M2vrX7UGqmZ+xFwqfQWYcs83dK2WWyaqli5mPOe89GWMKWRmYamc1sczgOFwbr2uCJDOxXv5zvk1cwOq0sPpFuScReCLfXWRsvVuZT070R+6bRDuKRFAoewjUKQFNmwE6iYmMFVgV6lB6XN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=eghDmcSR; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="eghDmcSR"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9178d514951so775196d6.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Oct 2026 12:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790968717; x=1791573517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K2WGxmgiqbuVWGrMMN7M+HLRy0CqkeslBWbdjt3ajek=;
        b=eghDmcSRsR6MOItEQd6AKVUmnUtisYNWkhZU9z5cL/DTj8jualhQcRwk33Y9a6UdOp
         tvXhwTjgyzCx0fzgVXbzdFi5tecJ4g8j+Ch603SxboaDbbIBjWtQ94+hOLawY0Oepn6M
         gE0DHnHjVDcGbpp1TuPQ32XLwMZKMlVEoFpPMmU3jr2BN3Cj5zSXZLeDt8BGe5XqD3ch
         Eoeo//GZIU3j9xx4jYjKhOYCPnzOaXAPM+mHc+fWtMxgQkQiHOG/i5By/Xl4OSS8EZhJ
         FnvaUi62c8p7ZGrWmAb5hpds+Zmkg+wkBfOHxZy/EtLcFLEvNCGBtGIUDAGso76DNv6w
         gPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790968717; x=1791573517;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K2WGxmgiqbuVWGrMMN7M+HLRy0CqkeslBWbdjt3ajek=;
        b=Sa6k3zT7FTTrM+Do+aIJxIL4jE6NPtzf9qCiPEjPXWhdWExpM6Lr9WppcgATLlkoEq
         U0aFSUOT06pehLy/YApS8QlMbk5uua3bsRxFt8MCy3WD3TLlKazW3phFZAFN/wJUmy04
         Nb2bdhet13rjKy3MGvCrNcERLWtosJIRb3HfEiMhHZJDUXAXyg08ijWHOP4Yd+5uNRqP
         krG1i/FELWFNpI0w3S0GvrHHCmmxtAaX6jheqpeg54K02byzGxc7889qoJjAM5+BzHaR
         qAePikrCDWAL8S80GJ1+qemfNKRMKCcB72TeYxQzPMaZ0PVwnDDYXo4wAzrWOnPM4Ggs
         3pmQ==
X-Forwarded-Encrypted: i=1; AKwUvByCpWHrLiZEXkgg07LpQa1cc2lAF0wzUSZdafLBWLA15rJhRn6IUW2H2zC1/BSScak2zPJzqdYlwqo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdADAwO2wiYRiU2lpyz8rWPH/KyopcDpKHQPGUan/wVqMGWx5W
	h7RviNB0djjDR8FGvXKdM6tKSG0hoLoeE2EePLtAFNbVCSrl0L9oOaxywvDFSSk+uGk7H0v0o7M
	QUubKlhs=
X-Gm-Gg: AYBFou1MpWKAvwgMI/sMtvLPnztSKNxh08+ezFEN/e5zOcihl8299MwtmWVMVNmvyh5
	NbUb98QDaTYl6vwnsZE1GLiNbujTjnfzRMXnx2D5OYO9cwhlmkvmy1Xk6+8dpgKl4ajt/NQyinr
	ryl6mI8ENnNLeOGWIDZXAoeju48+ZyoJXj9M1isL8aF38E4VWvR0KnmwwaXcnE9UkD0roIJ5M1y
	oDDL3VarCCY9CumqPUzzFCWYXLia1FoT0SSUZhpCztZmLERi9jiSBt+L9GOuQjPemoiyXIjXurr
	1SIOUPDQ8Ax1ilE3PswDG5odGD3OD05Xp2ox24Ow9GtnAEjow6qdZi9y2qJ2Uz4sf+gssaypzBN
	q4aiEC3ybOuYFjeTUbH0TA7ftMnmfILQTnnwIMYKRyF9iwlH4MISBiDIe9/LPFSU4mzrBDIluxl
	kyxfg4xlYDlmf3mRTSlcfRfAVMblTfHeyyVkG7Akmn8vHeNk/muTTwTjbxjzWegckidh2qkzn/s
	uq+k+6tNQk=
X-Received: by 2002:a05:6214:3019:b0:917:a92a:fd59 with SMTP id 6a1803df08f44-9195d1da497mr5054326d6.37.1790968717042;
        Fri, 02 Oct 2026 12:18:37 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b67167sm27020566d6.21.2026.10.02.12.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 12:18:36 -0700 (PDT)
Message-ID: <6cad75b3-c4fb-486f-82a2-6613c4dffe32@riscstar.com>
Date: Fri, 2 Oct 2026 14:18:34 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] PCI/pwrctrl: tc9563: Introduce support for
 embedded GPIO controller
To: Bjorn Helgaas <helgaas@kernel.org>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Linus Walleij <linusw@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Daniel Thompson <daniel@riscstar.com>,
 Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20261002175405.GA189401@bhelgaas>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20261002175405.GA189401@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/26 12:54 PM, Bjorn Helgaas wrote:
> [cc->to: Bjorn A for arm64 DTS, Linus, Bart for immutable branch question]
> 
> On Wed, Sep 23, 2026 at 03:43:50PM -0500, Bjorn Helgaas wrote:
>> On Wed, Sep 09, 2026 at 04:55:52PM +0200, Lorenzo Bianconi wrote:
>>> The TC9563 embeds a GPIO controller currently used for per-port reset
>>> signals.
>>> Add a driver for the GPIO controller embedded in the Toshiba TC9563 PCIe
>>> switch providing 37 GPIO lines. The controller is registered as an auxiliary
>>> device by the TC9563 power controller driver and accessed through the same
>>> i2c device.
>>> Please note this series is based on pwrctrl upstream branch.
>> ...
> 
>>> ---
>>> Alex Elder (1):
>>>        gpio: tc9563: Add support for the embedded GPIO controller
>>>
>>> Lorenzo Bianconi (4):
>>>        dt-bindings: PCI: toshiba,tc9563: Document embedded GPIO controller
>>>        PCI/pwrctrl: tc9563: Add GPIO auxiliary device support
>>>        PCI/pwrctrl: tc9563: Switch per-port reset to GPIO descriptor API
>>>        arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563 embedded GPIO controller
>>>
>>>   .../devicetree/bindings/pci/toshiba,tc9563.yaml    |  14 +-
>>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   7 +-
>>>   drivers/gpio/Kconfig                               |  11 ++
>>>   drivers/gpio/Makefile                              |   1 +
>>>   drivers/gpio/gpio-tc9563.c                         |  99 +++++++++++++
>>>   drivers/pci/pwrctrl/Kconfig                        |   1 +
>>>   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 165 +++++++++++++++++++--
>>>   include/linux/soc/qcom/tc9563.h                    |  19 +++
>>>   8 files changed, 300 insertions(+), 17 deletions(-)
>>> ---
>>> base-commit: 028f86457e822ab9de5b0d6d23efddc1b8b54ae1
>>> change-id: 20260731-pci-tc9563-aux-66a29d438f60
>>
>> Applied on pci/pwrctrl for v7.4, thank you!
> 
> I had applied the arch/arm64 DTS change:
> 
>    arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563 embedded GPIO controller
> 
> on pci/pwrctrl, but I think that was a mistake because that should be
> handled by Bjorn Andersson instead.

I'm only responding to this to provide slightly more explanation
about what you want to do.  Resetting pci/pwrctrl has no effect
on me.
> What I would *like* to do is rework the pci/pwrctrl branch to drop
> patch 5/5 (the arch/arm64 DTS change) and reorder the Alex's new gpio
> driver first so it's not in the middle of the tc9563 DT and driver
> updates:

Currently, the dt-bindings commit is before the gpio commit (and
followed by the two pwrctrl commits).  You want to reorder the
first two, as below.

					-Alex

>    gpio: tc9563: Add support for the embedded GPIO controller
>    dt-bindings: PCI: toshiba,tc9563: Document embedded GPIO controller
>    PCI/pwrctrl: tc9563: Add GPIO auxiliary device support
>    PCI/pwrctrl: tc9563: Switch per-port reset to GPIO descriptor API
> 
> But I don't want to break anybody who assumed pci/pwrctrl was
> immutable and pulled it in already, e.g., to the GPIO tree.  Would
> this rework break anybody?
