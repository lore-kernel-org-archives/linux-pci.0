Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80554145F;
	Tue, 29 Sep 2026 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703752; cv=none; b=kbKBG4NQ11gg5y0nJBQAnQnMx1DfBSTcf+cE7DX4uwjDtLnrlaMz4uj1AWwXmnX4+ZuFvCcy/GlBUk6eldsyZZauB8F2r9XukHKnDbCFc32eIBo8XVkk4VAndJfT+VqnncIw55G1hhO4FBjN7Y6Wbu6ppfVmJ0k8zubTrRnvY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703752; c=relaxed/simple;
	bh=nRyD4a/hB8am2cmvhjozymSRZLwXE8yMvtgh2kC5rx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G55y9Zt1oMQDXJtX57nZGLH50UtF+5y8J7bigey9RA9D+V0cL+8mN+uwPAKkHgLDy62ttE9+HYfH2w1T8GHLW4ikVVnPlCTk1fwrosI3spLfUvgZEs/i0PTy+O1CvDDPa8dZx8izEoalmzBE+T00CJZ+7awkaBq84QePmAeMMYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VoNR+EWI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VoNR+EWI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790703750; x=1822239750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nRyD4a/hB8am2cmvhjozymSRZLwXE8yMvtgh2kC5rx4=;
  b=VoNR+EWIwwPLVqxWPcT1GsCNuGhMgcp7SwjS1D/nyIhvi/xs8gm1R8+9
   xEapHWdJPp+6R4LwxZVvXxW35UObP40uSKpZ89lyQZC3XMt7+WcGckNN/
   Cp+OMkZlK0TYI3ByjEtCC1Z+/VYdzA3djuzGqtmR4oSeLqTaanqhCcgh7
   oWhoyM4LnxtX6/A0HoVx+2Yl7sdOESxtNZjolX85MPFGNKd6uf1QjYAUG
   yUwMVq1U78EPxRjqs/kJt19A+fkz0m1VJIYfjqx05hee7l+tU0iO2Suv/
   svm+KxmL2ucuW+gC6/RJM+vvnwzm7AqyjZVcpFem51ZPheiG96iYSz3AW
   A==;
X-CSE-ConnectionGUID: O8V7RQAGSAiccygWz9OzTA==
X-CSE-MsgGUID: UY8qubdwQlyd86i4WK1ovA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90484680"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90484680"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 10:42:29 -0700
X-CSE-ConnectionGUID: iqj9BKCGRWWgCg4P7qDSAQ==
X-CSE-MsgGUID: 0GrdSjn4Q/u+9LmgjfF48g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="271923181"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 10:42:29 -0700
Message-ID: <53b1d658-9b37-4721-b6bc-b1f0379c5649@linux.intel.com>
Date: Tue, 29 Sep 2026 10:42:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5d6d94b4-458f-473c-84df-c6fab7805dbe@linux.intel.com>
 <20260326061200.GA3552@black.igk.intel.com>
 <3a97fb38-70c7-4ca9-8c49-4c95e1623c91@linux.intel.com>
 <20260327111616.GC3552@black.igk.intel.com>
 <633cef07-2991-4ce8-b8c6-6b091deaeb0b@linux.intel.com>
 <20260407070800.GF3552@black.igk.intel.com>
 <bd8e9c59-afd8-48ac-ad54-64abad8bfbd1@linux.intel.com>
 <161e11c7-af4c-4cc7-8ad5-a5901f231d54@linux.intel.com>
 <20260925051922.GU106095@black.igk.intel.com>
 <c5754240-1768-44a2-869c-6b159fd54907@linux.intel.com>
 <ara-_IPXV_i90if1@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ara-_IPXV_i90if1@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/2026 11:35 AM, Lukas Wunner wrote:
> On Fri, Sep 25, 2026 at 10:38:08AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Once the port is in D3hot, pciehp has cleared HPIE and depends on PME.
>> That is where Catlow breaks. The PME interrupt arrives, but PME Status in
>> Root Status is never set. pcie_pme_irq() returns IRQ_NONE, the port stays
>> in D3hot and the hot-add event is lost.
> 
> If a device below the Root Port (instead of the Root Port itself)
> signals PME, does the Root Port misbehave in the same way?
> I.e. is the PME Status bit clear in that case as well?
> 
> If so, the proper solution might be to add a quirk to the PME driver,
> not the PCIe hotplug driver.

I don't know, since my test only ever exercises the Port's own PME.  I will
collect that data and get back to you.

> 
> pcie_pme_irq() checks PME Status and bails out if it's not set.
> That would need an amendment such that Root Ports with broken PME
> would always assume it's set if they receive a PME.  I think that
> would be safe because even though PME is shared with other interrupts
> such as hotplug, I think it's the only interrupt source once the port
> is in D3hot.
> 
> There's another check for PME Status in pcie_pme_work_fn().
> This one is tricky because it uses the PME Status bit to jump
> out of the for-loop.  Does the Root Port at least set the
> Requester ID to an appropriate value?  If so maybe that can be
> used as an indicator whether the loop should be terminated.
> 
> Or maybe the PME Pending bit can be used in lieu of PME Status?
> 
> Thanks,
> 
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

