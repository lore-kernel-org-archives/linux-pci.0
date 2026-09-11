Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4929C357CEC;
	Fri, 11 Sep 2026 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146121; cv=none; b=M6B9i9hI8GE9vVy06RoDvQEq45daC2CDQyvsogPVjnlxS+P7eru8fLNJ6iSZK5T7KUFUCovo0YS+ijiPang3nN+x+K7BZgmiXKQSj2qS6Oe6BC9Cwi1LHp1L62i5ahvi2KZiRwJlYYMV6ke68nCNOWLTJ6OqW79h9t/KhDDOi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146121; c=relaxed/simple;
	bh=aaAKWopbCK+0xZ0QrGlRqM02hRxcFJ0DFASAL+5f1Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3W1Ypw4PnMhTx1y/DOZ2KTEIgMRFfL9XB5giR9duRBKTF4NQY81RutbHmj2sFFUGmr1EptH4C1MkVduD4w3lmxhrSs1YUkBapXL3q38QLFWhi/jf4GEzl1FS/K12U4nZ9pPOeDDKMSDub5eqldp47NEmzZwEnbM1hRi5nhBQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYp5DJ5x; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYp5DJ5x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789146120; x=1820682120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aaAKWopbCK+0xZ0QrGlRqM02hRxcFJ0DFASAL+5f1Eg=;
  b=JYp5DJ5xufpdBb9IDBAi/T0atmBI/TXNzzaWdBKXRpJK0lYkBIu7yg3M
   3oNSd9wVo68Ii/ejyRepZTLjkI0KCYtIW0HyNEqi3yyeHY1vBNMAhutHX
   fGM7Q/KBwMarUBLOMHvrpehrCrhWfZEIrtYWp2AfLwk9nDsRCsA0DVZUq
   EnAXlQszsT5LUCZzd6UutRjdSM/UT/p2QGXCiRkD+/DM5gLEBMkm1kHBJ
   wUWk5Il0Lgz4nUFf5oxB/ea/ymgjrnhhrtxM+HW2cIXJgvTk82apgBxYh
   5yisTm01kCHdx0f0zxnCD9LDDhoyt1n9331X/Q1uOEVS9rf3PWfYE4QJA
   A==;
X-CSE-ConnectionGUID: r79X3k7HRTuGUdWMgYWxvg==
X-CSE-MsgGUID: wts1Anp8QsiWnPc8d5ha2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="106981293"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="106981293"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 10:01:59 -0700
X-CSE-ConnectionGUID: bpZkMqP4RxqfXIlEn17nKw==
X-CSE-MsgGUID: UOZBEKQMSJGAKjFhAHvdFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="355007"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 10:01:59 -0700
Message-ID: <bd8e9c59-afd8-48ac-ad54-64abad8bfbd1@linux.intel.com>
Date: Fri, 11 Sep 2026 10:01:58 -0700
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
 <3a97fb38-70c7-4ca9-8c49-4c95e1623c91@linux.intel.com>
 <20260327111616.GC3552@black.igk.intel.com>
 <633cef07-2991-4ce8-b8c6-6b091deaeb0b@linux.intel.com>
 <20260407070800.GF3552@black.igk.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260407070800.GF3552@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mika, Bjorn, Lukas, Rafael,

Apologies for the very long silence on this.  I was out on an extended
vacation and then got pulled into other work when I got back.  I want to
spin v5 now, and before that I want to respond to some of the opens.  v4
was posted about an hour before Bjorn's v3 review landed, so none of that
discussion was reflected in it.

Quick recap for anyone paging this back in:

  On Intel Catlow Lake PCH Root Ports, the Root Status register (PME
  Status) is not reliably updated when the PME arrives.  The interrupt
  itself is delivered; IOSF-SB backdoor reads confirm the status bits stay
  clear, and nothing in BIOS or the kernel is clearing them.  So
  pcie_pme_irq() sees no PME Status, returns IRQ_NONE, and a hot-add that
  happens while the port is runtime suspended in D3hot is lost, because
  pciehp_suspend() has cleared HPIE and is relying on PME to bring the
  port back.

  v1 hacked pciehp_isr().  v2 called pm_runtime_disable() in the quirk,
  which costs ~10% PC6 residency here and, more importantly, doesn't help
  once the system suspends.  v3/v4 instead set PCI_DEV_FLAGS_PME_UNRELIABLE
  via a quirk and skip the HPIE clear in pciehp_disable_interrupt(), so the
  port still goes to D3hot but hotplug events arrive as ordinary hotplug
  interrupts.  Bjorn's objection to that is that eb34da60edee cleared HPIE
  for a reason, and we had nothing solid to say why Catlow won't hit the
  spurious wakeup that motivated it.  Mika's last question was whether the
  port enters D3cold at all.

