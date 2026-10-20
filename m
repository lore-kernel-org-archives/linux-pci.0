Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517855;
	b=wEPZWiO57o13hL8cE2Ybt7MAcwdRyZvpuFwqdiJ9VV+LytktjIWICvVXP8G3iDY7YF4T
	 sXi1hHYEqhWjmQ0KkMiyeSJV6Wr7XSqG25RMeKczQnHUYXrsC7abIgbNezKKKKwKYZDGP
	 LscLp+HE0Imijmga7Lv/U3thkhLEK4wGWUeuAurzbLJGpnt2BViaLEDtNaCM0AD0s7qP7
	 KwXF/WIExQn5VCEY1g4K9t9GiBg0CylVlDqAwsHUQ15/enagz6QIsZ7nQ444ptnme0Y/G
	 hpqZlPEJRtrUlD6KgcCzj6vlGqKr/c6ElnYZfvNqgPGLARxf0OkH13QTKjiv5lym2Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517855;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=PcHs3T9RNrjGJ/kkw/QX7ghnAHX+LL460ZrxWT/X6TQ=;
	b=qBV/uRJysCTLiWT8x8tPdNYkG3/bt5WT3L8NzmPEFH5quG1ay1nv9iIY43kneHWNOURB
	 cLNIdTPGazUnMfxlv3wdsGggnQFIPlfDBYpeNZ+ctcPJ+Sc8v3NFHrhvS6JGvLRuIxsEb
	 C6jG2fUWpBJAqE+pXOs6OE2qIzDCYwwDuu1y8e/WoPk58XLHQwlVQD2fYXCFR7izCTdG/
	 mLEaQ5ckh7asavv99j5NzQyDci/4N32fRvDX7hk6g0T23z+68RvUvVMaKscjLq9JfYvIF
	 Ph2B9ViQYcBrsRqb6Ihwq0XpS1JTgTf0KGvZGopLOfDZwepUZLrv6mtKLSavOTGcKOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GLgJmHEo;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429D4606A329;
	Tue, 20 Oct 2026 17:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 429D4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GLgJmHEo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792517854; x=1824053854;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=lNY8eB2S7ON/APhcHIHq/+A9keCJvLb9p9kaRvUVAbc=;
  b=GLgJmHEobuh9Kx+nNCC9kMQaAqHKAYcg8dJHjPJ4Jo+7k2879RJauwv7
   NE7Kpi/kwlArCzJ4aeJh2fJ+6qlIAeM8Rf8iW5kkwyvjDhb88sYbC1Eeo
   L+2va2tYAIwbsfffl+X5+V4JuTmtULPzOP1h4HA+2aGppmm9AVlEnmD6C
   1inTa1T7zqkiDGNp18+Y7M+noiZ4+6eVAaVDnyd/ktkHDr+oDF4by8O7E
   WWkPjg+fVqL00F1LIxZG5C1/VElFpb/Wm8CmGWmWFinQM0beMEsmsFEls
   6uoFSwYXCKCzQ6MI4ig4uJAPvfhAbVg7CiM4AxSLA+eB0Yi+x4fAD4bIY
   A==;
X-CSE-ConnectionGUID: 6bEkv7VEQSKtI/rxq9hkBQ==
X-CSE-MsgGUID: 07uAqTrNSby9XxE8399OLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1231583"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1231583"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 10:37:33 -0700
X-CSE-ConnectionGUID: azKgqgXKSvqLLNw/Tfd9nQ==
X-CSE-MsgGUID: nI6MZLtBRWSKB1vQilL02w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3200380"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 10:37:29 -0700
Message-ID: <074b0b65-b9fb-477e-b511-d09fb1915614@linux.intel.com>
Date: Tue, 20 Oct 2026 10:37:27 -0700
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
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
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
 <c7a3ef34-27f0-4b0b-8eab-db0fff15588d@linux.intel.com>
Content-Language: en-US
In-Reply-To: <c7a3ef34-27f0-4b0b-8eab-db0fff15588d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lukas, Bjorn,

Gentle ping on the two options in my mail below.  In the meantime I
validated both approaches on Catlow Lake with physical hot-remove and
hot-add, and both fix the issue.

Please let me know which one you prefer and I will send v5 with that
approach.

