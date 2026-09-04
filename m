Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139714E66A3;
	Fri,  4 Sep 2026 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540143; cv=none; b=t9fMYLvWxs482nC0R/6GR6MKDqI6FnD+/pO4iP/meZka4fix7hqtjmJ7sMYXuL78+ab1Ok+UOXrxbgD/bFYdVo0OBYcMinjlZkuZ7YnjnUnuaNN6/knmzIiDwqRQoxswiGoyJpChadED6JCflR/0lKUjylF9oMRX9AhfGWi7Ydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540143; c=relaxed/simple;
	bh=Y3hc/EJGg+jiVVBGRRnBPDNC8fwbBB/4it+Ybe/bNz0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f5x8vb69jAcLKXQd1F/wJLxW+npCuxENVvwEKW1MFVXvb80NG8nVCFKdGTUWVF+oS7ylOCdGSt4TuWN+DYM6p93/Ml2uLihYNI0c+Rdyb88kW2fKBkZGddE3VHQjoeckuDUoz16JPgw8JwVHlDGqACHW7KgTFGihbqnueeoFmbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U4uu4KTa; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U4uu4KTa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:To:
	Content-Type; bh=NfI3sXa25YFWPfyRn+wgSyK1ek+FDv+B1YGaaHsijuo=;
	b=U4uu4KTaIEW+h9cMnkm1PY9BQufllSyQ7cQiXgrk2hXim0Drm1nI8I9ZJo9O/c
	bod4GATPrp8wqC1ARVrUosUrAHvRGVy10KYIg6pki8EOWxIsJ9Xhohw328A/Arnc
	X7Dt/3kjIErd7eSbl/2s3QwUAqDFy1n4pRmxkv23ZIMVE=
Received: from [IPV6:240e:b8f:91b3:d000:cb89:e59c:b7d0:5b84] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAXZJmq9JpqJYjJQw--.64773S2;
	Sat, 05 Sep 2026 00:41:15 +0800 (CST)
Message-ID: <1a193cc9-38c8-470c-9041-fdf1dad5b6e3@163.com>
Date: Sat, 5 Sep 2026 00:41:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] PCI: Configure Root Port MPS during host probing
From: Hans Zhang <18255117159@163.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, Manivannan Sadhasivam <mani@kernel.org>,
 lpieralisi@kernel.org, kwilczynski@kernel.org, heiko@sntech.de,
 yue.wang@amlogic.com, pali@kernel.org, neil.armstrong@linaro.org,
 robh@kernel.org, jingoohan1@gmail.com, khilman@baylibre.com,
 jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20260622171448.GA678675@bhelgaas>
 <72a058fd-5781-43bc-9148-180140929ecd@163.com>
Content-Language: en-US
In-Reply-To: <72a058fd-5781-43bc-9148-180140929ecd@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAXZJmq9JpqJYjJQw--.64773S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFykGr13tF43Jr1rArWDJwb_yoW8uw4kpF
	W5Xan3ta1xKry3CF1qqw1Fyr1jqa48tFy3XryDtryayFn0vr15XF1I9wsYkrn7Wr1xGr12
	9r1Uta4xXrn0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ucdb8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AuoTGqa9KsUEwAA3r



On 7/14/26 19:06, Hans Zhang wrote:
> 
> 
> On 6/23/26 01:14, Bjorn Helgaas wrote:
>> On Fri, Jun 19, 2026 at 11:29:39PM +0800, Hans Zhang wrote:
>>> On 5/6/26 22:00, Manivannan Sadhasivam wrote:
>>>> On Fri, Nov 28, 2025 at 01:09:06AM +0800, Hans Zhang wrote:
>>>>> Current PCIe initialization exhibits a key optimization gap: Root 
>>>>> Ports
>>>>> may operate with non-optimal Maximum Payload Size (MPS) settings. 
>>>>> While
>>>>> downstream device configuration is handled during bus enumeration, 
>>>>> Root
>>>>> Port MPS values inherited from firmware or hardware defaults often 
>>>>> fail
>>>>> to utilize the full capabilities supported by controller hardware. 
>>>>> This
>>>>> results in suboptimal data transfer efficiency throughout the PCIe
>>>>> hierarchy.
>>>>>
>>>>> This patch series addresses this by:
>>>>>
>>>>> 1. Core PCI enhancement (Patch 1):
>>>>> - Proactively configures Root Port MPS during host controller probing
>>>>> - Sets initial MPS to hardware maximum (128 << dev->pcie_mpss)
>>>>> - Conditional on PCIe bus tuning being enabled (PCIE_BUS_TUNE_OFF 
>>>>> unset)
>>>>>     and not in PCIE_BUS_PEER2PEER mode (which requires default 128 
>>>>> bytes)
>>>>> - Maintains backward compatibility via PCIE_BUS_TUNE_OFF check
>>>>> - Preserves standard MPS negotiation during downstream enumeration
>>>>>
>>>>> 2. Driver cleanup (Patch 2):
>>>>> - Removes redundant MPS configuration from Meson PCIe controller 
>>>>> driver
>>>>> - Functionality is now centralized in PCI core
>>>>> - Simplifies driver maintenance long-term
>>>>>
>>>>
>>>> For the series,
>>>>
>>>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>>>>
>>>> Bjorn: Could you please take a look? This series has been floating 
>>>> for a
>>>> while...
>>>
>>> Hello Bjorn,
>>>
>>> Any chance for this series to be applied?
>>
>> It's too late for v7.2; we're already more than halfway through the
>> merge window.  We can look again for v7.3 after v7.2-rc1.
> 
> Hello Bjorn,
> 
> Gentle ping on this series.
> 

Hello Bjorn,

Would you have time to take a look at this series? If there is anything 
else I can do to improve, I will do it.


Best regards,
Hans

