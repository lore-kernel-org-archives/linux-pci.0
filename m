Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455D408626
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687344; cv=none; b=kok0OHGDGfNvQLBrkBJInlwgG2AEsW89EwquGMy0VH4n3t90n6MCNK+9QC992J1REUqu/HMmfqAYlFe2LUuIy4Jg8eIncplllZQCcSkbT80Fvox8fjVk78QONtndGa2b3CmM6tm+/QBqxmzHClUGTF0Rtzlz2B7ZltXlUmCkshY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687344; c=relaxed/simple;
	bh=DWmNJ5lwsL10oKYuxQDPlcDGajEHoML1G3ab68pBqgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UK+AAwqjgejRG/O+ZlCihNPAEKeK/PzwVGc++OdkqKuyGDkvFC3ai/TQaluce87YE+obao20dTIdk4X3t++FFvTeNzUWe4tff/fpAbBxidYNAZukapwi+Eg/tS4LvHhHUAnbZ9h3x7qY4fG88oPePq8yc+z2u8ZwAC1AbPiJu4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=leUELaFJ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="leUELaFJ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so5713006d6.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783687342; x=1784292142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YJBwqL8OFuvpdmiP4qvFBor8YyEfp6aV/aiB/sY0dm4=;
        b=leUELaFJsmYR/5cwOTvjTdqjN1E7PxME7EZSem7Z3OlLTDdGVgwLg3PpDAIIp3eEHA
         eZ7YRp6SRFXHf4ucsGXYzxP9NeIzLJqVg95cfbjHOuPdseDQj8hmSDKYFzgwOIYdnCGp
         QFJXEg05+NcLTnNM/Xz0cQo70DITUBBm/TLhGuAL2x+EC8N5bbif6egQP7I3xjNRqnMh
         SCeNrCiXPcVghmp6sUXtyClzlssNkxeIrJDxDKm8+89YJEfhmZ1eoo04TydPZ49Bwc8g
         +Kbd77uB/aK3ry7t/93JAXTw07o6kvIMnnAYe6mjz5WF6KUkcxzILwsA76HpH9mzP+N6
         +4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783687342; x=1784292142;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YJBwqL8OFuvpdmiP4qvFBor8YyEfp6aV/aiB/sY0dm4=;
        b=EYf8AvHGmEPmWHZ5lWVN+GAjsObRXPFRN4+bemMUyyW2x1YW0GFiBaPOFL4HTB7CJQ
         m/F2Dxx7cVGz6TQBNWRbUcQD/UHS6fgrIrZbqB6f0mFtiLGKzLT+vsY2HJlk1/D/ER/Z
         iCIKtbiJqplGBqX+oNfGHPMI7sjW9KGmhhle++kvd/pLyUG9dlpLIyNh/7crepyqixNZ
         m8+Mn4PPgBP8O6zgCPXTTD2xKu9zVi8QSDFKkiyeJcJrGbbPiXcHduXvHugzUCCbQOPy
         A3IlKET0sFtB1w7IqqgoFEtimMC53upYaTihf/lfQk8z7sl3ogEjDL0uTGBGR4SYrgJS
         XBeg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5IF2XmaxJwgAaLVwpwoBwLtZwQRr/JZpsN3+F7uFhxtpRzRWO13/Cqv1cfKUxOdT4ubhVKxVh99A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9DmHDRsdubQVlpyc/5eDbp40K4cK8hN7RJfU8NEZE4K4Yb4qa
	6qCkZtehYLfD0JXdjQ6ElABB7zy0KPk3BxSEDkLtQYfRDSRoKXz5BYhGMJaKmbf1Oe8=
X-Gm-Gg: AfdE7cnNgU96QOiCB70OPsHkq54fkoBw/DUOJlDgTf6ufmwIidlpLdPgtIlQpmHUskY
	Y4/C2Tx5MmFo0VpqHReEBGGu3FcQSYiAT8qOOWNKVhSIywjpDFZQjZ6pqZII/450fA67OuGdurL
	2XF/8iV2s3CLjplbsKWIi+oU3k1LX3V0q+ppjN/ffxiLkXqYGWESsX2aVjIyEhrpm68pfFMHNTU
	Iv+4sPaFVRflWhnG8ZUqSCUImrZaODbwWrk6cC1Em4P3lqNc/ySYO8V/dHN9MqxiAnvTbi5bOIx
	YRUh0EEH8e5Peqk8y75AnsUSHPdiAEckyb3lIFV/AA7flxJaSpMr6DFx4Avfo+em/efeyQbRBfY
	0m2TdPJ0Z3CGnJUNBjp1R8ppwIm9Vp3LStlPUxRRCpUCCVLVGbDHw2ZicU60ypN76CuEjiXe8Fv
	tSV/N81TG6XpTw
X-Received: by 2002:a05:6214:5704:b0:8e9:f5de:d5b5 with SMTP id 6a1803df08f44-8fec3a038a2mr127470696d6.44.1783687341764;
        Fri, 10 Jul 2026 05:42:21 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d22bsm40069556d6.32.2026.07.10.05.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 05:42:21 -0700 (PDT)
Message-ID: <3cece33f-375f-4cb2-b07d-e75f065fe5ea@riscstar.com>
Date: Fri, 10 Jul 2026 07:42:18 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] PCI: spacemit-k1: Add multiple PHY handles support
To: Inochi Amaoto <inochiama@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Christian Bruel <christian.bruel@foss.st.com>, Frank Li <Frank.Li@nxp.com>,
 Nam Cao <namcao@linutronix.de>, Qiang Yu <qiang.yu@oss.qualcomm.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Xincheng Zhang <zhangxincheng@ultrarisc.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Vidya Sagar <vidyas@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-3-inochiama@gmail.com>
 <ak9KzNFF26B0Kttz@ashevche-desk.local> <alBNXgMAwXPKwiJ2@inochi.infowork>
 <alCoTEDUY8AO9OzD@ashevche-desk.local> <alDNlfb0_T9g-ATO@inochi.infowork>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <alDNlfb0_T9g-ATO@inochi.infowork>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/26 5:55 AM, Inochi Amaoto wrote:
>>>>> +	k1->phy_count = i;
>>>>> +	if (k1->phy_count == 0)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	return 0;
>>>> This doesn't seem correct to me, I would expect phy_count to be assigned only
>>>> when it's valid. (Yes, perhaps 0 is the same as it was, but semantically it's
>>>> different 0 in this case.)
>>> I guess you think 0 is a valid number? I can not understand what you thing
>>> Assign this to 0 if there is no phy is fine to me, which shows there is 0
>>> vaild phy found.
>> Isn't it already 0? Semantically code is wrong in a flow (not in the result).
>>
> In fact it is already 0 here. But I am not understand why you thing is wrong.
> Could you explain it in detail? (Maybe you think it is not good to return
> -EINVAL?)

What Andy is saying is that assigning the value of phy_count
before checking that it is valid is not the expected order of
things.

The point is about best practice, not about the end result.

Best practice would be "don't touch anything if the return
value will indicate an error."

And therefore, better coding practice would be to check for
a bad value, and only after that has been done should you
assign the k1->phy_count value.

					-Alex
