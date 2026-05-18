Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F961C28E
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134556; cv=none; b=rFS6lg0tFUmHqWAoEsBCT0a3VWYBmllqrYozoghdE6tC9NKauJb0nVGZKgWskrakVAoRDpCMU7rk9TkFwep7u6HQWviiq5AEdfgMx266m84sfr3HDeiJ31GDdvrsChvxGjaw3lDK/ZLaYMZTdPzxAQ+q6aCdul37sqnqlnblHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134556; c=relaxed/simple;
	bh=CGPXWSK5hmlKnJSFcHOXBCFjxRTJpTKralBxlZebXn8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WZfjj2WIbQsSBiOwqw9hvYQaaErpPz0IUu5nxloHkiidF94EtB7veoiWUPtLQ+Z/0KyIHh9kzsDqMwtHFnw50dG6wwk8pcYrpeMVj/xu7FY4kZJgOHBYgtJGE/thhIp9+iRPjQTaFntqKK9ys/tWTP4HAAquyj+qTSpd3vXTZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4wEteGP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4wEteGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52569C2BCB7;
	Mon, 18 May 2026 20:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779134556;
	bh=CGPXWSK5hmlKnJSFcHOXBCFjxRTJpTKralBxlZebXn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=H4wEteGPlUyrciAsdHz8CZQWFJtcdT+Qw6trNLcBEtdvzZcWjLLfvfbrtChj1hWlt
	 GfRmFzE4I300JkdszLN5O7GR0tt30c1pRAkgjBm3bgIRDVnan7rkum3C7gfBiPqA22
	 U5hW8WvBXks3LhMT5gr/PgNSBy9hN6y1DBLzcGoPFWLWbsO8ZxeBSlB0kwuHhTPOuF
	 +axFzKhtFPaIcwfb43hLQscCKNLeG4rxuEJ+7Geoopt7mq3xP73vkhhk0j2JBXLYfY
	 8OfvU6Jz0UoAdjeCaoGvRBJODoZqfkRxVVKvofNG6bznLzPuoAvDcu5bJkEDhL47t1
	 LYI10RLHFjh4Q==
Date: Mon, 18 May 2026 15:02:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: linux-pci@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [pci:for-linus] BUILD SUCCESS WITH UNVERIFIED WARNING
 ed831e7ea1a860bdbab3eadeb95f7f73e9d212df
Message-ID: <20260518200231.GA640024@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202605161948.M6XaueWn-lkp@intel.com>

[+cc Florian, Jim, bcm-kernel-feedback-list]

On Sat, May 16, 2026 at 07:59:00PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
> branch HEAD: ed831e7ea1a860bdbab3eadeb95f7f73e9d212df  PCI: brcmstb: Assign pcie->gen from of_pci_get_max_link_speed()
> 
> Unverified Warning (likely false positive, kindly check if interested):
> 
>     drivers/pci/controller/pcie-brcmstb.c:2190 brcm_pcie_probe() warn: 'pcie->clk' from clk_prepare_enable() not released on lines: 2177.

