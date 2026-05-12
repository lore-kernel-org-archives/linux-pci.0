Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC49383304;
	Tue, 12 May 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580479; cv=none; b=SWRt15mpw1P1IuzIOXh9W6RxlZVj5do7XuZRLFVADw8sjKriD9GW/kRX+5sD1N/KBJov/VDrnTsr9QDgXXqlk++Lzk5yZ5AiIgNcrN0YW8uVuzWPPLaVO4HNuWZPbf34S2adFT+8PdGURWhZpL0WNrYpKjn1xzAyt55mWXqh5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580479; c=relaxed/simple;
	bh=eQ9jfRVoFQSsfWSxqwqwQP+2I8qoE/A3eF1LrMm6Hls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j888roYU/yuA2+nyqkzgvXq8W6VZnt6QXVJWRBfjBSJjH+iY1VxyDnhFjEYYbohppL36T4fjcVP7DjDrpxz4XQow/ydoOeLbQLD0j4g2k8IXrKihN6scrtY/clyHtQDzWQTJYf/SAJfaoVIp6X3NdHY1p/NVBv61fTOLEPpx3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l11nVtHh; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l11nVtHh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=rq4RL+Vka9BqWTh+n74cXJ8jiIkAjFYQA9ezbcVKwM8=;
	b=l11nVtHhS05LPBjraPnJUV3epcd49eg7vnfCSTy3DkvxfB/Iem6EvnQ4JrZ+O3
	BhcY7irXVFlck61xjPG4X8Hus9w0cfkoycqGiyCMqQ/WFdniOD93FdgJ9AxJeoGe
	dVHmA2apbi2ME13a7dgimnGQ49LaIn7Vkbs2WArMTitJE=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3yRC0+wJqHlnODQ--.89S2;
	Tue, 12 May 2026 18:06:46 +0800 (CST)
Message-ID: <a28b7442-8bd6-4a05-8864-af6c0ad35a2c@163.com>
Date: Tue, 12 May 2026 18:06:44 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] PCI: dwc: Use common
 pci_host_common_link_train_delay() helper
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, mani@kernel.org,
 vigneshr@ti.com, jingoohan1@gmail.com, thomas.petazzoni@bootlin.com,
 pali@kernel.org, ryder.lee@mediatek.com, claudiu.beznea.uj@bp.renesas.com,
 mpillai@cadence.com, robh@kernel.org, s-vadapalli@ti.com,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 claudiu.beznea@tuxon.dev, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260511055923.37117-1-18255117159@163.com>
 <20260511055923.37117-5-18255117159@163.com>
 <20260511070139.GA1096586@rocinante>
 <e600d0a4-b93e-425f-a5f1-c76802c65622@163.com>
 <20260512071328.GA3606279@rocinante>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260512071328.GA3606279@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgB3yRC0+wJqHlnODQ--.89S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr47XFW5ZryfKF15WryDWrg_yoWxuFg_u3
	y8Awn7ur43XF93WwsIyrn8XFnxX34DuFWFqry0vrW2gw1jga1qyrsIgFs5ta1xC3y7JF47
	JF1vkw1xKwn3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjeT5PUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xZH6moC+7ZuEQAA3K



On 5/12/26 15:14, Krzysztof Wilczyński wrote:
> Hello,
> 
>>>> -	/*
>>>> -	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
>>>> -	 * speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
>>>> -	 * after Link training completes before sending a Configuration Request.
>>>> -	 */
>>>> -	if (pci->max_link_speed > 2)
>>>> -		msleep(PCIE_RESET_CONFIG_WAIT_MS);
>>>> +	pci_host_common_link_train_delay(pci->max_link_speed);
>>>
>>> This comment could move to the helper you added.
>>
>> Hi Krzysztof,
>>
>> Will add.
> 
> No need.  Per Mani's feedback about macro being well documented.
> 

Hi Krzysztof,

Okay.

Best regards,
Hans

> Thank you nonetheless!
> 
> 	Krzysztof

