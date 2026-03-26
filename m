Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1387B33B961;
	Thu, 26 Mar 2026 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560232; cv=none; b=NvGPhP/WliFIEDgH8YwQSjiTjfJ7OyiyR8P3qSCRhotwj4+8uLNDbECSyCv0Kb3Xm2gj9b6gBykypkUlIS15ErSyQh22yliPj/L2ANccmPnY9rv1t/D5/0c1D8fK7bvrQy6glnvCA7ONb4zFQR0aH/uHiy4aJqORFyQNDBWacq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560232; c=relaxed/simple;
	bh=FhluOVIZepRAewJwEulzIW1IFQEUQRZGDOeDiLfWatI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+AZzDnJcSZ2U9MAB+r4Gq11RgcXGWcgHs1KAQJIWVQgOgPT+bCN8/5nkpeSm1Hs/1a8q8uBocw5O2pQd5JFEeJq1Hy7SNhBGkhFrluAU9vhwJvI0Kl0czgOkmSLzFIT+l9p5KA6jtvmXLPud0yhzZQoAsbyGHx5SscG2xT6Z9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Segy6HIV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Segy6HIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774560231; x=1806096231;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FhluOVIZepRAewJwEulzIW1IFQEUQRZGDOeDiLfWatI=;
  b=Segy6HIV9yyU/clJbR3rZDHrT7urpvlKheKo6ejxB35w/oVKky434pFV
   /MZiiyXkf2Gx2LAxVWuMyiWKj3+PCWEJ/62Cbjj7CNHCJ6EygwrfcR+Pn
   nkgUO1a9Q4768PG/xYpbjLOhGfxmlflDMBMIujn5J2mbn3ClCl9PNd6aI
   7tZ2fiQsPy1k6NpXhO3oBbbGF+EHi15b9j6BiT1miJWtiRghBwmUFQY4y
   m8/PJWk/5ZIz8DxAaJA5Bp+dDudQdZqIlIqSwregbJxtXa70OcHE8Lu/H
   2qZwZbtkYuNwm/r8VvfQucnie3XwQTwP2BhuWzkBqizcMOeM9D04ES8tX
   Q==;
X-CSE-ConnectionGUID: /Zkvaoj+QjqznEPCqmkpDQ==
X-CSE-MsgGUID: 03XtDn3dSviWuXi9USZ8YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75525306"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75525306"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 14:23:51 -0700
X-CSE-ConnectionGUID: d7nIro01TMi7i+uBF7B5VA==
X-CSE-MsgGUID: zKfQGo63TrC2jaOjAnFEww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="263034482"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 14:23:51 -0700
Message-ID: <3a97fb38-70c7-4ca9-8c49-4c95e1623c91@linux.intel.com>
Date: Thu, 26 Mar 2026 14:23:50 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323232437.GA1085990@bhelgaas>
 <ca15feda-5d63-405d-a4c4-00cbb9991fed@linux.intel.com>
 <20260325061131.GY2275908@black.igk.intel.com>
 <5d6d94b4-458f-473c-84df-c6fab7805dbe@linux.intel.com>
 <20260326061200.GA3552@black.igk.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260326061200.GA3552@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mika,

On 3/25/2026 11:12 PM, Mika Westerberg wrote:
> On Wed, Mar 25, 2026 at 02:12:48PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>
>>
>> On 3/24/2026 11:11 PM, Mika Westerberg wrote:
>>> On Tue, Mar 24, 2026 at 02:45:25PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>>>> eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
>>>>> cleared PCI_EXP_SLTCTL_HPIE so that when the link goes down, we
>>>>> wouldn't get a PCI_EXP_SLTSTA_DLLSC interrupt and wake the system.
>>>>>
>>>>> I don't know the details of why the PCI_EXP_SLTSTA_DLLSC would cause
>>>>> that wakeup.  I would think pciehp should field that, and it should be
>>>>> able to figure out whether to bring the port out of D3hot.
>>>>>
>>>>> Anyway, with this patch it looks like we'll leave PCI_EXP_SLTCTL_HPIE
>>>>> set, and potentially get that PCI_EXP_SLTSTA_DLLSC interrupt again?
>>>>
>>>> I have tested this patch on Catlow Lake. Enabling HPIE does not result in
>>>> spurious wakeups as mentioned in Mika's patch.
>>>>
>>>> Mika, any comments?
>>>
>>> What do you have connected to the slot?
>>
>> A network card.
> 
> Okay.
> 
> Out of interest how do you hotplug it? :)

We physically remove and insert the card.

> 
>>> IIRC the interrupt triggers when presence change toggles (due to the link
>>> going down).
>>>
>>
>> I have tested the s3 mode. I was able to see message related to system entering
>> suspend and then coming back again after (after user intervention). I also noted
>> pcie_disable_interrupt() called before suspend and pcie_enable_interrupt() called
>> after resume.
> 
> In case of S3 the BIOS also configures the hardware before entering
> suspend. On client at least it's suspend-to-idle and any interrupt will
> bring the CPU and the system out of it. It could be that that's the reason
> you don't see any issue if this is server system and it goes into full S3?
> 

Looking at the kernel logs, the system is actually using suspend-to-idle 
(s2idle), not full S3:

  PM: suspend entry (s2idle)

So this is the same suspend mode where you observed the spurious wakeup issue.
Interestingly, we're not seeing the problem on Catlow Lake with HPIE enabled.

I am trying to understand the wakeup sequence in your case. IIUC, before the
system enters suspend, it will put the device and port in D3hot, right? So link
down should happen before the system goes to sleep or idle. At what point does
the spurious DLLSC interrupt occur that causes the unwanted wakeup?



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

