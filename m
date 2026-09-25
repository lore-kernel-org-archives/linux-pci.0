Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509D4D0A03
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352846; cv=none; b=qxREidIcREeEhpLfpNp/XsoesxbFpn7rEvdK1IT9zkBW5KRzGD0qD3TpaREdNwjQTYDn7oae4RiTPzSLRA3d6tfLtHdD/R6KSN1OORBKUCOQZ0usux0Zu6mG+1m5YSQ28pTeC7Wd2oFjWowORRrlHaftiPHYcqHERxyqCwN6QKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352846; c=relaxed/simple;
	bh=tswYQPfuihTwEd6HKk6wVZXyWOSbxxQJIcPTmqIe/88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXl7vEhp8sA/3E00VFj3rXXVWS6BduupYQlEl5dd4lmeWOXdYfagW/qYA1y9hDiUlNoZInkWD7oZWkle9Q0ZTbFCl2I5/3AyYR0XLx4VjSYwTVA/MdwkEIzNwWPHqHZjHJXisOcO+0h3B/jNtNFsrZMEugJm0erJICk/ja+yK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2RlPHOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2RlPHOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAAB1F000FF;
	Fri, 25 Sep 2026 16:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790352844;
	bh=lC1tOqbAe1z67qReNrFMBShG5+DsN9uUaHcnF8pYEEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C2RlPHOcy4cqDvbTf1pv9aAh8UA9P4aA8jWH/UOx51bS0ZReoRZJRsBfntWxYo4aP
	 jSeMzEtrXjWbhxV3ImpnPptk7ZSbQY0YCSiekxVMmLXwrBtn7XLiYpn1rG/yBSKXDK
	 sxHxpsotoq2q//0sX6QWM+Ys7yqm9jR8AIzD2g6U3hlLCadqmo6XQaDGUsU2ch6arl
	 1eGM/CkLRf7S44aeFDpwmHfC82C1KdMOQtBWTSogu/1OH8G9umac2RLabJNOGf6fH8
	 efKODyykgYeyJUOH5AFHs0Epj4tBH+FoBjPhDbcYRCxhioNm9BW7w+oGZ5ASGG3Ic9
	 p6xjUD0YJd2VA==
Date: Fri, 25 Sep 2026 11:14:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [pci:controller:dwc-rcar-gen4] BUILD SUCCESS WITH UNVERIFIED
 WARNING 7fc9907223d6fa1bea13f896af7d0c77b36724e0
Message-ID: <20260925161402.GA2056819@bhelgaas>
References: <202609250740.xsN0zhYb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202609250740.xsN0zhYb-lkp@intel.com>

[+to Marek, +cc Rob, Krzysztof, Conor]

On Fri, Sep 25, 2026 at 07:18:43AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
> branch HEAD: 7fc9907223d6fa1bea13f896af7d0c77b36724e0  PCI: rcar-gen4: Add Application/Local register reset control
> 
> Unverified Warning (likely false positive, kindly check if interested):
> 
>     https://lore.kernel.org/oe-kbuild/202609230547.zdjJoKk2-lkp@intel.com
>     https://lore.kernel.org/oe-kbuild/202609230819.0wgao12k-lkp@intel.com
> 
>     Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml: properties:reset-names: {'minItems': 1, 'maxItems': 2, 'items': [{'const': 'pwr'}, {'const': 'core'}]} should not be valid under {'required': ['maxItems']}
>     Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml: properties:reset-names: {'minItems': 1, 'maxItems': 2, 'items': [{'const': 'pwr'}, {'const': 'core'}]} should not be valid under {'required': ['maxItems']}

Can you take a look at this?  I'm not much of a DT reader, but I think the
warning is saying that maxItems: is unnecessary when the items: list
already tells us the maxItems?

  reset-names:
    minItems: 1
    maxItems: 2
    items:
      - const: pwr
      - const: core

I don't see any other PCI .yaml that uses maxItems: and items: in quite the
same way, but maybe we want them to match the 'reset:' property?

These are from:

  https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=173cc7417848 ("dt-bindings: PCI: rcar-gen4-pci-ep: Document Application/Local register reset")
  https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=50b1333e0c7b ("dt-bindings: PCI: rcar-gen4-pci-host: Document Application/Local register reset")