On 4/7/2026 12:08 AM, Mika Westerberg wrote:
> Hi,
> 
> On Fri, Apr 03, 2026 at 12:37:39PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Hi Mika,
>>
>> On 3/27/2026 4:16 AM, Mika Westerberg wrote:
>>> Hey,
>>>
>>> On Thu, Mar 26, 2026 at 02:23:50PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>>> Hi Mika,
>>>>
>>>> On 3/25/2026 11:12 PM, Mika Westerberg wrote:
>>>>> On Wed, Mar 25, 2026 at 02:12:48PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>>>>>
>>>>>>
>>>>>> On 3/24/2026 11:11 PM, Mika Westerberg wrote:
>>>>>>> On Tue, Mar 24, 2026 at 02:45:25PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>>>>>>>> eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
>>>>>>>>> cleared PCI_EXP_SLTCTL_HPIE so that when the link goes down, we
>>>>>>>>> wouldn't get a PCI_EXP_SLTSTA_DLLSC interrupt and wake the system.
>>>>>>>>>
>>>>>>>>> I don't know the details of why the PCI_EXP_SLTSTA_DLLSC would cause
>>>>>>>>> that wakeup.  I would think pciehp should field that, and it should be
>>>>>>>>> able to figure out whether to bring the port out of D3hot.
>>>>>>>>>
>>>>>>>>> Anyway, with this patch it looks like we'll leave PCI_EXP_SLTCTL_HPIE
>>>>>>>>> set, and potentially get that PCI_EXP_SLTSTA_DLLSC interrupt again?
>>>>>>>>
>>>>>>>> I have tested this patch on Catlow Lake. Enabling HPIE does not result in
>>>>>>>> spurious wakeups as mentioned in Mika's patch.
>>>>>>>>
>>>>>>>> Mika, any comments?
>>>>>>>
>>>>>>> What do you have connected to the slot?
>>>>>>
>>>>>> A network card.
>>>>>
>>>>> Okay.
>>>>>
>>>>> Out of interest how do you hotplug it? :)
>>>>
>>>> We physically remove and insert the card.
>>>
>>> Got it.
>>>
>>>>>>> IIRC the interrupt triggers when presence change toggles (due to the link
>>>>>>> going down).
>>>>>>>
>>>>>>
>>>>>> I have tested the s3 mode. I was able to see message related to system entering
>>>>>> suspend and then coming back again after (after user intervention). I also noted
>>>>>> pcie_disable_interrupt() called before suspend and pcie_enable_interrupt() called
>>>>>> after resume.
>>>>>
>>>>> In case of S3 the BIOS also configures the hardware before entering
>>>>> suspend. On client at least it's suspend-to-idle and any interrupt will
>>>>> bring the CPU and the system out of it. It could be that that's the reason
>>>>> you don't see any issue if this is server system and it goes into full S3?
>>>>>
>>>>
>>>> Looking at the kernel logs, the system is actually using suspend-to-idle 
>>>> (s2idle), not full S3:
>>>>
>>>>   PM: suspend entry (s2idle)
>>>>
>>>> So this is the same suspend mode where you observed the spurious wakeup issue.
>>>> Interestingly, we're not seeing the problem on Catlow Lake with HPIE enabled.
>>>>
>>>> I am trying to understand the wakeup sequence in your case. IIUC, before the
>>>> system enters suspend, it will put the device and port in D3hot, right? So link
>>>> down should happen before the system goes to sleep or idle. At what point does
>>>> the spurious DLLSC interrupt occur that causes the unwanted wakeup?
>>>
>>> I think in case of tunneled PCIe it is presence detect that toggles and
>>> triggers the interrupt if left enabled.
>>>
>>> The flow is something like this (from my memory):
>>>
>>> 1. User enters s2idle.
>>> 2. PM core suspends devices.
>>> 3. PCI core suspends the devices behind the root port and then the root
>>>    port itself. This makes the root port be in D3hot and the link below it
>>>    is still in L1.
>>> 4. PCI/ACPI turns of the power resource attached to the root port. This
>>>    puts the link into L2/3 ready and then PERST# is asserted in which case
>>>    the tunnels are gone and presence detect changes and the link enters L2
>>>    and the root port enters D3cold.
>>
>> Thanks for the detailed explanation. So the spurious wakeup happens when the
>> power resource is turned off during suspend, which triggers the presence detect
>> change. Is there a way to detect if a port has this power resource configuration
>> via ACPI methods? I'm wondering if we could make HPIE disabling conditional on
>> the presence of this power management setup.
> 
> Yes the Root Port has _PR3() method but see below.
> 
>>> In your case does the root port enter D3cold? Does it have power resource?
>>> Or it stays in D3hot? We should not put any hotplug ports into low power
>>> states if they don't have HotPlugSupportInD3 property as described here:
>>
>> I think it stays in D3hot. I am not very clear about the power resource. is
>> there a way to check for it? Should I look for power_resources_* in sysfs or
>> check the ACPI tables directly?
>>
>> Regarding your suggestion about HotPlugSupportInD3: would it make sense to modify
>> the HPIE disable logic to be conditional on the presence of this _DSD property? 
> 
> We already have the check in acpi_pci_bridge_d3(). In your case that should
> return false and the port should never enter D3.

