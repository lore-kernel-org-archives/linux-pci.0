Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A34C3B71C1
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574548; cv=none; b=MzjD6/uxGGpz1dr0oFFbsQLmJApBrguIKJqY5vsvlMI1F/CrMQxSOHNyWWDtfiYq9iZxP3ZUHqENPFC50svzSv+hTvYnNqgCustVBVed0Jh7e4biBTn9PYh3zZBRMWEJQA+74FWSKADrXrVRg8BZjZK2bQf2iUGbwjCxnguApkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574548; c=relaxed/simple;
	bh=IZUwUzYqNUwMlmCYb6LmfLKmx4Mjvl8lUQFUEepftmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpQgDSiznzOOyS2A12SDIovjtMm992ZPsbsldTAcBpFhmok5VHdkgDFXWDXCaOZhM07vvdoIEN1VtR20iakJMOzT+viOgiy9qe2dJfv1neg2e7Kz7sB7qMPAXgktoErDiWbC0wkK6eM1lRyoh9aCnJn3hOSde4IKassbGPCebYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J/9oBK6W; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J/9oBK6W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=oDMuup7k0NYHwbtaJC3oPVr62QOUwrPoiy1ADTfugyU=;
	b=J/9oBK6Wu/kZNtfpZOhyWg5U4d/5UuiySlf2pMK4+LE5K1kAEd9f5ySt7lorzD
	tKLGX8QjdqQYUY1obkJ0vLRSjmjVqHNHmMlQsHBUZxnZNMnCB/uiaJQD1IlNI8B6
	88vn+C2c75CrBDBKqDdBtcMqqQZduegWLvSHxVVPhr+nw=
Received: from [IPV6:240e:b8f:91b3:d000:a95a:12fc:887a:b0f1] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBXGiZ9vapqTugESA--.43532S2;
	Thu, 17 Sep 2026 00:02:05 +0800 (CST)
Message-ID: <c96534dd-9623-46e7-8385-220566938b8d@163.com>
Date: Thu, 17 Sep 2026 00:02:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] PCI: Configure Root Port MPS during host probing
To: sashiko-reviews@lists.linux.dev
Cc: linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org,
 linux-pci@vger.kernel.org
References: <20260916153907.60344-1-18255117159@163.com>
 <20260916153907.60344-3-18255117159@163.com>
 <20260916155143.2E31B1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260916155143.2E31B1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgBXGiZ9vapqTugESA--.43532S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryDury7Zw48KFyfXrWkZwb_yoW5tF4xpa
	y5JasYyFs7GFyIya92v348Zr1rJF93Ca17G398Wryvv3ZxC347Kry2yws5G34xGrs7Wry2
	yan0v34xArn8ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRepBfUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x3Td2qqvX08gQAA3v

Hi,

Thanks for the review.



On 9/16/26 23:51, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] pci: dangerous dynamic MPS reduction under PCIE_BUS_DEFAULT
> --
> 
> commit 32945143b32b8b42f1dd3e1f419414a5bf8f9acf
> Author: Hans Zhang <18255117159@163.com>
> 
> PCI: Configure Root Port MPS during host probing
> 
> This commit updates the PCIe initialization logic to set a Root Port's Maximum
> Payload Size (MPS) to its maximum supported value during host controller
> probing. It does this as long as the MPS strategy is not PCIE_BUS_TUNE_OFF or
> PCIE_BUS_PEER2PEER, meaning it applies under the default PCIE_BUS_DEFAULT
> strategy.
> 
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 232bce2819f06..08af75aa7366b 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2248,6 +2248,21 @@ static void pci_configure_mps(struct pci_dev *dev)
>>   		return;
>>   	}
>>   
>> +	/*
>> +	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all) or
>> +	 * PCIE_BUS_PEER2PEER (use minimum MPS for peer-to-peer), set Root Ports'
>> +	 * MPS to their maximum supported value. Depending on the MPS strategy
>> +	 * and MPSS of downstream devices, a Root Port's MPS may be reduced
>> +	 * later during device enumeration.
>> +	 */
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
>> +	    pcie_bus_config != PCIE_BUS_TUNE_OFF &&
>> +	    pcie_bus_config != PCIE_BUS_PEER2PEER) {
>> +		rc = pcie_set_mps(dev, 128 << dev->pcie_mpss);
> 
> [Severity: High]
> Does this code introduce a regression where active downstream topologies are
> exposed to dangerous dynamic MPS reductions under the default PCIE_BUS_DEFAULT
> strategy?
> 
> By forcing the Root Port MPS to its maximum supported value here, it overrides
> safe firmware settings. If a device with a smaller MPSS is subsequently
> enumerated or hotplugged, pci_configure_mps() will detect that the downstream
> MPSS is smaller than the Root Port's MPS, triggering pcie_reduce_mps() on the
> entire hierarchy.
> 
> Because pcie_reduce_mps() modifies the Root Port first and sequentially walks
> downstream without quiescing active devices, this creates a dangerous window.
> 
> If an existing downstream device (such as an active NIC or early
> firmware-driven display controller) is actively performing DMA, could it
> transmit a payload exceeding the newly reduced MPS of the Root Port,
> potentially leading to Malformed TLP Fatal Errors and a system crash?


The scenario you describe requires pcie_reduce_mps() to modify the MPS
of a device that is already active.  As explained in the review of patch
1/3, pci_configure_mps() is only reached from pci_setup_device() during
enumeration, before the device is bound to its driver and before it can
generate TLPs.  The reduction is therefore performed while the hierarchy
is still quiescent.

The pre-existing behaviour from 9f0e89359775 already lowers the Root
Port's MPS when a downstream device has a smaller MPSS, so this series
does not introduce dynamic reduction of an active hierarchy.  Patch 1/3
additionally covers Switch ports and already-programmed siblings, which
the old code missed; that is what fixes the Switch case reported in v8.

> 
>> +		if (rc)
>> +			dev_warn(&dev->dev, "failed to set root port MPS\n");
>> +	}
>> +
>>   	if (!bridge || !pci_is_pcie(bridge))
>>   		return;
> 

