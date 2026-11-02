Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651911;
	b=E0pmZquRDDIPRjKtlbx+n4KgF9VVFJX4q0gQcVbYo8qc+57rUdPaW9jVV8B00Er8C/5D
	 2l6opTXpoDNYNve2JwdncIZque0Z4/kfqts5QD5FyRHwidLyw42b8X04UQ4WA868Rizer
	 eaV8/bX7pCwYjnF0B8Fdsat8Q12yYwgVF/y+vckMNmL/rzAX9L1Uvpz8g+O1/GQ+jiDRm
	 Vo07t8zpl1LFxHDczUePk/0CqaLwSxtrGuQhNFkIHgCBvdhbMKZsJ/zQMabeB7CYUDcmr
	 509R+HPhPZWCSY5LXwzoVOyqmQxuKBIcQGcGFFzO2vTXHcY6vdi4SX6JSfmkChdnMdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651911;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=5LcGYg3nNUzRJnQm+K7RIrUIxDPgKMPd8NQr+QV64IA=;
	b=rt//lZwKusPzuAImpeXPyi+fOrAvTC0ydGNAa0d/6xyBjEYbnRSsx6fKCd8kJ1jvAg8u
	 qPryr+8lIfUoHjGojS8EuxsMJX45PTuj9QJozHAp5bHtfGH2KrdgJ+xUewEgqYIHr2z5c
	 chKbKfCLN+bgba+LamZE7ckjlJuwzS1TSebHdEvqgy2PQO1fE7u0/vK1sJhEMFRWpJyJK
	 v07Qqd9COUGSOWVBob4U9EotqNLffX2kItxlLWxCbv/MMzoCM2Xu2r4YxegXUhUejeP7G
	 NU/LkCrvD6ZbkInUpGR1xoYs8KPU88r7V2dD1n1Sb8FCBlB5sd9TrA4KuBcQn3IaJdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bRty8RaI;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78D0606A335;
	Mon,  2 Nov 2026 20:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C78D0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bRty8RaI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793651909; x=1825187909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BsPUYQg3UGlRUHhqrv/48JCqsDbQofqrAk+YJKsHA40=;
  b=bRty8RaIKGLjcZPNfFKOb8TbxunK96n6g/dydFON/lGD2OH3wk7QWIe7
   YFighgPuvN31wQ8ygFbeOX1HoT3kT9RuzNwVk9Nh6/hJWXuJpenpn16Dt
   EzAGGFoUQBVzNSiBfinEfwuqu6XkxHUF3evf/kP76o+tBxzGRar+U6ATg
   8lbxw1HAu6KW/moyjP2JnKHt3tg9MKCNEWq59f+DjffrJtz7PVs9gLksN
   sxJaiU+xX1DlZnIcz1Sol6fbjBJwDfW4cS2GGU4ikINSF28zaskAusuAJ
   VpswA/UsQEOSikBGDs+Dronz4s43DPgGsmf76DX6lqwaQ8/rE31Ysqk86
   w==;
X-CSE-ConnectionGUID: 35FUIAI4QGebNUG2UgmwUQ==
X-CSE-MsgGUID: uc6DL1yESb6drhsPgsJc1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2367856"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2367856"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:38:29 -0800
X-CSE-ConnectionGUID: lQ3qwfmDS+ak5HNmktJEew==
X-CSE-MsgGUID: EigDHSgfT1WmnFjrAgSXFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7998587"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:38:29 -0800
Message-ID: <840c7598-f988-428a-8bea-4d66b0f4f4d7@linux.intel.com>
Date: Mon, 2 Nov 2026 12:38:28 -0800
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
Subject: Re: [PATCH v15 1/4] PCI: Assume control of portdrv-related features
 only when portdrv enabled
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org,
 terry.bowman@amd.com, kanie@linux.alibaba.com, olof@lixom.net
References: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261002211828.1293177-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <aujwl45XrkVT-zUx@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aujwl45XrkVT-zUx@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/2026 12:20 PM, Lukas Wunner wrote:
> On Fri, Oct 02, 2026 at 02:18:25PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Native control of PME, AER, DPC, and PCIe hotplug depends on the portdrv,
>> so default to native handling of them only when CONFIG_PCIEPORTBUS is
>> enabled.
>>
>> Native control of LTR and SHPC hotplug does not depend on portdrv, so keep
>> defaulting those to native regardless.
>>
>> [bhelgaas: commit log]
>> Link: https://lore.kernel.org/r/fcbe8a624166a1101a755edfef44a185d32ff493.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is now commit 6347fd9aee19 in Linus' tree and I think there's a problem:
> 
>> +++ b/drivers/pci/probe.c
>> @@ -658,6 +658,8 @@ static const struct device_type pci_host_bridge_type = {
>>  
>>  static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>>  {
>> +	bool port_services = IS_ENABLED(CONFIG_PCIEPORTBUS);
>> +
>>  	INIT_LIST_HEAD(&bridge->windows);
>>  	INIT_LIST_HEAD(&bridge->dma_ranges);
>>  	INIT_LIST_HEAD(&bridge->ports);
>> @@ -668,12 +670,12 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>>  	 * may implement its own AER handling and use _OSC to prevent the
>>  	 * OS from interfering.
>>  	 */
>> -	bridge->native_aer = 1;
>> -	bridge->native_pcie_hotplug = 1;
>> +	bridge->native_aer = port_services;
>> +	bridge->native_pcie_hotplug = port_services;
> 
> The commit is setting the native_pcie_hotplug bit up front based on
> CONFIG_PCIEPORTBUS.
> 
> But there's an if-clause at the top of get_port_device_capability() which
> adds PCIE_PORT_SERVICE_HP to the port services used by a given PCIe port.
> 
> Inside the if-clause is code to disable hotplug interrupts if the BIOS
> left them enable.
> 
> Since the commit, if CONFIG_PCIEPORTBUS=n, the if-clause is no longer
> entered and so the interrupts are no longer disabled.

I don't think this case changed. get_port_device_capability() is in
portdrv.c, which is only built with CONFIG_PCIEPORTBUS=y:

  obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o

So with CONFIG_PCIEPORTBUS=n, the if-clause was never entered, before or
after this commit.

With CONFIG_PCIEPORTBUS=y, native_pcie_hotplug still starts out as 1,
so the clause still disables the hotplug interrupts when
CONFIG_HOTPLUG_PCI_PCIE=n.

Your patch was about setting native_pcie_hotplug from CONFIG_HOTPLUG_PCI_PCIE. 
That would break the PCIEPORTBUS=y, HOTPLUG_PCI_PCIE=n case, as you said. 
This commit uses CONFIG_PCIEPORTBUS instead.

Did you see a case where the interrupts stay enabled with this commit?


> 
> I'm amazed sashiko didn't flag this.  I didn't spot it during review
> either, but noticed it when rebasing my development branch.  I still
> have a patch on that branch which I developed last year but which
> was ultimately not accepted (for good reasons).  Back then I already
> noticed that the interrupt disablement issue prevented simplification
> of native_pcie_hotplug initialization.  I forgot about it but had to
> revisit the patch when rebasing the development branch on top of your
> patches:
> 
> https://lore.kernel.org/r/5eae82776d695e589b89aad500d8208b980347e5.1752390102.git.lukas@wunner.de
> 
> Now what?  The offending patch is the first one in a series of three.
> Revert all three or can we somehow salvage this?
> 
> Thanks,
> 
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

