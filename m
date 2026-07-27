Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C3941E6CA
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167955; cv=none; b=eMTup3ezgDiDQ0r+VGZTmAVduG02vwxw1A9pMNm2QcNis5U6fkcFWi0Wm1tWd22Dri2XJYiiIXeUH2KwTBpdZz+LdV3KgeEMHVJzjZ88BfykAP7H1PyXm0U5NntlF51FhHKBN74A9Y1VWYJk0XAS1nkcJ7H62Qr/AopFhFqT1TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167955; c=relaxed/simple;
	bh=rJeNBOwIj2fpTTbrgZp0kaifEW7FTkpHCojoUf8sGCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHvJX+h/cNizUvWVqGngWeJUbH5IRLpY9ufNBtV652Y80i5ZjBMd7qk8LKHURKb23VBCV1Gud+KC4SLxhpp+JB7u0s761AZLW7JMWc4CkqMFGS4av11Ip2U1EcQi2KMa91GBROqURx2YnOEDwxYZQBNVXoyUDRyIoBWrM2WxPYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=aJCgjoJJ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="aJCgjoJJ"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c4436d02cso14517761cf.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785167952; x=1785772752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iRYJYVd0WrMo0au+p8lu+GWgBRTTEDJMXDl3Udh1WWA=;
        b=aJCgjoJJ7+y45q/xn56ADc1ZiqsoXNxguZNZn0dcAdYjWUtvXdthLTs42i69K2mlxh
         xSW9bvzwjlYOFxoCCUEJK7Y4+0od7Blq3Zs/xNDzXRf2cwW9XHNjBEE4Au6QuCDhXm1L
         586TY5BNhCYOjtMZrk8Frz6dRdP1CZ2ZxRBYIuNdoBgI2VMDMVYgWwYSnGtjGVf/WuYT
         P6BgKCQebEvz3zX/rw7rLOqtKMHlp7AHL5NAyiZyZitW7KuOJyPVQ7eDPDDVg+VwZaAa
         K3hCzyIEzXvkwYk2L1A99rNmAcuWyliwT0/5M9PPdKuJPp+ijcNT84DrW1P6FPrGxjfX
         Q1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167952; x=1785772752;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iRYJYVd0WrMo0au+p8lu+GWgBRTTEDJMXDl3Udh1WWA=;
        b=GamDaTrgOPYAzLttVRRzlGVb02v5v1Jz7fpltr3rB5maVe28POWevtjm185P4uW4tB
         lH84faaslmRHQX2VOJleO2kerPr1Gxk3psMnzWxRZgDIIBzwqQYYwi1fdYWI4Onigf3T
         a4JC88td75CfOlch86YcfWj053qz75LVUKQcOLl3bVPyFCsbqOtcnRDgUrxJ3Vfbf5d5
         GVYi6LJKDpKzDe8b9+dJYAhIA/LWkJOb2ES6kKpBUianXlzOhpYy9RJk5RhrZRmp2RZB
         t0A2B9vskhd7LR/lrkrHiG/RVVp33RS9dVIeGObFaVOmEfr+jnWkt0QRg95GxdlLhuqZ
         OufQ==
X-Gm-Message-State: AOJu0YzWvWh/NwEImoifexKhkNfQxanNRmehXVuZohEIHbOVrDSZDXK3
	C1tR5vnjipBSmz7A9Xl2sX958ioQtqDDiQANslILj2jcUJrWccKyRsJqXlAwXR4pFdc=
X-Gm-Gg: AR+sD1283TCfAmWf16MVFsZOVduVvMmC7KJLKwXQtpGSvkDfEdZRqqZc5xJ9Ug9lhCp
	Uy+ze8517jolmvcP6DPJ+hlq02J9CPSj2FDgc3t9owB2Y53kCY4etAOjgGDUXQr99dsSqWtQyFa
	nezCbZzYouu5a7mArhe9goFj0c315eh+oI3QPWZWHs4dy1DgXVyM0tn5+jrVlv+bZnaP4tPdUv2
	Al3QgwrU/e+GTfG0JUnF1A87dQKR3A2ZVQHGHDi18gdWBK3rCLEMtaWCx5MlVJG70Iq82b+3dqD
	XCcpp/qXSCULoT6drpHOmk6JfXqMuhq95eA09YLd/yAC7awme8ebeWa9wn+MaMyVHHatH9Efs/0
	fccBQRBrDUgqgW/ROM/+XQWRiTHyR7ApTeDLph85S5qFcilS49jOtmrod0bvFj5IsgaXjO2ckPi
	AXTW2hGa2zVzNcvRLCfE3E1dmlmpNfZ+/mq8/86cNih6G0HFBeMolT79XiS5Iu4mGikODX754=
X-Received: by 2002:a05:622a:551a:b0:528:3a24:f396 with SMTP id d75a77b69052e-529a8739eacmr90115781cf.73.1785167952432;
        Mon, 27 Jul 2026 08:59:12 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a262fa9dsm56944561cf.0.2026.07.27.08.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 08:59:12 -0700 (PDT)
Message-ID: <f9937e7b-746c-486b-b94f-fb3b34a2b0d0@riscstar.com>
Date: Mon, 27 Jul 2026 10:59:11 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] PCI/pwrctrl: tc9563: Skip Tx amplitude and DFE tuning
 for DSP3
To: manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-4-ec4286e31331@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260725-tc9563-fix-v1-4-ec4286e31331@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/26 3:59 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> DSP3 doesn't support tuning Tx amplitude and DFE settings. So just skip
> the setting if DT has passed the tuning properties. There is no need to
> error out the whole driver because of it.
> 
> Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

So to keep things simple, tc9563_pwrctrl_parse_device_dt() is called
for all downstream ports but you ignore the setting (with a warning)
for those that do not apply to DSP3.

What about tc9563_pwrctrl_set_nfts()?

Other than that (question) this looks good.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index ca19bf60d290..28e9ec3e172a 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -308,6 +308,7 @@ static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9563,
>   static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl *tc9563,
>   					   enum tc9563_pwrctrl_ports port)
>   {
> +	struct device *dev = tc9563->pwrctrl.dev;
>   	u32 amp = tc9563->cfg[port].tx_amp;
>   	int port_access;
>   
> @@ -327,6 +328,9 @@ static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl *tc9563,
>   	case TC9563_DSP2:
>   		port_access = 0x8;
>   		break;
> +	case TC9563_DSP3:
> +		dev_dbg(dev, "Tx amplitude tuning not supported for DSP3\n");
> +		return 0;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -345,6 +349,7 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl *tc9563,
>   				      enum tc9563_pwrctrl_ports port)
>   {
>   	struct tc9563_pwrctrl_cfg *cfg = &tc9563->cfg[port];
> +	struct device *dev = tc9563->pwrctrl.dev;
>   	int port_access, lane_access = 0x3;
>   	u32 phy_rate = 0x21;
>   
> @@ -363,6 +368,9 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl *tc9563,
>   		port_access = 0x8;
>   		lane_access = 0x1;
>   		break;
> +	case TC9563_DSP3:
> +		dev_dbg(dev, "DFE tuning not supported for DSP3\n");
> +		return 0;
>   	default:
>   		return -EINVAL;
>   	}
> 

