Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816546;
	b=D69OtpLF6BypvvhtHaLwLTD2kUOrFGrt0uf4HkBA76tkwnQnZ97XMM/b+rTH1KAQaj72
	 I+Rb9/6QV2QOQJR3awnzV49g1A3Zdr/SYic9BFhk5HCexdzPruKc2/1g+KLuaJAXPbz1F
	 LqDKobG5Ht7LjDXxP7egIMGbuO0yk4SwmGUhZNRka+qeNSYg5kJTQGz6rFjRt02QSw/0z
	 3RftZtik+Jg6TijaESEmPuvFU5B7oc//pZa9GReVaFycA1kX0u25UPdARvD1H+WxXjQv8
	 1M8WSA6ZSw8urKgiKdz25jxBKbesXfuhN52B7Hd1zbrtZKAjHIP1XXBl4QXHua/EbGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816546;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7yTbv8YwAcrsjOA+FlcAgBBThQQJhOAfCviYuR8q++4=;
	b=HVqis6PrIkL/FKUQUP/s/MMe75xxNqKA044teA+/KdwKrOd71/1zMjDV43Mr1LNdBkom
	 /O7iPA/99th/WdEbmP+JZq6zDaKIBMNxUBOazrvOS+Gr1EGQ7v/aJqwpTA+6lO+BiOrCO
	 PxGtLUzUV8EKhvy0byZABSxXwQaI9BEgeOaCoYHIH5FqlbX+vPgptjTn2LId/xyspsOMK
	 D9IYZDsWC2tbgq4PTmEOdkAhasdSUd1te0+4x7fLQ7/8juJiEgFtwkBHe319UIKqwhcZR
	 zA3zsRDWnm8oTOPVp/BBsK7WIOpR39oKPqMx34PsJW2DBJjkfHGjbTn3CEbjoawCUYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BBouw2Mw;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE27606ECCE;
	Wed,  4 Nov 2026 18:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFE27606ECCE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BBouw2Mw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793816546; x=1825352546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TXUULsJLLY4XFiOhJ4L2NPJsEAXhKf1mCdwiwhKVxNI=;
  b=BBouw2MwXZiKiXZCHRqKtYAA9IX8BxtOl5xTFz4aARpxkHzOJa7SrGvT
   7Ppp7FRAdYiHMdfc3aLOXBEKn2YikXPwkfBXgqNGHTna+ulNvw5TzfLPH
   LlQ4mVfsm6tJwBJeyiAZzlGRQBz6MhvOFOoxHbX+Im+Y3qh1rVuhE5q+I
   VC2asTwf6mov8RcR/f0h7PKq1tP3GAQZHgbb0x/8t+brOjnvzVqV4zwLD
   QV21957WnoXuEYtddTZNVwNRZQANclXB01NzecwZdVvwvXl1DaPe2MVP4
   eV2oGuDrJyT3zNgIOiSHaTFVkDdk/CfcJEA4IuaRq8veNzHswptBiHyKC
   Q==;
