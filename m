Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10937382F0C
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786679432; cv=none; b=mGTOOpTrRGzF+7OxajsdjWfsQ2g5gOce9WTv8yXcLMhi7yn+hLy7TXZx+pJDG/SUJKmOZ/Jw+eovX25splyK1N2SNEoVIKFkvFPLd9qGktqk9pjRnVRUCPlqEEISjlgYqlmPnxhnxVyknoBYO2JkaQlClC4dX96xYwyDSiZq/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786679432; c=relaxed/simple;
	bh=z11pJszxm0strCN43zW2BUKNP+2k4qr5SHdl+LLtpKQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P3dyRePsnvE0XT9vUVmYr6zMWCh3LZ9vZyuuYwVJXTEz6r69wgLkcxAcNU4abRjMMJra5GmTYKjEdpCBxevPvGSoK8wB8QoPJT1Hrf7G1x5f3iVvh21+rw5g6+UltI7LYFLLiMUDS/U44QOniP2a6DBADVIAxTxC4ATR5jX/g0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HETH7YfM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HETH7YfM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786679430; x=1818215430;
  h=date:from:to:cc:subject:message-id;
  bh=z11pJszxm0strCN43zW2BUKNP+2k4qr5SHdl+LLtpKQ=;
  b=HETH7YfMV7lw1XWiP6nfZZ0RClvrjZv0ZerMKbwCizdqK1s9jZ/CTu7a
   Ojm/7jmVy2+W3+5PwPKh/yxlcXa+BbTBGX5xOTbNmRcf8LXuCWf+ocmEo
   J6blETDduPH+S9/KOxI81FUazhi+0EyawmybTlmS0domzytJ7cqE7a96D
   Ea5AMlpvQ4FbRCDIZRI0deuwVPBNSS/w48oQ4R4KS7RYVHZAsHQGKWCBl
   wB6reELqg7IXaHVvNosiI3LEOtthh+LQrkhI5m+Dbah+nS70gW8RMGCiq
   MwaODtOho+CkQPO6JwQYbKkpAg5tiJPr9OxC/pN/WbLJpK7vaiOiK9zHo
   A==;
X-CSE-ConnectionGUID: i2XADqDKTfOjlRicDHjHcQ==
X-CSE-MsgGUID: CBOs1tzLRxKYU/Buf5DBYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87121950"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87121950"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 20:50:30 -0700
X-CSE-ConnectionGUID: ZCDwl7TNSJGGgK8AZgcebg==
X-CSE-MsgGUID: U6fAqStZQdOlAISHmr/kqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="264155702"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Aug 2026 20:50:23 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuivz-00000000Xfg-3E3d;
	Fri, 14 Aug 2026 03:50:19 +0000
Date: Fri, 14 Aug 2026 11:49:57 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-binding] BUILD SUCCESS
 f7b2ceb411479b4c95aee1c0dd720af53367ff8b
Message-ID: <202608141145.boYqSfl2-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-binding
branch HEAD: f7b2ceb411479b4c95aee1c0dd720af53367ff8b  dt-bindings: PCI: Correct white-space style

elapsed time: 2427m

