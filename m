Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190378C1F
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770956899; cv=none; b=iWWMQHIuH1f968kOWjzWVx/7M/iUpR8SrxvHj+bh02JzjKJ9s0vcFNWS5w3mTE+8n+CwmDtp191WdDRCrmgk6o7m9N12z6E3knL8qbIbqc+K11aNXUUCfILYcK28B0Oa9ma9zY03fuJFMLe/PNwmkhJ5kj1Yfrx4o/i0eyAKbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770956899; c=relaxed/simple;
	bh=7FqUy8UllDvMhcnWQe0A+2F29sipDK40R5SgbRJOnz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kb/sjhxZn191nCAFBIzeqCMyvzYVO5Bps2F5ht2i7nOAHFP6PWOA1KogEXJFinZx5k7YfC5srXVC2/UgqOZJgVvc/Ww+UlJMoH4djYnGRccx4CpKsgkcECIB1Puwsqz0R4pKel72FE3Bk4hGQD8MQChPEEFkp8e7xhlCpOd3PkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYCbhnLh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYCbhnLh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770956897; x=1802492897;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7FqUy8UllDvMhcnWQe0A+2F29sipDK40R5SgbRJOnz4=;
  b=hYCbhnLhZys0qpfHJlcrnKCuAmDx3R0vs8PH0W8YmpeTxsbvCkpRuf/O
   M9LMLqjyk8ihsvXEn3UQyM9hEZBMyBkVxC5BuwkpY4PRs84bXPmce7Fq4
   QK2DeluU6neQgQGrpWJ7pIMB0ab5id7WVQsgCc68BKHw6eVOlHd9oDTJ3
   HW1gOjQD7LbUTo/M/1NzX6XklohKTPrTva5Zzpre4Mu0wV9leqHYdzVmR
   TDc/veW1223t0xDWNfW+Ni0yU2Qc9oUsaLU1DG/fBA3gWsCuP03VUkQH6
   u4bQluFtSC4J6X5galrjSgR6a91y5JpnXAnN9wE8yk2GejvyXpjNmWW0K
   w==;
X-CSE-ConnectionGUID: SW/EXfrcRrqqTWU7UG/7jA==
X-CSE-MsgGUID: G6VtsvIxQmuc82vbdfJsgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71855065"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="71855065"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 20:28:16 -0800
X-CSE-ConnectionGUID: Foj8O1gvS1yIdnJ3bxyrtw==
X-CSE-MsgGUID: uAu+VRu9Tk2CNd48bveoBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="216955571"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 20:28:17 -0800
Received: from [10.125.108.245] (unknown [10.125.108.245])
	by linux.intel.com (Postfix) with ESMTP id EBBD020A8401;
	Thu, 12 Feb 2026 20:28:15 -0800 (PST)
Message-ID: <bf28da73-7189-412f-808a-2dbb6d241b4d@linux.intel.com>
Date: Thu, 12 Feb 2026 20:28:15 -0800
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
 <8b4800cf-7e8a-42f7-a84a-5081afe00048@linux.intel.com>
 <aY586W1YoKVyfBJZ@kbusch-mbp>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aY586W1YoKVyfBJZ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 2/12/26 5:22 PM, Keith Busch wrote:
> On Thu, Feb 12, 2026 at 02:51:46PM -0800, Kuppuswamy Sathyanarayanan wrote:
>> On 2/12/2026 2:12 PM, Keith Busch wrote:
>>
>> As per EDR flow, firmware waits for _OST reply from OS to complete the
>> current interrupt handling. After receiving _OST, firmware decides whether
>> recovery should continue or if the link should be disabled. When/how firmware
>> handles subsequent DPC events depends on firmware's implementation.
> You at least agree the OS controls the "Trigger Status". That controls
> whether the link stays contained or not, but now you're saying the
> firmware gets to yank the link after the OS returns _OST success?
> There's no flow in the spec suggesting any such behavior.

I was referring to the flow chart and notes on page 85, in PCI firmware spec,
v3.3, which mention firmware can choose to disable the link in certain
cases (notes 3,5).

>
>>> Sure, there's no explicit language in any spec I can find that the OS
>>> must write 1 to bit 3 of the status register, but it doesn't say
>>> firmware owns that bit either. The firmware handed control of the status
>>> to the OS in this path. It would not make sense to return to firmware in
>>> a state that makes it impossible to report new errors during that
>>> transition window.
>> The spec explicitly lists what the OS can write during the EDR window. For
>> few registers it gives full contro; For DPC status, it explicitly states
>> which bit it can clear (DPC trigger status).
> What harm do you think will come if we return the dpc status register to
> firmware in a state that indicates the OS handled it to completion?
>
>>> Besides, is firmware first even triggering off an interrupt? Pretty sure
>>> it's triggering off the ERR_COR message, no? Why would it need to own
>>> the Interrupt Status bit when it's not even relying on it?
>> If it not triggered by interrupt, then interrupt status bit does not
>> matter (even for OS handler).
> Emperically speaking, yes, it does matter. Otherwise why would this
> patch exist?

What's the actual symptom being observed? Is the Interrupt Status bit
being left set causing a functional problem, or is this preventive cleanup?

>
> Or the other way, if you think it doesn't matter, then why oppose
> improving Linux hardware interop?

I'm not opposing the change. I want to make sure we align with the
spec and don't break existing firmware expectations.

If firmware is the final decision maker of the recovery flow (as shown in the
flow chart), does this change actually help with early re-handling of DPC
events? Also, if there currently exists firmware that assumes it owns the
decision on when to re-handle DPC events, this change might break those
assumptions.

If this change improves interoperability with existing platforms, we should
take it. As a follow up, we should work on clarifying the spec to explicitly
permit OS clearing of Interrupt Status during EDR.


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

