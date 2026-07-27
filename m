Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407141D642
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167952; cv=none; b=QT8/KnOoXkxWkCT/tkBei0kp3oeqko3dzTDo8nQz72f1cPZ2V8cuGNVZM3L6dOSzVxXbSkOS+byRBvXRMHvoZUUP8Ys75yVZ4zjAd4EfGrFDZ8tDUbDeFsWAo5yGvI35N4i68NY3n6mP1Dh7O0TPVNtgQOLuAIrqKk66yzvvH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167952; c=relaxed/simple;
	bh=RPvzmBUvGUDgoK8qi8BU9CzoCvJCoYIwfvAGLDgTQwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5+dpSuTkq4YsUyYCV/v60OeCI1gjdDtoww2Wd2+y5c45yCVGE1I95oRMDMopA+Gl+rydeV6A240MMX6RZkT4feG3iLL9QlBmtp8OvxzJ7FzF2R2ViFemF31OmuqisCe3aGjfuagWQgmqVyGtmEpzqEKRAdRLpNBoA59eWePfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Y/amVQbb; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Y/amVQbb"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51bfad59921so21663141cf.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785167949; x=1785772749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eI+pv0AMxILlggFrEFkkHRcxF3WFLsvXTsHBUr1TQj8=;
        b=Y/amVQbbNCfBvpHYl6W41jy5EdjHPzeJi4ZGcvPOO/A1IeVUTDO/I3VXabpZa9cvje
         QlI3AjYqFqzkbJwlbVMxqdpBxaNytlk09yjUXNhHQOWjj/gSAC3zARfGqbkfbRWQvLwV
         9xZcRzK7PUNM8JB7egV1zKeobPziGi0IEiG+gv/M69zlz8XszhkGQM+n6fxagKmrtfy/
         ULKXXXTPEprWvpQ65NtzGqxREe3BplkhnlxOtJAdN79NOrO3O1chE6SJUKvAtuUBJxU8
         9+etck6V1UZilQoFC0WM94OIxKPxnFVbX0Zo5BMyffiVKBVH5obHm44JgMVyCcB94ubr
         nGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167949; x=1785772749;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eI+pv0AMxILlggFrEFkkHRcxF3WFLsvXTsHBUr1TQj8=;
        b=GSlJEfHShezGCCkMlrElpkXzdP57ogu6cMd1lxuFVB6Aq5uGOeIFiSD/bWkg7P5xi0
         VyuWkxL3jCXUheKOsUpwvx4Txnxc2YprJ4SNyarNjnig2Y4uLW8sIbUhBLoB+R4mtK5i
         ZHt0lcf3FMSSbViV/UCF2vN5OApCrXWq5aHLIYy0epA1IRn4cgBSP+mV0yEJek+lOG5u
         37VZFELW/ACfRLjvrNugEGCwsr8gwk+cz6sloIywnQJ49NMyJkznfSDODG7RErVeENsx
         QK9Gi60xzneidjJyFhQQTmVdVs7H7unD9e6z+4HWXUePM5/mhYmZwoyqfn+PWeNaFQFE
         OlQA==
X-Gm-Message-State: AOJu0YxolEVtSiE+aFT3CZMRA/Y6PZH+tNVprwZfpZAYGUo9pJCEDMQN
	4Re1lGhpRqiHVGUfXwDDZ5bdSDxzwW5JVDHF14qaAZ33o8XGneXspwAXc278KI43IIq7Sx0gHsL
	HJTgmdh0=
X-Gm-Gg: AR+sD12WdLnWjDvIYamhyOSLX8kV14RBr9neWQUTo/uI/tvECNjpi9AKtFm9w1S3FeV
	K35kynXKoAMOzCjmMgwEftobYJ/p8nzPBKb3Rwh5wtsW/eogv0XJwNTTBek8t13aYT+sG00l8jZ
	7VijpAgJnnG7WqsjVWAC/JJh35hz3nv3qKSrlTLVBl7IoMK5YFJv+7Qj4sFTQDfk7XcXLb4fAh7
	Rrgrzg2UgCC5vXLMVu/PAKSF5nSVd07gAr9Xt2PH4K0U0mE8b93b2r5SRurmUKnmPqWiXN0gU+B
	5GFuSS5/0x7MZfzsH4lCOyOyKmLY+lb3eAKTJS15gHjvwpN6vlVssTzeH7xgNJywCsrWRcwLYf8
	bm8Ox9YQRTc7bXUWM71F/pm7SY/GLgVxbrdQX/L503nlRzPs3Qxp4jtkHZ6cQHg8JxkFqXctIi1
	8HyQ==
X-Received: by 2002:a05:622a:559a:b0:528:3ae6:14b1 with SMTP id d75a77b69052e-529d1c4c98fmr673601cf.43.1785167949589;
        Mon, 27 Jul 2026 08:59:09 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a262fa9dsm56944561cf.0.2026.07.27.08.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 08:59:09 -0700 (PDT)
Message-ID: <f210077c-a868-4cdb-98fc-39e6fd715085@riscstar.com>
Date: Mon, 27 Jul 2026 10:59:08 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] PCI/pwrctrl: tc9563: Power off only the external
 ports in tc9563_pwrctrl_disable_port()
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
 <20260725-tc9563-fix-v1-3-ec4286e31331@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260725-tc9563-fix-v1-3-ec4286e31331@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/26 3:59 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> TC9563 supports powering off only the external facing ports like DSP1 and
> DSP2. It is not recommended to power off USP and DSP3 as they have fixed
> ports/endpoint connected.
> 
> Hence, fix tc9563_pwrctrl_disable_port() to power off only DSP1 and DSP2.
> 
> Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

This is very nice and makes that function a little less
confusing...

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index 482e82e433dd..ca19bf60d290 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -241,12 +241,18 @@ static int tc9563_pwrctrl_disable_port(struct tc9563_pwrctrl *tc9563,
>   	if (!cfg->disable_port)
>   		return 0;
>   
> -	if (port == TC9563_DSP1) {
> +	switch (port) {
> +	case TC9563_DSP1:
>   		seq = dsp1_pwroff_seq;
>   		len = ARRAY_SIZE(dsp1_pwroff_seq);
> -	} else {
> +		break;
> +	case TC9563_DSP2:
>   		seq = dsp2_pwroff_seq;
>   		len = ARRAY_SIZE(dsp2_pwroff_seq);
> +		break;
> +	default:
> +		/* Only external downstream ports DSP1/DSP2 can be powered off */
> +		return 0;
>   	}
>   
>   	ret = tc9563_pwrctrl_i2c_bulk_write(tc9563->client, seq, len);
> 