configs tested: 114
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-13.4.0
arc                  randconfig-001-20260813    gcc-13.4.0
arc                  randconfig-002-20260813    gcc-13.4.0
arm                       keystone_defconfig    gcc-16.1.0
arm                  randconfig-001-20260813    gcc-13.4.0
arm                  randconfig-002-20260813    gcc-13.4.0
arm                  randconfig-003-20260813    gcc-13.4.0
arm                  randconfig-004-20260813    gcc-13.4.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260813    gcc-14.3.0
arm64                randconfig-001-20260813    gcc-16.1.0
arm64                randconfig-002-20260813    gcc-14.3.0
arm64                randconfig-002-20260813    gcc-16.1.0
arm64                randconfig-003-20260813    gcc-14.3.0
arm64                randconfig-003-20260813    gcc-16.1.0
arm64                randconfig-004-20260813    gcc-14.3.0
arm64                randconfig-004-20260813    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260813    gcc-14.3.0
csky                 randconfig-001-20260813    gcc-16.1.0
csky                 randconfig-002-20260813    gcc-14.3.0
csky                 randconfig-002-20260813    gcc-16.1.0
hexagon              randconfig-001-20260813    gcc-11.5.0
hexagon              randconfig-002-20260813    gcc-11.5.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260813    gcc-14
i386       buildonly-randconfig-002-20260813    gcc-14
i386       buildonly-randconfig-003-20260813    gcc-14
i386       buildonly-randconfig-004-20260813    gcc-14
i386       buildonly-randconfig-005-20260813    gcc-14
i386       buildonly-randconfig-006-20260813    gcc-14
i386                 randconfig-001-20260813    clang-22
i386                 randconfig-002-20260813    clang-22
i386                 randconfig-003-20260813    clang-22
i386                 randconfig-004-20260813    clang-22
i386                 randconfig-005-20260813    clang-22
i386                 randconfig-006-20260813    clang-22
i386                 randconfig-007-20260813    clang-22
i386                 randconfig-011-20260813    clang-22
i386                 randconfig-012-20260813    clang-22
i386                 randconfig-013-20260813    clang-22
i386                 randconfig-014-20260813    clang-22
i386                 randconfig-015-20260813    clang-22
i386                 randconfig-016-20260813    clang-22
i386                 randconfig-017-20260813    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260813    gcc-11.5.0
loongarch            randconfig-002-20260813    gcc-11.5.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260813    gcc-11.5.0
nios2                randconfig-002-20260813    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-10.5.0
parisc               randconfig-001-20260813    gcc-10.5.0
parisc               randconfig-002-20260813    gcc-10.5.0
powerpc                   adder875_defconfig    gcc-16.1.0
powerpc                   amigaone_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260813    gcc-10.5.0
powerpc              randconfig-002-20260813    gcc-10.5.0
powerpc                    taishan_defconfig    clang-21
powerpc64            randconfig-001-20260813    gcc-10.5.0
powerpc64            randconfig-002-20260813    gcc-10.5.0
riscv                         randconfig-001    gcc-10.5.0
riscv                randconfig-001-20260813    gcc-10.5.0
riscv                randconfig-002-20260813    gcc-10.5.0
s390                 randconfig-001-20260813    gcc-10.5.0
s390                 randconfig-002-20260813    gcc-10.5.0
sh                                 defconfig    gcc-16.1.0
sh                       edosk7705_defconfig    gcc-16.1.0
sh                   randconfig-001-20260813    gcc-10.5.0
sh                   randconfig-002-20260813    gcc-10.5.0
sparc                         randconfig-001    clang-20
sparc                randconfig-001-20260813    clang-20
sparc                randconfig-002-20260813    clang-20
sparc64              randconfig-001-20260813    clang-20
sparc64              randconfig-002-20260813    clang-20
um                   randconfig-001-20260813    clang-20
um                   randconfig-002-20260813    clang-20
x86_64     buildonly-randconfig-001-20260813    gcc-14
x86_64     buildonly-randconfig-002-20260813    gcc-14
x86_64     buildonly-randconfig-003-20260813    gcc-14
x86_64     buildonly-randconfig-004-20260813    gcc-14
x86_64     buildonly-randconfig-005-20260813    gcc-14
x86_64     buildonly-randconfig-006-20260813    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260813    gcc-13
x86_64               randconfig-002-20260813    gcc-13
x86_64               randconfig-003-20260813    gcc-13
x86_64               randconfig-004-20260813    gcc-13
x86_64               randconfig-005-20260813    gcc-13
x86_64               randconfig-006-20260813    gcc-13
x86_64               randconfig-011-20260813    gcc-14
x86_64               randconfig-012-20260813    gcc-14
x86_64               randconfig-013-20260813    gcc-14
x86_64               randconfig-014-20260813    gcc-14
x86_64               randconfig-015-20260813    gcc-14
x86_64               randconfig-016-20260813    gcc-14
x86_64               randconfig-071-20260813    gcc-14
x86_64               randconfig-072-20260813    gcc-14
x86_64               randconfig-073-20260813    gcc-14
x86_64               randconfig-074-20260813    gcc-14
x86_64               randconfig-075-20260813    gcc-14
x86_64               randconfig-076-20260813    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260813    clang-20
xtensa               randconfig-002-20260813    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
