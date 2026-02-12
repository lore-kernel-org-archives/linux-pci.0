Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086BFCA5A
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770932996; cv=none; b=LBqAmbvYEnl/HR3r8J3j5EiaR7IvU4rp65NMaMIoJjtF/Wq7hakwihFxEnw9+M8xymrofirTiSSwB0o4UWkWMNcqNJD4ulERyMEG8cCdWuR8MmLfcF0PzuBQrKGBWCmsFVKah7uVmyEozrAhDof+A/Y8PNwI2OhDLnxB60He0bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770932996; c=relaxed/simple;
	bh=1FN/qG+RxInFRzFxK1T+V7SKD6cgVV3iMTCfdspAjJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKbioO6LdFgKIop3zvf/24juaeCsy0pRoUxfq3rmxAAqqCUzyctTCDHbvtdQ/NeDZvUIZUL0hi1T/HMZ3IGzHjTWEvuiMv602peFdBKZZAE7vtcCbbGtY4I3spdMzQsVvEIo3sVJaptks873zgdmfWezqHfqC99s2U8FC+iCSAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SK1ojE/t; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SK1ojE/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770932994; x=1802468994;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1FN/qG+RxInFRzFxK1T+V7SKD6cgVV3iMTCfdspAjJs=;
  b=SK1ojE/tkNwKTpG2DO/3ieeVCO8PhyO5zVA4DxMsbjSBtm6d7oSfiGPm
   uUA9mBcXuCzel8rX4bnwWu9ozej5F7OLfQ/Mb4KlZkecv/DQVuP7mPOUp
   6JapWSZpL/TE553DN/qGueWpO7A3cdRXFdljOPMlYz9RLzQ4FOpCtiU0v
   2A/EK6WbIOXDOyP2hfRhkqex/qLTx1kVdM0ovxO2cfEvyfUgs06dkV0TM
   OsjBB2j5PD3H4Kh/zOw7/CFB0kwsf1nGDKwoTHHXlzQIvtfeCloaedAMI
   IdVqUAwGJKLx6EX8eaSPQs3I3fGrRumK7R7wkv402Fr+0KnwzKEenAHTI
   w==;
X-CSE-ConnectionGUID: hXirIHURQy+3qCVYr/TQxw==
X-CSE-MsgGUID: f1AqvfcRQvmYsG07w+vjlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82755147"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="82755147"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 13:49:53 -0800
X-CSE-ConnectionGUID: gzyARRs0RPaG5a6JMcQyCw==
X-CSE-MsgGUID: GsOLu9vjS/+vw8ONvdjUWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211535456"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 13:49:52 -0800
Message-ID: <9a7a176d-4450-47ac-859c-0ce69a19afee@linux.intel.com>
Date: Thu, 12 Feb 2026 13:49:52 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/DPC: Clear Interrupt Status in dpc_reset_link()
To: Keith Busch <kbusch@kernel.org>
Cc: Danielle Costantino <dcostantino@meta.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
References: <20260212191818.3625264-1-dcostantino@meta.com>
 <20260212191818.3625264-2-dcostantino@meta.com>
 <9b75cf12-a0b4-49bf-b261-cbe02c0fe310@linux.intel.com>
 <aY5E4OWE_v0Jdyd1@kbusch-mbp>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aY5E4OWE_v0Jdyd1@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Keith,

On 2/12/2026 1:23 PM, Keith Busch wrote:
> On Thu, Feb 12, 2026 at 11:50:54AM -0800, Kuppuswamy Sathyanarayanan wrote:
>> In case of EDR, firmware owns the interrupt handling. It just uses ACPI
>> method to request OS help with recovery. Since interrupt handling is
>> owned by firmware, I think firmware should clear the interrupt status.
> 
> But the PCI Firmware Specication says the OS owns the status register
> while it is handling EDR notification
> 
> "
>    the operating system is permitted to write the following:
> 
>      * Device Status Register
>      * Uncorrectable Error Status Register
>      * Correctable Error Status Register
>      * Root Error Status Register
>      * RP PIO Status Register
> 
>    in the Port that triggered DPC while processing an Error Disconnect Recover
>    notification from firmware
> "

Please check the _OSC DPC control bit details in PCI firmware spec.

It specifically calls out OS is permitted to write to DPC trigger status
bit in DPC status register. It does not talk about about DPC interrupt
status bit.

Copied here for reference:

"If control of this feature was requested and denied, or was not requested,
then the operating system is permitted to write to the DPC Trigger Status bit
in the DPC Status Register in the Port that triggered containment"

I think since firmware registers interrupt handler for DPC, after OS helps
handle the recovery it should complete the loop and clear it.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