> Warning ids grouped by kconfigs:
> 
> recent_errors
> |-- arc-randconfig-2400-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- arc-randconfig-2401-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- arm-randconfig-2400-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- arm-randconfig-2401-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- arm-randconfig-2402-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- arm-randconfig-2403-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- arm-randconfig-2404-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- arm64-randconfig-2400-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- arm64-randconfig-2401-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- arm64-randconfig-2402-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- arm64-randconfig-2403-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- arm64-randconfig-2404-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- csky-randconfig-2400-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- csky-randconfig-2401-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- loongarch-randconfig-2400-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- loongarch-randconfig-2401-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- microblaze-randconfig-2400-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- microblaze-randconfig-2401-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- mips-randconfig-2400-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- mips-randconfig-2401-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- nios2-randconfig-2400-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- nios2-randconfig-2401-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- openrisc-randconfig-2400-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- openrisc-randconfig-2401-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- powerpc-randconfig-2400-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- powerpc-randconfig-2401-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- riscv-randconfig-2400-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- riscv-randconfig-2401-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- sh-randconfig-2400-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- sh-randconfig-2401-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |-- xtensa-randconfig-2400-20260923
> |   |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> |   `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> `-- xtensa-randconfig-2401-20260923
>     |-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-ep.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
>     `-- Documentation-devicetree-bindings-pci-rcar-gen4-pci-host.yaml:properties:reset-names:minItems:maxItems:items:const:pwr-const:core-should-not-be-valid-under-required:maxItems
> 
> elapsed time: 3223m
> 
> configs tested: 316
> configs skipped: 8
> 
> tested configs:
> alpha                              allnoconfig    gcc-16.1.0
> alpha                             allyesconfig    gcc-16.1.0
> alpha                                defconfig    gcc-16.1.0
> alpha                randconfig-r1303-20260925    gcc-14.3.0 sparse
> alpha                randconfig-r1304-20260924    gcc-16.1.0 sparse
> alpha                randconfig-r2102-20260923    gcc-8.5.0  cocci
> alpha                randconfig-r2107-20260923    gcc-10.5.0 cocci
> arc                               allmodconfig    clang-24
> arc                                allnoconfig    gcc-16.1.0
> arc                               allyesconfig    clang-24
> arc                                  defconfig    gcc-16.1.0
> arc                      haps_hs_smp_defconfig    gcc-16.1.0
> arc                   randconfig-1000-20260924    clang-24
> arc                   randconfig-1000-20260925    clang-24
> arc                   randconfig-1001-20260924    clang-24
> arc                   randconfig-1001-20260925    clang-24
> arc                  randconfig-r2101-20260923    gcc-8.5.0  cocci
> arc                  randconfig-r2201-20260923    gcc-8.5.0  smatch
> arc                  randconfig-r2202-20260923    gcc-14.3.0 smatch
> arm                                allnoconfig    gcc-16.1.0
> arm                               allyesconfig    clang-24
> arm                          assabet_defconfig    clang-24
> arm                                  defconfig    gcc-16.1.0
> arm                          nhk8815_defconfig    clang-24
> arm                   randconfig-1000-20260924    clang-24
> arm                   randconfig-1000-20260925    clang-24
> arm                   randconfig-1001-20260924    clang-24
> arm                   randconfig-1001-20260925    clang-24
> arm                   randconfig-1002-20260924    clang-24
> arm                   randconfig-1002-20260925    clang-24
> arm                   randconfig-1003-20260924    clang-24
> arm                   randconfig-1003-20260925    clang-24
> arm                  randconfig-r1305-20260924    gcc-16.1.0 sparse
> arm                  randconfig-r2100-20260923    gcc-8.5.0  cocci
> arm                  randconfig-r2201-20260923    gcc-16.1.0 smatch
> arm                         spear6xx_defconfig    clang-24
> arm                            stm32_defconfig    clang-24
> arm64                             allmodconfig    clang-24
> arm64                              allnoconfig    gcc-16.1.0
> arm64                                defconfig    gcc-16.1.0
> arm64                                defconfig    gcc-16.1.0
> arm64                 randconfig-1000-20260924    gcc-11.5.0
> arm64                 randconfig-1001-20260924    gcc-11.5.0
> arm64                 randconfig-1002-20260924    gcc-11.5.0
> arm64                 randconfig-1003-20260924    gcc-11.5.0
> arm64                randconfig-r1302-20260924    gcc-16.1.0 sparse
> arm64                randconfig-r1307-20260924    gcc-11.5.0 sparse
> arm64                randconfig-r2106-20260923    gcc-15.2.0 cocci
> arm64                randconfig-r2200-20260923    clang-24   smatch
> arm64                randconfig-r2201-20260923    clang-24   smatch
> csky                              allmodconfig    gcc-16.1.0
> csky                               allnoconfig    gcc-16.1.0
> csky                                 defconfig    gcc-16.1.0
> csky                  randconfig-1000-20260924    gcc-11.5.0
> csky                  randconfig-1001-20260924    gcc-11.5.0
> csky                 randconfig-r1300-20260924    gcc-16.1.0 sparse
> csky                 randconfig-r2103-20260923    gcc-8.5.0  cocci
> csky                 randconfig-r2107-20260923    gcc-15.2.0 cocci
> hexagon                           allmodconfig    gcc-16.1.0
> hexagon                            allnoconfig    gcc-16.1.0
> hexagon                              defconfig    gcc-16.1.0
> hexagon               randconfig-1000-20260924    gcc-8.5.0
> hexagon               randconfig-1000-20260925    gcc-9.5.0
> hexagon               randconfig-1001-20260924    gcc-8.5.0
> hexagon               randconfig-1001-20260925    gcc-9.5.0
> hexagon              randconfig-r1301-20260924    gcc-16.1.0 sparse
> i386                              allmodconfig    clang-22
> i386                               allnoconfig    gcc-16.1.0
> i386                              allyesconfig    clang-22
> i386        buildonly-randconfig-1000-20260924    gcc-14
> i386        buildonly-randconfig-1001-20260924    gcc-14
> i386        buildonly-randconfig-1002-20260924    gcc-14
> i386        buildonly-randconfig-1003-20260924    gcc-14
> i386        buildonly-randconfig-1004-20260924    gcc-14
> i386        buildonly-randconfig-1005-20260924    gcc-14
> i386                                 defconfig    gcc-16.1.0
> i386                  randconfig-1000-20260924    gcc-12
> i386                  randconfig-1001-20260924    gcc-12
> i386                  randconfig-1002-20260924    gcc-12
> i386                  randconfig-1003-20260924    gcc-12
> i386                  randconfig-1004-20260924    gcc-12
> i386                  randconfig-1005-20260924    gcc-12
> i386                  randconfig-1006-20260924    gcc-12
> i386                  randconfig-1007-20260924    clang-22
> i386                  randconfig-1008-20260924    clang-22
> i386                  randconfig-1009-20260924    clang-22
> i386                  randconfig-1010-20260924    clang-22
> i386                  randconfig-1011-20260924    clang-22
> i386                  randconfig-1012-20260924    clang-22
> i386                  randconfig-1013-20260924    clang-22
> i386                  randconfig-1300-20260924    clang-22   sparse
> i386                  randconfig-1301-20260924    clang-22   sparse
> i386                  randconfig-1302-20260924    clang-22   sparse
> i386                  randconfig-2100-20260923    clang-22   cocci
> i386                  randconfig-2100-20260923    gcc-14     cocci
> i386                  randconfig-2101-20260923    clang-22   cocci
> i386                  randconfig-2102-20260923    clang-22   cocci
> i386                  randconfig-2103-20260923    clang-22   cocci
> i386                  randconfig-2103-20260923    gcc-14     cocci
> i386                  randconfig-2200-20260923    gcc-12     smatch
> i386                 randconfig-r2100-20260923    gcc-8.5.0  cocci
> loongarch                         allmodconfig    clang-24
> loongarch                          allnoconfig    gcc-16.1.0
> loongarch                            defconfig    clang-24
> loongarch             randconfig-1000-20260924    gcc-8.5.0
> loongarch             randconfig-1000-20260925    gcc-9.5.0
> loongarch             randconfig-1001-20260924    gcc-8.5.0
> loongarch             randconfig-1001-20260925    gcc-9.5.0
> loongarch            randconfig-r2104-20260923    gcc-10.5.0 cocci
> loongarch            randconfig-r2105-20260923    gcc-14     cocci
> m68k                              allmodconfig    gcc-16.1.0
> m68k                               allnoconfig    gcc-16.1.0
> m68k                              allyesconfig    clang-24
> m68k                           amiga_defconfig    gcc-16.1.0
> m68k                                 defconfig    clang-24
> m68k                        m5249evb_defconfig    gcc-16.1.0
> m68k                         m5307c3_defconfig    gcc-16.1.0
> m68k                 randconfig-r2103-20260923    gcc-8.5.0  cocci
> m68k                 randconfig-r2105-20260923    gcc-10.5.0 cocci
> microblaze                         allnoconfig    gcc-16.1.0
> microblaze                        allyesconfig    gcc-16.1.0
> microblaze                           defconfig    clang-24
> microblaze           randconfig-r1304-20260925    gcc-14.3.0 sparse
> microblaze           randconfig-r2200-20260923    gcc-9.5.0  smatch
> mips                              allmodconfig    gcc-16.1.0
> mips                               allnoconfig    gcc-16.1.0
> mips                              allyesconfig    gcc-16.1.0
> mips                        bmips_be_defconfig    gcc-16.1.0
> mips                 randconfig-r1309-20260924    gcc-11.5.0 sparse
> mips                 randconfig-r2101-20260923    gcc-8.5.0  cocci
> mips                 randconfig-r2104-20260923    gcc-15.2.0 cocci
> mips                 randconfig-r2202-20260923    gcc-8.5.0  smatch
> mips                            xway_defconfig    clang-24
> nios2                             allmodconfig    gcc-11.5.0
> nios2                              allnoconfig    clang-24
> nios2                                defconfig    clang-24
> nios2                 randconfig-1000-20260924    gcc-8.5.0
> nios2                 randconfig-1000-20260925    gcc-9.5.0
> nios2                 randconfig-1001-20260924    gcc-8.5.0
> nios2                 randconfig-1001-20260925    gcc-9.5.0
> nios2                randconfig-r1303-20260924    gcc-16.1.0 sparse
> nios2                randconfig-r1306-20260924    gcc-11.5.0 sparse
> nios2                randconfig-r2100-20260923    gcc-15.2.0 cocci
> openrisc                          allmodconfig    gcc-11.5.0
> openrisc                           allnoconfig    clang-24
> openrisc                             defconfig    gcc-16.1.0
> openrisc                   or1klitex_defconfig    clang-24
> openrisc             randconfig-r2106-20260923    gcc-16.1.0 cocci
> parisc                            allmodconfig    gcc-16.1.0
> parisc                             allnoconfig    clang-24
> parisc                            allyesconfig    clang-17
> parisc                               defconfig    gcc-16.1.0
> parisc                randconfig-1000-20260924    gcc-8.5.0
> parisc                randconfig-1001-20260924    gcc-8.5.0
> parisc               randconfig-r1301-20260925    gcc-14.3.0 sparse
> parisc               randconfig-r2103-20260923    gcc-14     cocci
> parisc               randconfig-r2103-20260923    gcc-8.5.0  cocci
> parisc               randconfig-r2104-20260923    gcc-14     cocci
> parisc               randconfig-r2106-20260923    gcc-10.5.0 cocci
> parisc               randconfig-r2202-20260923    gcc-12.5.0 smatch
> parisc64                             defconfig    clang-24
> powerpc                            allnoconfig    clang-24
> powerpc                       mgcoge_defconfig    gcc-16.1.0
> powerpc               randconfig-1000-20260924    gcc-8.5.0
> powerpc               randconfig-1001-20260924    gcc-8.5.0
> powerpc              randconfig-r2100-20260923    gcc-8.5.0  cocci
> powerpc              randconfig-r2102-20260923    gcc-15.2.0 cocci
> powerpc              randconfig-r2102-20260923    gcc-8.5.0  cocci
> powerpc64             randconfig-1000-20260924    gcc-8.5.0
> powerpc64             randconfig-1001-20260924    gcc-8.5.0
> powerpc64            randconfig-r1300-20260925    gcc-14.3.0 sparse
> powerpc64            randconfig-r2105-20260923    gcc-15.2.0 cocci
> riscv                             allmodconfig    clang-24
> riscv                              allnoconfig    clang-24
> riscv                             allyesconfig    clang-24
> riscv                                defconfig    gcc-16.1.0
> riscv                 randconfig-1000-20260924    gcc-15.2.0
> riscv                 randconfig-1000-20260925    clang-24
> riscv                 randconfig-1001-20260924    gcc-15.2.0
> riscv                 randconfig-1001-20260925    clang-24
> riscv                 randconfig-2000-20260923    gcc-9.5.0
> riscv                 randconfig-2001-20260923    gcc-9.5.0
> riscv                randconfig-r2107-20260923    gcc-16.1.0 cocci
> s390                              allmodconfig    clang-17
> s390                               allnoconfig    clang-24
> s390                              allyesconfig    gcc-16.1.0
> s390                                 defconfig    gcc-16.1.0
> s390                  randconfig-1000-20260924    gcc-15.2.0
> s390                  randconfig-1000-20260925    clang-24
> s390                  randconfig-1001-20260924    gcc-15.2.0
> s390                  randconfig-1001-20260925    clang-24
> s390                  randconfig-2000-20260923    gcc-9.5.0
> s390                  randconfig-2001-20260923    gcc-9.5.0
> s390                 randconfig-r1308-20260924    gcc-11.5.0 sparse
> s390                 randconfig-r2200-20260923    gcc-8.5.0  smatch
> sh                                allmodconfig    gcc-16.1.0
> sh                                 allnoconfig    clang-24
> sh                                allyesconfig    clang-17
> sh                                   defconfig    gcc-14
> sh                    randconfig-1000-20260924    gcc-15.2.0
> sh                    randconfig-1000-20260925    clang-24
> sh                    randconfig-1001-20260924    gcc-15.2.0
> sh                    randconfig-1001-20260925    clang-24
> sh                    randconfig-2000-20260923    gcc-9.5.0
> sh                    randconfig-2001-20260923    gcc-9.5.0
> sh                   randconfig-r1305-20260925    gcc-14.3.0 sparse
> sh                   randconfig-r2103-20260923    gcc-15.2.0 cocci
> sh                   randconfig-r2104-20260923    gcc-16.1.0 cocci
> sh                            se7780_defconfig    clang-24
> sparc                              allnoconfig    clang-24
> sparc                                defconfig    gcc-16.1.0
> sparc                 randconfig-1000-20260924    clang-17
> sparc                 randconfig-1000-20260925    gcc-12
> sparc                 randconfig-1001-20260924    clang-17
> sparc                 randconfig-1001-20260925    gcc-12
> sparc                 randconfig-2000-20260923    gcc-14.3.0
> sparc                 randconfig-2001-20260923    gcc-14.3.0
> sparc                randconfig-r2105-20260923    gcc-16.1.0 cocci
> sparc                randconfig-r2200-20260923    gcc-8.5.0  smatch
> sparc                randconfig-r2201-20260923    gcc-11.5.0 smatch
> sparc64                              defconfig    gcc-14
> sparc64               randconfig-1000-20260924    clang-17
> sparc64               randconfig-1000-20260925    gcc-12
> sparc64               randconfig-1001-20260924    clang-17
> sparc64               randconfig-1001-20260925    gcc-12
> sparc64               randconfig-2000-20260923    gcc-14.3.0
> sparc64               randconfig-2001-20260923    gcc-14.3.0
> sparc64              randconfig-r2101-20260923    gcc-15.2.0 cocci
> sparc64              randconfig-r2102-20260923    gcc-8.5.0  cocci
> um                                allmodconfig    clang-17
> um                                 allnoconfig    clang-24
> um                                allyesconfig    gcc-16.1.0
> um                                   defconfig    gcc-14
> um                              i386_defconfig    gcc-14
> um                    randconfig-1000-20260924    clang-17
> um                    randconfig-1000-20260925    gcc-12
> um                    randconfig-1001-20260924    clang-17
> um                    randconfig-1001-20260925    gcc-12
> um                    randconfig-2000-20260923    gcc-14.3.0
> um                    randconfig-2001-20260923    gcc-14.3.0
> um                   randconfig-r1302-20260925    gcc-14.3.0 sparse
> um                            x86_64_defconfig    gcc-14
> x86_64                             allnoconfig    clang-24
> x86_64      buildonly-randconfig-1000-20260924    clang-22
> x86_64      buildonly-randconfig-1000-20260925    clang-22
> x86_64      buildonly-randconfig-1001-20260924    clang-22
> x86_64      buildonly-randconfig-1001-20260925    clang-22
> x86_64      buildonly-randconfig-1002-20260924    clang-22
> x86_64      buildonly-randconfig-1002-20260925    clang-22
> x86_64      buildonly-randconfig-1003-20260924    clang-22
> x86_64      buildonly-randconfig-1003-20260925    clang-22
> x86_64      buildonly-randconfig-1004-20260924    clang-22
> x86_64      buildonly-randconfig-1004-20260925    clang-22
> x86_64      buildonly-randconfig-1005-20260924    clang-22
> x86_64      buildonly-randconfig-1005-20260925    clang-22
> x86_64                               defconfig    gcc-14
> x86_64                                   kexec    clang-22
> x86_64                randconfig-1000-20260924    clang-22
> x86_64                randconfig-1000-20260925    gcc-14
> x86_64                randconfig-1001-20260924    clang-22
> x86_64                randconfig-1001-20260925    gcc-14
> x86_64                randconfig-1002-20260924    clang-22
> x86_64                randconfig-1002-20260925    gcc-14
> x86_64                randconfig-1003-20260924    clang-22
> x86_64                randconfig-1003-20260925    gcc-14
> x86_64                randconfig-1004-20260924    clang-22
> x86_64                randconfig-1004-20260925    gcc-14
> x86_64                randconfig-1005-20260924    clang-22
> x86_64                randconfig-1005-20260925    gcc-14
> x86_64                randconfig-1006-20260924    clang-22
> x86_64                randconfig-1007-20260924    clang-22
> x86_64                randconfig-1008-20260924    clang-22
> x86_64                randconfig-1009-20260924    clang-22
> x86_64                randconfig-1010-20260924    clang-22
> x86_64                randconfig-1011-20260924    clang-22
> x86_64                randconfig-1012-20260924    clang-22
> x86_64                randconfig-1013-20260924    clang-22
> x86_64                randconfig-1014-20260924    clang-22
> x86_64                randconfig-1015-20260924    clang-22
> x86_64                randconfig-1016-20260924    clang-22
> x86_64                randconfig-1017-20260924    clang-22
> x86_64                randconfig-1300-20260924    clang-22   sparse
> x86_64                randconfig-1301-20260924    clang-22   sparse
> x86_64                randconfig-1302-20260924    clang-22   sparse
> x86_64                randconfig-2100-20260923    clang-22   cocci
> x86_64                randconfig-2101-20260923    clang-22   cocci
> x86_64                randconfig-2102-20260923    clang-22   cocci
> x86_64                randconfig-2103-20260923    clang-22   cocci
> x86_64                randconfig-2200-20260923    gcc-14     smatch
> x86_64               randconfig-r2100-20260923    gcc-14     cocci
> x86_64               randconfig-r2101-20260923    gcc-14     cocci
> x86_64               randconfig-r2101-20260923    gcc-8.5.0  cocci
> x86_64               randconfig-r2102-20260923    gcc-14     cocci
> x86_64               randconfig-r2106-20260923    gcc-14     cocci
> x86_64               randconfig-r2107-20260923    gcc-14     cocci
> x86_64               randconfig-r2201-20260923    clang-22   smatch
> x86_64                                rhel-9.4    clang-22
> x86_64                            rhel-9.4-bpf    clang-22
> x86_64                            rhel-9.4-bpf    gcc-14
> x86_64                           rhel-9.4-func    clang-22
> x86_64                     rhel-9.4-kselftests    clang-22
> x86_64                          rhel-9.4-kunit    clang-22
> x86_64                          rhel-9.4-kunit    gcc-14
> x86_64                            rhel-9.4-ltp    clang-22
> x86_64                            rhel-9.4-ltp    gcc-14
> x86_64                           rhel-9.4-rust    clang-22
> x86_64                           rhel-9.4-rust    clang-22
> xtensa                            alldefconfig    gcc-16.1.0
> xtensa                             allnoconfig    clang-24
> xtensa                randconfig-1000-20260924    clang-17
> xtensa                randconfig-1000-20260925    gcc-12
> xtensa                randconfig-1001-20260924    clang-17
> xtensa                randconfig-1001-20260925    gcc-12
> xtensa                randconfig-2000-20260923    gcc-14.3.0
> xtensa                randconfig-2001-20260923    gcc-14.3.0
> xtensa               randconfig-r2202-20260923    gcc-10.5.0 smatch
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
