Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EEB2DA76A
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861282; cv=none; b=N9cR01l2KPT/7wYhaSvIKrSVE5NUUCaVzuIFJwmcz+ma+tjolbwpO/d2w+jAwPv2N0Z4/DjW3uzz+Ny8vbUa1U8nkRLfyCr1UEDwCmxl/yQpk+JGkXWSACCPDv7Wxd2w8Iu2vVDw0MPTL5+QkibOti+4pyQh/xNuprNXs8NIfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861282; c=relaxed/simple;
	bh=hPru58oWwU9otMvcO3a67mvX+0gv3ropSQ062zAqvsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eV6ELVnQgocF0dymlW0LUNzx9AjcthbVp+8mu9JQImq/wLxg+xBZj4Pyiz2Kf2nFFlPyVT5dwnsbPeJeNpFQIF+g2Zsqgj6xENYUq+zClGLhPnscmAqhBmQKQIYzgQPMo6nvOOwqft2fA+BA6J8hx2hjFV+sfBw1IhJ8QAuTy6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIyCECSw; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIyCECSw"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1279eced0b9so3865141c88.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 15:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775861280; x=1776466080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QTxNYnizVQS5DoTeHSomY7vjG5MdvS+/woov2XbZ558=;
        b=VIyCECSwvhO+ox4ANOpY96zpCb7Y3XoaIA1QVDuz5jKU9ja8E8qGefGPk4S8eOXTyx
         1ADUHufXqbinPWPbDtrfiZzpS7r58bIYFXGN2hnnL9/lmW0JHk/7MER/CkjWZPY9gN4c
         vAMM5cPP61pq44LxZ2ydHzDy5UAQoFY/wE+yuOsLYsSoXjmn32eK+BL/xPi0PDGzQ6H+
         3OLppRTZtnHUZydciHF0I1M4DjovSqvUaxdgwWBU5lNdLZvVv6VgoV+caE6Kglxt4uL8
         j1PWpe2BtxVCJe4LwWf+zMk+ap/HwqgGpaO3uhWXGPwG9kydVvk7rczgRHRUXVWF7XYN
         mWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861280; x=1776466080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTxNYnizVQS5DoTeHSomY7vjG5MdvS+/woov2XbZ558=;
        b=SIwn5Nyt0N7RZFGCQFegYair2i4ETM9+p/OyNIF/Y5kurxXP5Stc7kGg4e8CCmE3Cd
         V6gLN/LDisN4f6CsKEf9UJVr9a6gb0AMU63RgsmTfYpOqEsdngyuhyr1R+ieLzdXqtBm
         W8+zbPVlEel72zKtqPf71+ejLlyjq3OThDAguKDRXM6g7Fhvtii4YvX3xyKLYXXaXr7E
         NUop95C+dOz+ltXQ6jocQpk2old90sCQUayGg7Fw8zLtdHnEIwgim5dh1Jkmy+oEpC0B
         mKcojG7mazzruJ2yTi8faYCaJ10QlKkQT2yMoR8WnDKMm774mhR6mJlKpsJeKhdjInjn
         h7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUt1ji0XlRmRlAbX73xfNFSTpTKGWQIBe81OLmGHKlU+mu2rhrhPN35v5ciocob+yzidXPpd2FmCLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6xfId1+Ivn1c+TCywBkl5iSxMI23Q/NTrTMwq/16C8VyZBSf
	zNBs/PVzjTEO+SpEdue2ww2a2IGt29Zyw+l67sOAWVhkNDUZoyY9SpT/hZxCpQ==
X-Gm-Gg: AeBDieuIJDbGJZjPRbvPGHetpLRS9pDs+3vYnPB96qM8RA46m+uWsAxvZCTg7NxJkV6
	P35Yyuyakbq2welN36bvJLV66VGBdhBRfxjwgMGrylrf6GM64Auon8fdf13x8ABYkAZPcUL8uJ6
	AOh1dA3mFHw8uTqKbuuW64JsHcnK7vB6dkYGbZfOIIg53pxUgxHu9n/fkJteV1rgfoIY6X4q2L1
	W0Tzx3HPZxbyHQvo807mZH7K9YN6o0HnW7cvlGaKgUwJ7CUO5bDH/c7fid2ACnrS1UqPTYbbWJb
	ZNTtY06W/AB/EYDz0cAky0SBHFPln82oXxsngpZorf3NMCY/qVCItrxf6cUDn9rEzmrrfGA8qMu
	vE1RQDfvTTnAtBYnA8tfReCvJbDz5Qbr/Y1pw2ijtLXOXu+LF+JRmPNfGw5dpW4JkiPHxBQR0J5
	q/pAv8/Y3cum75a03fMvpxqyuNkmMyC/QojyXX5Enc