On 10/7/2026 12:55 PM, Kuppuswamy Sathyanarayanan wrote:
> Hi Lukas,
> 
> On 9/25/2026 11:35 AM, Lukas Wunner wrote:
>> On Fri, Sep 25, 2026 at 10:38:08AM -0700, Kuppuswamy Sathyanarayanan wrote:
>>> Once the port is in D3hot, pciehp has cleared HPIE and depends on PME.
>>> That is where Catlow breaks. The PME interrupt arrives, but PME Status in
>>> Root Status is never set. pcie_pme_irq() returns IRQ_NONE, the port stays
>>> in D3hot and the hot-add event is lost.
>>
>> If a device below the Root Port (instead of the Root Port itself)
>> signals PME, does the Root Port misbehave in the same way?
>> I.e. is the PME Status bit clear in that case as well?
> 
> No, a downstream PME is reported correctly.  I tested with a NIC at
> 0a:00.0 (8086:1533) connected below Root Port 00:1c.6 (8086:7a3e).  The NIC
> and the Port were both runtime suspended to D3hot, and the NIC woke on link
> change.  All six PMEs I captured had PME Status set and Requester ID 0x0a00,
> which matches the NIC's BDF, and went through the normal path in
> pcie_pme_handle_request().
> 
>>
>> If so, the proper solution might be to add a quirk to the PME driver,
>> not the PCIe hotplug driver.
> 
> Given the above, the problem is narrower than broken PME in general.  It
> only affects the PME the Port generates for its own hotplug event, and
> hotplug is the only user of that.  So both drivers are possible places for
> the fix, and I would like your and Bjorn's preference before sending v5.
> 
> 1. pciehp route (v4)
> 
>    https://lore.kernel.org/linux-pci/20260323223056.3119060-1-sathyanarayanan.kuppuswamy@linux.intel.com/
> 
>    A quirk sets PCI_DEV_FLAGS_PME_UNRELIABLE on the affected Ports, and
>    pciehp_disable_interrupt() skips clearing HPIE for them.  The Port
>    still goes to D3hot, but hotplug events arrive as ordinary hotplug
>    interrupts and PME is not needed.  The downside is that it changes the
>    suspend behaviour added by eb34da60edee, which was Bjorn's concern.
> 
> 2. PME route
> 
>    Keep the same quirk flag, leave pciehp alone, and handle it in
>    pcie_pme_irq().  If a quirked Port interrupts while not in D0 and PME
>    Status is clear, resume the Port.  pciehp_runtime_resume() then
>    re-enables HPIE and pciehp_check_presence() finds the new card.
>    Downstream PMEs still set PME Status and take the normal path, and
>    pcie_pme_work_fn() is unchanged.
> 
> 	if (PCI_POSSIBLE_ERROR(rtsta)) {
> 		spin_unlock_irqrestore(&data->lock, flags);
> 		return IRQ_NONE;
> 	}
> 
> 	if (!(rtsta & PCI_EXP_RTSTA_PME)) {
> 		spin_unlock_irqrestore(&data->lock, flags);
> 
> 		/*
> 		 * Some Root Ports don't set PME Status for a PME they
> 		 * generate for their own hotplug events.  While the Port
> 		 * is not in D0, PME is the only interrupt it can signal
> 		 * for such events, so resume it and let pciehp pick up
> 		 * the event.
> 		 */
> 		if ((port->dev_flags & PCI_DEV_FLAGS_PME_UNRELIABLE) &&
> 		    port->current_state != PCI_D0) {
> 			pci_wakeup_event(port);
> 			pm_request_resume(&port->dev);
> 			return IRQ_HANDLED;
> 		}
> 		return IRQ_NONE;
> 	}
> 
>>
>> pcie_pme_irq() checks PME Status and bails out if it's not set.
>> That would need an amendment such that Root Ports with broken PME
>> would always assume it's set if they receive a PME.  I think that
>> would be safe because even though PME is shared with other interrupts
>> such as hotplug, I think it's the only interrupt source once the port
>> is in D3hot.
>>
>> There's another check for PME Status in pcie_pme_work_fn().
>> This one is tricky because it uses the PME Status bit to jump
>> out of the for-loop.  Does the Root Port at least set the
>> Requester ID to an appropriate value?  If so maybe that can be
>> used as an indicator whether the loop should be terminated.
>>
>> Or maybe the PME Pending bit can be used in lieu of PME Status?
>>
> 
> In the failing case Requester ID stays 0000 and PME Pending is not set
> either, so neither can be used in place of PME Status.  That is why option
> 2 resumes the Port directly from pcie_pme_irq() and does not go through
> pcie_pme_work_fn() at all.
> 
> 
>> Thanks,
>>
>> Lukas
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

