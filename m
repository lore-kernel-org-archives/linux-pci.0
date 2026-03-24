Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA62F12CE;
	Tue, 24 Mar 2026 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774388728; cv=none; b=qcSFOowOwkKE9Gj5AlEvWDG+omltCa1kla/PGClrQn6qAkeyJjO3YcEjc43kBMVF0wLLzk8HwfcBtALbskNJ8fqOgi+kycc1lVu40C3JrS6PmY9d6rO0wth9GtonhoY913u1/doqp5eW4X95d9ZDvAZLVFAyBjT2TjswX5XHYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774388728; c=relaxed/simple;
	bh=5Uc/M6y8RJwDOsK/l7s8dkHkFkXNdMK9r4JiItpJkbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSIsSFkAjtn+9NCBp2+6HIFLGaqBX+PweKXcpBp9tRArR2Y8/9LvVc26GUNuX9Ovtuhx5Us5blkJLrcoeuPxlHkHqzABQ207uIDmt+F1jKQSN7p7RGZ5a35nUnFd1RWg70qY9PMC9xRIrISa7SVQqB7CfGKCc1trowWHF72GeKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoFpiXr/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoFpiXr/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774388726; x=1805924726;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5Uc/M6y8RJwDOsK/l7s8dkHkFkXNdMK9r4JiItpJkbo=;
  b=IoFpiXr/kOUA0+WGQuVhD95c2ARD90+eVD6mWzZsM3AAobldsVdq35pF
   LQwXlPtS6j1ie1xg3IrvuIjFjBX60mmCMxVK8JpVzmAt63/guX5VAViTy
   iLv5Ez6rrDcJXnWsM+mG6XAuYl3RxsT7iks0MP3aTEdYS+5hVwMU9vEsL
   su4zzXeslKqzgWo9LovFJDY3xS//jS2kVhyVjQN5LrP6LYhh7YtDSxBN5
   LX/2KNl9qXlbitsNkIQOAfzrmMLJVvKDEenC25+DqT9N/Rry1X/iQW5Ct
   EhXvO/NWhgj1xr405vYfucsQYGrVa7PFaZBzvDnk1ZbpidH7pXb99AYRu
   Q==;
X-CSE-ConnectionGUID: kIM01pv3Qj+DQpZSC+pDZw==
X-CSE-MsgGUID: KW+1hoHpRsuXOJtEcb1Zuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75303374"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="75303374"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:45:26 -0700
X-CSE-ConnectionGUID: Hpu7pOprTDesBoWW78Vieg==
X-CSE-MsgGUID: nMAbw2vqTf6SsvZvpPIe8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="221134180"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:45:25 -0700
Message-ID: <ca15feda-5d63-405d-a4c4-00cbb9991fed@linux.intel.com>
Date: Tue, 24 Mar 2026 14:45:25 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20260323232437.GA1085990@bhelgaas>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260323232437.GA1085990@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bjorn,

Thanks for the review.

On 3/23/2026 4:24 PM, Bjorn Helgaas wrote:
> [+cc Mika, author of eb34da60edee]
> 
> On Mon, Mar 16, 2026 at 03:08:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> On Intel Catlow Lake platforms, PCH PCIe root ports do not reliably
>> update PME status registers (PME Status and PME Requester_ID in the
>> Root Status register) during D3hot to D0 transitions, even though PME
>> interrupts are delivered correctly.
> 
> IIUC, the Root Status update should happen on receipt of a PME Message
> and is not directly related to a D3hot to D0 transition (PCIe r7.0,
> sec 6.1.6).


You're correct. PME status register updates occur on PME Message
reception, not during power state transitions.

I used "D3hot to D0 transitions" as shorthand for the full sequence: port
in D3hot detects hotplug event -> generates PME Message -> should update
Root Status -> PME interrupt -> port wakes to D0.

On Catlow Lake, the PME interrupt is delivered but the Root Status
registers (PME_Status and PME_Requester_ID) are not updated when the port
generates these PME Messages. This causes pcie_pme_irq() to return
IRQ_NONE, leaving the port in D3hot.

I'll clarify the commit message to avoid this misleading shorthand.
Something like below:

On Intel Catlow Lake platforms, PCH PCIe root ports do not reliably
update PME status registers (PME Status and PME Requester_ID in the
Root Status register) when receiving PME Messages while in D3hot state,
even though PME interrupts are delivered correctly

> 
>> This issue manifests during PCIe hotplug operations as follows:
>>
>> 1. After a hot-remove event, the PCIe port runtime suspends to D3hot.
>>    pciehp_suspend() disables hotplug interrupts (HPIE) to rely on
>>    PME-based wakeup.
> 
> Didn't we rely on PME interrupts anyway, independent of HPIE?

I don't think they are independent. If HPIE is enabled, hotplug interrupt
will be triggered as direct interrupt and we don't have to reply on PME
for wakeup.

