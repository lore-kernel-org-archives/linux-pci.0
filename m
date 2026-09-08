Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D7513541;
	Tue,  8 Sep 2026 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864099; cv=none; b=JH7yKSmgKfzr13/MIXIDMHno30E6MNUQvqI24Kz9/6Xhx4zInX2T5i1ZxMNLcwLw8YOaYec9wSz4iMGP1uKrL09FO/Et6qy3lAlFzpbHp6xDTBYx9e83IIewePNAJ/smPhBpQDCl9kQT76zSeyHsvhM9iHNbOv07Rn5j2AWlIsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864099; c=relaxed/simple;
	bh=Gw7KN0Or/jOkVbOCW9IUJ128+upxz2FvtjLVYKII3dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fx5+TpNSrr1FrEMcA0hqv7TpsnKkopC4JPTeLIb4R+HZ6btR+rVejftHCIQ5sy8uiSy4dnFedaPRBQDKhQyIQvCKZ+44cO5Y+yeUxyOZBbGNyaeOKfZZXMqmHr/yiSakxr6T7FdxL8BPDXw2j52q7GGve6y8xf6wWudcsI9P7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0TUmpCT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0TUmpCT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788864097; x=1820400097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gw7KN0Or/jOkVbOCW9IUJ128+upxz2FvtjLVYKII3dQ=;
  b=U0TUmpCTqZbOiIE9PP6jSyWNxK1gxK1W4CQ65kC+YmU5fJhGkzpkeaai
   wGb+HTOEprsSaBGM9tM1rr3nBKYeBCETqpmxsbe39Cq7PlCTiV5m+lfgh
   D3ct2Q1ueMg8uHtzMS0V1e8f5jmUh9PqWYEYujrMMRrCd0IqjXxQ3yJg0
   Omn+hc9sW54AgRPGAlec1GGZqmpttllZIu78XjexEIJsYhM8eiNGGpSZS
   2GaHg7JFptdISlttWOsWw+eEQqom+oSKv296nWwsxQeYiTtqnwQUlA4UV
   TjgKhTFXfGUPlM3Ox6ufMDPouuDEX4UbPsG7Q4OTmgv2Lam40DoRy+zI2
   g==;
X-CSE-ConnectionGUID: n1NgR5lCRLeMgLCxrst0aw==
X-CSE-MsgGUID: JTM8ZwJWTpqUnedUMnlo7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89292662"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89292662"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:41:37 -0700
X-CSE-ConnectionGUID: Cn4i2TNtSGiFr8qAHvdhVQ==
X-CSE-MsgGUID: 0Ze/sG3wQDqoJxVvvBbL4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="270468783"
Received: from igk-lkp-server01.igk.intel.com (HELO cc074f2a4298) ([10.211.93.152])
  by orviesa008.jf.intel.com with ESMTP; 08 Sep 2026 03:41:34 -0700
Received: from kbuild by cc074f2a4298 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3tGd-000000000f4-2tBu;
	Tue, 08 Sep 2026 10:41:31 +0000
Date: Tue, 8 Sep 2026 12:40:32 +0200
From: kernel test robot <lkp@intel.com>
To: Alex Elder <elder@riscstar.com>, bhelgaas@google.com, robh@kernel.org,
	saravanak@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, herve.codina@bootlin.com,
	daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PCI: of: introduce of_pci_verify_node()
Message-ID: <202609081256.UUzbm16V-lkp@intel.com>
References: <20260904134607.1856121-5-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904134607.1856121-5-elder@riscstar.com>

Hi Alex,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cee9395acd8043be0644b25c34bfa86623f2b935]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Elder/PCI-of-avoid-allocations-in-of_pci_prop_compatible/20260904-084603
base:   cee9395acd8043be0644b25c34bfa86623f2b935
patch link:    https://lore.kernel.org/r/20260904134607.1856121-5-elder%40riscstar.com
patch subject: [PATCH v4 4/4] PCI: of: introduce of_pci_verify_node()
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20260908/202609081256.UUzbm16V-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260908/202609081256.UUzbm16V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609081256.UUzbm16V-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/of_property.c:335:7: error: incompatible pointer to integer conversion initializing 'char' with an expression of type 'char[48]' [-Wint-conversion]
     335 |         char bufp = buf;
         |              ^      ~~~
   drivers/pci/of_property.c:338:17: error: incompatible integer to pointer conversion passing 'char' to parameter of type 'char *'; take the address with & [-Wint-conversion]
     338 |         ret = snprintf(bufp, PROP_SIZE, "pci%x,%x", pdev->vendor, pdev->device);
         |                        ^~~~
         |                        &
   include/linux/sprintf.h:13:35: note: passing argument to parameter 'buf' here
      13 | __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
         |                                   ^
   drivers/pci/of_property.c:341:41: error: incompatible integer to pointer conversion assigning to 'const char *' from 'char'; take the address with & [-Wint-conversion]
     341 |         compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] = bufp;
         |                                                ^ ~~~~
         |                                                  &
   drivers/pci/of_property.c:344:17: error: incompatible integer to pointer conversion passing 'char' to parameter of type 'char *'; take the address with & [-Wint-conversion]
     344 |         ret = snprintf(bufp, PROP_SIZE, "pciclass,%06x", pdev->class);
         |                        ^~~~
         |                        &
   include/linux/sprintf.h:13:35: note: passing argument to parameter 'buf' here
      13 | __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
         |                                   ^
   drivers/pci/of_property.c:347:43: error: incompatible integer to pointer conversion assigning to 'const char *' from 'char'; take the address with & [-Wint-conversion]
     347 |         compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] = bufp;
         |                                                  ^ ~~~~
         |                                                    &
   drivers/pci/of_property.c:350:17: error: incompatible integer to pointer conversion passing 'char' to parameter of type 'char *'; take the address with & [-Wint-conversion]
     350 |         ret = snprintf(bufp, PROP_SIZE, "pciclass,%04x", pdev->class >> 8);
         |                        ^~~~
         |                        &
   include/linux/sprintf.h:13:35: note: passing argument to parameter 'buf' here
      13 | __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
         |                                   ^
   drivers/pci/of_property.c:351:41: error: incompatible integer to pointer conversion assigning to 'const char *' from 'char'; take the address with & [-Wint-conversion]
     351 |         compat_strs[PROP_COMPAT_PCICLASS_CCSS] = bufp;
         |                                                ^ ~~~~
         |                                                  &
