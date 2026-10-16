Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5381A48B383
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154049; cv=none; b=U7JIwYQIPDvR/19hH4S7ty5KPbYIFKHqdo6Ez9XTOiF8gxUgxygnR6xIH0Gb5zUbqj7ogF/wb25zuJ/2LgSCDNS1A7W+/PsmxzxcekaEpr8xud1JWpPP83z2Q43IqajnRXYqVWMLK2tukeJFs/y0xJz4F+k49XstmX24w12Po+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154049; c=relaxed/simple;
	bh=hehiMMplNuH1ASVIZKS7JNCOTwicSdsvGPoc5cURypQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BF/LU3bXgvnEDUMcEWtIvxS5p2675gUCwsHMyCDC5U66uu9ecHGYFNQH3OCcLDdLrUeyORKRDlR44UnuVb3dIp2aDdG635Mydg++mMXhxYAvdXm8roDKPFXcwdt73/PPqbML15FQ6QUN/8FZP+u9AMwOj1tjv/KI1ugZz/9WFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rMkvsB+U; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMkvsB+U"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4956869750eso41873025e9.2
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792154046; x=1792758846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZIpyq+qJUC7i4cP+JzTAwJd0/DwOmvkqZRCfLBzvRJc=;
        b=rMkvsB+UIzB2KQ00cNXqaxW8hYzJPBkqYUn/tn3zdeyCfPUkl3V0qEvMsbtR1h6z55
         YBaUC3LDyIJ5wDnZCk2A5uCa4mrqp+ponQ/e4FoHluTXgmpVMz6dOvGrmSGX2zVSqkz4
         Hu4CPzHd9BlDHCeN9QIArFRxW7p8vTPJf84X6gJS+Lvnx9tT4JEGum/p4JvH6GLZaNi9
         lNIe5xVrGHEr7niRJGQEZSB+fGtgF1czLyLoGzkQPfKGdloyl/BsjIOeaYefV8IcdjZQ
         guZL5qo3KSRKnXoMZy8xTsrElD2tuF6Xy+7NVQLnw28qKXPrbaj1Q14CPrIawA/+zkwv
         VomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792154046; x=1792758846;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZIpyq+qJUC7i4cP+JzTAwJd0/DwOmvkqZRCfLBzvRJc=;
        b=cQgvGf54QPdQ3XF2zELXYmhlqNUUGaDhxvEwOoofVlYCHOFbbMG7RJcmHNc6yCL9a0
         Z2VjadwbN/wP8jW0+dfgy3ZtEpgGy6bB6Wx4zC/uu0CxRYZG5IS3hoDqfWhUoUTBZ3k1
         GuG+De4UiRf67S+m9S8ptb4n9ejK687YNNF2MtMj1w34RIq8pPy1GMYDeQhrTHWwJWOl
         jKfhBU7lsCpTQq7vxkTEtQpp/lN7dWp3fsqn2QVqjB0cVkR/UMzCY8oqYcmOGeh4oA4F
         euqtDTn/b6cxBVWWPMuxsxkrBZ9fj1Ka1gsAZ3kEdmSoyfeUJI8tEk8NFAO6XIxY13ds
         WIhw==
X-Forwarded-Encrypted: i=1; AKwUvBxpx/bGjT8jGOPifopnt9WVvi+aNL4CCbRK5TkrQaq6jIwCd5dSgiwwl0aYrsUvG6+kxHYlauNr7yU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKizzuHTPzmrC3LpIMOt56c+nvfC7ln+E0UeWtFMZnrTMiwgkbn
	Fu4ISk1FNRoy2/3Xp4X5YrLco1HxHObuNtgO3H8EK/QKsZlwG8BbpMcfCkJVN9ldp6hBFuQbSZ1
	yVg3u
