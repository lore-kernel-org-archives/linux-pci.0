Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2943DA7C6
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589970; cv=none; b=oBXgrrAOofmlAVfJ5u4Xak26A7u7sKpBAScZAGBlhTuTEZCkg7HAh48EvlEx66h/uHkrf4bHc8GG04sQ4RZBzHYNPafdukczn5O/2zNjwKcDH1d2S1bmJhCoqwT3+YguWhIcxR8W8uWKdiIJf8v6R7RlWJvcJLZzzXYy/q80lkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589970; c=relaxed/simple;
	bh=t40aBcgGV57bL2flENf/wilglZ3GkLTHBo5a64S6uhs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=vC0v5TVhTYcsShX8D5etJWtPKMESYmE2/mwBrxyJpeDbyXmFUyKBBMyRNzsoR0m8QBy7m7zyoEA22/PTEYjLhDLjIGJJSZgaOBo6Udl8igA4CedpIVd4Bw+5NtLuJSGWeHCNxgXsdTpgR5ZtsvSEwHulzDxL9fQ7JwSBoYx2o0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mUYLPD1a; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUYLPD1a"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b613a17bso37405525e9.3
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 23:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781589966; x=1782194766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3BJdilVoM5GU6RaftGRrjnToveeVu99NI9zfibDhTk=;
        b=mUYLPD1as7/xd1TAbCo6rBhFsYFQFPB/ObLaj0MWB5p0RQVFjjDWAdGQEMYgTAXaYW
         A+8XtoSL4kT9ElNQxddPqWmLx8fu+BVbG+3kEX6nytfDIizRtBDRUxWc02Ml6XRqK9+7
         QjLtRLB3r0csnqUzAMj531SRKtuXValpTA2FoSP8shdkE9CYnvWZqH6wT/ayq4mviuI1
         rvrA4hvd/4jKE8M6XXtKJzfNby8Am/KbNxxov4MbdzO2cP4n3s3Ac+dBOaKxQDLbpDJ1
         hDloNRdhbRp5SBaXLGG3QotQAAby8ckv7nY0eyANCGMjZbANlBLcqQlYtO6Q+V6r1rVT
         2LbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781589966; x=1782194766;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3BJdilVoM5GU6RaftGRrjnToveeVu99NI9zfibDhTk=;
        b=SMZXDeYvWRfC6ICsLitDQnaACF58RtPKeRb18g64iMbKFiiivBovRErQjZj1hCutVj
         wps6nOOqQ+bM3OJQgVTwZ/am4EqVBISQfYZ0oQ6Ry133L887b+rWWc/mS/XOSDypJmVs
         2m1nbCm7j5/ctecIwyKd0Rj63Sa/aQRKsqKTX/GkwbC5p+6MOCu2ln7ONgp+01JvVDMf
         rWFliBnBWUih+rBkCHfzPxYwj+oUPfEzYBWq9yqanmB1e3BS+hUooMvVf85DWz3ONt4Y
         vKfo41zBdQACuLnojEXfupz7fvynR0x/yMIyOKPRsMAXuovHljQf5pMXJ2N1eSUMpgkt
         L8Kg==
X-Forwarded-Encrypted: i=1; AFNElJ/nFmBmJJpGx/SxQWPzLHTAVc8J8fi8uDpLJBl1wdaSvGPd86eMh0osJfjhqqUfiTdKEYMnkOfFosY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4EliDupF/dF2H31+Jcz24lBq6YPHXwKXwg0oIMGcmwLURAk9
	JBmSaGLdKv4uAK0oxKbqDQHBemH/rw+wpq0SA9rBG5XftxcmO/VtnYtHWFzqbj1bx28=