>> drivers/pci/of_property.c:336:6: warning: unused variable 'i' [-Wunused-variable]
     336 |         int i, ret;
         |             ^
   1 warning and 7 errors generated.


vim +/i +336 drivers/pci/of_property.c

407d1a51921e9f Lizhi Hou  2023-08-15  326  
5a35f85c8e450f Alex Elder 2026-09-04  327  /* The three compatible property strings have max sizes 12+1, 15+1, and 13+1 */
5a35f85c8e450f Alex Elder 2026-09-04  328  #define PROP_SIZE	16	/* Max size of each compatible string */
407d1a51921e9f Lizhi Hou  2023-08-15  329  static int of_pci_prop_compatible(struct pci_dev *pdev,
407d1a51921e9f Lizhi Hou  2023-08-15  330  				  struct of_changeset *ocs,
407d1a51921e9f Lizhi Hou  2023-08-15  331  				  struct device_node *np)
407d1a51921e9f Lizhi Hou  2023-08-15  332  {
407d1a51921e9f Lizhi Hou  2023-08-15  333  	const char *compat_strs[PROP_COMPAT_NUM] = { 0 };
5a35f85c8e450f Alex Elder 2026-09-04  334  	char buf[PROP_COMPAT_NUM * PROP_SIZE] = { };
5a35f85c8e450f Alex Elder 2026-09-04  335  	char bufp = buf;
407d1a51921e9f Lizhi Hou  2023-08-15 @336  	int i, ret;
407d1a51921e9f Lizhi Hou  2023-08-15  337  
5a35f85c8e450f Alex Elder 2026-09-04  338  	ret = snprintf(bufp, PROP_SIZE, "pci%x,%x", pdev->vendor, pdev->device);
5a35f85c8e450f Alex Elder 2026-09-04  339  	if (ret >= PROP_SIZE)
5a35f85c8e450f Alex Elder 2026-09-04  340  		return -EINVAL;
5a35f85c8e450f Alex Elder 2026-09-04  341  	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] = bufp;
5a35f85c8e450f Alex Elder 2026-09-04  342  	bufp += ret + 1;
407d1a51921e9f Lizhi Hou  2023-08-15  343  
5a35f85c8e450f Alex Elder 2026-09-04  344  	ret = snprintf(bufp, PROP_SIZE, "pciclass,%06x", pdev->class);
5a35f85c8e450f Alex Elder 2026-09-04  345  	if (ret >= PROP_SIZE)
5a35f85c8e450f Alex Elder 2026-09-04  346  		return -EINVAL;
5a35f85c8e450f Alex Elder 2026-09-04  347  	compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] = bufp;
5a35f85c8e450f Alex Elder 2026-09-04  348  	bufp += ret + 1;
407d1a51921e9f Lizhi Hou  2023-08-15  349  
5a35f85c8e450f Alex Elder 2026-09-04  350  	ret = snprintf(bufp, PROP_SIZE, "pciclass,%04x", pdev->class >> 8);
5a35f85c8e450f Alex Elder 2026-09-04  351  	compat_strs[PROP_COMPAT_PCICLASS_CCSS] = bufp;
5a35f85c8e450f Alex Elder 2026-09-04  352  
5a35f85c8e450f Alex Elder 2026-09-04  353  	return of_changeset_add_prop_string_array(ocs, np, "compatible",
5a35f85c8e450f Alex Elder 2026-09-04  354  						  compat_strs, PROP_COMPAT_NUM);
407d1a51921e9f Lizhi Hou  2023-08-15  355  }
5a35f85c8e450f Alex Elder 2026-09-04  356  #undef PROP_SIZE
407d1a51921e9f Lizhi Hou  2023-08-15  357  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
