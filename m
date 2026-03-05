Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A299F33B6FB;
	Thu,  5 Mar 2026 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742733; cv=none; b=MoAUOazjXSJVAPFatHXj7mcLqCOYV7O9dt+c2+L8U+pqB4qK4+j1L4zAdWtxBTABpxnzyA3m+ur+rU+D3omQL9CnNH33JTrfK4hnILgbDdb7BghHP7z3+qx9hhtFmy2G3LPCc62OBZ0JqlFC+35qa+mEOFRRT1xm8Vfar0+anZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742733; c=relaxed/simple;
	bh=hugQiWGkFSYVq+nyZirpvLC+ZZve2bK6FwMh0hbpRhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1iljytesJ/Qi20H3ONpD3to3WhlelV0Ncrwy/1EWVw2SQrThhUS2jiU8g9Kqlsk2uutROBrWHJGc9evAyjnj+ww8CLMCtLxwYvHLTVjYKpSJvaV6r+HyCfPhDJFYVL2r6ZQLmuuU3mRcpQx19ByMgPaxoBXK2vx5GA8c/ZNHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUFRzDIT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUFRzDIT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772742731; x=1804278731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hugQiWGkFSYVq+nyZirpvLC+ZZve2bK6FwMh0hbpRhI=;
  b=HUFRzDITLmLMvwF7tGCHw9cAQEME3xhjnzA/rKK3O2cwdWN4eIOITO34
   I0ULVCJuxLk1cTBqF1y2LPRg58DExerMw4wOm8oqV6Hr0v0QbY0IkwIdM
   cB7+9aUQCWGKNowKWuaPEfdYntLvUs2KQqR2hVyeOQpZrmaU4el+mRoEx
   Xku0doJ8Pr4VpxhA54J8WE1td5cRmwI+K+VyFLw+OiJx/ZHpH1e2VnVvX
   NY9uC5XSKxtRjsH7xPvJHaCHP0lEcWjomkYdiC8snBVHL43TXHiqPNIoO
   DtSzVg0uwmLVyxAuha0Upxnn2gHG1vH7pjVWX4PseJ4uxMM6WjACUNOzf
   w==;
X-CSE-ConnectionGUID: FhqZ8u9bRxibxFuZGilZ9Q==
X-CSE-MsgGUID: 1odPlBm1Qgi7TA2EaV7wPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="77690773"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="77690773"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 12:32:10 -0800
X-CSE-ConnectionGUID: dLwqVkZmQF+QYNrEDvZfnw==
X-CSE-MsgGUID: nTLHGL1wQAOhkWhnUrJNfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="249259129"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Mar 2026 12:32:02 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyFMU-000000001Cc-0tog;
	Thu, 05 Mar 2026 20:31:58 +0000
Date: Fri, 6 Mar 2026 04:31:10 +0800
From: kernel test robot <lkp@intel.com>
To: Chengwen Feng <fengchengwen@huawei.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, wei.huang2@amd.com,
	jonathan.cameron@huawei.com, wangzhou1@hisilicon.com,
	wanghuiqiang@huawei.com, liuyonglong@huawei.com
Subject: Re: [PATCH v2] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
Message-ID: <202603060433.2NbZmymR-lkp@intel.com>
References: <20260305083650.54611-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305083650.54611-1-fengchengwen@huawei.com>

Hi Chengwen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus arm64/for-next/core tip/x86/core rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v7.0-rc2 next-20260305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengwen-Feng/PCI-TPH-Fix-get-cpu-steer-tag-fail-on-ARM64-platform/20260305-164057
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260305083650.54611-1-fengchengwen%40huawei.com
patch subject: [PATCH v2] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
config: x86_64-buildonly-randconfig-002-20260306 (https://download.01.org/0day-ci/archive/20260306/202603060433.2NbZmymR-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603060433.2NbZmymR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603060433.2NbZmymR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/common.c:2649:5: warning: no previous prototype for function 'acpi_get_cpu_acpi_id' [-Wmissing-prototypes]
    2649 | int acpi_get_cpu_acpi_id(unsigned int cpu)
         |     ^
   arch/x86/kernel/cpu/common.c:2649:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    2649 | int acpi_get_cpu_acpi_id(unsigned int cpu)
         | ^
         | static 
   1 warning generated.


vim +/acpi_get_cpu_acpi_id +2649 arch/x86/kernel/cpu/common.c

  2648	
> 2649	int acpi_get_cpu_acpi_id(unsigned int cpu)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