X-CSE-ConnectionGUID: nM97NloKSi2Au9q2j12yLA==
X-CSE-MsgGUID: I0AMJWPlSzKFGfXK1rzxxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2483642"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2483642"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 10:22:25 -0800
X-CSE-ConnectionGUID: SvtWUMwESrWYh+QXd6WClA==
X-CSE-MsgGUID: NDz4HI44Q5GVKK8nWJ8RoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7117725"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 10:22:25 -0800
Message-ID: <bca530a5-5f9c-4be1-aeda-d1c97fbc9623@linux.intel.com>
Date: Wed, 4 Nov 2026 10:22:24 -0800
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
Subject: Re: [PATCH v2 6/6] PCI/portdrv: Bind DPC service based on
 host_bridge->native_dpc
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261104163514.GE716491@yaz-khff2.amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20261104163514.GE716491@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/2026 8:35 AM, Yazen Ghannam wrote:
> On Tue, Oct 20, 2026 at 11:19:23AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> get_port_device_capability() binds the DPC service if the port has a DPC
>> capability and either "pcie_ports=dpc-native" was given or the OS
>> controls AER.  This repeats decisions that are already made elsewhere.
>> It also ignores host_bridge->native_dpc, which is meant to say whether
>> the OS owns DPC.
>>
>> Make host_bridge->native_dpc the single decider:
>>
>>   - In acpi_pci_root_create(), assume DPC control whenever _OSC grants
>>     AER control.  PCI Firmware r3.3, sec 4.5.2.4, requires platforms to
>>     retain AER if they retain DPC.  Put the other way, firmware that
>>     grants AER does not keep DPC.  PCIe r7.0 sec 6.2.11 recommends that
>>     the OS link control of DPC to control of AER.  Commit 97ca178c899d
>>     ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")
>>     relied on this link.  Keeping it means DPC still works with firmware
>>     that predates the _OSC DPC control bit.  Such firmware grants AER but
>>     masks DPC.  The OS cannot tell such firmware from firmware that
>>     retains DPC on purpose, so log a message when it assumes DPC control
>>     that _OSC did not grant.  Only do this if the OS requested DPC
>>     control, i.e., if CONFIG_PCIE_DPC is enabled.
>>
>>   - "pcie_ports=native" and "pcie_ports=dpc-native" are already folded
>>     into the _OSC control mask, so they are reflected in native_dpc.
>>
>> Then bind the DPC service if the port has a DPC capability and
>> host_bridge->native_dpc is set.
>>
>> The only change in behavior is for firmware that grants DPC control but
>> retains AER control.  PCI Firmware r3.3, sec 4.5.2.4, does not forbid
>> this.  The OS now uses DPC there because firmware granted it.  Since
>> "PCI/DPC: Reinstate support for AER-incapable ports", dpc_probe() no
>> longer requires AER control.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>  drivers/acpi/pci_root.c    | 16 ++++++++++++++++
>>  drivers/pci/pcie/portdrv.c |  6 +-----
>>  2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 5c674d5b6bb8..b380b6d8874d 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -1056,6 +1056,22 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>>  	ctrl = root->osc_control_set;
>>  	ext_ctrl = root->osc_ext_control_set;
>>  
>> +	/*
>> +	 * PCI Firmware r3.3, sec 4.5.2.4, requires platforms to retain AER
>> +	 * if they retain DPC.  Put the other way, firmware that grants AER
>> +	 * does not keep DPC.  PCIe r7.0 sec 6.2.11 recommends that the OS
>> +	 * link control of DPC to control of AER.  Firmware that predates
>> +	 * the _OSC DPC control bit grants AER without DPC, so assume control
>> +	 * of DPC whenever we control AER.
>> +	 */
> 
> Oh, I see now that this got rewritten.
> 
> But it really does repeat the same info from the commit message. So IMO
> it can just be removed or summarized further.

Agreed.  I'll shorten it in v3 to something like:

	/*
	 * Firmware that predates the _OSC DPC control bit grants AER but
	 * masks DPC.  Link DPC control to AER control, as PCIe r7.0 sec
	 * 6.2.11 recommends.
	 */

> 
>> +	if (IS_ENABLED(CONFIG_PCIE_DPC) &&
>> +	    (ctrl & OSC_PCI_EXPRESS_AER_CONTROL) &&
>> +	    !(ctrl & OSC_PCI_EXPRESS_DPC_CONTROL)) {
>> +		decode_osc_control(root, "OS assuming control (AER granted) of",
>> +				   OSC_PCI_EXPRESS_DPC_CONTROL);
>> +		ctrl |= OSC_PCI_EXPRESS_DPC_CONTROL;
>> +	}
>> +
>>  	/*
>>  	 * If the user specified "pcie_ports=native", use the PCIe port
>>  	 * services regardless of what _OSC says, i.e., proceed as though the
>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>> index b77680fd3b75..f1beb440a3dc 100644
>> --- a/drivers/pci/pcie/portdrv.c
>> +++ b/drivers/pci/pcie/portdrv.c
>> @@ -258,12 +258,8 @@ static int get_port_device_capability(struct pci_dev *dev)
>>  		pcie_pme_interrupt_enable(dev, false);
>>  	}
>>  
>> -	/*
>> -	 * With dpc-native, allow Linux to use DPC even if it doesn't have
>> -	 * permission to use AER.
>> -	 */
>>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>> -	    (pcie_ports_dpc_native || host->native_aer))
>> +	    host->native_dpc)
>>  		services |= PCIE_PORT_SERVICE_DPC;
>>  
>>  	/* Enable bandwidth control if more than one speed is supported. */
>> -- 
> 
> Besides my comment on the comment, looks good to me.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 

Thanks!


> Thanks,
> Yazen

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

