Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54852931DE;
	Fri, 25 Sep 2026 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357892; cv=none; b=oX7+Jxa/MdYVH0UaqsrV5XWzZntVGLwFgkVmeHnZqRpGQVCAM9oOkOgRCDr50zn/2I+KF4/rr90ayd58w1SSIZ74cXQJuB4TIkYNyN2LJqDwmI/fgjGJ3ywnX7u36XuJYT+yzk4CE2RnllsA37DC8U6kSTJTHGSa2ykwj9NelUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357892; c=relaxed/simple;
	bh=MlHOHPeHD7877V5XgcXRy9N2S9TD0570vOMzy0okZ0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZ9gBwM3XOF8Kz/qHd8WTljPR+ezV9llsDLMg/7wEiRXYBHf/UvWz0Hmi6LyoliJYfO7Afth/i4VSAZ+oL2ILKaQIPrQ7rzy37+YGhTsjlkmpiF3mNVdxipMTSxZGozdJhQ8z4Qq8gd4KObUwGlwhF2A1PuqA/tVrL9D6siMoCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zkkuw07U; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zkkuw07U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790357890; x=1821893890;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MlHOHPeHD7877V5XgcXRy9N2S9TD0570vOMzy0okZ0I=;
  b=Zkkuw07UyVXqXaQLnL0s/zWCs+/w9MFjDHaj9nydvUiMlOH5Mz4EsXVm
   ypsuum3pOZ3UvJcquP7MnNmr+O5AWLSCHd2d9xsqhizJMeuCMQtgMIEaS
   gdR6beCVpKBmWnLayBBVPCXGEJ4h1lxEGhgLutNnWUpnifs2t3kJW0sqM
   vmE0q18KR50Mt4WI7suJ0iW2XF2DiO1MCoJ3ov+RgCYFYRyzbsW3Ds9Oe
   d9PfmzyhXiJf9KMbwgjjgpj0+/8kVmBvaSlbKiPhg6sTMCkDiKk0IStRX
   WV9c4uJRWeKDVM3fSxN+JxWpbsrxyD4qhrq+K3FCx19gVVH5aY5yOU0gm
   A==;
X-CSE-ConnectionGUID: 5F7cBU2/QkG45+LgGkqewg==
X-CSE-MsgGUID: yBloYVyxScy2A8cPueGq3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="116677935"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="116677935"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 10:38:09 -0700
X-CSE-ConnectionGUID: RhN67IFCS4eHFnfQ16oaEA==
X-CSE-MsgGUID: pG9QP/YXTO2B4n2UF3CyqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="270874835"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 10:38:08 -0700
Message-ID: <c5754240-1768-44a2-869c-6b159fd54907@linux.intel.com>
Date: Fri, 25 Sep 2026 10:38:08 -0700
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
References: <ca15feda-5d63-405d-a4c4-00cbb9991fed@linux.intel.com>
 <20260325061131.GY2275908@black.igk.intel.com>
 <5d6d94b4-458f-473c-84df-c6fab7805dbe@linux.intel.com>
 <20260326061200.GA3552@black.igk.intel.com>
 <3a97fb38-70c7-4ca9-8c49-4c95e1623c91@linux.intel.com>
 <20260327111616.GC3552@black.igk.intel.com>
 <633cef07-2991-4ce8-b8c6-6b091deaeb0b@linux.intel.com>
 <20260407070800.GF3552@black.igk.intel.com>
 <bd8e9c59-afd8-48ac-ad54-64abad8bfbd1@linux.intel.com>
 <161e11c7-af4c-4cc7-8ad5-a5901f231d54@linux.intel.com>
 <20260925051922.GU106095@black.igk.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260925051922.GU106095@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mika,

On 9/24/2026 10:19 PM, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Sep 24, 2026 at 11:46:04AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Hi Bjorn/Mika,
>>
>> On 9/11/2026 10:01 AM, Kuppuswamy Sathyanarayanan wrote:
>>> Hi Mika, Bjorn, Lukas, Rafael,
>>>
>>
>> Gentle ping on my reply below.
>>
>> Bjorn, could you let me know which of the three directions you would like
>> me to take for v5?
>>
>> Mika, could you take a look at the acpi_pci_bridge_d3() findings and let
>> me know if they match your understanding?
> 
> I have already forgotten what this is about ;-) Maybe some refresher would
> help here.
> 
> If I understand right the root port has _PR3() but no _S0W so
> acpi_pci_bridge_d3() returns false for it? Then pci_bridge_d3_possible()
> returns false as well and the root port stays in D0? And that should make
> the hotplug PME work just fine but you are sayng that's not the case on
> Catlow Lake?

Sorry, my last mail was too long. It is the other way around on both
points.

For reference, I did a detailed recap of the overall problem, the D3cold 
evaluation, and the three potential design paths for v5 in my last email here:

https://lore.kernel.org/linux-pci/20260911170100.kuppuswamy.sathyanarayanan@intel.com/

To recap the ACPI behavior:
The Root Port (\_SB.PC00.RP25) has _PS0, _PS3 and _PRW. It has no _PR0,
no _PR3, no _S0W and no HotPlugSupportInD3.

So acpi_pci_bridge_d3() returns true, not false. It never gets to the
HotPlugSupportInD3 check because it returns early here:

	if (adev) {
		if (acpi_dev_power_state_for_wake(adev) <= ACPI_STATE_D2)
			return false;	/* no _S0W, not taken */
		if (acpi_device_power_manageable(adev))
			return true;	/* _PS0 is enough, taken */
	}

pci_bridge_d3_possible() is therefore true and the port runtime suspends
to D3hot (sysfs shows power/control is "auto" for this port). Because there
is no _PR0 or _PR3, it never reaches D3cold.

Once the port is in D3hot, pciehp has cleared HPIE and depends on PME.
That is where Catlow breaks. The PME interrupt arrives, but PME Status in
Root Status is never set. pcie_pme_irq() returns IRQ_NONE, the port stays
in D3hot and the hot-add event is lost.

If the port stayed in D0 as you describe, runtime hotplug would work. v2
did that and it worked. But it costs about 10% PC6 residency, and
pciehp_suspend() still clears HPIE on the way into s2idle.

The question for you is whether this matches your reading. With no power
resource, there is no PERST# assertion and no presence detect toggle on
suspend. So leaving HPIE enabled should not bring back the spurious wakeup
that eb34da60edee fixed. If you agree, that is the justification I would
put in v5 for keeping HPIE enabled on these ports.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

