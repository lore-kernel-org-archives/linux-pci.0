Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A110FC636D3
	for <linux-pci@archiver.kernel.org>; Wed,  8 Feb 2023 07:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjBHHfD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 8 Feb 2023 02:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjBHHe6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 02:34:58 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C20E31E15
        for <linux-pci@vger.kernel.org>; Tue,  7 Feb 2023 23:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675841698; x=1707377698;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xtD/SQUvIlQ2QOQDq757fy5h2e0GHjdTZ2W6wMMQte0=;
  b=R4Xv/ceTCJciGpKBt56LkUaVxGF9EFEe6bui3nzAGd/6dEDXMzj2DKfu
   GDK6vY+PZE0qkNXJ80L9LP462yqAyJ6o0JkVCrYn4ivwrE0NceDzDSFXY
   ENtEZVrmo1ZyjiIr3RXumX1urE6jRT7bIUrWF/s60+gPKrvKzg6/d5n+k
   B7WzIS/1MzU/aNpXUdEsGy48JInBLFR7JWbWZ+b1SDIcpmr15uLrBj7Pz
   yAXlIS8e++m5qXwdjcXTDNaAT4I2btKCaO2LP3Kd2hQXxxobaJVfdXWte
   j4kqY15E0EpOHPztAf4KouhcdMRcbkgq5uhv4b8kVslTOdLGWNCYzViCB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415954666"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="415954666"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 23:34:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="667150954"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="667150954"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Feb 2023 23:34:55 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPeyl-0004HS-0q;
        Wed, 08 Feb 2023 07:34:55 +0000
Date:   Wed, 08 Feb 2023 15:33:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/resource] BUILD SUCCESS
 7180c1d08639f28e63110ad35815f7a1785b8a19
Message-ID: <63e35065.+mrvjmQlNN7H9Nsw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
branch HEAD: 7180c1d08639f28e63110ad35815f7a1785b8a19  PCI: Distribute available resources for root buses, too

elapsed time: 775m

configs tested: 72
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-bpf
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
mips                             allyesconfig
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
arm                                 defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
arm64                            allyesconfig
x86_64                    rhel-8.3-kselftests
arm                              allyesconfig
i386                 randconfig-a011-20230206
i386                 randconfig-a014-20230206
i386                 randconfig-a012-20230206
x86_64                               rhel-8.3
i386                 randconfig-a013-20230206
s390                 randconfig-r044-20230206
arc                  randconfig-r043-20230205
arm                  randconfig-r046-20230205
arc                  randconfig-r043-20230206
i386                 randconfig-a016-20230206
i386                 randconfig-a015-20230206
i386                             allyesconfig
riscv                randconfig-r042-20230206
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
x86_64               randconfig-a012-20230206
x86_64               randconfig-a014-20230206
x86_64                           allyesconfig
x86_64               randconfig-a015-20230206
x86_64               randconfig-a016-20230206

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230205
riscv                randconfig-r042-20230205
hexagon              randconfig-r045-20230206
hexagon              randconfig-r041-20230206
arm                  randconfig-r046-20230206
s390                 randconfig-r044-20230205
hexagon              randconfig-r045-20230205
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a001-20230206
x86_64               randconfig-a005-20230206
i386                 randconfig-a005-20230206
i386                 randconfig-a004-20230206
x86_64               randconfig-a006-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a002-20230206
i386                 randconfig-a003-20230206
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a006-20230206
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
