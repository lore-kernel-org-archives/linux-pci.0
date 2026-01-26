Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735322264CF
	for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769452930; cv=none; b=LsAjqENKZwBsMwKMLY6djJhVUcBpsBmAjYqHIBoRoOFHIOIWT4mtqoJq6aHM795mFDAgusFcHdIq7R+NbIuK700Q1ncXLIBUHeiySu6PD6mnCtqDl+y9Ws8smRKojI2krlDmotg2D45Gkw/RBEqE5W1GktXRQn5KmhIlp6Ndyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769452930; c=relaxed/simple;
	bh=aS9CbmgY+AE+YomBTccWVmA0YpzUUIeFUkHHsdJIMz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQxeU2bwCrWAP4UBiqzPLkPoX/YBr4PQu/e3NZN0dgc3zL+Y3WBrC5OzxfH8uew5kfg9Pjr/xPVM8pib3HCASqD3JzdVEiCX0xGSjrxHMsQV/I7K6HwPEG34LNLn32KGE1K6tD6AaY+p0JzF78zEtHuq7DKH7hmjnYewvy4lH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kW1QUIcL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kW1QUIcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769452929; x=1800988929;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aS9CbmgY+AE+YomBTccWVmA0YpzUUIeFUkHHsdJIMz0=;
  b=kW1QUIcLr+lJl088M+8W9FGkgLNb3JXGZGtVy7sEMTdgENroEhBQyfd3
   9LPTnzNnZ8BQoAZUZYxip+Lj7dzmL7LSlgrog+wUJBqLD5DASuFN/A1bV
   Sntz1JTORdocl6Kxu+B2ZbgSQf4sU77w+G9U1nKepONHWXzGUjjV8ic2e
   xCJAYwVsXdZWGWBRVhBr65kx65128EeC6Iw5EdN5p2GP0rSLA0jiEre+S
   Az8bomI2HQhaWg5UfIIfWbkeAufAL1bRSIMlKnSi1Xf5L1geWT1bZjkpJ
   z0l2CTWS/K8eIQ8TlE+gmBmLET/ILbPMqbq6LVQFZ7DhnPdncYG5XNXV1
   A==;
X-CSE-ConnectionGUID: o+Jb4X9qTtWFDkfk7IAqXA==
X-CSE-MsgGUID: O9RfWYZVSVS9YlTXwXQkIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70351470"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="70351470"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 10:42:08 -0800
X-CSE-ConnectionGUID: EFde78KTRz6/CeyOU2w2Pg==
X-CSE-MsgGUID: v60C9EKQQLG3CEucScpJSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="207629537"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 10:42:07 -0800
Message-ID: <06fcb922-458c-473c-999a-1dd8518976f1@linux.intel.com>
Date: Mon, 26 Jan 2026 10:42:06 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Clear stale errors on reporting agents upon
 probe
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Terry Bowman <terry.bowman@amd.com>, linux-pci@vger.kernel.org,
 Shuai Xue <xueshuai@linux.alibaba.com>, tianruidong@linux.alibaba.com,
 Keith Busch <kbusch@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <3011c2ed30c11f858e35e29939add754adea7478.1769332702.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <3011c2ed30c11f858e35e29939add754adea7478.1769332702.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/2026 1:25 AM, Lukas Wunner wrote:
> Correctable and Uncorrectable Error Status Registers on reporting agents
> are cleared upon PCI device enumeration in pci_aer_init() to flush past
> events.  They're cleared again when an error is handled by the AER driver.
> 
> If an agent reports a new error after pci_aer_init() and before the AER
> driver has probed on the corresponding Root Port or Root Complex Event
> Collector, that error is not handled by the AER driver:  It clears the
> Root Error Status Register on probe, but neglects to re-clear the
> Correctable and Uncorrectable Error Status Registers on reporting agents.
> 
> The error will eventually be reported when another error occurs.  Which
> is irritating because to an end user it appears as if the earlier error
> has just happened.
> 
> Amend the AER driver to clear stale errors on reporting agents upon probe.
> 
> Skip reporting agents which have not invoked pci_aer_init() yet to avoid
> using an uninitialized pdev->aer_cap.  They're recognizable by the error
> bits in the Device Control register still being clear.
> 
> Reporting agents may execute pci_aer_init() after the AER driver has
> probed, particularly when devices are hotplugged or removed/rescanned via
> sysfs.  For this reason, it continues to be necessary that pci_aer_init()
> clears Correctable and Uncorrectable Error Status Registers.
> 

Can you include details about where and in what configuration you observed 
this issue?

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> Reported-by: Lucas Van <lucas.van@intel.com> # off-list
> Tested-by: Lucas Van <lucas.van@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pcie/aer.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e0bcaa8..4299c55 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1608,6 +1608,20 @@ static void aer_disable_irq(struct pci_dev *pdev)
>  	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>  }
>  
> +static int clear_status_iter(struct pci_dev *dev, void *data)
> +{
> +	u16 devctl;
> +
> +	/* Skip if pci_enable_pcie_error_reporting() hasn't been called yet */
> +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &devctl);
> +	if (!(devctl & PCI_EXP_AER_FLAGS))
> +		return 0;
> +
> +	pci_aer_clear_status(dev);
> +	pcie_clear_device_status(dev);

Should pci_aer_init() also clear device status along with uncor/cor error status?

> +	return 0;
> +}
> +
>  /**
>   * aer_enable_rootport - enable Root Port's interrupts when receiving messages
>   * @rpc: pointer to a Root Port data structure
> @@ -1629,9 +1643,19 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>  	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
>  				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
>  
> -	/* Clear error status */
> +	/* Clear error status of this Root Port or RCEC */
>  	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
>  	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, reg32);
> +
> +	/* Clear error status of agents reporting to this Root Port or RCEC */
> +	if (reg32 & AER_ERR_STATUS_MASK) {
> +		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
> +			pcie_walk_rcec(pdev, clear_status_iter, NULL);
> +		else if (pdev->subordinate)
> +			pci_walk_bus(pdev->subordinate, clear_status_iter,
> +				     NULL);
> +	}
> +
>  	pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &reg32);
>  	pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS, reg32);
>  	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

