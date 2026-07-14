Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD7E37A856;
	Tue, 14 Jul 2026 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027228; cv=none; b=SHkL9vTy4zRL0zNyv3MYuLvG0jVDJPkBFiI/v2VJ8aSP6xWAJzHZOaxyeHPacxMEbNw6t5/mlBxmtleUCEqJNY2EZ2ZUuNsDw9yGiUkSBkHgJrLWCsRqR/DHtO5PDrdEiQW/3KJns8uFJOCauxj6v3M/yH7b3LTwDe+g5MdjHHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027228; c=relaxed/simple;
	bh=cbMd0m+UuZgOYF4KB0Fkt2usHzWLtArTGxt0b+hFjAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfZXu+NBW3XfYIGJizWoyteE4hro1a43wH9ZrbruXU8DysgXg/xtt4hVlqCW9dPrj6A3e2cyvj8CconNvZBTrMGP57jvwW3f3yIL4V3MuL6oCgylHe/d6CwZi/M8HdFeApsDRuuX4jDzMrP6HwSH0/TftZL3P6f+ejtQDqoXChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZG/28Z9Y; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZG/28Z9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=S323XPQAVbXMMiJRm+Dg+pgQry7Wic4cXHZLSGEJw+0=;
	b=ZG/28Z9YW8+8O+S7agcsiaFV1MwoBUU+msb83Q9py4oWPZgTpjLvhYUhaQLaC7
	BXqhypUV8U2IPJ0lkxgb6mWSThzlCykBtyKXpKjOUYmn3nyX32EKhxlC1kehCh8Q
	UJJlhIMZSEiy9uGsFcTK2R8wxpOGY+4MEN9GGkYZesuEc=
Received: from [10.111.8.51] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXna8fGFZqlFnYJQ--.22967S2;
	Tue, 14 Jul 2026 19:06:08 +0800 (CST)
Message-ID: <72a058fd-5781-43bc-9148-180140929ecd@163.com>
Date: Tue, 14 Jul 2026 19:06:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] PCI: Configure Root Port MPS during host probing
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
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260622171448.GA678675@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXna8fGFZqlFnYJQ--.22967S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWUZryDtF43XF4kJFW7CFg_yoW8CFWkpF
	W5XanayF4xKFyfCF4qqwsYkryYqa48ta43Xr1DtryayFn09rn8XFWjgws5Gwn7Xr1xCr1S
	9r1qqa4xXwn0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4UDXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AA+4WpWGCAV3gAA38



On 6/23/26 01:14, Bjorn Helgaas wrote:
> On Fri, Jun 19, 2026 at 11:29:39PM +0800, Hans Zhang wrote:
>> On 5/6/26 22:00, Manivannan Sadhasivam wrote:
>>> On Fri, Nov 28, 2025 at 01:09:06AM +0800, Hans Zhang wrote:
>>>> Current PCIe initialization exhibits a key optimization gap: Root Ports
>>>> may operate with non-optimal Maximum Payload Size (MPS) settings. While
>>>> downstream device configuration is handled during bus enumeration, Root
>>>> Port MPS values inherited from firmware or hardware defaults often fail
>>>> to utilize the full capabilities supported by controller hardware. This
>>>> results in suboptimal data transfer efficiency throughout the PCIe
>>>> hierarchy.
>>>>
>>>> This patch series addresses this by:
>>>>
>>>> 1. Core PCI enhancement (Patch 1):
>>>> - Proactively configures Root Port MPS during host controller probing
>>>> - Sets initial MPS to hardware maximum (128 << dev->pcie_mpss)
>>>> - Conditional on PCIe bus tuning being enabled (PCIE_BUS_TUNE_OFF unset)
>>>>     and not in PCIE_BUS_PEER2PEER mode (which requires default 128 bytes)
>>>> - Maintains backward compatibility via PCIE_BUS_TUNE_OFF check
>>>> - Preserves standard MPS negotiation during downstream enumeration
>>>>
>>>> 2. Driver cleanup (Patch 2):
>>>> - Removes redundant MPS configuration from Meson PCIe controller driver
>>>> - Functionality is now centralized in PCI core
>>>> - Simplifies driver maintenance long-term
>>>>
>>>
>>> For the series,
>>>
>>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>>>
>>> Bjorn: Could you please take a look? This series has been floating for a
>>> while...
>>
>> Hello Bjorn,
>>
>> Any chance for this series to be applied?
> 
> It's too late for v7.2; we're already more than halfway through the
> merge window.  We can look again for v7.3 after v7.2-rc1.

Hello Bjorn,

Gentle ping on this series.

Best regards,
Hans