X-Received: by 2002:a05:7300:6d03:b0:2d2:fe3e:b763 with SMTP id 5a478bee46e88-2d589462e7bmr2955704eec.22.1775861279883;
        Fri, 10 Apr 2026 15:47:59 -0700 (PDT)
Received: from [192.168.86.23] ([136.25.189.61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2a4esm7957243eec.16.2026.04.10.15.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 15:47:59 -0700 (PDT)
Message-ID: <ee233885-fff7-4591-92d9-c976ed0b8b08@gmail.com>
Date: Fri, 10 Apr 2026 15:47:58 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] misc: pci_endpoint_test: validate BAR index in
 doorbell test
To: Koichiro Den <den@valinux.co.jp>, carlos.bilbao@kernel.org
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, bilbao@vt.edu
References: <20260404012002.111873-1-carlos.bilbao@kernel.org>
 <20260404012002.111873-2-carlos.bilbao@kernel.org>
 <bqqpugb2vhp7pia4pptktnv2ky6briu6lgvlnmvtopdx3nqq63@hgdapwdihxe4>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <bqqpugb2vhp7pia4pptktnv2ky6briu6lgvlnmvtopdx3nqq63@hgdapwdihxe4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 4/6/26 09:39, Koichiro Den wrote:
> On Fri, Apr 03, 2026 at 06:20:01PM -0700, carlos.bilbao@kernel.org wrote:
>> From: Carlos Bilbao <carlos.bilbao@kernel.org>
>>
>> pci_endpoint_test_doorbell() reads the BAR number directly from an endpoint
>> test register and uses it as an index into test->bar[] without bounds
>> checking. Since the value is a raw u32 from device MMIO, any value is
>> possible and if greater than or equal to PCI_STD_NUM_BARS the access goes
>> out of bounds.
>>
>> Add a bounds check before dereferencing test->bar[bar].
>>
>> Fixes: eefb83790a0d ("misc: pci_endpoint_test: Add doorbell test case")
>> Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
>> ---
>>   drivers/misc/pci_endpoint_test.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>> index 74ab5b5b9011..276bed3f1c18 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -1089,6 +1089,11 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
>>   	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
>>   
>>   	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
>> +	if (bar >= PCI_STD_NUM_BARS) {
>> +		dev_err(dev, "BAR %u reported by endpoint out of range [0, %u]\n",
>> +			bar, PCI_STD_NUM_BARS - 1);
>> +		return -EINVAL;
>> +	}
> Hi,
>
> On the EP-side (pci-epf-test.c), doorbell_bar is set to NO_BAR or a valid BAR
> number in the range 0..(PCI_STD_NUM_BARS-1), so if we add such a safeguard here,
> we might as well handle NO_BAR explicitly.
>
> That said, I'm not sure this check is really needed. At this point
> COMMAND_ENABLE_DOORBELL should have succeeded, so bar is expected to always be
> within the valid range. Whether such defensive checks are desirable probably
> depends on the maintainers' preference. In any case, I don't think a Fixes tag
> is appropriate here.
>
> Also, even if the intention is also to guard against an "all 1's" value scenario
> on errors, then I think it might be better to handle that in a more centralized
> way, since the same concern would apply to other similar reads as well.


Thanks for the feedback. I'll send a v2 with changes here to handle bar
< BAR_0 as well as dropping the Fixes tag.


>
> Best regards,
> Koichiro
>
>>   
>>   	writel(data, test->bar[bar] + addr);
>>   
>> -- 
>> 2.43.0
>>
>>

Thanks,

Carlos

