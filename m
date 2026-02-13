Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344408C1F
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 04:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770956979; cv=none; b=TIKhsoTMC8HaYS6l9IDgVCmbv2HFEA/SDWPNRyLF0bR1xDtl1n8BuvhWMBF9C2FeAgKKK20wh8N4LQiY5xE8hevVL2HY4BMQF9vBQeS496/TJo3sXDy/eFvBDwXn+ZXD1DQG/DxzgWHHOFla0XHE7xfVNa3RSBFd4orLX1g8gUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770956979; c=relaxed/simple;
	bh=3CbvAVFOcvVK1/nkNolxkOFXCiu15X775M/ZmhQi16M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nuHrdTz4D8md5R6Zkyd5GfT9EIhsgQCk/8Y6pYqHgcCDFhNF3Pe8vNFdZyW8rZ+UHHjPHhcJ4AI+4d3tQDDRlMqcEIyeY8QBLds2A8ZUlmzBazSdTUw0pfBBcoQbAqCPLa51l2JTw3fyrOGczJukuRYwARCmor4MSk74E5sHSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5aoBuOh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5aoBuOh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770956978; x=1802492978;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=3CbvAVFOcvVK1/nkNolxkOFXCiu15X775M/ZmhQi16M=;
  b=S5aoBuOhgUAMa9HA4/RagTVJ1aVlblOxmm9hD5bT+qIhkQWQomP0sM6g
   4UFFQSas6IkcZWH/DciIacNRDeM9bWXbCbkeyxaW772CaCCpK24hAllJy
   LzhjH7Bnk7vKsCSspAI+k8V2d6LgN1FJTsdAIDSUepCX0bn6JJ8Rzn2tT
   xh3hxPBnOVq6KvQynSQygwjxDP3OnJadpKO481ovRytJH84NQ+q+OVmfi
   YHGyW2prveOApmzB415SjLcUNpfPCqE8zM1hXZ/LmTOjhyA3NE2fggbsG
   5ZXSm6ZQj2TZ94K9mR+HqPv19rIiIIVBPX+/o10/nXS/YTsDR1BZSY3gl
   A==;
X-CSE-ConnectionGUID: PRcHpKLwSCuvo+40R8FkrA==
X-CSE-MsgGUID: LRUrfgJHQ7eTM3bzSomyZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="97599183"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="97599183"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 20:29:38 -0800
X-CSE-ConnectionGUID: E8ws1ApcRu++264aMwlq7g==
X-CSE-MsgGUID: CcH0/HRhQqqDWDI/PVCRSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="242283144"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 20:29:37 -0800
Received: from [10.125.108.245] (unknown [10.125.108.245])
	by linux.intel.com (Postfix) with ESMTP id 0211120A8401;
	Thu, 12 Feb 2026 20:29:36 -0800 (PST)
Message-ID: <0c14b730-73cf-4eae-9115-f4d8c45f69cb@linux.intel.com>
Date: Thu, 12 Feb 2026 20:29:36 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/DPC: Clear Interrupt Status in dpc_reset_link()
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Danielle Costantino <dcostantino@meta.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
References: <20260212191818.3625264-1-dcostantino@meta.com>
 <20260212191818.3625264-2-dcostantino@meta.com>
 <9b75cf12-a0b4-49bf-b261-cbe02c0fe310@linux.intel.com>
 <aY5E4OWE_v0Jdyd1@kbusch-mbp>
 <9a7a176d-4450-47ac-859c-0ce69a19afee@linux.intel.com>
 <aY5QMlr_7XLIbOsV@kbusch-mbp>
 <8b4800cf-7e8a-42f7-a84a-5081afe00048@linux.intel.com>
 <aY586W1YoKVyfBJZ@kbusch-mbp>
 <4c0d0575-0da1-49ff-878e-65622b442e98@linux.intel.com>
Content-Language: en-US
In-Reply-To: <4c0d0575-0da1-49ff-878e-65622b442e98@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi All,

Please ignore my previous emails. For some reason, when I was typing the reply, it seems to have sent it.

On 2/12/26 8:22 PM, Sathyanarayanan Kuppuswamy wrote:
>
> Hi Keith,
>
> On 2/12/26 5:22 PM, Keith Busch wrote:
>> On Thu, Feb 12, 2026 at 02:51:46PM -0800, Kuppuswamy Sathyanarayanan wrote:
>>> On 2/12/2026 2:12 PM, Keith Busch wrote:
>>>
>>> As per EDR flow, firmware waits for _OST reply from OS to complete the
>>> current interrupt handling. After receiving _OST, firmware decides whether
>>> recovery should continue or if the link should be disabled. When/how firmware
>>> handles subsequent DPC events depends on firmware's implementation.
>> You at least agree the OS controls the "Trigger Status". That controls
>> whether the link stays contained or not, but now you're saying the
>> firmware gets to yank the link after the OS returns _OST success?
>> There's no flow in the spec suggesting any such behavior.
>
> I was referring to the flow chart and notes on page 85, in PCI firmware spec,
> v3.3, which mention firmware can choose to disable the link in certain
> cases (notes 3,5).
>
>>>> Sure, there's no explicit language in any spec I can find that the OS
>>>> must write 1 to bit 3 of the status register, but it doesn't say
>>>> firmware owns that bit either. The firmware handed control of the status
>>>> to the OS in this path. It would not make sense to return to firmware in
>>>> a state that makes it impossible to report new errors during that
>>>> transition window.
>>> The spec explicitly lists what the OS can write during the EDR window. For
>>> few registers it gives full contro; For DPC status, it explicitly states
>>> which bit it can clear (DPC trigger status).
>> What harm do you think will come if we return the dpc status register to
>> firmware in a state that indicates the OS handled it to completion?
>>
>>>> Besides, is firmware first even triggering off an interrupt? Pretty sure
>>>> it's triggering off the ERR_COR message, no? Why would it need to own
>>>> the Interrupt Status bit when it's not even relying on it?
>>> If it not triggered by interrupt, then interrupt status bit does not
>>> matter (even for OS handler).
>> Emperically speaking, yes, it does matter. Otherwise why would this
>> patch exist?
>
> What's the actual symptom being observed? Is the Interrupt Status bit
> being left set causing a functional problem, or is this preventive cleanup?
>
>> Or the other way, if you think it doesn't matter, then why oppose
>> improving Linux hardware interop?
>
> I'm not opposing the change. I want to make sure we align with the
> spec and not break any firmware expectations.
>
> If firmware is the final decision maker of the recovery flow (as shown in
> the flow chart), then does this change really help early re-handling of DPC
> events?
>
> Another point I am concerned, If there currently exits a firmware
> implementation, which  assumes firmware own the decision on when to
> re-handle DPC events. we
>  not want handle DPC again before
> completing the current event and makes a decision on whether to recover
> , then this change might break it.
>
> If you think it is better for OS to clear it, then I think we should attempt to
> clarify that part in spec as a follow up to make sure we set clear expectation
> to the firmware.
>
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