X-Gm-Gg: Acq92OEh7EYGLVZ/AwPlXfE1zVWpKwBRtCw08yvUnLOqean/yasYH/vL/T/RcBG6EYR
	azPtMx7X8X6g8Bnfk6r56o04G8Y1kJV67yDnUtp4viQljh4EhiBncfCLr08c7AlpaER5h1j890z
	aaM6773qwzeBPndZlYBMuciS/eNH0Nn+hyXYU8hshTQqd8o8UoesVEMJ2hi1OfVP2ZWzMA977pt
	gj11wevzbH1yuwimylZ2XEhtA6+IfwOKwRQlqJ7xOgBUTHWVwuoMpAImVbKGlM7qsp0tWEUQXf7
	EZrpl2Is2lAijkWPAIpM99lgpTRp94vnVu415eQfA4McD0VJmptZB8041RytgU0SuXonVwXPkoZ
	KndsnV9h+vUGd7dQ76jaazZf7edBwd60MaDQG/d40JE7pKYmvqH7kfq6vtPTR5HTeRG/dv/Oi/Y
	865kcCmSdBjUqUPQvGdN785wSNCxmhHO/P
X-Received: by 2002:a05:600c:46cf:b0:490:b6a4:9f43 with SMTP id 5b1f17b1804b1-4922ff8ee49mr30603825e9.7.1781589964995;
        Mon, 15 Jun 2026 23:06:04 -0700 (PDT)
Received: from [172.20.10.3] ([37.167.70.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa891acsm51925935e9.9.2026.06.15.23.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 23:06:04 -0700 (PDT)
Message-ID: <b2d8cb85-5529-4a4c-a233-64ca7a436f0b@linaro.org>
Date: Tue, 16 Jun 2026 08:06:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] PCI: meson: Fix PERST# timing by asserting reset before
 LTSSM enable
To: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Gowtham Kudupudi <gowtham@ferryfair.com>
Cc: robh@kernel.org, bhelgaas@google.com, khilman@baylibre.com,
 jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
 linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 yue.wang@Amlogic.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org
References: <20260614015620.20432-1-gowtham@ferryfair.com>
 <84cc8b0c-da06-4d01-a076-9743c29c91f6@aliel.fr>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <84cc8b0c-da06-4d01-a076-9743c29c91f6@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/26 12:34, Ronald Claveau wrote:
> On 6/14/26 3:56 AM, Gowtham Kudupudi wrote:
>> On warm reboot, the PCIe controller's LTSSM starts link training
>> immediately if PERST# is already deasserted from the previous boot.
>> The driver then pulses PERST# for only 500us, which is too short to
>> properly reset the endpoint device that has already started training.
>>
>> Fix by moving the PERST# assert/deassert pulse BEFORE enabling LTSSM,
>> so the endpoint gets a clean reset cycle before link training begins.
>>
>> This was found on Amlogic G12B (A311D) with NVMe on an M.2 slot.
>> Cold boot worked because POR held PERST# low; warm reboot did not.
>> The fix was confirmed on a Banana Pi CM4 with Waveshare IO base board.
>>
>> Signed-off-by: Gowtham Kudupudi <gowtham@ferryfair.com>
>> ---
>>   drivers/pci/controller/dwc/pci-meson.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
>> index 5f8e2f4b3c12..3a7e9f1d5b8c 100644
>> --- a/drivers/pci/controller/dwc/pci-meson.c
>> +++ b/drivers/pci/controller/dwc/pci-meson.c
>> @@ -310,8 +310,8 @@ static int meson_pcie_start_link(struct dw_pcie *pci)
>>   {
>>   	struct meson_pcie *mp = to_meson_pcie(pci);
>>   
>> +	meson_pcie_assert_reset(mp);
>>   	meson_pcie_ltssm_enable(mp);
>> -	meson_pcie_assert_reset(mp);

I think this change is valid, other controllers resets PERST
in the host init callback, so either this or move to the
init callback.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

>>   
>>   	return 0;
>>   }
> 
> Hi Gowtham,
> 
> I have a patch [1] that I haven't submitted yet.
> This might be related to your issue, what do you think ?

Ronald, This fix is valid, it's definitely better to probe the
driver with PERST asserted, please send it.

Neil

> 
> [1] https://github.com/rclaveau-tech/linux-khadas/commit/bee0a02d9756
> 

