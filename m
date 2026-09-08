Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE835540B2;
	Tue,  8 Sep 2026 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876957; cv=none; b=dE92e8YAXkogkYwkP02tSNHiwhcYKN37qED3jvdUrwOoHNfhxeaBT1V8c+oS6UOYrQ3m8RQqEw/6IpMRerKtJf31h4HjLjpa7aMJDXpDSkTNIL7nIRpZMTv3xBa1nLDkt03wkx8yqSwyJ8GTfBp/Fv6ptteFUFY3eaI0ECqTE5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876957; c=relaxed/simple;
	bh=UmzRLg9YuP0UokhozXud47y5dFbrbDDKOh1IQcffn44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOdP/tbSIjJxCjlE+x4RCZCkHx+tfPz7RvSsG7krXDJJlf9PWYiVryNAuGOzi0hctoTXFdKOX9q4lDIwqWQh86csckTpvBqcw0gCV4BU1x0OWdYHQdU757quKSzbrYHITmIwEf/4j8/INesLFe6aEyu2gIu3VwMSHiRCPcZh0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIPQ2AJ/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIPQ2AJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788876948; x=1820412948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UmzRLg9YuP0UokhozXud47y5dFbrbDDKOh1IQcffn44=;
  b=eIPQ2AJ/BzhsFcRCDKfgw1lxIHIoJtcdBYs0Aq0tsTWoSwp6S//vk4Rm
   gACQOYyEwEmn/yrhswj6wgDFSfnFsZ6lvb3fAHOGWCUj6j4p8iQTJiFEv
   HS4ejgnWwdWLApRrsYvQ1UenaMnzVq5tbgVnW5wVMB8TOTbWUSOiUYS5L
   LmUvEZKbD9p8q2to6NSKStRGQobYCLEZRQkkuNJAXr5XwabmDEuZ4t9UE
   Tb5hhX28+aVLw81FFs6ByLHyL4E0/60ASIZOwiyUe9nOxMmPA9eIt+JCc
   PY+ZR3q1FcB9zuvX/q4s++OTz8ZnTjU/xlaraKBYb4QTGlYkIDReOiwfU
   Q==;
X-CSE-ConnectionGUID: rk42PQCxTd6sxZnCxKEW3Q==
X-CSE-MsgGUID: qrQJ6EFoRHWHmHsjpzYD6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99873122"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="99873122"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 07:15:40 -0700
X-CSE-ConnectionGUID: arCvz7q5RtuSE/ZzRlFGVg==
X-CSE-MsgGUID: Zoxde7IOQ8GMxKUOPxv2sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="266692854"
Received: from igk-lkp-server01.igk.intel.com (HELO cc074f2a4298) ([10.211.93.152])
  by fmviesa006.fm.intel.com with ESMTP; 08 Sep 2026 07:15:38 -0700
Received: from kbuild by cc074f2a4298 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3wbo-000000000jO-2VeK;
	Tue, 08 Sep 2026 14:15:36 +0000
Date: Tue, 8 Sep 2026 16:15:04 +0200
From: kernel test robot <lkp@intel.com>
To: Alex Elder <elder@riscstar.com>, bhelgaas@google.com, robh@kernel.org,
	saravanak@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, herve.codina@bootlin.com,
	daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PCI: of: introduce of_pci_verify_node()
Message-ID: <202609081616.N6meYz4f-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on cee9395acd8043be0644b25c34bfa86623f2b935]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Elder/PCI-of-avoid-allocations-in-of_pci_prop_compatible/20260904-084603
base:   cee9395acd8043be0644b25c34bfa86623f2b935
patch link:    https://lore.kernel.org/r/20260904134607.1856121-5-elder%40riscstar.com
patch subject: [PATCH v4 4/4] PCI: of: introduce of_pci_verify_node()
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20260908/202609081616.N6meYz4f-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260908/202609081616.N6meYz4f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609081616.N6meYz4f-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/of_property.c:335:7: error: incompatible pointer to integer conversion initializing 'char' with an expression of type 'char[48]' [-Wint-conversion]
     335 |         char bufp = buf;
         |              ^      ~~~
>> drivers/pci/of_property.c:338:17: error: incompatible integer to pointer conversion passing 'char' to parameter of type 'char *'; take the address with & [-Wint-conversion]
     338 |         ret = snprintf(bufp, PROP_SIZE, "pci%x,%x", pdev->vendor, pdev->device);
         |                        ^~~~
         |                        &
   include/linux/sprintf.h:13:35: note: passing argument to parameter 'buf' here
      13 | __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
         |                                   ^
>> drivers/pci/of_property.c:341:41: error: incompatible integer to pointer conversion assigning to 'const char *' from 'char'; take the address with & [-Wint-conversion]
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
   drivers/pci/of_property.c:336:6: warning: unused variable 'i' [-Wunused-variable]
     336 |         int i, ret;
         |             ^
   1 warning and 7 errors generated.


vim +335 drivers/pci/of_property.c

   326	
   327	/* The three compatible property strings have max sizes 12+1, 15+1, and 13+1 */
   328	#define PROP_SIZE	16	/* Max size of each compatible string */
   329	static int of_pci_prop_compatible(struct pci_dev *pdev,
   330					  struct of_changeset *ocs,
   331					  struct device_node *np)
   332	{
   333		const char *compat_strs[PROP_COMPAT_NUM] = { 0 };
   334		char buf[PROP_COMPAT_NUM * PROP_SIZE] = { };
 > 335		char bufp = buf;
   336		int i, ret;
   337	
 > 338		ret = snprintf(bufp, PROP_SIZE, "pci%x,%x", pdev->vendor, pdev->device);
   339		if (ret >= PROP_SIZE)
   340			return -EINVAL;
 > 341		compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] = bufp;
   342		bufp += ret + 1;
   343	
   344		ret = snprintf(bufp, PROP_SIZE, "pciclass,%06x", pdev->class);
   345		if (ret >= PROP_SIZE)
   346			return -EINVAL;
   347		compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] = bufp;
   348		bufp += ret + 1;
   349	
   350		ret = snprintf(bufp, PROP_SIZE, "pciclass,%04x", pdev->class >> 8);
   351		compat_strs[PROP_COMPAT_PCICLASS_CCSS] = bufp;
   352	
   353		return of_changeset_add_prop_string_array(ocs, np, "compatible",
   354							  compat_strs, PROP_COMPAT_NUM);
   355	}
   356	#undef PROP_SIZE
   357	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
