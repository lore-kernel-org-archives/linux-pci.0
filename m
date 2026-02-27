Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F538318139
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232440; cv=none; b=YKhhHAslkVIehxnSXJ01/Nbx2MvfAf70gnH3lA38d1snQYZpQZuesmPH5FzRkeBXec3Wt63veZunV5N10Cqx1QW5iDciuQgFeqKfpHvA/IwpR31THQnQ0hTjjsBYE+hCaV/phnJZ6Q+ys7azj+IWDE4JfqlAzkeMwdCBPRgVRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232440; c=relaxed/simple;
	bh=lue3b+HknU9rFxnmo2Rt3XzEDUUy9plnd6sgbzfQpxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMD/jez/7VZDjTYSVjFsZsQciUnGYTAIubZdGfJQTm1c0sYrzYx07dmPkfUBmALnWPOcocDhxsX36p+ZBavvQAtO6XhZR/l5arJ253BUFXLiBq4GhP0QmfS870Fpg8v6IYiAg710iHwjvxYoYGQ2svFgvhlHH+mbTHOAzh5vKQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1uKmdsq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1uKmdsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772232438; x=1803768438;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lue3b+HknU9rFxnmo2Rt3XzEDUUy9plnd6sgbzfQpxM=;
  b=E1uKmdsqkP/neZAQQvkBmIh+2nrwcowcTp4bsn71hErtm8d72KTOMHzq
   X2lyKuT1r+nZ6SgATeKirlOpJwI/ky5CumXMhTFFJcLrI5bCvKB1AArK2
   /wPq5VgmrhU9K5zZD/TXtTx7lJt8wRf3ZOLkaxiSJiV1Uqin6AEZNvmmh
   S+r2EBwmwlebOBVEft9QYE1WsBd65psdiCKajldnaJ2ELNRw1cnK5K0hZ
   ncRDWswB2Y4T44FTraBo/SPphpWhVrGvzqJE9hQFFhmImqdSTrT+0JSJt
   jfUnYH9MgqtEDemztiOJxFs84UFVDOvbMpC3hy26+R7BC4ieNxWi985b6
   Q==;
X-CSE-ConnectionGUID: BrzRrFZ8QLCm0iN8D3GAUQ==
X-CSE-MsgGUID: iVTFq1kvRKOY5HYOyNuaDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="84672202"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="84672202"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 14:47:17 -0800
X-CSE-ConnectionGUID: 7EIxxpGmS4WlOsxmEicJGw==
X-CSE-MsgGUID: gWQwaua6TQKnrHU/X25DHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="240039721"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 14:47:16 -0800
Message-ID: <0fdec25a-1ea5-4526-8809-eff71553067c@linux.intel.com>
Date: Fri, 27 Feb 2026 14:47:16 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ERR: Clear fatal status of the reporting device
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Sizhe Liu <liusizhe5@huawei.com>, bhelgaas@google.com,
 jonathan.cameron@huawei.com, shiju.jose@huawei.com, keith.busch@intel.com,
 linux-pci@vger.kernel.org, linuxarm@huawei.com, prime.zeng@hisilicon.com,
 fanghao11@huawei.com, shenyang39@huawei.com,
 Shuai Xue <xueshuai@linux.alibaba.com>, Terry Bowman <terry.bowman@amd.com>
References: <20260227102505.3966864-1-liusizhe5@huawei.com>
 <20260227163118.GA3897131@bhelgaas> <aaIJa_2XiQht4swq@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aaIJa_2XiQht4swq@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lukas,

On 2/27/2026 1:15 PM, Lukas Wunner wrote:
> On Fri, Feb 27, 2026 at 06:25:05PM +0800, Sizhe Liu wrote:
>> During PCIe native AER error recovery, ERR_FATAL status bits are not cleared
>> after fatal error handling. This causes stale ERR_FATAL bits to be reported
>> in subsequent AER events, even after reporting "device recovery successful".
> 
> Wrong.	The bits are cleared by:
> 
> report_slot_reset()
>   err_handler->slot_reset()
>     pci_restore_state()
>       pci_aer_clear_status()
>       	pci_aer_raw_clear_status()

Thanks for the correction and for sharing the call flow. I was not aware
that the fatal status bits are already cleared via pci_restore_state().

That raises a question. If pci_restore_state() already clears all AER
status bits through pci_aer_raw_clear_status(), do we still need the
explicit pci_aer_clear_nonfatal_status() call in pcie_do_recovery()?
Similarly, could pcie_clear_device_status() also be moved there?
I see pcie_clear_device_status() call is sprinkled across all error
handling paths (EDR, DPC & AER).

Also, since pci_aer_raw_clear_status() clears all error status registers,
is there a risk of silently losing newly detected errors that arrive while
recovery is still in progress?


> 
> Thanks,
> 
> Lukas
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

