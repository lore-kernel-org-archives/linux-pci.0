Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D5F41F347
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167958; cv=none; b=DpVKIepdrDmCWLnoVKNhJ+Hjl4GdpdErElMLmpkrQhuSZusVjfIeLtzPZQW8pZLTNBqQG3lGWWfcTgZXJ5yZ+wWAHA/5zSC8BLCPNhyxXES+UpQjqYoaqk/DJ41u2qy96fcgzKsUagkrbzqUN7FAiUHys11NSqcphgyeI+lSmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167958; c=relaxed/simple;
	bh=GREFLNoFwBaO8g/qcZzBBb5BmM7mDh+vmMslx6ltmZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qt2/DKxiiS8iLsMlO5hp2o//vVFodc/EJk3tznKC1iyDjXnWz9HEwU5P73tpNu8+Nl3Mk82OMOGGy8k1fyjxhw+D/fW21ozayHvs0Pd1PbH8beDI54Uj3ELkJDu5VKP/t1SowF7zWl6sQdMEXYE89v77gE+x9+q04ON6yeitNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=WZtZ1fTg; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="WZtZ1fTg"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2cce930cso27956021cf.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785167955; x=1785772755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+UjimiS1ZGH8Z9qmeBpLWyEaDQH9OUrvKHAWj/PGhmQ=;
        b=WZtZ1fTgVUxjVHo0yiTn+FjKi6/WHtvsuQlTdY07paWROiJntStJa8+iCGiBnyJLT0
         mIaKCz66xRi+z+zi9jRDhmiXuViNE3eQemfmeRXzIzzZbUoS2wg3eHvepUG0VwPFh40a
         25ASlNcM3W7MOSqqbtDL+tWj4LZDk1Ls+YX0a7OvsTI05sduf5E4B2SGRYAge14YxIax
         6eTW33vTWgMIoD7awi/K18tPCwnR4r7s3BKc7DJo4bv+LvrXhmVU+OBTWkHNHWsJvaC6
         hWsBEiMQnx4DlG60FsDVVhTK6JU63hYMTuOPRQ7oaSRv9xJ+MmUljfULMRemLsAey6b5
         skYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167955; x=1785772755;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+UjimiS1ZGH8Z9qmeBpLWyEaDQH9OUrvKHAWj/PGhmQ=;
        b=Jmv6cC7221rxu9GDk8DQshlKZRXbHtHxh/gbb+7QxRuleqgWyTq/6IC/suXPrce4q9
         DX/UVorHVzGJOZq2ySjKH+XXvIBcoC6MW0YV9igVlI0JHXdYmUlWZklmvaSbML0daP40
         XoJeu52b4mOVvHFnxuUUUQEqfiem6EHOjJqN0NYn2DS1vKQumD12SbUx6M+Y/Cz2dM0t
         ZGQrMwMKVNJz5fqafE6vQnZ2w1Lba6B5acTiKgi3G1FC+r4SS7NqSPlaAC7nBAQnAPjc
         YeSr7ePBOFPvOB3QAH9gZP+8lKD3ACQVn8e6AOGgRt/CJI+VT54bskp6XrCyZcjI8lrX
         UMYA==
X-Gm-Message-State: AOJu0YwsTwqH5qh8B+oUHZ1yaobhtFeFKYvll1kV6+WeRooki58Hdq17
	kXH9MEHgkuBl9O8z4x3gsf8JP5BOP5ororDzR1II8uUv80nOd/46KLAbtKa3EZ2qwWA=
X-Gm-Gg: AR+sD13QS6eC0jW/83BzwIsziKWeCSSmGBYYxlwyOHAWSiQbO+JDP1wfrNgwxY1laqe
	QdXT5i3Lux5OyAs2wWP4Ew2lvJgegsGleyeS7eXi0y6JqXSUg77zlV9I2PM9HQTj8NCnn7oaXjs
	o0oJ0uzZQODXXy/ymDEcUWAjAq5G77+v2sbMRm9n3yrVvBeq7D5iawad3V1RpvlsixGJrWbP1xa
	BmiMmX8zsxhKYu06hl+NZhqakJs9X2Lq168Puoo6v8a8NjQoZPI8GvY+WdeYJ5DKXPLhjDk8jD5
	xlIoRqejVUyw1+prP6sUQRpOEPlC13NxYFoyKTk4Fe1RCDbdeLyxt+krrpawpV02QMHPJuAbcdH
	pZDCPbw/Je7HeNHRgVMD1vYb/Faoma+5KkOx4DeSoya9TTzZVOjVmVzLFyU20e3nJ7UyKAobd9i
	n7EQ==
X-Received: by 2002:a05:622a:d1:b0:51c:2685:2964 with SMTP id d75a77b69052e-529a86811cemr92228301cf.43.1785167955252;
        Mon, 27 Jul 2026 08:59:15 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a262fa9dsm56944561cf.0.2026.07.27.08.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 08:59:14 -0700 (PDT)
Message-ID: <341eff6e-9acb-43c3-9514-578bb628bf27@riscstar.com>
Date: Mon, 27 Jul 2026 10:59:14 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] PCI/pwrctrl: tc9563: Rename DSP3 to VDSP
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
 <20260725-tc9563-fix-v1-5-ec4286e31331@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260725-tc9563-fix-v1-5-ec4286e31331@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/26 3:59 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> TC9563 Reference Manual calls DSP3 as VDSP (Virtual Downstream Port). Hence
> name it as such to avoid ambiguity.

I didn't really like the overloaded "virtual" term (though maybe
it is normal for PCI).  However I do like that this makes it
clearer that the third downstream port is different from the
first two.

Reviewed-by: Alex Elder <elder@riscstar.com>

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index 28e9ec3e172a..f1179737f221 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -80,7 +80,7 @@ enum tc9563_pwrctrl_ports {
>   	TC9563_USP,
>   	TC9563_DSP1,
>   	TC9563_DSP2,
> -	TC9563_DSP3,
> +	TC9563_VDSP,
>   	TC9563_ETHERNET,
>   	TC9563_MAX
>   };
> @@ -328,8 +328,8 @@ static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl *tc9563,
>   	case TC9563_DSP2:
>   		port_access = 0x8;
>   		break;
> -	case TC9563_DSP3:
> -		dev_dbg(dev, "Tx amplitude tuning not supported for DSP3\n");
> +	case TC9563_VDSP:
> +		dev_dbg(dev, "Tx amplitude tuning not supported for VDSP\n");
>   		return 0;
>   	default:
>   		return -EINVAL;
> @@ -368,8 +368,8 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl *tc9563,
>   		port_access = 0x8;
>   		lane_access = 0x1;
>   		break;
> -	case TC9563_DSP3:
> -		dev_dbg(dev, "DFE tuning not supported for DSP3\n");
> +	case TC9563_VDSP:
> +		dev_dbg(dev, "DFE tuning not supported for VDSP\n");
>   		return 0;
>   	default:
>   		return -EINVAL;
> @@ -612,10 +612,10 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>   			break;
>   
>   		/*
> -		 * The integrated Ethernet MAC Endpoint under DSP3 is a single
> +		 * The integrated Ethernet MAC Endpoint under VDSP is a single
>   		 * device whose functions share the same config registers.
>   		 */
> -		if (port == TC9563_DSP3) {
> +		if (port == TC9563_VDSP) {
>   			struct device_node *eth __free(device_node) =
>   					of_get_next_available_child(child, NULL);
>   			if (eth) {
> 

