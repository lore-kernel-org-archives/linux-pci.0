Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A32E5B21;
	Wed, 25 Mar 2026 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473171; cv=none; b=f1yeeudsA7+ScvL+kNRPSgk/pjIzFKDR3pXmvVy2ZOQQ1bBhkswfb5jUY4/g6Usr7tNXaatdJgDMPhoke4NI6z185+5OLETDF89+g5Er+AU6KGaVPA9qi92V+MdPGpGA8i+XYKAXoSl9EPZSCqSifB0NZ4LO9JlVRZDGjTclVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473171; c=relaxed/simple;
	bh=NxvBGH/abql62elxDwoWqwKvXejmgsVsSmc9ofRp83c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0dhRL8ILcltbyRefUpKPixLg/vwDMRMXd7XeLeQwB5v4HK3FZ1LkBAW5S/8cZvSVJBMRh3juWrB3juU7BF/UkLgOMaU+hfnzt2ZrX3rRCdkJzkTECgexOqanHmb1v/wZtAautAnepKLdEo11HhjuScqg4Gvzq9M5J+7Sew/5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IReDBQMy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IReDBQMy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774473170; x=1806009170;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NxvBGH/abql62elxDwoWqwKvXejmgsVsSmc9ofRp83c=;
  b=IReDBQMyIijVGQH+od3YdZkolcfG4csIg4nhudWIpgTHEFAFXTXt/olo
   UOM0VVHyQcnCHBc/lHCMjP9vYX8NaSRYVd6XYpd34+UxH2zt4KEOozRxq
   9zdBm3kEnPSyZW3kw+REWvbGYxX0s3W6ajHbt33e5bDIkrtroUWPuhez1
   zoRnbGSnRo/xxhx5MN0ZfqDYMtsv3UPe/10VRP+Z4IIYqfD/Lr1cxQQrv
   ioI10jNIWBELI8jL5kRnXyVmaQWNH+VtQHg3diGWsZqUFNzcKcG9Q1KJX
   O8t8GJK6V+kUYaN/OLuLGwmxtgWSOBt+xR/i06zxM3WPjdz+fFbv1r0uQ
   A==;
X-CSE-ConnectionGUID: 1wziZEg9TraE0MlaQOj3Qg==
X-CSE-MsgGUID: QI/eS4InTq+tf0M/UjiZUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75637615"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75637615"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:12:49 -0700
X-CSE-ConnectionGUID: ElEvDgu2SsGwms/JQKzNGA==
X-CSE-MsgGUID: 87i1nf5FQW+Q8LQlOe5AHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224808976"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:12:49 -0700
Message-ID: <5d6d94b4-458f-473c-84df-c6fab7805dbe@linux.intel.com>
Date: Wed, 25 Mar 2026 14:12:48 -0700
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
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260325061131.GY2275908@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/2026 11:11 PM, Mika Westerberg wrote:
> On Tue, Mar 24, 2026 at 02:45:25PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>> eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
>>> cleared PCI_EXP_SLTCTL_HPIE so that when the link goes down, we
>>> wouldn't get a PCI_EXP_SLTSTA_DLLSC interrupt and wake the system.
>>>
>>> I don't know the details of why the PCI_EXP_SLTSTA_DLLSC would cause
>>> that wakeup.  I would think pciehp should field that, and it should be
>>> able to figure out whether to bring the port out of D3hot.
>>>
>>> Anyway, with this patch it looks like we'll leave PCI_EXP_SLTCTL_HPIE
>>> set, and potentially get that PCI_EXP_SLTSTA_DLLSC interrupt again?
>>
>> I have tested this patch on Catlow Lake. Enabling HPIE does not result in
>> spurious wakeups as mentioned in Mika's patch.
>>
>> Mika, any comments?
> 
> What do you have connected to the slot?

A network card.

> 
> IIRC the interrupt triggers when presence change toggles (due to the link
> going down).
> 

I have tested the s3 mode. I was able to see message related to system entering
suspend and then coming back again after (after user intervention). I also noted
pcie_disable_interrupt() called before suspend and pcie_enable_interrupt() called
after resume.

If required, I can repeat the test and collect logs. 


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