It would return false - but we never get that far.  The affected Port is
0000:00:1a.0 (\_SB.PC00.RP25), and it has _PS0/_PS3 and _PRW, but no
_PR0/_PR3, no _S0W and no HotPlugSupportInD3.  With that, the first block
wins:

	if (adev) {
		if (acpi_dev_power_state_for_wake(adev) <= ACPI_STATE_D2)
			return false;	<-- no _S0W, so 0xFF; not taken
		if (acpi_device_power_manageable(adev))
			return true;	<-- taken; _PS0 alone is enough
	}

and the HotPlugSupportInD3 check that would have said no is unreachable.
So the shortcut added by c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports
for D3 if power managed by ACPI", 2020) returns true before the
requirements added by dff6139015dc ("PCI/ACPI: Allow D3 only if Root Port
can signal and wake from D3", 2022) are ever consulted. 

Bjorn, I think the same data answers your concern.  In Mika's flow the
presence-detect toggle comes from PCI/ACPI turning off the Port's power
resource and asserting PERST#.  With no _PR3, D3cold is never valid, the
Port only ever reaches D3hot, PERST# is never asserted, and presence detect
never toggles.  That is a structural difference from the case eb34da60edee
was written for.

You also suggested keeping the workaround in pme.c, for instance calling
pcie_pme_walk_bus() regardless of PCI_EXP_RTSTA_PME on quirked ports.  I
don't think that works, for the reason Lukas raised.  The Port's interrupt
is shared (hotplug, bandwidth notification, AER and DPC).  Without PME Status
as the filter, all of those would walk the bus and resume every device below
the Port to read its PMCSR, on every interrupt rather than only around
suspend.

That leaves the question of which direction to take for v5.  I see three,
and I would prefer the first.

1. Keep the v3/v4 mechanism (quirk plus skipping the HPIE clear) and
   justify it with the no-Power-Resource, no-D3cold reasoning above, in the
   commit log and in a comment next to the pciehp change.  

2. Go back to the v2 shape and keep the affected Port out of low-power
   states from the quirk, so PME is never depended on.  Bjorn, I think this
   is where your simplicity argument actually lands, more so than the pme.c
   variant above, since it touches no shared code at all.  What stopped me
   in v2 was not only the power cost.  pciehp_suspend() clears HPIE
   regardless of runtime PM state, so keeping the Port resumed still loses
   hot-add across s2idle, whereas option 1 covers both cases.

3. Make the HotPlugSupportInD3, _PRW and _S0W requirements apply to
   power-manageable ports too instead of being short-circuited.  That fixes
   this Port with no quirk at all, which is what dff6139015dc looks like it
   was meant to do, but it also takes D3 away from any port with _PS0/_PS3
   and no HotPlugSupportInD3, so I think it belongs in a separate
   discussion rather than gating this series.  I do think it is worth doing
   on its own.  Lukas, Rafael, let me know if you agree it is worth a
   separate patch.

Could you let me know which one you would like me to take?  If there are no
objections I will send v5 with option 1.


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

