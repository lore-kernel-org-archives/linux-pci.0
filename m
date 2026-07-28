Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5901361670
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 04:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785213057; cv=none; b=jITk/5qK3K5QOoHc47zM6RkQeKzII7jjN8Mq8xFC0kvabYrLq/zMTd5oeilID5ZO9JKpioTaHVinsv519K6AjaO4YeBQ3nBdEqULZdTq8niGR8DCXgX7lhobWIGz9CkoCdkJJn0xC/OECf7SyDWJppCwqK7KP49Rn4/hhLV3Kd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785213057; c=relaxed/simple;
	bh=Z+HA6eoCK9D6YxKGVzxh8oyrHbwyVwZ8vyKxGn5/oh8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NP2DSunuoL12y+XTRzlFJoapIRcmZTmchNnDnDjM6vZHwqd5RoQGiHNaHb1mrPr/pcJi8+Ay1LxSvxz/W2SfQeQNozcmYguWgdQGSd6SpSqVT5phQ/lyajLF5BS+0YNVXIycWecjssHJL2RHNg0/G0CDQjXzoMe+1mkuCTemMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oG52x5Sz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oG52x5Sz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785213056; x=1816749056;
  h=date:from:to:cc:subject:message-id;
  bh=Z+HA6eoCK9D6YxKGVzxh8oyrHbwyVwZ8vyKxGn5/oh8=;
  b=oG52x5SzhjU8yeF/hQBq7eWDLxZKOmtTlSlh+Zs54PD04Z+ygYVmUpiX
   Isb28yR3XXXL8eNaz3TueeoU5zDPNJ8b9IPLR1sx4z+cewF7Cbc3/4EBN
   bU3DWWKdObshswQqFVQy5p/IQ8++BaYzjmXZDG3eTQJmIZ+4Jg+h88QRL
   vLF1TnFeC6u2WhUPHwr+eGVG0RQVL1zGFkWI82K2ZXDKVw01q0iu92VRx
   u29gj1xLvjAJg2Wys+uykm1oc/GtdFuYTM0tC+IvbWXs6MEXxRxHFyK0D
   cm/SNgWhfFZfSV9qAzr0ivMUQ7moVOEZhU/GeSTWidDcawVzrz6fgQNV+
   w==;
X-CSE-ConnectionGUID: vIKLSzDrQReOJUKKl/QiAw==
X-CSE-MsgGUID: OVWOqyX9ScGvaww7t74qFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="88327418"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="88327418"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 21:30:55 -0700
X-CSE-ConnectionGUID: TRWTYDczRsGIqITLq5zyPw==
X-CSE-MsgGUID: kDJhHKngST2SaayY9qdsgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="261577083"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 27 Jul 2026 21:30:54 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1woZSk-00000000dxz-3dPs;
	Tue, 28 Jul 2026 04:30:50 +0000
Date: Tue, 28 Jul 2026 12:29:44 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 7147a7bfce47acd48c3738130bf0bd692bfd80de
Message-ID: <202607281233.CklEFV9W-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: 7147a7bfce47acd48c3738130bf0bd692bfd80de  PCI: j721e: Fix incorrect max_lanes for J7200

elapsed time: 5177m

configs tested: 12
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha    allnoconfig    gcc-16.1.0
alpha   allyesconfig    gcc-16.1.0
arc     allmodconfig    gcc-16.1.0
arc     allyesconfig    gcc-16.1.0
csky    allmodconfig    gcc-16.1.0
i386    allmodconfig    gcc-14
nios2   allmodconfig    gcc-11.5.0
nios2    allnoconfig    gcc-11.5.0
parisc  allmodconfig    gcc-16.1.0
parisc  allyesconfig    gcc-16.1.0
x86_64         kexec    clang-22
x86_64  rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