> 
> eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
> cleared PCI_EXP_SLTCTL_HPIE so that when the link goes down, we
> wouldn't get a PCI_EXP_SLTSTA_DLLSC interrupt and wake the system.
> 
> I don't know the details of why the PCI_EXP_SLTSTA_DLLSC would cause
> that wakeup.  I would think pciehp should field that, and it should be
> able to figure out whether to bring the port out of D3hot.
> 
> Anyway, with this patch it looks like we'll leave PCI_EXP_SLTCTL_HPIE
> set, and potentially get that PCI_EXP_SLTSTA_DLLSC interrupt again?

I have tested this patch on Catlow Lake. Enabling HPIE does not result in
spurious wakeups as mentioned in Mika's patch.

Mika, any comments?

> 
>> 2. When a hot-add occurs while the port is in D3hot, a PME interrupt
>>    fires as expected to wake the port.
> 
> Why is a PME interrupt expected here?  I would expect a hot-add to
> cause a PCI_EXP_SLTSTA_PDC or PCI_EXP_SLTSTA_DLLSC interrupt.  Sec
> 6.1.6 suggests PME interrupts are only from Root Ports.
> 
>> 3. However, the PME interrupt handler finds the PME_Status and
>>    PME_Requester_ID registers unpopulated, preventing identification
>>    of which device triggered the PME. The handler returns IRQ_NONE,
>>    leaving the port in D3hot.
> 
> I guess this is pcie_pme_irq(), and it finds PCI_EXP_RTSTA_PME clear
> because of this Catlow defect?  It looks like it returns without even
> looking at PME_Requester_ID.

Yes, it returns after checking for PCI_EXP_RTSTA_PME. I tried modifying
it to proceed without the status check, but it still failed when reading
PME_Requester_ID (also not updated). So I mentioned both registers.

> 
> Sec 5.3.3.1 suggests that the purpose of PME_Requester_ID is to
> facilitate quicker PME service and shorter resume time.  So maybe the
> lack of PME_Requester_ID should only be a performance issue, not a
> functional problem?
> 
> If we know we got a PME interrupt, and we can wake up (maybe more
> slowly without a Requester ID), why can't we just do the wakeup
> independent of PCI_EXP_RTSTA_PME and PCI_EXP_RTSTA_PME_RQ_ID?  Are
> spurious PME interrupts a problem?
> 

Yes, I think we can call pcie_pme_walk_bus() even when PCI_EXP_RTSTA_PME
is clear for ports with the quirk. This would work but be slower without
the Requester_ID hint.

I can verify this alternative approach if Mika confirms that keeping HPIE
enabled is problematic. In our testing on Catlow Lake, enabling HPIE did not
cause any spurious wakeup issues.

