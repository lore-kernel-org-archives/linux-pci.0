Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16928C866
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770925857; cv=none; b=cXCvcLFLglZ+sPwX4GDQW3k/UT+yxwbAT1dERcu4B4l+B7nsyF/0RotGNymwnQQZcCf9X2tg7XXw1Sv+QEIhI5McfP62rvTEJcYZXabH4ORk//h2JTVr9jPwXHkYHZZ0d7J05NttcMs8PL717ca13k9Lx1dAFBMpBTToob+9Vls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770925857; c=relaxed/simple;
	bh=9Vq7wFnmX0pcUnYPq6rTPZ4tTafUoJ52G7cQX2Fui/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yk5Qg90lX6ySuiShvGpIn8YjHOJOg5QURgIU4mg6zarB5GrAlFElKm834ejvR0N9/L/7CWT7lmVFSgtG3rwXJ3f1FGDI/2cU4uqHTMvq2yvbesGriey5cytAPjyPq4LFMoH7ZI7NUAkSFqKroJevqf+e9cY2FRIxCfoYWvY8zFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zt24vuKm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zt24vuKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770925856; x=1802461856;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9Vq7wFnmX0pcUnYPq6rTPZ4tTafUoJ52G7cQX2Fui/Q=;
  b=Zt24vuKmIXy49eLgmr067isPDeBObKHGY/revd1qgoRewHLX2IyavVy7
   CDvMvujisCt3lecZfxQOVb3FH40ZRxqCpOFNTdJVIriy69QDaYxMfOTap
   Jvhd15IcUvXQBZBRqHrY2kCK6EpuaMnUfvtYSnEnOGvElrg9yM8v6RnwC
   /MLRtgFtXsnh8WsEIgZLVM35u4MM8cme/40HMMUy7pSBLGAUY6JFUyqms
   vx9bsaiP0KXWBWaIDbGn2fPfCvQ1utGp+eMXKqK6buopH5e23Dxh/DMi9
   KwHdl8eMMiYkD99X1WRTXRm2+QGWQtuUcgkDc9iALdZxlehfaYPanq0//
   w==;
X-CSE-ConnectionGUID: 1n1NBi9aQy68YCBR6g5ugw==
X-CSE-MsgGUID: 8xg95mFaR6SdQvzOkUYPBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72292546"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72292546"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 11:50:55 -0800
X-CSE-ConnectionGUID: 72EpLjS3Sl2fgja4b9ZdIg==
X-CSE-MsgGUID: nwDGbSMrTTCZRLLu1UV29Q==
X-ExtLoop1: 1
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 11:50:55 -0800
Message-ID: <9b75cf12-a0b4-49bf-b261-cbe02c0fe310@linux.intel.com>
Date: Thu, 12 Feb 2026 11:50:54 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/DPC: Clear Interrupt Status in dpc_reset_link()
To: Danielle Costantino <dcostantino@meta.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
References: <20260212191818.3625264-1-dcostantino@meta.com>
 <20260212191818.3625264-2-dcostantino@meta.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260212191818.3625264-2-dcostantino@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/2026 11:18 AM, Danielle Costantino wrote:
> In the native DPC interrupt path, dpc_irq() clears
> PCI_EXP_DPC_STATUS_INTERRUPT before scheduling the threaded handler
> that eventually calls dpc_reset_link().  However, in the firmware-first
> EDR path, dpc_irq() is never invoked -- firmware owns the DPC interrupt
> and notifies the OS via an ACPI EDR notification.  dpc_reset_link() is
> then called directly from edr_handle_event() via pcie_do_recovery().
> 
> Because dpc_reset_link() only clears PCI_EXP_DPC_STATUS_TRIGGER, the
> Interrupt Status bit (bit 3) is left set permanently after every EDR
> event.
> 
> Clear PCI_EXP_DPC_STATUS_INTERRUPT alongside PCI_EXP_DPC_STATUS_TRIGGER
> in dpc_reset_link().  Both bits are RW1C in the DPC Status register per
> PCIe r6.1, sec 7.9.14.5, so writing them together is safe.  The native
> path is unaffected because dpc_irq() has already cleared the Interrupt
> Status bit before dpc_reset_link() runs.
> 

In native path (dpc_irq()), OS owns the interrupt delivery and handling.
So it clears it in dpc_irq() handler.

In case of EDR, firmware owns the interrupt handling. It just uses ACPI
method to request OS help with recovery. Since interrupt handling is
owned by firmware, I think firmware should clear the interrupt status.

> Fixes: aea47413e7ce ("PCI/DPC: Expose dpc_process_error(), dpc_reset_link() for use by EDR")
> Signed-off-by: Danielle Costantino <dcostantino@meta.com>
> ---
>  drivers/pci/pcie/dpc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index fc18349614d7..9baa2345e33e 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -171,8 +171,16 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  		goto out;
>  	}
>  
> +	/*
> +	 * Clear both DPC Trigger Status and DPC Interrupt Status.  In the
> +	 * native DPC path, dpc_irq() already clears Interrupt Status before
> +	 * the threaded handler runs.  But in the EDR (firmware-first) path,
> +	 * dpc_irq() is never called, so Interrupt Status must be cleared
> +	 * here to prevent it from remaining stale indefinitely.
> +	 */
>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
> -			      PCI_EXP_DPC_STATUS_TRIGGER);
> +			      PCI_EXP_DPC_STATUS_TRIGGER |
> +			      PCI_EXP_DPC_STATUS_INTERRUPT);
>  
>  	if (pci_bridge_wait_for_secondary_bus(pdev, "DPC")) {
>  		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

