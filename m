Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D567395DA9
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245683; cv=none; b=E9UbsK5XLZ9YSTbvdWk/vUmlFPOwhWRv7dPo2gnwAWOh30l8qSSiN3QBJ4wkIxJzM6DKx/Edg44NPDR2pUriO5SRsyFRrrBZXHvIF5VB3o87U2qzKv3ETpWlZq2+8GiL0XZITbT2YyVPARVWKqDvk86zeh31eMupMaJKwAGORuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245683; c=relaxed/simple;
	bh=GNFioT5Go4+A2iCqPdYE4MF6fqEa92pWZK+ljRe2ivk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjmoalP8vXlvAicoN6rFWkdG+fgpZvrWzGvi6bYaaYQN1jSxMWJ8GTzWKik9oGRxtKm/jEbkCqcmSQzuoCmm+H5FbT8U21BDRlg4eGxlsZeq/GP3SuEYy3ugAKWk1pmTmZrlSVLkH4LNxb4Qs5fYjAwv2i3oQDPbsC88w8qZ5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=iyIwyQOP; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="iyIwyQOP"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9309d4ea213so320211285a.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 06:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785245677; x=1785850477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XzGCbFXxJEuGYSs3c0juxd6AOVKDvi6DBrR61H9y/ak=;
        b=iyIwyQOPfrkNqOivvOHtBOKA+b9LKLNLCUukLsmgvodu++4vXsXc/Zq4XEs3AwZNIJ
         oq2FwusW0svmmsgRIHQz0YJpFbjuStd1lnKMlWne/RmpNuHb19zuKC28xd3kWpX6gG+y
         Q/iSXQ4iXbZ1PBu7OjCHOmIHAYBquRB3mk4tvUcIg9KGVeWJdajKvxzO6trwCLxMKAW1
         VMp1uRhkjBiuawpJw0q+iSjkZ0yWr4EmnYsZk56AP9kaMRgrKflpAJ37tJD3At8PzYnH
         jDAm9sroIS7XxwyJ/Ajn+kj/YXEmFfkEbr1ESZlRatEz7YnhIywDrrJb+JF9q5xwhLsM
         HDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785245677; x=1785850477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XzGCbFXxJEuGYSs3c0juxd6AOVKDvi6DBrR61H9y/ak=;
        b=gUf6ksK8nT+OYFgkyfTzcfyok5lKFkyU50cWlqekueKnpAYRMCLuICfD6MFAlVX23M
         xgnEsR45NspjEoenf7lxeP46Z1WJdIxXIyA9VKD9zYyP7BUEIBD4fgq0LBiBzB4zjQcB
         x4+yGQdEmkJDQB0gE2eXNr3O5jL8X1B8BZqMF8Qu0KvWJPCULLXEzObpRm85uIrucUfV
         61q0HebnFQiCFmaNmrCuFyFBsAs9vY8lGPhEpdkpVh0NOTQKTCpeOB2ZKtSnYkPYWo/j
         LBJUmXT41D7xswp01Typ3k7CfGok5OLuOQ5NB8LjSiqTbvkZE35M1/D+UiFwYhuYqZAm
         7kVA==
X-Forwarded-Encrypted: i=1; AHgh+RpE8QcfxHoQZMW9xPkQtEJ0U7k9gAo+1dYacrWibXY+4JHxZobK41VU7X8h9mP5+3PNzVKdYBaN8cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzygGykhOq7Qi2VJNpfxTIh3hg1B66lyhKw0cvHKfbss5UJxSG7
	GLHD6XpnBxeM2VR2F+vYvbR0Ay7lPAgsRXakceZXQs/nJ2WFSMjrWOyZiGyxgvEGDu8=
X-Gm-Gg: AR+sD11FufQpso7yt8ySskEGQLK60JxZvX7tATecSELOAaluQ+t7iQ9yXCyluS1TaDY
	nZOOU9xXswXlwdk+HUfsGnyreQs4xFkoxMLQspfk1ZoOYYu7MfxW0ZOZILMgn/onngKcuEIbciu
	+onjzi3EsJ/KJiveHpGQrY6RzAay+f0mSU1Rm+CGUNGz7v5YHJkl0MBR8YNhqDUZGr9Lc0QbyNC
	CHoGpORXVuRf1/9x+BTj2UHNJXedn1fDWX+1BusgBQKm1pQKWpKLzMCqtjYE+NxmMNrmVa7uDoY
	4jjlji67mgg4XxHZduhBYkTi7PV4tJyXQYjiKppcTlB+slqHguZsjkukRHuPjo4mcRX61b5umyh
	jhgsNpjFcAYHV1KOqgmmvQfqINSxtBRhtlLFc+BtAUqjnwvJqbwAaFSAe4ILm97GXKTPc1XBVb8
	SzlaFJfPJmrjmWFuxB3FIbyAVAXskmp01/2GaHHD0zFhKalV6VPArr0lKAP3VY
X-Received: by 2002:a05:620a:4693:b0:92e:e2fc:26d3 with SMTP id af79cd13be357-9330272f6b0mr228855185a.46.1785245677388;
        Tue, 28 Jul 2026 06:34:37 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de6523c4sm844235885a.34.2026.07.28.06.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 06:34:36 -0700 (PDT)
Message-ID: <9b7cc38c-83d0-48fb-9282-b8c8efd2ae21@riscstar.com>
Date: Tue, 28 Jul 2026 08:34:34 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] PCI/pwrctrl: tc9563: Skip Tx amplitude and DFE tuning
 for DSP3
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-4-ec4286e31331@oss.qualcomm.com>
 <f9937e7b-746c-486b-b94f-fb3b34a2b0d0@riscstar.com>
 <oefxm7olagbd3dby2npgly7ausiz3g6cvls5igaxdzvlbr3wrv@rjlfebi2p36j>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <oefxm7olagbd3dby2npgly7ausiz3g6cvls5igaxdzvlbr3wrv@rjlfebi2p36j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/26 8:25 AM, Manivannan Sadhasivam wrote:
> On Mon, Jul 27, 2026 at 10:59:11AM -0500, Alex Elder wrote:
>> On 7/25/26 3:59 AM, Manivannan Sadhasivam via B4 Relay wrote:
>>> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>
>>> DSP3 doesn't support tuning Tx amplitude and DFE settings. So just skip
>>> the setting if DT has passed the tuning properties. There is no need to
>>> error out the whole driver because of it.
>>>
>>> Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>
>> So to keep things simple, tc9563_pwrctrl_parse_device_dt() is called
>> for all downstream ports but you ignore the setting (with a warning)
>> for those that do not apply to DSP3.
>>
>> What about tc9563_pwrctrl_set_nfts()?
>>
> 
> Good catch! I missed adding the check for N_FTS as well:

In case you need it:

Reviewed-by: Alex Elder <elder@riscstar.com>

> 
> ```
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index 9d869483b6b3..978907aa0ce5 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -410,11 +410,17 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
>                  {TC9563_NFTS_2_5_GT, nfts[0]},
>                  {TC9563_NFTS_5_GT, nfts[1]},
>          };
> +       struct device *dev = tc9563->pwrctrl.dev;
>          int ret;
> 
>          if (!nfts[0])
>                  return 0;
> 
> +       if (port == TC9563_VDSP) {
> +               dev_dbg(dev, "N_FTS tuning not supported for VDSP\n");
> +               return 0;
> +       }
> +
>          ret =  tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_PORT_SELECT,
>                                          BIT(port));
>          if (ret)
> ```
> 
> @Bjorn: Could you please amend the above diff with this commit?
> 
> - Mani
> 