>> 4. Because the port remains in D3hot with HPIE disabled, the hotplug
>>    event is lost and the newly inserted device is not recognized.
>>
>> The PME interrupt delivery mechanism itself works correctly;
>> interrupts arrive reliably. The problem is purely the missing status
>> register updates. Verification via IOSF-SideBand (IOSF-SB) backdoor
>> reads confirms that these registers remain empty when the PME
>> interrupt fires. Neither BIOS nor kernel code is clearing these
>> registers.
>>
>> This issue is present in all steppings of Catlow Lake PCH and affects
>> customers in production deployments. A public hardware errata document
>> is not yet available.
>>
>> Work around this issue by introducing a PCI_DEV_FLAGS_PME_UNRELIABLE
>> flag for affected ports. When this flag is set, pciehp keeps hotplug
>> interrupts (HPIE) enabled during D3hot instead of disabling them and
>> relying on PME. This allows hotplug events to be delivered via direct
>> interrupts rather than through the broken PME status mechanism.
>>
>> The port still enters D3hot for power savings during runtime suspend,
>> avoiding the power regression that would occur with pm_runtime_disable().
>> Testing confirms this approach does not impact PC6/PC10 package C-state
>> residency.
>>
>> During system suspend/resume, the behavior is unchanged. Ports are
>> resumed unconditionally when coming out of system sleep due to
>> DPM_FLAG_SMART_SUSPEND set by pcie_portdrv_probe(), and pciehp
>> re-enables interrupts and checks slot occupation status during resume.
>>
>> The quirk is applied only to Catlow PCH PCIe root ports (device IDs
>> 0x7a30 through 0x7a4b). Catlow CPU PCIe ports are not affected as
>> they are not hotplug-capable.
>>
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>
>> Changes since v2:
>>  * Switched from pm_runtime_disable() to PCI_DEV_FLAGS_PME_UNRELIABLE
>>    flag approach to avoid power regression (feedback from Rafael and Lukas)
>>  * Keep hotplug interrupts (HPIE) enabled during D3hot instead of
>>    preventing D3hot entry entirely
>>  * Port still enters D3hot for power savings; testing confirms no impact
>>    on PC6 package C-state residency
>>  * Modified pciehp to check pme_is_broken() before disabling/enabling
>>    hotplug interrupts during suspend/resume
>>  * Made quirk comment generic to cover both PME notification and status
>>    update issues, with Catlow Lake specifics documented separately
>>
>> Changes since v1:
>>  * Removed hack in hotplug driver and disabled runtime PM on affected ports.
>>  * Fixed the commit log and comments accordingly.
>>
>>  drivers/pci/hotplug/pciehp_core.c | 11 ++++--
>>  drivers/pci/quirks.c              | 60 +++++++++++++++++++++++++++++++
>>  include/linux/pci.h               |  2 ++
>>  3 files changed, 71 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
>> index 1e9158d7bac7..f854ef9551c3 100644
>> --- a/drivers/pci/hotplug/pciehp_core.c
>> +++ b/drivers/pci/hotplug/pciehp_core.c
>> @@ -260,13 +260,20 @@ static bool pme_is_native(struct pcie_device *dev)
>>  	return pcie_ports_native || host->native_pme;
>>  }
>>  
>> +static bool pme_is_broken(struct pcie_device *pcie)
>> +{
>> +	struct pci_dev *pdev = pcie->port;
>> +
>> +	return !!(pdev->dev_flags & PCI_DEV_FLAGS_PME_UNRELIABLE);
>> +}
>> +
>>  static void pciehp_disable_interrupt(struct pcie_device *dev)
>>  {
>>  	/*
>>  	 * Disable hotplug interrupt so that it does not trigger
>>  	 * immediately when the downstream link goes down.
>>  	 */
>> -	if (pme_is_native(dev))
>> +	if (pme_is_native(dev) && !pme_is_broken(dev))
>>  		pcie_disable_interrupt(get_service_data(dev));
>>  }
>>  
>> @@ -318,7 +325,7 @@ static int pciehp_resume(struct pcie_device *dev)
>>  {
>>  	struct controller *ctrl = get_service_data(dev);
>>  
>> -	if (pme_is_native(dev))
>> +	if (pme_is_native(dev) && !pme_is_broken(dev))
>>  		pcie_enable_interrupt(ctrl);
>>  
>>  	pciehp_check_presence(ctrl);
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 48946cca4be7..bfb52735c4e3 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -6380,3 +6380,63 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
>>  #endif
>> +
>> +/*
>> + * Some PCIe root ports have a hardware issue where PME-based wakeup
>> + * from D3hot is unreliable. This can manifest as either PME interrupts
>> + * not being delivered, or PME status registers (PME Status and PME
>> + * Requester_ID in Root Status) not being reliably updated even when
>> + * interrupts are delivered.
>> + *
>> + * When a hotplug event occurs while the port is in D3hot, the system
>> + * relies on PME to wake the port back to D0. If PME notification or
>> + * status updates are unreliable, the PME handler either doesn't get
>> + * invoked or cannot identify the event source. This leaves the port in
>> + * D3hot with hotplug interrupts disabled, causing hotplug events to be
>> + * missed.
>> + *
>> + * Mark affected ports with PCI_DEV_FLAGS_PME_UNRELIABLE to keep
>> + * hotplug interrupts (HPIE) enabled during D3hot instead of relying on
>> + * PME-based wakeup. This allows hotplug events to be delivered via
>> + * direct interrupts while still permitting the port to enter D3hot for
>> + * power savings.
>> + *
>> + * Known affected hardware:
>> + * - Intel Catlow Lake PCH PCIe root ports: PME status registers are
>> + *   not updated during D3hot to D0 transitions, even though PME
>> + *   interrupts are delivered correctly.
>> + */
>> +static void quirk_pcie_pme_unreliable(struct pci_dev *dev)
>> +{
>> +	dev->dev_flags |= PCI_DEV_FLAGS_PME_UNRELIABLE;
>> +	pci_info(dev, "PME status unreliable, keeping hotplug interrupts enabled in D3hot\n");
>> +}
>> +/* Apply quirk to Catlow Lake PCH root ports (0x7a30 - 0x7a4b) */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a30, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a31, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a32, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a33, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a34, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a35, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a36, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a37, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a38, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a39, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3a, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3b, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3c, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3d, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3e, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3f, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a40, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a41, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a42, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a43, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a44, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a45, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a46, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a47, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a48, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a49, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4a, quirk_pcie_pme_unreliable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4b, quirk_pcie_pme_unreliable);
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 1c270f1d5123..9761351c5d70 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -253,6 +253,8 @@ enum pci_dev_flags {
>>  	 * integrated with the downstream devices and doesn't use real PCI.
>>  	 */
>>  	PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIAS = (__force pci_dev_flags_t) (1 << 14),
>> +	/* Device PME is broken or unreliable */
>> +	PCI_DEV_FLAGS_PME_UNRELIABLE = (__force pci_dev_flags_t) (1 << 15),
>>  };
>>  
>>  enum pci_irq_reroute_variant {
>> -- 
>> 2.43.0
>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

