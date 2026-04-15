Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EAF3822A6
	for <linux-pci@vger.kernel.org>; Wed, 15 Apr 2026 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258013; cv=none; b=LZcRrgO7Cu8XjwjjODX4N6795bryrDOUXyR1NQPJ6jQi1l1PYX9fej6VJsE3KsW2kn9g5/oLrSPtHmgwMARiLhDk23AVYo7BPfCIEsIvyLG6NH/tVQ1sJ75QsHRjgqUj1M/e1WSU0CYGS4aezOame3XdcFi5DOtGNjJjGnJMCKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258013; c=relaxed/simple;
	bh=hl/AX6pB4lUdlQmsvgf25YRDlmnblMuIPVOXJnQ/Z8M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AxJFzaOjZkT5L4ca0RSAkTXRC3HVlgggOQBT5U3XBERoaRT12Wl2a2nwnuyfPEeXIvAMOjgbjf5gdOy7H4BKEAncb7M1d8mQ9VEUTVhZkTwYnRzcpsRDp+JSKTJxP4XRjbnhRFWEFjueXOPAaCnvI7VCM31IAWzipZQRLLAG4qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkFHp0hC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkFHp0hC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776258013; x=1807794013;
  h=date:from:to:cc:subject:message-id;
  bh=hl/AX6pB4lUdlQmsvgf25YRDlmnblMuIPVOXJnQ/Z8M=;
  b=SkFHp0hCFjkpVR33L3t6wjSDcPjKFhx0vHJ8X30OmszCq8+5T0DHoA8T
   r1m90LMpVEpo8J/FwOluHRNYdkHp2mrVUwwPyl0R3JFw3JNokjPGPEm5e
   LUiKGdIpHy2CulXB3+tNPD5/ZHc6aoBUMlUpqlwW4F60U22c9aYj/WFJM
   KnqdzXDZy4qRj0+96+rnZxDUqQKRqRpZQHKuykFnEyDo2jtImXhwTFnXL
   4vtNK5ahYcNYsw6641jl0qnELqTFSVpi8c/jgNrkBRJaG6Dohr42tRNzg
   9hdZ+t41TigAkMZM7ZHLxz6wPwdP6jgfXHxIjLThgXot7QgPCqvLM2Nc+
   g==;
X-CSE-ConnectionGUID: xjTDjIgEQle5uDIl/1wqIw==
X-CSE-MsgGUID: 2jst07nPR5S4oAKkiaQ3ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="102691878"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="102691878"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 06:00:10 -0700
X-CSE-ConnectionGUID: ERu7GOhkT5yoZ3gIGDrg/Q==
X-CSE-MsgGUID: 5IpmoPNzQ/Gxi8IKBJ1RsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230658670"
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Apr 2026 06:00:07 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCzqd-000000000Wl-2qKH;
	Wed, 15 Apr 2026 13:00:03 +0000
Date: Wed, 15 Apr 2026 20:59:11 +0800
From: kernel test robot <lkp@intel.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [pci:controller/cadence-j721e 1/1]
 arch/powerpc/boot/treeboot-akebono.c:57:9: error: invalid instruction, did
 you mean: mfcr, mfdccr, mfdcr, mfdscr?
