Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319EB3CAA41;
	Wed, 13 May 2026 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713664; cv=none; b=WCVFNblpVC2sMMslF8+qMiUWgLa0JDms8zMbyCpk/BExSOUbAnNk5F9jyVOa6hd1yYm0ArvnT6OSvwqHxiIX+VjfveFwiATXRvq0mMsprKT6EtEOANEtNbw+Q2Q1gXFoJDHwMwVSwGplaY8pJwoh+IBu5PwzfLd71ebpmBq8wvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713664; c=relaxed/simple;
	bh=ALVwDDjok+OEdPpXRwF61S2YSUI5YuC2BZEzIYLQAj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS61Dy5XKSJYdjxNJIJQnhts2z8mtyfTgdbWY7GWrlqWsCYRjEAmp0OzJWzb1pbQQaQbOoDvlBW0CMqO0p2IKu4kALOK9hhvUkjQcNtfInDO2BxMLCjQ+jpNQwS50BrIEsPWfEwsM39Y1RAHSQyMWtkkEbcC0CJOTV8BdYDr/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HG1K1yxP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HG1K1yxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778713662; x=1810249662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ALVwDDjok+OEdPpXRwF61S2YSUI5YuC2BZEzIYLQAj8=;
  b=HG1K1yxPWYngHdnq3HN4+B8Og57brja/XcsUUInTgsJ/yYAVJASWAjtn
   XQVt6aLX9uw5kUWQDYi4oJ4kMUI3FYDJWeUZc04bNE2tzSF774hvR9RrW
   XFUCKBdmu493An3sx50q61cWQqo0dKkxfORpUxAuJzY9/1rrwj5WLGc3o
   JfdipYooOVEv+HGT6p22tuvqX6Z77ssf9ImCc5X0HlvA5K4z/OAuZdfbD
   VkClTNyiWOJVAIVkCVtXAwdJbucXz43uoo0e1JTXBXZkcwefpqfK3OjWA
   6GY4L1vVWXtgHtJs08F/xmtm/K/BSTXC+eX2tNd0DsYaV1RuyX6cfR2Iw
   Q==;
X-CSE-ConnectionGUID: ZRVEFfkNR7WBsDSG9eZANw==
X-CSE-MsgGUID: l+5Kz43WQQy0izD6MGvC3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="91037815"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="91037815"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 16:07:41 -0700
X-CSE-ConnectionGUID: i0+kLsn+TGODubVr1B9qyw==
X-CSE-MsgGUID: 7wtMRLYHQ6Ow3/zWIrgT2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="235557652"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 May 2026 16:07:40 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNIfx-000000005H1-21xG;
	Wed, 13 May 2026 23:07:37 +0000
Date: Thu, 14 May 2026 07:07:16 +0800
From: kernel test robot <lkp@intel.com>
To: hangej <hangej@amazon.com>, bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dwmw2@infradead.org, kexec@lists.infradead.org, hangej@amazon.com
Subject: Re: [PATCH] pci_crash: capture PCI config space at panic time
Message-ID: <202605140714.yFl4KATZ-lkp@intel.com>
References: <20260512162402.1929687-1-hangej@amazon.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512162402.1929687-1-hangej@amazon.com>

Hi hangej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hangej/pci_crash-capture-PCI-config-space-at-panic-time/20260514-000653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260512162402.1929687-1-hangej%40amazon.com
patch subject: [PATCH] pci_crash: capture PCI config space at panic time
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260514/202605140714.yFl4KATZ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605140714.yFl4KATZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605140714.yFl4KATZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/pci_crash.c:74 cannot understand function prototype: 'void *pci_crash_buffer;'
>> Warning: kernel/pci_crash.c:80 cannot understand function prototype: 'size_t pci_crash_buffer_size;'
>> Warning: kernel/pci_crash.c:90 cannot understand function prototype: 'phys_addr_t pci_crash_pagemap_phys;'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
