Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865538;
	b=Z8JQdjPKNNXoqLtgff9HjlZgjZXKK2s1ULHKuAEN7QKhGKa99VkVfKLd6nWDruOjH0Zz
	 UeIHVb4+9F4n+ZEClFmIDCvXKPfSFsk0B3fY7G7dmS4t2YJSGCVezjD43B9OfOrpn9ctD
	 uFMAZuiyQZUV5nUgVT763sdAU9pcBQObIpaiQLSctyTsFnrihe09pOLTuizdToXLdilfF
	 gC95AKqv7nMtl0qEhwyaZiu0fGPq2zgchX0NUHh9eZGxDZOQ/HfBOZz6lS/PuHhIqKaDw
	 u5bOsI217C3T/rSN22IlObTBb4mV/jzhcVzU+muSZaGkAcvyouPsiEMGuk4ugoeIOkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865538;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=e2oVwTaTCwxHvwwap2cgr/6EHHJdr1C71nzOKZZtAlc=;
	b=u0y77TIKg0Mgd1+TZ83zkRkBxOFnpGPSCIQkyDWBQ0L34Z+UZtw+S7mDMVNZm02lm/w6
	 ThFCn5uNtuiI9/8qG825BsPT+cKNtpBsK3HTzmZIK9QRopU7tgqDaS2vXl59H2LAXRFeV
	 aeZwgXLlZ6RNBdH3uoo0QjjtUkXvxbUj+YcpSA1DnJ5qUfnrmZQyxDXa+kTFw9oQREOB6
	 FU+adWhtntdrWLoc963tbzzo06oXh724YXG/8ZfqxtMVdJVA8vgyp+KMphLvSzd9fkK7N
	 tswTiuIR1X/flWv3oCWti80seJOMKt1W5+a1YgU8InQ0tKvdT5ocjyMCuW2NfVH8tBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A+NEP1DZ;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE5D606A322;
	Mon, 16 Nov 2026 21:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE5D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A+NEP1DZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794865538; x=1826401538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t2yvB9DYmiJPK3oV/xa3zYvTyeZSfQsNGh82q3/TX7A=;
  b=A+NEP1DZR7fj4UgNAp4Jv3eo25SDI6k7zJXl3q75r6Up/O5/jDIHrbqD
   1gMaHG9E5KmNVSxP8Mbwo8TgJF3tyqp3qok9wII31yN4azgO4n93EH0cX
   8NmDj+RlGFTxmTRsR9D4qK7vkNMXcUWsXbrAuMpDfp/XP7OZStx6YfAQg
   iZLvMlvYEF2VSn8HPX1pxRxC23aedJSkWgz81OaPqxIvmKukw1ETRcv3y
   Tk3G6KoJTrDQ2BZQmoVbkfP+n8/bNwBZt/bqPo0+/YHiicKnPLolRBdtY
   73du/cYFnJIK9yehlEXkwwJfVax/mTnI/z7eJY3N7kO5i0hQaszrZftpd
   Q==;
X-CSE-ConnectionGUID: Yi2WVLUsTgWEzixjP3LfIQ==
X-CSE-MsgGUID: ONuiZEJdQ/mKVct/cNJtDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3653564"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3653564"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 13:45:37 -0800
X-CSE-ConnectionGUID: O+r/9rycSDmDnwJ6WpoZsA==
X-CSE-MsgGUID: zY5GI7BESF2oA4WmbY4NnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="10175777"
Received: from skuppusw-desk1.jf.intel.com (HELO [10.24.80.125]) ([10.24.80.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 13:45:37 -0800
Message-ID: <2bd3ff86-d13f-41f5-acb5-def8c1a4fbaf@linux.intel.com>
Date: Mon, 16 Nov 2026 13:45:36 -0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] PCI/PME: Resume Catlow Lake Root Ports on PME with PME
 Status clear
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>
References: <20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <avsyp3TXjgj8km7T@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <avsyp3TXjgj8km7T@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bjorn,

Please let me know your comments.

On 11/16/26 08:43, Lukas Wunner wrote:
> On Tue, Nov 03, 2026 at 11:31:36AM -0800, Kuppuswamy Sathyanarayanan wrote:
>> Intel Catlow Lake PCH Root Ports do not set PME Status in the Root
>> Status register when they generate a PME for their own hotplug event.
>> The PME interrupt itself is delivered.  PMEs from devices below the Root
>> Port are reported correctly.
>>
>> PME and hotplug share the same interrupt.  When a hotplug Root Port
>> runtime suspends to D3hot, pciehp disables hotplug interrupts and relies
>> on PME to resume the Port.  On a hot-add the Port signals PME, but Root
>> Status stays clear.  pcie_pme_irq() then returns IRQ_NONE.  pciehp_isr()
>> also returns IRQ_NONE because hotplug interrupts are disabled.  The Port
>> stays in D3hot and the new device is never enumerated.
>>
>> Mark the affected Root Ports with a new PCI_DEV_FLAGS_PME_UNRELIABLE
>> flag.  If such a Port interrupts while not in D0 and PME Status is
>> clear, pcie_pme_irq() resumes the Port.  pciehp re-enables hotplug
>> interrupts on runtime resume, and pciehp_check_presence() finds the new
>> device.  pciehp itself is unchanged.
> [...]
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Link: https://lore.kernel.org/linux-pci/ara-_IPXV_i90if1@wunner.de/
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