Message-ID: <202604152040.H4DRQF1s-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Hi Siddharth,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence-j721e
head:   4b361b1e92be255ff923453fe8db74086cc7cf66
commit: 4b361b1e92be255ff923453fe8db74086cc7cf66 [1/1] PCI: j721e: Add config guards for Cadence Host and Endpoint library APIs
config: powerpc-randconfig-r071-20260412 (https://download.01.org/0day-ci/archive/20260415/202604152040.H4DRQF1s-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project ae825cb8cea7f3ac8e5e4096f22713845cf5e501)
smatch: v0.5.0-9007-gcf3ea02b
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260415/202604152040.H4DRQF1s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604152040.H4DRQF1s-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/boot/treeboot-akebono.c:57:9: error: invalid instruction, did you mean: mfcr, mfdccr, mfdcr, mfdscr?
      57 |                 reg = mfdcrx(DDR3_MR0CF + i);
         |                       ^
   arch/powerpc/boot/dcr.h:16:16: note: expanded from macro 'mfdcrx'
      16 |                 asm volatile("mfdcrx %0,%1" : "=r"(rval) : "r"(rn)); \
         |                              ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         mfdcrx 4,6
         |         ^~~~~~
>> arch/powerpc/boot/treeboot-akebono.c:57:9: error: invalid instruction, did you mean: mfcr, mfdccr, mfdcr, mfdscr?
      57 |                 reg = mfdcrx(DDR3_MR0CF + i);
         |                       ^
   arch/powerpc/boot/dcr.h:16:16: note: expanded from macro 'mfdcrx'
      16 |                 asm volatile("mfdcrx %0,%1" : "=r"(rval) : "r"(rn)); \
         |                              ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         mfdcrx 8,8
         |         ^~~~~~
>> arch/powerpc/boot/treeboot-akebono.c:57:9: error: invalid instruction, did you mean: mfcr, mfdccr, mfdcr, mfdscr?
      57 |                 reg = mfdcrx(DDR3_MR0CF + i);
         |                       ^
   arch/powerpc/boot/dcr.h:16:16: note: expanded from macro 'mfdcrx'
      16 |                 asm volatile("mfdcrx %0,%1" : "=r"(rval) : "r"(rn)); \
         |                              ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         mfdcrx 3,3
         |         ^~~~~~
>> arch/powerpc/boot/treeboot-akebono.c:57:9: error: invalid instruction, did you mean: mfcr, mfdccr, mfdcr, mfdscr?
      57 |                 reg = mfdcrx(DDR3_MR0CF + i);
         |                       ^
   arch/powerpc/boot/dcr.h:16:16: note: expanded from macro 'mfdcrx'
      16 |                 asm volatile("mfdcrx %0,%1" : "=r"(rval) : "r"(rn)); \
         |                              ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         mfdcrx 3,3
         |         ^~~~~~
>> arch/powerpc/boot/treeboot-akebono.c:78:2: error: invalid instruction, did you mean: mtcr, mtdccr, mtdcr, mtdscr?
      78 |         mtdcrx(CCTL0_MCO4, 0x1);
         |         ^
   arch/powerpc/boot/dcr.h:21:16: note: expanded from macro 'mtdcrx'
      21 |                 asm volatile("mtdcrx %0,%1" : : "r"(rn), "r" (val)); \
         |                              ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         mtdcrx 4,5
         |         ^~~~~~
   arch/powerpc/boot/treeboot-akebono.c:81:8: error: invalid instruction, did you mean: mfcr, mfdccr, mfdcr, mfdscr?
      81 |         reg = mfdcrx(CCTL0_MCO2) & ~0x2;
         |               ^
   arch/powerpc/boot/dcr.h:16:16: note: expanded from macro 'mfdcrx'
      16 |                 asm volatile("mfdcrx %0,%1" : "=r"(rval) : "r"(rn)); \
         |                              ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         mfdcrx 4,3
         |         ^~~~~~
   arch/powerpc/boot/treeboot-akebono.c:82:2: error: invalid instruction, did you mean: mtcr, mtdccr, mtdcr, mtdscr?
      82 |         mtdcrx(CCTL0_MCO2, reg);
         |         ^
   arch/powerpc/boot/dcr.h:21:16: note: expanded from macro 'mtdcrx'
      21 |                 asm volatile("mtdcrx %0,%1" : : "r"(rn), "r" (val)); \
         |                              ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         mtdcrx 3,4
         |         ^~~~~~
   7 errors generated.
--
>> arch/powerpc/boot/treeboot-currituck.c:46:9: error: invalid instruction, did you mean: mfcr, mfdccr, mfdcr, mfdscr?
      46 |                 reg = mfdcrx(DDR3_MR0CF + i);
         |                       ^
   arch/powerpc/boot/dcr.h:16:16: note: expanded from macro 'mfdcrx'
      16 |                 asm volatile("mfdcrx %0,%1" : "=r"(rval) : "r"(rn)); \
         |                              ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         mfdcrx 4,4
         |         ^~~~~~
>> arch/powerpc/boot/treeboot-currituck.c:46:9: error: invalid instruction, did you mean: mfcr, mfdccr, mfdcr, mfdscr?
      46 |                 reg = mfdcrx(DDR3_MR0CF + i);
         |                       ^
   arch/powerpc/boot/dcr.h:16:16: note: expanded from macro 'mfdcrx'
      16 |                 asm volatile("mfdcrx %0,%1" : "=r"(rval) : "r"(rn)); \
         |                              ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         mfdcrx 8,8
         |         ^~~~~~
>> arch/powerpc/boot/treeboot-currituck.c:46:9: error: invalid instruction, did you mean: mfcr, mfdccr, mfdcr, mfdscr?
      46 |                 reg = mfdcrx(DDR3_MR0CF + i);
         |                       ^
   arch/powerpc/boot/dcr.h:16:16: note: expanded from macro 'mfdcrx'
      16 |                 asm volatile("mfdcrx %0,%1" : "=r"(rval) : "r"(rn)); \
         |                              ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         mfdcrx 3,3
         |         ^~~~~~
>> arch/powerpc/boot/treeboot-currituck.c:46:9: error: invalid instruction, did you mean: mfcr, mfdccr, mfdcr, mfdscr?
      46 |                 reg = mfdcrx(DDR3_MR0CF + i);
         |                       ^
   arch/powerpc/boot/dcr.h:16:16: note: expanded from macro 'mfdcrx'
      16 |                 asm volatile("mfdcrx %0,%1" : "=r"(rval) : "r"(rn)); \
         |                              ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         mfdcrx 3,3
         |         ^~~~~~
   4 errors generated.


vim +57 arch/powerpc/boot/treeboot-akebono.c

2a2c74b2efcb1a Alistair Popple 2014-03-06  49  
2a2c74b2efcb1a Alistair Popple 2014-03-06  50  static unsigned long long ibm_akebono_detect_memsize(void)
2a2c74b2efcb1a Alistair Popple 2014-03-06  51  {
2a2c74b2efcb1a Alistair Popple 2014-03-06  52  	u32 reg;
2a2c74b2efcb1a Alistair Popple 2014-03-06  53  	unsigned i;
2a2c74b2efcb1a Alistair Popple 2014-03-06  54  	unsigned long long memsize = 0;
2a2c74b2efcb1a Alistair Popple 2014-03-06  55  
2a2c74b2efcb1a Alistair Popple 2014-03-06  56  	for (i = 0; i < MAX_RANKS; i++) {
2a2c74b2efcb1a Alistair Popple 2014-03-06 @57  		reg = mfdcrx(DDR3_MR0CF + i);
2a2c74b2efcb1a Alistair Popple 2014-03-06  58  
2a2c74b2efcb1a Alistair Popple 2014-03-06  59  		if (!(reg & 1))
2a2c74b2efcb1a Alistair Popple 2014-03-06  60  			continue;
2a2c74b2efcb1a Alistair Popple 2014-03-06  61  
2a2c74b2efcb1a Alistair Popple 2014-03-06  62  		reg &= 0x0000f000;
2a2c74b2efcb1a Alistair Popple 2014-03-06  63  		reg >>= 12;
2a2c74b2efcb1a Alistair Popple 2014-03-06  64  		memsize += (0x800000ULL << reg);
2a2c74b2efcb1a Alistair Popple 2014-03-06  65  	}
2a2c74b2efcb1a Alistair Popple 2014-03-06  66  
2a2c74b2efcb1a Alistair Popple 2014-03-06  67  	return memsize;
2a2c74b2efcb1a Alistair Popple 2014-03-06  68  }
2a2c74b2efcb1a Alistair Popple 2014-03-06  69  
2a2c74b2efcb1a Alistair Popple 2014-03-06  70  static void ibm_akebono_fixups(void)
2a2c74b2efcb1a Alistair Popple 2014-03-06  71  {
2a2c74b2efcb1a Alistair Popple 2014-03-06  72  	void *emac;
2a2c74b2efcb1a Alistair Popple 2014-03-06  73  	u32 reg;
2a2c74b2efcb1a Alistair Popple 2014-03-06  74  
2a2c74b2efcb1a Alistair Popple 2014-03-06  75  	dt_fixup_memory(0x0ULL,  ibm_akebono_memsize);
2a2c74b2efcb1a Alistair Popple 2014-03-06  76  
2a2c74b2efcb1a Alistair Popple 2014-03-06  77  	/* Fixup the SD timeout frequency */
2a2c74b2efcb1a Alistair Popple 2014-03-06 @78  	mtdcrx(CCTL0_MCO4, 0x1);
2a2c74b2efcb1a Alistair Popple 2014-03-06  79  
2a2c74b2efcb1a Alistair Popple 2014-03-06  80  	/* Disable SD high-speed mode (which seems to be broken) */
2a2c74b2efcb1a Alistair Popple 2014-03-06  81  	reg = mfdcrx(CCTL0_MCO2) & ~0x2;
2a2c74b2efcb1a Alistair Popple 2014-03-06  82  	mtdcrx(CCTL0_MCO2, reg);
2a2c74b2efcb1a Alistair Popple 2014-03-06  83  
2a2c74b2efcb1a Alistair Popple 2014-03-06  84  	/* Set the MAC address */
2a2c74b2efcb1a Alistair Popple 2014-03-06  85  	emac = finddevice("/plb/opb/ethernet");
2a2c74b2efcb1a Alistair Popple 2014-03-06  86  	if (emac > 0) {
2a2c74b2efcb1a Alistair Popple 2014-03-06  87  		if (mac_addr)
2a2c74b2efcb1a Alistair Popple 2014-03-06  88  			setprop(emac, "local-mac-address",
2a2c74b2efcb1a Alistair Popple 2014-03-06  89  				((u8 *) &mac_addr) + 2 , 6);
2a2c74b2efcb1a Alistair Popple 2014-03-06  90  	}
2a2c74b2efcb1a Alistair Popple 2014-03-06  91  }
2a2c74b2efcb1a Alistair Popple 2014-03-06  92  

:::::: The code at line 57 was first introduced by commit
:::::: 2a2c74b2efcb1a0ca3fdcb5fbb96ad8de6a29177 IBM Akebono: Add the Akebono platform

:::::: TO: Alistair Popple <alistair@popple.id.au>
:::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
