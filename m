Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91E340A7D;
	Wed, 18 Feb 2026 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432082; cv=none; b=oHYRrDshFJveVflHqbDBY4fktvARNu6E7sIyKmYTDlEMBrG2VMcj0Hk1Aa8cNFtsj6qW4xSAqM3g9X+t5O1FZM8qG+AEQDBXb5ZKLe2YgmwaeXZ15tPhuggnvA/EcpRAnPmV71lvbYG3Wh5W9xoBMEE7ytShnU+gkwfO04MwHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432082; c=relaxed/simple;
	bh=VocakYWepX2xze/0NydVE16ure0+YOLZWXz5qgKsR7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9QAB0IjEl3+SQiD/ogE9Su+wJYU/P9+MtrlkccZSryJz1fTBdjwx9quknkriWkTdSuFNSyBFg+5YFMdjLCjmqMq+mOC/iuoL6I1rjz7Px/SVidMBwpzCbVyYJsWiPwfuFthc5DNjfXYj2ch4rNWhNi/MBhOjyNU4c3JF1LxxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JguKQgmP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JguKQgmP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771432081; x=1802968081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VocakYWepX2xze/0NydVE16ure0+YOLZWXz5qgKsR7k=;
  b=JguKQgmPV3C2OxcbmM21ajYEo/55DRskPLKDjD0M0QBF3KedlghHOiyp
   g944sBH87pdy7mLm4bBbrBuBTteY9m/Nz4eF1U5zs/cS2dfya1UDrigY1
   LniqJlmRyGrEi7YdGtRAsDbhKwhcD+H52Glk0Dgj6YRLT86RlZ/fKDGBm
   /+rKS/PY60LFhFyIEqIMXKPR83jQMGfg7RmKiQK5OH1NVF6DxA/VYOR6i
   YFrD7Fh4vppNuQqI6j2tQSEGamhgZy8NxBOrdb3GbgwrQHKbDbSeUvps2
   IjCrdlVHvRttoitYtygPSN7Ezvq4MYJA6PZKz63O4672+7GEDukp9mIzh
   g==;
X-CSE-ConnectionGUID: QuVHyS0+R7m1YQcf2/gf2w==
X-CSE-MsgGUID: 6plIbct+R+iF9XqjblE9Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="90095147"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="90095147"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 08:28:01 -0800
X-CSE-ConnectionGUID: +KcOij2OToetnw1ElMy7TA==
X-CSE-MsgGUID: wZGZjE4CTYuKohfp9HD/2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="213478726"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 08:28:01 -0800
Message-ID: <1fe249bb-fc41-4387-a25e-69b33bde696f@linux.intel.com>
Date: Wed, 18 Feb 2026 08:28:00 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <aZAPqQTiGQiDvX52@wunner.de> <aZCQsyL9RRessjMI@wunner.de>
 <70533ce4-265e-449c-bd63-06f2d7f5bdf1@linux.intel.com>
 <aZSx3NF5gZ0rLIVU@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aZSx3NF5gZ0rLIVU@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lukas,

On 2/17/2026 10:22 AM, Lukas Wunner wrote:
> On Tue, Feb 17, 2026 at 09:01:25AM -0800, Kuppuswamy Sathyanarayanan wrote:
>> On 2/14/2026 7:11 AM, Lukas Wunner wrote:
>>> I've just realized that pcie_disable_interrupt() isn't called from
>>> pciehp_suspend() if pme_is_native() is true.  Should disabling
>                                            ^^^^
> Sorry, I meant "if pme_is_native() is *false*".
> My brain was apparently half asleep when I wrote this.
> 
>>> runtime PM cause a power regression, an alternative solution may be
>>> to make pcie_disable_interrupt() conditional on a new pme_is_broken()
>>> which checks for affected Catlow Lake PCH Root Ports.
>>>
>>> The pm_runtime_disable() approach is slightly preferred because
>>> it keeps pciehp code clean.
>>
>> I think pcie_disable_interrupt() is called from pciehp_suspend() when
>> pme_is_native() is true. Looking at the code:
>>
>> static void pciehp_disable_interrupt(struct pcie_device *dev)
>> {
>>         /*
>>          * Disable hotplug interrupt so that it does not trigger
>>          * immediately when the downstream link goes down.
>>          */
>>         if (pme_is_native(dev->port))
>>                 pcie_disable_interrupt(get_service_data(dev));
>> }
> 
> What I had in mind is something like:
> 
> -	if (pme_is_native(dev))
> +	if (pme_is_native(dev) && !pme_is_broken(dev))
> 		pcie_disable_interrupt(get_service_data(dev));
> 
> Again, the pm_runtime_disable() (or pm_runtime_get_sync()) approach
> is slightly preferred because it keeps pciehp code clean and confines
> the issue to a quirk that only needs to be compiled in on x86.

Got it. Thanks for clarifying.

> 
> Thanks,
> 
> Lukas
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

