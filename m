Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888527BF6C;
	Mon, 16 Mar 2026 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680902; cv=none; b=BtzYIAa74srMWxtvYliVYPIJ4PdG0BMaUVgvOG7uvTQLxBtR9NbTqV32dX63sJP6L8c60ojtccMoNlPIbnzYj4m83pt84iVPhcG1JgVVMTOER0vIXee+atXubRSzbSnPCkmMB60bKXbGcFo3fDexmd92sHxADLoXgji+FrSIbrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680902; c=relaxed/simple;
	bh=1QaWj1bwHAm5E2mhN/xOBT1kGpEQS+6ortTVaFl4lBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9pHEcQh3Bb7OCd4X4+TkSc0U0quiyxRXBa/aNTOC+F9DO4I9RudhmuHt7jDUrtiksLkVPOy0S1NL/NFekqqVeDuR2O7cQIDyWxXFP/5HSSy1wCE2eg7eCex7M6xjmTG39T6Uecdd5pSf8s0xy9bg8j9lxwD3dqPMgAL/B1BZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8MLmfvn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8MLmfvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773680901; x=1805216901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1QaWj1bwHAm5E2mhN/xOBT1kGpEQS+6ortTVaFl4lBU=;
  b=a8MLmfvnGY9rHMqK23M/8dR+HlNBba9rGjc+ZMba/fnZlqaaJ/oJjQXt
   TB8DrM1KRHEwmsNbqkwDwl6OufFEQgCfw6A2VCbJyUNTrI9VTI6cG6ftb
   huvoAC6ugYKhMhgyIF/EZcZqpVEJ+K2ZLejSCkcfpmCKqlW4UgqIrdub+
   rA1JDjLxD2yNODlA2FtvB6PcERoFmJRtn6WLkwGs9xZgRrqgAUT5ZKIKe
   7AOjvNfOBaxO8ZVEQRhmdwMLNCbZTbH2SC0ZAtfDnxS45vw+Zb753uU/H
   l62Ih1PGwsUt6XjN4tPq2oiH1h3Ca+dvxUE/2A+ehz5BWrkjjzS9oHpfJ
   Q==;
X-CSE-ConnectionGUID: l6xTOXvYQh2zRk4o1YS62w==
X-CSE-MsgGUID: qkBScapfT+evu1NnRwFSrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="78599050"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="78599050"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 10:08:20 -0700
X-CSE-ConnectionGUID: P8f1zGkORvWGfscsJ3OkOQ==
X-CSE-MsgGUID: Hp+nuDmiSjWB5X2XVYMa8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217783569"
Received: from lkp-server01.sh.intel.com (HELO 892944969b78) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Mar 2026 10:08:18 -0700
Received: from kbuild by 892944969b78 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2BQN-0000000010w-2UiD;
	Mon, 16 Mar 2026 17:08:15 +0000
Date: Tue, 17 Mar 2026 01:07:42 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	hans.zhang@cixtech.com
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH 2/2] PCI: cadence: Add debugfs property to provide LTSSM
 status of the PCIe link
Message-ID: <202603170025.GkqrnkFH-lkp@intel.com>
References: <20260315155514.127255-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315155514.127255-3-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1c9982b4961334c1edb0745a04cabd34bc2de675]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-cadence-Add-HPA-architecture-flag/20260316-002148
base:   1c9982b4961334c1edb0745a04cabd34bc2de675
patch link:    https://lore.kernel.org/r/20260315155514.127255-3-18255117159%40163.com
patch subject: [PATCH 2/2] PCI: cadence: Add debugfs property to provide LTSSM status of the PCIe link
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20260317/202603170025.GkqrnkFH-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260317/202603170025.GkqrnkFH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603170025.GkqrnkFH-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "cdns_pcie_debugfs_init" [drivers/pci/controller/cadence/pcie-cadence-host-mod.ko] undefined!
>> ERROR: modpost: "cdns_pcie_debugfs_init" [drivers/pci/controller/cadence/pcie-cadence-ep-mod.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