X-Gm-Gg: AYBFou2Isxgi1Sb9OarkS88QCdvSl2wdbimI3HzT/Uri++LUaMcLPhKpS2Nqd3d/CqI
	X+ACHzugpEHkCFh6LLZ23+dKlz4TCRAacSkchtxB/1l86hJFlQrLCqWLPiSNC6IW+ieB3kHQzAx
	Fh02pI6uA44RPw8jsaaHRel6jd5rHtSXlMb58QKubjta9QSAw1J9ghJjl9vtSkXnUKXH04ikwUx
	kKBfvronhdaKS6bks79r2fXvz5daTRNiyiRmhg5nW1PwZsdW+wZSiirvqlhPZ1t34evnv511vm0
	MUG8ffEx1ecr6IHYKC+7NeoEwibRZJVTNJpoImNIY/ds89HZR5IyB9Rmw1ObyQyRF0CfaAa89oD
	3iGwB5JXYisnnwf7kad3e5nuKpdzXhCid0YIXq1MssPmzxKuUqxic5okT5evXkgQT6woA5OWXNk
	048kszNQ1ufM1L6wVv5PLNxT56QnOoGdiqWDpzYXoX5+t8UWxc/n1sIfsmcQh6uWzmHtI4g1XiB
	ZlzEB0jDTN9emEfvJkisi4QlpJbs1rm+Rj3tokEJvAhByCFS2ekbw==
X-Received: by 2002:a05:600c:3494:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-4a18e4c3f24mr492255685e9.23.1792154046355;
        Fri, 16 Oct 2026 05:34:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:9e08:19eb:ca8a:9b73? ([2a01:e0a:106d:1080:9e08:19eb:ca8a:9b73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5128f1sm4861952f8f.59.2026.10.16.05.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 05:34:05 -0700 (PDT)
Message-ID: <c622efa2-df8b-44de-9552-d2b16159a661@linaro.org>
Date: Fri, 16 Oct 2026 14:34:04 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] PCI: qcom: Advertise hotplug with no command completion
 support
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260314-hotplug-v1-1-96ac87d93867@oss.qualcomm.com>
 <d709693e-b9ad-4d53-a368-67fbb0cbd601@linaro.org>
 <1ae8d4f0-1c32-4dbd-a18e-7a2ce2627efc@oss.qualcomm.com>
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
In-Reply-To: <1ae8d4f0-1c32-4dbd-a18e-7a2ce2627efc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 10/16/26 13:08, Krishna Chaitanya Chundru wrote:
> 
> 
> On 10/16/2026 3:54 PM, Neil Armstrong wrote:
>> Hi,
>>
>> On 3/14/26 02:56, Krishna Chaitanya Chundru wrote:
>>> QCOM PCIe controller advertise hotplug capability in hardware but do not
>>> support hotplug command completion. As a result, the PCI core registers
>>> the pciehp service and issues hotplug commands that never gets completions,
>>> leading to repeated timeout warnings and multi-second delays during boot
>>> and suspend/resume.
>>>
>>> Commit a54db86ddc153 ("PCI: qcom: Do not advertise hotplug capability for
>>> IPs v2.7.0 and v1.9.0") avoided these timeouts by clearing the Hot-Plug
>>> Capability bit entirely, which also disabled all hotplug functionality.
>>>
>>> Instead of disabling hotplug, mark these controllers as not supporting
>>> command completion by setting the No Command Completed Support (NCCS) bit
>>> in the Slot Capabilities register. This prevents the PCI hotplug driver
>>> from waiting for commands completion while still allowing hotplug-related
>>> functionality such as Data Link Layer state change events.
>>
>> I'm a little late to the party, but marking the RC as Hotplus means the bridge
>> is marked as is_pciehp and pci_bridge_d3_possible() returns false.
>>
>> This means this breaks D3Cold support completely since in
>> __pci_host_common_d3cold_possible()
>> we now check all PCI devices, including bridges, and the RC is not set in
>> D3Hot anymore.
>>
>> The only way to enable D3Cold is to pass pcie_port_pm=force to allow D3 on all
>> Hotplug bridges. Which may be wrong on TB bridges.
>>
> Hi Neil,
> can you enable hotplug driver and use this patch [1], that should solve the issue.
> 
> [1]
> https://patch.msgid.link/20260729165005.896725-1-manivannan.sadhasivam@oss.qualcomm.com

Thanks this fixes the issue,

Neil

> 
>> Neil
>>
>>>
>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>> ---
>>>    drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
>>> b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index
>>> 67a16af69ddc75fca1b123e70715e692a91a9135..a2924610f3625f2456a491473c135840e31bafb9
>>> 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -358,7 +358,7 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>>>        dw_pcie_dbi_ro_wr_en(pci);
>>>          val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
>>> -    val &= ~PCI_EXP_SLTCAP_HPC;
>>> +    val |= PCI_EXP_SLTCAP_NCCS;
>>>        writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
>>>          dw_pcie_dbi_ro_wr_dis(pci);
>>>
>>> ---
>>> base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
>>> change-id: 20260313-hotplug-4c296595b5b8
>>>
>>> Best regards,
>>
> 

