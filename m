Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CBF2931D1
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102325; cv=none; b=ligaeUHBo/HbHKqPwbRhRBohgmqqlsw5uOsMA03dx4FLa3Q0HIBe3bOvEuC6ENREjOKiwNMsjGE4I0gxZbX9JmdVEeYqvkCaTSM5bWvTO1b+BT89FT61VQpqKgb+urN2KCcUN51QlVhMPUHI/vvXrlRV23ud/Ql3TYGy/AxMeqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102325; c=relaxed/simple;
	bh=1VPdX9pDtSPZUkKaAqv+B+3T1bpAAcYTXwPP+GQyXpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmEkHZEKWVZv4PsYcHMKGxnbH7eM228PulBG86NsxEUHUURoT3eq+bstgSRmo7Mm/9N0jKFBlduaNPiynk+Hh56SEk3sFASMejpDLikAVDQ5EHa+xIZv5kp5Dstx2NiMASboTMS49v83SkWPUn9vYvd7sbuM5PSpe8bZn9u7mGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c0fcRdbe; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c0fcRdbe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Hi4O8KIiCyXeFNxWl9xgXoqyTQKSTJOcECFLM2oHMr0=;
	b=c0fcRdbe5h4j2ZvQud3zaBuJF/Q6wNPXSPsAgxzjQ989UD3gGz0zEVQr5R/Vpj
	nj19tUhPrrZBN3kHjbBIZir/8Sbylu0AysmJUuQt8h9Lj+wz823aqLIGcW/ork0D
	E67X/+51RAoXmohJCVpWJRgH41XDLUrfyreWzkqgoWT6c=
Received: from [10.111.8.51] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHBNmLPVdqHuTTJw--.46184S2;
	Wed, 15 Jul 2026 15:58:04 +0800 (CST)
Message-ID: <7a754ea9-c3bf-4507-9cc6-ceef32b3ecae@163.com>
Date: Wed, 15 Jul 2026 15:57:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] PCI: cadence: Add HPA IP debugfs for LTSSM status
To: Manivannan Sadhasivam <mani@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260701073513.1101559-1-18255117159@163.com>
 <20260701073513.1101559-3-18255117159@163.com>
 <20260701074818.E3F291F000E9@smtp.kernel.org>
 <rrf3bid5g7hsaigimjy6d5i5sv63n6af3sriksfx7tyymg6fqz@a6vsjz6zrthr>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <rrf3bid5g7hsaigimjy6d5i5sv63n6af3sriksfx7tyymg6fqz@a6vsjz6zrthr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCHBNmLPVdqHuTTJw--.46184S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr48Xw43Kr18ur17ZrWfAFb_yoW5Xr48pa
	4kGFWfCF4xZa1Yvanak3WUXr13t3s7Z348Jan09r17ur13ur4UtFs2gFW5XFW7Gw4DKr1x
	Zw15Kasrtr18Z3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zK9a9hUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AzihmpXPYw+8AAA3G



On 7/15/26 15:44, Manivannan Sadhasivam wrote:
> On Wed, Jul 01, 2026 at 07:48:18AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Low] Modpost link error when building Cadence drivers as modules due to an orphaned debugfs object.
>> --
>>
>> commit 98a72e00615e702fb5448b12d14570527e38b67f
>> Author: Hans Zhang <18255117159@163.com>
>>
>> PCI: cadence: Add HPA IP debugfs for LTSSM status
>>
>> This commit adds debugfs support for HPA-based Cadence PCIe controllers,
>> exposing the current LTSSM state through a new ltssm_status file.
>>
>>> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
>>> index b8ec1cecfaa88..2cdc4617e0c20 100644
>>> --- a/drivers/pci/controller/cadence/Makefile
>>> +++ b/drivers/pci/controller/cadence/Makefile
>>> @@ -4,6 +4,7 @@ pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-c
>>>   pcie-cadence-ep-mod-y := pcie-cadence-ep.o
>>>   
>>>   obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
>>> +obj-$(CONFIG_PCIE_CADENCE_DEBUGFS) += pcie-cadence-debugfs.o
>>
>> [Severity: Low]
>> Will this cause a link error during modpost when building the Cadence drivers
>> as modules?
>>
>> Since CONFIG_PCIE_CADENCE_DEBUGFS is a boolean, this adds the object directly
>> to obj-y instead of appending it to a composite module target like
>> pcie-cadence-mod-y. When the driver is configured as a module (e.g.,
>> CONFIG_PCIE_CADENCE=m), the object is compiled but left unlinked.
>>
>> Could this lead to undefined symbol errors for cdns_pcie_debugfs_init and
>> cdns_pcie_debugfs_deinit in the caller modules?
>>
> 
> This is a real concern. So I fixed the Makefile with below change while
> applying:
> 
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index b8ec1cecfaa8..80be0b885ac8 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   pcie-cadence-mod-y := pcie-cadence-hpa.o pcie-cadence.o
> +pcie-cadence-mod-$(CONFIG_PCIE_CADENCE_DEBUGFS) += pcie-cadence-debugfs.o
>   pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-cadence-host-hpa.o
>   pcie-cadence-ep-mod-y := pcie-cadence-ep.o
> 
> This will ensure that the debugfs functions are always built into the
> 'pcie-cadence-mod*' object.
> 

Hello Mani,

Thank you very much.

Best regards,
Hans

> - Mani
> 

