Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79374BB7FE;
	Thu,  3 Sep 2026 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446556; cv=none; b=umhd91A5DO22Q4m2SoXpoplKgBTlX9GRrZa/20kKww64Kh5uxdUN1YBYDy8A3MIA8qAKhA5VBq+zVnLSJnCMpLunOM6bueQl4zX6ZoVMMDa2B+98QOvRsGldOo3k+PU1PrbDJzRncN8DsWGzO8XOZ1g0cB9EoqfSx9JyoyXIYsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446556; c=relaxed/simple;
	bh=PwtfWAIumYD77h7PzOYYwW+zTFMzpuitgv/f5YxSGN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWRl2WisPWuarAHC+TJ+HXSQq20Y1dIY4DOjxgZO2UbR084QSU7ftwAK1XFfyva4WtR6xiNnTNmlNCfJDsTi10di/nFvJsvjMgyTWL77lASs7vw2I0V4vDq6XSUjeL3+tffCRkxWkArXE8/J10c2QaiNUwfINZcxcjjrCF1pRPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: esmtpsz19t1788446514tc68bbb6b
X-QQ-Originating-IP: MeASNOdmrs56CZbnO7tzXMJwu+SSeXXkrojO4rHMzek=
Received: from [127.0.0.1] ( [180.159.160.209])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 22:41:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15928767512073922891
EX-QQ-RecipientCnt: 29
Message-ID: <1437AFFE6B2A54BD+7fe7c715-a19c-4efa-bf66-50b5c04ffb19@radxa.com>
Date: Thu, 3 Sep 2026 22:41:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sophon@radxa.com
Subject: Re: [PATCH 1/6] PCI: of: Avoid config reads for disabled bridge nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
 <8c2eaba0-c1bd-4db0-bbc8-5ae3b3d9a13c@oss.qualcomm.com>
 <B4EB99E5B76C9F40+e6fdbdd4-5c05-4b98-867c-29c7178a0d72@radxa.com>
 <a5d83aa4-7065-47c0-bbda-35063034b0d6@oss.qualcomm.com>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <a5d83aa4-7065-47c0-bbda-35063034b0d6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OGRTx1KypL8C0MPdYFDfRXngEb9R45x+ZcfuMshYmcbpQKQ5nsTICWn3
	FqcUKqHK/yq1QllReLC7mUgRfB3RbW4r71lb+ASBsB2S1c6XepeP3m6m6AotobmrXQpDV94
	JoB3CvKbkmUJV6pQhRyKCfokH2bx0JHAjsWFdGZzxT4gD+jSzTFlqY0lqc2oOTzYWUszkeZ
	h38UwYsXoHjUAGHh7JekPTBGSFBRCH0r82zdNzN/xaV7YyAq3TPamq4sq+uM3MRKCjW05TV
	7njzM7cmdI4bkPNTgVz1GohQL01iueNJ1Yqaj3m4U2vhQve/MLV186cSCxa9Is1/iET5a9r
	Mmn95ITiBmoQHEP02gw/0U0yMmMRPcHfvlRLuNhNW1z+jycwT5hWi3x6InUbNVCGJ0tU/Bf
	YIPpp5ozFU7dAgVKPgh8SsbQbr18OFLOhfgmzj4fXvMiGFsaUsdDLFuBLidkA5OXR3EA+Ba
	zaMldZbiUP+wR9WSayxKNXwE4K0VjdOiiR5Hr0ZFHJLAs9ROI09V5jA0vIgPysbSaZXG/wT
	g+Zo/Guthqzs4QZ2miFzDsxK0zCr1IxLb/wPyeUQjSqeQWSFNQ9EjRLDQs2lZCn8vgxI9pB
	HA1pq1yd+uwoaf08n1A3KveOefJ7tvuY/6GCkKULCCkF8neiIObqRzpDK0IFiSLieYRbZLt
	aRPqLIYf3cviF/hyVkOjrylUTXqkdsC3FE5SuI+4orNNGNZtYOBNzpLJ468E+SrtLYuSqcH
	MWbd+LStx5Edk8bLxDgr9+7jFA9LnTKR4ZsLkqz7CBpGotfV0Heds5hRNnu1N2R1XM9yJUq
	lD8crLgYdzGa34VDoSLTLrQFoqDU1UXKYv9QDo1TlB8k9oqlEjRPDiPyd0cktiU1iaWWDDl
	DVMbYtt2y1RDUzonOLFz962qD5Jq4zVQ3anDDnr52ffbRugJOftyUm6Sl/1FxaNeZDa2NuL
	AKzD6T7lbzeFmS9NQeXXQCwTYff/SSSM6AAntMA0sH18k6Fdvbxuzyxdw+Dhj675CzuG+0s
	Jb+zog2ojVxMDC6Q3hDlS6yCwOfhAPYWV0u0+DaQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On 9/3/2026 10:40 PM, Konrad Dybcio wrote:
> On 9/2/26 11:31 AM, Xilin Wu wrote:
>> On 9/2/2026 4:43 PM, Konrad Dybcio wrote:
>>> On 9/1/26 10:47 AM, Xilin Wu wrote:
>>>> The TC9563 PCI power-control driver powers off external downstream ports
>>>> whose device tree nodes have status = "disabled".
>>>>
>>>> On the Radxa Dragon Q8B, reading the Vendor ID from one of these
>>>> powered-off port functions during PCI enumeration raises an Arm SError
>>>> instead of returning an all-ones PCI error response. This prevents the
>>>> board from completing boot.
>>>
>>> I agree with the premise of the patch, but I'd like to understand why
>>> that happens - do you have any details?
>>
>> Unfortunately, I don't have further details. The downstream kernel also includes a similar workaround, so I suspect it's related to how the TC9563 chip is designed.
> 
> I'm curious in why the port is still advertised on the bus if
> the i2c interface writes some magic bits to "disable" it on the IC
> side.. but perhaps that's just how that IC behaves and we can't
> do anything about it?

Yeah I think so.

> 
> Konrad
> 


-- 
Best regards,
Xilin Wu <sophon@radxa.com>

