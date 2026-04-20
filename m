Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561603845D1;
	Mon, 20 Apr 2026 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776715846; cv=none; b=MI55PTS5/KuEn2tGuZ+z5eNIAnqc0atkK0dU779sctJFqpcF1mVIYhabZn/2BCr2IQG4Ux+BYPQH4B7VJS73yhurEQEuneI78RpJSBGYlLHAN0wgsHoYDmdJQsPJ1V5qgqTDwH6g3xHD09IpuezSCYzaeI92V0ZYi7F1D5klMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776715846; c=relaxed/simple;
	bh=S/z0zn4Dn2TO2dYuuMEZ7tXprCTD2fyGXqNf8LXyvSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ+bF8Ugwi0tAaA3Bdocx2L/Bh7N+dlLkW7zlgHbkfY2WOZcgTCyBUz+A2vF+C0SalZSyBQjCMDZ64i58xDvmSr9Ln3hIMH5Ul8j/wCBMrtRvb78i1h29sZDCIsjzrEdagXMCrBOhnEgxoclThW8tuH/xLD6XqxG3arUVT6OHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiAbU0Ac; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiAbU0Ac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776715844; x=1808251844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S/z0zn4Dn2TO2dYuuMEZ7tXprCTD2fyGXqNf8LXyvSc=;
  b=DiAbU0AcwtC4x2dJycv7D3/+Sgcj7HTYzhFI66KMqTtCq2uE/izCQO5Y
   VzIWM1zGv8gEaN/NjNSUi/RnajP6qp7WBJVSoPJw1DxOLW1skxrVHRtdf
   Gj7K42m7Lo7zK96w54GLukv4PzSA0RLGujiTVsj8Tc5dKfM63Cnz4Dx5Q
   /UdSg+yaj6KqOmOrL/FHCIsgiqplF8VkXjjJcgOi3n9xSKuI7RdksBT7a
   4EaZFyktKIgqvSUB2PjFsFL5EmbIAqMxbXF3LjEpOmLw+TLprrKQyFutj
   950el7bg/08SOTIeX8xW8FsEgLsEr0Ao0X5QPud2eRzfrMsz/rAEE4XQM
   g==;
X-CSE-ConnectionGUID: Fz4Akc6kQACKC3yJkEdpAw==
X-CSE-MsgGUID: 8Ek9/yZRQ8eW6QZBgevohw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88257774"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="88257774"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 13:10:43 -0700
X-CSE-ConnectionGUID: oWPOVsJJRZuE44eifZB4XQ==
X-CSE-MsgGUID: sh/CJk3cSRG0hPN6WuwX7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="236793311"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Apr 2026 13:10:40 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wEux4-000000002pc-132t;
	Mon, 20 Apr 2026 20:10:38 +0000
Date: Tue, 21 Apr 2026 04:09:41 +0800
From: kernel test robot <lkp@intel.com>
To: Ankit Agrawal <ankita@nvidia.com>, alex@shazbot.org,
	kvm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jgg@ziepe.ca,
	yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com,
	ankita@nvidia.com, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Message-ID: <202604210425.SVQZamM3-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260421/202604210425.SVQZamM3-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260421/202604210425.SVQZamM3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604210425.SVQZamM3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/vfio/pci/nvgrace-gpu/main.c:296:23: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     296 |         mem_active_timeout = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT,
         |                              ^
   1 error generated.


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
