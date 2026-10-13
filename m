Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251F51DAFC;
	Tue, 13 Oct 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909288; cv=none; b=Xc/iu20JDQny9bgQ0FU0oiICNG/bdE03fVLjXhJLiOG24hm8jDFxeB9LB6iMdJALPn/eKIQhOW+Z13IPsdcTfZxcfNw9ZkxHBvWfkv3Z6gsqaPbup3JLXNfTVwJDEQu73IrX/3vYCCAUsEPnrenfRvmDGqPI6koncxWk6ZNAYMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909288; c=relaxed/simple;
	bh=Mc1DTfLGY7pcGFzCEyyWDlJ/Z2hxsqSiFDGUw49GIf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICntaY/VV06RQVaHU+YEcFD5q83I9RHCmS9LI5L98qZQoC9DdxWYlVURDBiwOlKvIwV6bW8VAV60XUGraBuaLSkitQ4oK1JdSGcyfIBZ72oiA41O3oWCknL74TTYpoVXKHO58Nqv4rlcaVa96G5FIx4vxdvfk7Ow20aN8z5aXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnlevLRw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnlevLRw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791909286; x=1823445286;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mc1DTfLGY7pcGFzCEyyWDlJ/Z2hxsqSiFDGUw49GIf4=;
  b=JnlevLRwGMvkYVM+DhPc09SchQTO7Hmc1A/XikrUpTg7/bf1ncRQO1E2
   8Y/FCwJsWFmYniH1jPrmF78VP8RxUlSZedZ1nnifXOGTzkGOG3OxPsNhl
   IRRXSqrRsAhSDiezhCmGPZfVCH3hket5JQo6XYrtzFWpjt3mWq+Sue3o2
   y4gAbbHJnaJOTQIyhzhAz3vKieGPYXOyV1PniWAIW1GCnZf3bd2RWrJf4
   uTich7XzV1Ya+pJZL/Su1YJHdopd4TX5JdOyY5Ew82F3egsSrwtzrCyHf
   lvxAiLnrGErdqcROgXg2EKVtMTmvzrTTX5yC90u2Q+DyBWrq65leM2sDh
   A==;
X-CSE-ConnectionGUID: +JKn5hHhQ7G7UCz/1AsONg==
X-CSE-MsgGUID: D856ylNlQMSTg6No/FjAMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="673383"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="673383"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:34:46 -0700
X-CSE-ConnectionGUID: YHDZeawZTy2M6ADHtkUGjA==
X-CSE-MsgGUID: 9ys0i9A1R4CmLucPxOFa8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1528330"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:34:45 -0700
Message-ID: <4723da77-acb2-4063-93d5-bf1cefd6b6e5@linux.intel.com>
Date: Tue, 13 Oct 2026 09:34:44 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] PCI/DPC: Decide DPC ownership with
 host_bridge->native_dpc
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261012232018.GA1428722@bhelgaas>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20261012232018.GA1428722@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 10/12/2026 4:20 PM, Bjorn Helgaas wrote:
> On Wed, Oct 07, 2026 at 09:58:36AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> This series makes host_bridge->native_dpc the single decider for whether
>> Linux uses DPC, as Bjorn asked during the review of "Simplify PCIe native
>> ownership".
>>
>>   https://lore.kernel.org/r/20261001221408.GA2731929@bhelgaas
>>
>> Today the DPC service binds on host_bridge->native_aer, AER availability
>> and "pcie_ports=dpc-native".  host_bridge->native_dpc is only consulted
>> by pci_dpc_recovered().  After this series, native_dpc is the end result
>> of everything that decides DPC ownership, and portdrv binds the DPC
>> service on it.
>>
>> The series applies on top of two others:
>>
>>   - pci/portdrv, which has patches 1-3 of v15 of "Simplify PCIe native
>>     ownership".  They fold "pcie_ports=native" and "pcie_ports=dpc-native"
>>     into the _OSC control mask, so native_dpc already reflects the
>>     command line.
>>
>>     https://lore.kernel.org/r/20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com
>>
>>   - Lukas's "Error reporting for AER-incapable devices".  It removes the
>>     AER Capability requirement from the DPC driver.
>>
>>     https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de
> 
> My impression was that Lukas planned to tweak a couple things in that
> series, e.g., https://lore.kernel.org/all/arltOHrdHdokyfC9@wunner.de
> 
> Does this actually depend on Lukas' series?  If so, can we include the
> relevant patch here?

It applies and builds on pci/portdrv without Lukas's series. It only
depends on his first two patches, which are DPC fixes. The rework he
mentioned is for patches 6 and 7, and this series doesn't need those.

  PCI/DPC: Avoid access to non-existent AER capability
  PCI/DPC: Reinstate support for AER-incapable ports

dpc_probe() still returns -ENOTSUPP unless the OS owns AER or
"pcie_ports=dpc-native" is given. Without Lukas's patch 2, portdrv
creates the DPC service from native_dpc, but dpc_probe() then rejects it
when firmware grants DPC and retains AER. So the change in patch 4 would
not take effect. Lukas's patch 2 needs his patch 1, because the DPC
driver uses the AER capability without checking that it exists.

If Lukas has no objections, I can include Lukas 2 patches part of v2.

> 
>> Patch 1 removes CONFIG_PCIE_EDR, which was another knob in deciding
>> whether to request DPC control in _OSC.
>>
>> Patch 2 stops requiring pci_aer_available() to bind the DPC service,
>> since the DPC driver does not depend on MSI or on the AER driver.
>>
>> Patch 3 requests DPC control only together with AER control, as PCI
>> Firmware r3.3, sec 4.5.2.4, requires.
>>
>> Patch 4 binds the DPC service on host_bridge->native_dpc and logs a
>> message when the OS assumes DPC control that _OSC did not grant.
>>
>> Kuppuswamy Sathyanarayanan (4):
>>   PCI/EDR: Remove CONFIG_PCIE_EDR
>>   PCI/portdrv: Don't require AER to bind DPC service
>>   PCI/ACPI: Request DPC control only together with AER control
>>   PCI/portdrv: Bind DPC service based on host_bridge->native_dpc
>>
>>  drivers/acpi/pci_root.c    | 26 +++++++++++++++++++++++---
>>  drivers/pci/pcie/Kconfig   |  9 ---------
>>  drivers/pci/pcie/Makefile  |  5 ++++-
>>  drivers/pci/pcie/dpc.c     |  5 +++--
>>  drivers/pci/pcie/portdrv.c |  7 +------
>>  include/linux/pci-acpi.h   |  4 ++--
>>  6 files changed, 33 insertions(+), 23 deletions(-)
>>
>>
>> base-commit: 4fe37866b0d92cdc45b62954a76489a9d9f8bd73
>> prerequisite-patch-id: e0eafcb39f15c38f3acfa601dfce07a6f0832ce1
>> prerequisite-patch-id: 83e8185612e785fad80790d4a0c20fa68ab12ce7
>> prerequisite-patch-id: 8e9e2b06f55249ff57c7d7f43918ee82f79d1450
>> prerequisite-patch-id: 78ad13a1c423c3ee50122237c4bd0fdedf2d1e00
>> prerequisite-patch-id: 0c4b9d46eea86635c431382aef2bf576a3bb5691
>> prerequisite-patch-id: 2d1a35309e750427352c6fe0d9bb62c4453c6252
>> prerequisite-patch-id: c1ed9c8ac6123e0a65ae0d7ba3183dd46477edf7
>> -- 
>> 2.43.0
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