Unrelated to ed831e7ea1a8 ("PCI: brcmstb: Assign pcie->gen from
of_pci_get_max_link_speed()"), and looks like a false positive to me.

  2098          ret = clk_prepare_enable(pcie->clk);

  2171          ret = pci_host_probe(bridge);
  2172          if (!ret && !brcm_pcie_link_up(pcie))
  2173                  ret = -ENODEV;
  2174
  2175          if (ret) {
  2176                  brcm_pcie_remove(pdev);
  2177                  return ret;
  2178          }

brcm_pcie_remove() calls __brcm_pcie_remove(), which calls
clk_disable_unprepare(pcie->clk), so I think this code is ok as-is.

> Warning ids grouped by kconfigs:
> 
> recent_errors
> `-- powerpc-randconfig-r072-20260516
>     `-- drivers-pci-controller-pcie-brcmstb.c-brcm_pcie_probe()-warn:pcie-clk-from-clk_prepare_enable()-not-released-on-lines:.
> 
> elapsed time: 1065m
> 
> configs tested: 164
> configs skipped: 13
> 
> tested configs:
> alpha                             allnoconfig    gcc-15.2.0
> alpha                            allyesconfig    gcc-15.2.0
> alpha                               defconfig    gcc-15.2.0
> arc                              allmodconfig    gcc-15.2.0
> arc                               allnoconfig    gcc-15.2.0
> arc                              allyesconfig    gcc-15.2.0
> arc                                 defconfig    gcc-15.2.0
> arc                            randconfig-001    gcc-8.5.0
> arc                   randconfig-001-20260516    gcc-14.3.0
> arc                            randconfig-002    gcc-8.5.0
> arc                   randconfig-002-20260516    gcc-13.4.0
> arm                               allnoconfig    clang-23
> arm                              allyesconfig    gcc-15.2.0
> arm                                 defconfig    clang-23
> arm                            randconfig-001    gcc-8.5.0
> arm                   randconfig-001-20260516    gcc-13.4.0
> arm                            randconfig-002    gcc-11.5.0
> arm                   randconfig-002-20260516    gcc-8.5.0
> arm                            randconfig-003    clang-20
> arm                   randconfig-003-20260516    clang-19
> arm                            randconfig-004    gcc-14.3.0
> arm                   randconfig-004-20260516    clang-23
> arm64                            allmodconfig    clang-19
> arm64                             allnoconfig    gcc-15.2.0
> arm64                               defconfig    gcc-15.2.0
> arm64                 randconfig-001-20260516    gcc-13.4.0
> arm64                 randconfig-002-20260516    clang-23
> arm64                 randconfig-003-20260516    gcc-9.5.0
> arm64                 randconfig-004-20260516    clang-23
> csky                             allmodconfig    gcc-15.2.0
> csky                              allnoconfig    gcc-15.2.0
> csky                                defconfig    gcc-15.2.0
> csky                  randconfig-001-20260516    gcc-15.2.0
> csky                  randconfig-002-20260516    gcc-10.5.0
> hexagon                          allmodconfig    clang-17
> hexagon                           allnoconfig    clang-23
> hexagon                             defconfig    clang-23
> hexagon               randconfig-001-20260516    clang-23
> hexagon               randconfig-002-20260516    clang-16
> i386                             allmodconfig    gcc-14
> i386                              allnoconfig    gcc-14
> i386                             allyesconfig    gcc-14
> i386        buildonly-randconfig-001-20260516    clang-20
> i386        buildonly-randconfig-002-20260516    clang-20
> i386        buildonly-randconfig-003-20260516    clang-20
> i386        buildonly-randconfig-004-20260516    gcc-14
> i386        buildonly-randconfig-005-20260516    clang-20
> i386        buildonly-randconfig-006-20260516    clang-20
> i386                                defconfig    clang-20
> i386                  randconfig-001-20260516    clang-20
> i386                  randconfig-002-20260516    clang-20
> i386                  randconfig-003-20260516    clang-20
> i386                  randconfig-004-20260516    clang-20
> i386                  randconfig-005-20260516    clang-20
> i386                  randconfig-006-20260516    clang-20
> i386                  randconfig-007-20260516    clang-20
> i386                  randconfig-011-20260516    gcc-14
> i386                  randconfig-012-20260516    clang-20
> i386                  randconfig-013-20260516    gcc-14
> i386                  randconfig-014-20260516    gcc-14
> i386                  randconfig-015-20260516    clang-20
> i386                  randconfig-016-20260516    gcc-14
> i386                  randconfig-017-20260516    gcc-14
> loongarch                        allmodconfig    clang-19
> loongarch                         allnoconfig    clang-23
> loongarch                           defconfig    clang-19
> loongarch             randconfig-001-20260516    gcc-15.2.0
> loongarch             randconfig-002-20260516    clang-18
> m68k                             allmodconfig    gcc-15.2.0
> m68k                              allnoconfig    gcc-15.2.0
> m68k                             allyesconfig    gcc-15.2.0
> m68k                                defconfig    gcc-15.2.0
> microblaze                        allnoconfig    gcc-15.2.0
> microblaze                       allyesconfig    gcc-15.2.0
> microblaze                          defconfig    gcc-15.2.0
> mips                             allmodconfig    gcc-15.2.0
> mips                              allnoconfig    gcc-15.2.0
> mips                             allyesconfig    gcc-15.2.0
> nios2                             allnoconfig    gcc-11.5.0
> nios2                               defconfig    gcc-11.5.0
> nios2                 randconfig-001-20260516    gcc-10.5.0
> nios2                 randconfig-002-20260516    gcc-11.5.0
> openrisc                         allmodconfig    gcc-15.2.0
> openrisc                          allnoconfig    gcc-15.2.0
> openrisc                            defconfig    gcc-15.2.0
> parisc                           allmodconfig    gcc-15.2.0
> parisc                            allnoconfig    gcc-15.2.0
> parisc                           allyesconfig    gcc-15.2.0
> parisc                              defconfig    gcc-15.2.0
> parisc                randconfig-001-20260516    gcc-10.5.0
> parisc                randconfig-002-20260516    gcc-11.5.0
> parisc64                            defconfig    gcc-15.2.0
> powerpc                           allnoconfig    gcc-15.2.0
> powerpc               randconfig-001-20260516    clang-23
> powerpc               randconfig-002-20260516    gcc-12.5.0
> powerpc64             randconfig-001-20260516    clang-17
> powerpc64             randconfig-002-20260516    clang-23
> riscv                            allmodconfig    clang-23
> riscv                             allnoconfig    gcc-15.2.0
> riscv                            allyesconfig    clang-16
> riscv                               defconfig    clang-23
> riscv                 randconfig-001-20260516    gcc-8.5.0
> riscv                 randconfig-002-20260516    clang-16
> s390                             allmodconfig    clang-18
> s390                              allnoconfig    clang-23
> s390                             allyesconfig    gcc-15.2.0
> s390                                defconfig    clang-23
> s390                  randconfig-001-20260516    clang-23
> s390                  randconfig-002-20260516    clang-23
> sh                               allmodconfig    gcc-15.2.0
> sh                                allnoconfig    gcc-15.2.0
> sh                               allyesconfig    gcc-15.2.0
> sh                                  defconfig    gcc-15.2.0
> sh                    randconfig-001-20260516    gcc-12.5.0
> sh                    randconfig-002-20260516    gcc-15.2.0
> sparc                             allnoconfig    gcc-15.2.0
> sparc                               defconfig    gcc-15.2.0
> sparc                 randconfig-001-20260516    gcc-8.5.0
> sparc                 randconfig-002-20260516    gcc-15.2.0
> sparc64                          allmodconfig    clang-23
> sparc64                             defconfig    clang-20
> sparc64               randconfig-001-20260516    gcc-10.5.0
> sparc64               randconfig-002-20260516    clang-20
> um                               allmodconfig    clang-19
> um                                allnoconfig    clang-23
> um                               allyesconfig    gcc-14
> um                                  defconfig    clang-23
> um                             i386_defconfig    gcc-14
> um                    randconfig-001-20260516    clang-16
> um                    randconfig-002-20260516    clang-18
> um                           x86_64_defconfig    clang-23
> x86_64                           allmodconfig    clang-20
> x86_64                            allnoconfig    clang-20
> x86_64                           allyesconfig    clang-20
> x86_64      buildonly-randconfig-001-20260516    clang-20
> x86_64      buildonly-randconfig-002-20260516    gcc-14
> x86_64      buildonly-randconfig-003-20260516    gcc-13
> x86_64      buildonly-randconfig-004-20260516    gcc-14
> x86_64      buildonly-randconfig-005-20260516    gcc-14
> x86_64      buildonly-randconfig-006-20260516    gcc-14
> x86_64                              defconfig    gcc-14
> x86_64                randconfig-001-20260516    clang-20
> x86_64                randconfig-002-20260516    clang-20
> x86_64                randconfig-003-20260516    gcc-14
> x86_64                randconfig-004-20260516    gcc-14
> x86_64                randconfig-005-20260516    gcc-14
> x86_64                randconfig-006-20260516    gcc-14
> x86_64                randconfig-011-20260516    gcc-14
> x86_64                randconfig-012-20260516    clang-20
> x86_64                randconfig-013-20260516    clang-20
> x86_64                randconfig-014-20260516    gcc-14
> x86_64                randconfig-015-20260516    clang-20
> x86_64                randconfig-016-20260516    gcc-14
> x86_64                randconfig-071-20260516    gcc-14
> x86_64                randconfig-072-20260516    gcc-14
> x86_64                randconfig-073-20260516    clang-20
> x86_64                randconfig-074-20260516    clang-20
> x86_64                randconfig-075-20260516    gcc-14
> x86_64                randconfig-076-20260516    clang-20
> x86_64                          rhel-9.4-rust    clang-20
> xtensa                            allnoconfig    gcc-15.2.0
> xtensa                randconfig-001-20260516    gcc-13.4.0
> xtensa                randconfig-002-20260516    gcc-8.5.0
> xtensa                         virt_defconfig    gcc-15.2.0
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
