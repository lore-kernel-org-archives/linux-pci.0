Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDBC19D092;
	Tue, 21 Apr 2026 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739040; cv=none; b=D0bvmUYM/GRri72D3dfhmstz6Xgk5pmRf0yuz+6/rcX2DK3IR6kaaSHd2/xnk569ECLt9Mit28FgX/CqU4ihp/O813VM7FQhw0m1AAd3cSsflRC7vsCrULv8reLu/jiddHFB9jjSEDF1hDZMiqdLcJalJJWbz7zJR3hDfoz7UcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739040; c=relaxed/simple;
	bh=kLjAJo70fkgnsD13Ls077Ot8cFRRYh1VFRwVAY2efjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwlLJLSP2+1ZsFXlaHFIhRw4bvRKUqkDd7Vl/NHOTePf/kiLG6BL7GJfs/4dPT1cfEGEJvl/T2nWpKU+ZDkFl/kd4scjkHTTTZEw4bcVDic+Kdsh4xUnIuWgi0yo+mGxnpJN7YrjyaAIG0duPWMfCBuvz1to/Jp8E0BailJsyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNyQ/Ai7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNyQ/Ai7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776739037; x=1808275037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kLjAJo70fkgnsD13Ls077Ot8cFRRYh1VFRwVAY2efjY=;
  b=RNyQ/Ai7kIr/5g/Y6HGcRMxoGv5khRuFPUWkv75DdzkHKC4mTy+P+F8c
   S0TwzDXd/29awIo1kLEeWiEKNi42KzI7JBgYRD6wx9eIjb7Fu8HGgobbE
   +fuHld+e+kd8YU7pIjHClY5qurYgZvpq9Q5REhZMFGPzqHw0hi8x8un22
   Gh+ZCiWJ2MJVzu3TNxpFcC+1e1JP7GmW6/CEZqpqnmQ3koe4CnZtUhJh6
   ZOUBfipl56LyedMMA3ZaTIdzzJ76nH2ebtX41ycnOR4JPQvink9I6xxmr
   GPJBs7P8decx+k2Zz1NNZi0MJzivXxGvnUGsTz00QJILiA6Jysm+G79G8
   A==;
X-CSE-ConnectionGUID: LIpecWWfQLa5NlsDPf/5rw==
X-CSE-MsgGUID: 4t3apqgJTAG/NZUKF8LBDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="103125437"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="103125437"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 19:37:17 -0700
X-CSE-ConnectionGUID: NkwAoNajSRO0BFlEPlrV9Q==
X-CSE-MsgGUID: 9GwtlLztRhOSz5yxXSrZXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="233670397"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 20 Apr 2026 19:37:14 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wF0z9-0000000037E-3e6J;
	Tue, 21 Apr 2026 02:37:11 +0000
Date: Tue, 21 Apr 2026 10:37:01 +0800
From: kernel test robot <lkp@intel.com>
To: Ankit Agrawal <ankita@nvidia.com>, alex@shazbot.org,
	kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jgg@ziepe.ca, yishaih@nvidia.com,
	skolothumtho@nvidia.com, kevin.tian@intel.com, ankita@nvidia.com,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Message-ID: <202604211223.HLb8onLi-lkp@intel.com>
References: <20260416014504.63067-1-ankita@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416014504.63067-1-ankita@nvidia.com>

Hi Ankit,

kernel test robot noticed the following build errors:

[auto build test ERROR on awilliam-vfio/next]
[also build test ERROR on awilliam-vfio/for-linus pci/next pci/for-linus linus/master v7.0 next-20260420]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ankit-Agrawal/vfio-nvgrace-gpu-Add-Blackwell-Next-GPU-readiness-check-via-CXL-DVSEC/20260419-053131
base:   https://github.com/awilliam/linux-vfio.git next
patch link:    https://lore.kernel.org/r/20260416014504.63067-1-ankita%40nvidia.com
patch subject: [PATCH v3 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260421/202604211223.HLb8onLi-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260421/202604211223.HLb8onLi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604211223.HLb8onLi-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/vfio/pci/nvgrace-gpu/main.c: In function 'nvgrace_gpu_wait_device_ready_cxl':
>> drivers/vfio/pci/nvgrace-gpu/main.c:296:30: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     296 |         mem_active_timeout = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT,
         |                              ^~~~~~~~~


vim +/FIELD_GET +296 drivers/vfio/pci/nvgrace-gpu/main.c

   280	
   281	static int nvgrace_gpu_wait_device_ready_cxl(struct nvgrace_gpu_pci_core_device *nvdev)
   282	{
   283		struct pci_dev *pdev = nvdev->core_device.pdev;
   284		int cxl_dvsec = nvdev->cxl_dvsec;
   285		unsigned long mem_info_valid_deadline;
   286		unsigned long timeout;
   287		u32 dvsec_memory_status;
   288		u8 mem_active_timeout;
   289	
   290		pci_read_config_dword(pdev, cxl_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
   291				      &dvsec_memory_status);
   292	
   293		if (cxl_dvsec_mem_is_active(dvsec_memory_status))
   294			return 0;
   295	
 > 296		mem_active_timeout = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT,
   297					       dvsec_memory_status);
   298	
   299		timeout = jiffies +
   300			  msecs_to_jiffies(cxl_mem_active_timeout_ms(mem_active_timeout));
   301	
   302		mem_info_valid_deadline = jiffies + msecs_to_jiffies(POLL_QUANTUM_MS);
   303	
   304		do {
   305			pci_read_config_dword(pdev,
   306					      cxl_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
   307					      &dvsec_memory_status);
   308	
   309			if (cxl_dvsec_mem_is_active(dvsec_memory_status))
   310				return 0;
   311	
   312			/* Bail early if MEM_INFO_VALID is not set within 1 second */
   313			if (!(dvsec_memory_status & PCI_DVSEC_CXL_MEM_INFO_VALID) &&
   314			    time_after(jiffies, mem_info_valid_deadline))
   315				return -ETIME;
   316	
   317			msleep(POLL_QUANTUM_MS);
   318		} while (!time_after(jiffies, timeout));
   319	
   320		return -ETIME;
   321	}
   322	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
