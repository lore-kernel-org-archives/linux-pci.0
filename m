Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AB3783CC;
	Wed,  7 Oct 2026 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791402962; cv=none; b=jz4UaXJM4AmNljWUcNwH8M2KLAY6CgEOdnhqcw0zj8cBzTDL0tO8WqI8+fu7fAIf3YSTP6EOGpDFevczBu82dV/l70o6bSstnHmxjB4sr5qBKBgoweWg9FH1KEGR5mDbms1JAn0Wk0YnluOl2dX6j+fgPsiP2SrKcq58hFpoAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791402962; c=relaxed/simple;
	bh=90bIuj+lxMdhobkGxdvUltqhBkAsksaxvsA/HHtEM4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYltQMoCwSv0NWbdkpirWswuP6hoOUT59dzMkdVI8JFEzTn6b/lFkvbqkM/tbcBJcZgkCQXck0YYLvH/IPkBOMkS8oCWwM+mpMOR4d2tw5u4fyuaOSocaY/9vIT6hBvRMS2MlKdSVqtU9psDwEw1AN+2FU2E4YcuuuI3kTw5Oow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLD5N2nY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLD5N2nY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791402961; x=1822938961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=90bIuj+lxMdhobkGxdvUltqhBkAsksaxvsA/HHtEM4Y=;
  b=iLD5N2nYBDlr8R8Z22/ezbkQtbA3U3r60OS4DZXbspI7pWH2sU5TWmtB
   rLUtwz4pyl+w/BygJ3OuPDlfDk+MiXcwFonXvsSpGhn2owIrpLkQRmNWv
   Ze6z9tqR8Y+pfqLqknRi2xHSYDM2OKWJEEnKtm/a3nknp8r2nsgzdqq+g
   y4+h+Kdq2NzibwPmXl/hgnvm/Vb0PS5XJxjO/cZb3gxFPce30LLr8Cb56
   FzORH8GakVav3+DS+qXul1UeulAtG2D34Vfje//brp6VvgCxpK6+zWknK
   UjRO7LCzWbJ5GpWrwluzrZ4EHf1xngkwtQwxNJx8RPmz7zrPEFG4vd3/Z
   w==;
X-CSE-ConnectionGUID: hSlXhpSzTn6Al4IZuVEqPw==
X-CSE-MsgGUID: WKn1hY2pSua3s2BGeY0dGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="284207"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="284207"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 12:56:00 -0700
X-CSE-ConnectionGUID: amGoUA8JRXGTlzGpze0JZg==
X-CSE-MsgGUID: S/tvMyPAQ6ChbOyPEpGOmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="128993"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 12:56:00 -0700
Message-ID: <c7a3ef34-27f0-4b0b-8eab-db0fff15588d@linux.intel.com>
Date: Wed, 7 Oct 2026 12:55:58 -0700
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

Hi Lukas,

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

No, a downstream PME is reported correctly.  I tested with a NIC at
0a:00.0 (8086:1533) connected below Root Port 00:1c.6 (8086:7a3e).  The NIC
and the Port were both runtime suspended to D3hot, and the NIC woke on link
change.  All six PMEs I captured had PME Status set and Requester ID 0x0a00,
which matches the NIC's BDF, and went through the normal path in
pcie_pme_handle_request().

> 
> If so, the proper solution might be to add a quirk to the PME driver,
> not the PCIe hotplug driver.

Given the above, the problem is narrower than broken PME in general.  It
only affects the PME the Port generates for its own hotplug event, and
hotplug is the only user of that.  So both drivers are possible places for
the fix, and I would like your and Bjorn's preference before sending v5.

1. pciehp route (v4)

   https://lore.kernel.org/linux-pci/20260323223056.3119060-1-sathyanarayanan.kuppuswamy@linux.intel.com/

   A quirk sets PCI_DEV_FLAGS_PME_UNRELIABLE on the affected Ports, and
   pciehp_disable_interrupt() skips clearing HPIE for them.  The Port
   still goes to D3hot, but hotplug events arrive as ordinary hotplug
   interrupts and PME is not needed.  The downside is that it changes the
   suspend behaviour added by eb34da60edee, which was Bjorn's concern.

2. PME route

   Keep the same quirk flag, leave pciehp alone, and handle it in
   pcie_pme_irq().  If a quirked Port interrupts while not in D0 and PME
   Status is clear, resume the Port.  pciehp_runtime_resume() then
   re-enables HPIE and pciehp_check_presence() finds the new card.
   Downstream PMEs still set PME Status and take the normal path, and
   pcie_pme_work_fn() is unchanged.

	if (PCI_POSSIBLE_ERROR(rtsta)) {
		spin_unlock_irqrestore(&data->lock, flags);
		return IRQ_NONE;
	}

	if (!(rtsta & PCI_EXP_RTSTA_PME)) {
		spin_unlock_irqrestore(&data->lock, flags);

		/*
		 * Some Root Ports don't set PME Status for a PME they
		 * generate for their own hotplug events.  While the Port
		 * is not in D0, PME is the only interrupt it can signal
		 * for such events, so resume it and let pciehp pick up
		 * the event.
		 */
		if ((port->dev_flags & PCI_DEV_FLAGS_PME_UNRELIABLE) &&
		    port->current_state != PCI_D0) {
			pci_wakeup_event(port);
			pm_request_resume(&port->dev);
			return IRQ_HANDLED;
		}
		return IRQ_NONE;
	}

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

In the failing case Requester ID stays 0000 and PME Pending is not set
either, so neither can be used in place of PME Status.  That is why option
2 resumes the Port directly from pcie_pme_irq() and does not go through
pcie_pme_work_fn() at all.


> Thanks,
> 
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

