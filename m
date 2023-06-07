Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D063C7EE29
	for <linux-pci@archiver.kernel.org>; Wed,  7 Jun 2023 11:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbjFGL0C (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Jun 2023 07:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbjFGL0B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 07:26:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2445710DE
        for <linux-pci@vger.kernel.org>; Wed,  7 Jun 2023 04:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686137160; x=1717673160;
  h=date:from:to:cc:subject:message-id;
  bh=as/wWsjFnAoIqcac6SfVDmN46Pu/Wa/JVqiB6uuXpxg=;
  b=CaCR+TPP79OxFkCZbg/I+0L2mMeCzDvlpswwD3YHfJC6umfdut6e1/+1
   d2gUxrLmB6GublLtDtPDImewuUCETyseBd1dz08GCbxcaDqvALxvkvEfL
   X3ZDxu/Cf0SdL+DbHTVL6G+UbWjJcjJEYeuWct35La9Rlkn5VarFxL7aJ
   l7HE2zKMW5gf2SsZ7MrEG0ZCHG56PrVCNzhq+6y2xkGle5kEqElbw16dZ
   0b8rg7aSGX1yzNyfZlccwxGXF/bqHqXdkYXi2LWTVrS82HEbMEeL5UZPr
   uygK+L/l0++y/+AmXlPgXpDNT+Vn8mAABK/JzwYY+MgLnBXwwJKnQ/JVu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="355813780"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="355813780"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 04:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="686928052"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="686928052"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jun 2023 04:25:58 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6rIc-0006VL-0R;
        Wed, 07 Jun 2023 11:25:58 +0000
Date:   Wed, 07 Jun 2023 19:25:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 f9dae2af6f947a299b4f32f70a936609b7914076
Message-ID: <20230607112519.SV2us%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: f9dae2af6f947a299b4f32f70a936609b7914076  Merge branch 'pci/controller/endpoint'

elapsed time: 724m

configs tested: 40
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
