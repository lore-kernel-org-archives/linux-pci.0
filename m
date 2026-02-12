Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D0728689A
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770936708; cv=none; b=YnRavElxb+bPTTlHyKkJX6i9r6vr6SsoM9m0hvH2fRd0oO0wJjU39PUi+2zPGQlFtx22CY+wizJ5UEB8vTOSNrnnmEJyehymwVTHsYuKzhJWAWhZIfJ+RKP4mTQmvKlVEIwFM+mid5d60aRcbjvsupPuwslnzXt3ZikgQE/SNOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770936708; c=relaxed/simple;
	bh=fTE9Wfnzc7eOUL0J68ccK/AXEHQDYfqGbDfqCoxFYKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ux6Zf1bwLxS7UvtkI60AB9c7yI9iRtWhjVxFk3it9aMBrlQavpRBUHRA6qlVQum0eFcG7lnRxW3kE8YAwGgZtYFxSf9pjLP+y+O3Yozo8AzctfGr8/ocszhOmPs4yBGSlWTUMb5CdY9FpIwicLrWDM/ndbpQ/9AIaBRJkKNnnSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hafVvRPA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hafVvRPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770936708; x=1802472708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fTE9Wfnzc7eOUL0J68ccK/AXEHQDYfqGbDfqCoxFYKg=;
  b=hafVvRPADOyz+tb4ecE0uo4XOr1Sx6zN1mYL2+Ysqa6lU0NTpRXEhZaj
   o6gcbogL692xbKJF2YKWA20vBGalNkx4ygQ2B0avua2Dm6CJXZGtyopJW
   m3OYX3W69Sw3r2WiidNhwmAsSgZIbfQlIM9ohpi5bj1nwBi5K8ezGxQd0
   m4UawsWvoAC2Rteg+Whfv2ceip0nFqOWiwAfkLU/kmFoNcX2dsqsajifN
   U9GhdmJsAleXpZtEcn2BXoSDnNa9rZIx+RGXO3XFU6UCaMkkq2IPSOk00
   hBL+Zc8rOiuDm44uNMYMn8W6DM8bCwjUJ1Wa7WdSvYuqpLdsvub4jVkOr
   A==;
X-CSE-ConnectionGUID: djelZXKLQxSNOz6+N7QiGg==
X-CSE-MsgGUID: e+MuSBFvSfK70/Qa36TbkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75967466"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="75967466"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:51:47 -0800
X-CSE-ConnectionGUID: x1OxsAeuSFybIfFSG62pqQ==
X-CSE-MsgGUID: 63fA01mSR++z6DisTKZtXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="216892803"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:51:46 -0800
Message-ID: <8b4800cf-7e8a-42f7-a84a-5081afe00048@linux.intel.com>
Date: Thu, 12 Feb 2026 14:51:46 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/DPC: Clear Interrupt Status in dpc_reset_link()
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
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aY5QMlr_7XLIbOsV@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/2026 2:12 PM, Keith Busch wrote:
> On Thu, Feb 12, 2026 at 01:49:52PM -0800, Kuppuswamy Sathyanarayanan wrote:
>> Hi Keith,
>>
>> On 2/12/2026 1:23 PM, Keith Busch wrote:
>>> On Thu, Feb 12, 2026 at 11:50:54AM -0800, Kuppuswamy Sathyanarayanan wrote:
>>>> In case of EDR, firmware owns the interrupt handling. It just uses ACPI
>>>> method to request OS help with recovery. Since interrupt handling is
>>>> owned by firmware, I think firmware should clear the interrupt status.
>>>
>>> But the PCI Firmware Specication says the OS owns the status register
>>> while it is handling EDR notification
>>>
>>> "
>>>    the operating system is permitted to write the following:
>>>
>>>      * Device Status Register
>>>      * Uncorrectable Error Status Register
>>>      * Correctable Error Status Register
>>>      * Root Error Status Register
>>>      * RP PIO Status Register
>>>
>>>    in the Port that triggered DPC while processing an Error Disconnect Recover
>>>    notification from firmware
>>> "
>>
>> Please check the _OSC DPC control bit details in PCI firmware spec.
>>
>> It specifically calls out OS is permitted to write to DPC trigger status
>> bit in DPC status register. It does not talk about about DPC interrupt
>> status bit.
>>
>> Copied here for reference:
>>
>> "If control of this feature was requested and denied, or was not requested,
>> then the operating system is permitted to write to the DPC Trigger Status bit
>> in the DPC Status Register in the Port that triggered containment"
>>
>> I think since firmware registers interrupt handler for DPC, after OS helps
>> handle the recovery it should complete the loop and clear it.
> 
> But that just creates a window for when after the OS lets the link
> retrain that the port will be unable to trigger a new containment event.

As per EDR flow, firmware waits for _OST reply from OS to complete the
current interrupt handling. After receiving _OST, firmware decides whether
recovery should continue or if the link should be disabled. When/how firmware
handles subsequent DPC events depends on firmware's implementation.


> 
> Sure, there's no explicit language in any spec I can find that the OS
> must write 1 to bit 3 of the status register, but it doesn't say
> firmware owns that bit either. The firmware handed control of the status
> to the OS in this path. It would not make sense to return to firmware in
> a state that makes it impossible to report new errors during that
> transition window.

The spec explicitly lists what the OS can write during the EDR window. For
few registers it gives full contro; For DPC status, it explicitly states
which bit it can clear (DPC trigger status). 

> 
> Besides, is firmware first even triggering off an interrupt? Pretty sure
> it's triggering off the ERR_COR message, no? Why would it need to own
> the Interrupt Status bit when it's not even relying on it?

If it not triggered by interrupt, then interrupt status bit does not
matter (even for OS handler).

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

