Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9429443;
	Sat, 24 Jan 2026 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769241308; cv=none; b=tVQkU4Tt4kiCwdhbKFzdnEXADTPef2gBXzsu7uNQmbGW1i6Jy/2KBWBa6F+fsw0teu/oTGLHDkG6mI7LViRsXO77QsgMFdzzpfl5enPcQ8+1s6+xCcvmAuAms/p4o0VE/si/+bpwIlP1MwuCDBDKqZ1pMiZ1fI68mPXF8zjIknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769241308; c=relaxed/simple;
	bh=i00HUhnpqmvttoUnCMJLQeaRIUE23H11RrAAHakMQrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCPGSHoFpdolbliTz1K6KVIorQv0tvhzQC9kVU6kXH9GGh8gHpJElAf2IXZwFXMNeQL/5Jq7IfLZINLDI1X8geZulM/K626RJvs5Hjt55nfmueSvSAtiUDTkOshRD9aNUodxdDI/8ZqcwzxFgMfT7pN+rsZsvfUZjZZtf1lLNzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWxZibw8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWxZibw8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769241305; x=1800777305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i00HUhnpqmvttoUnCMJLQeaRIUE23H11RrAAHakMQrE=;
  b=XWxZibw8E9QTN3le2add5fVc1+vcj96bpoFfavno+UlAiM4JNPQvuj02
   nd05hdsLYHervaRp+iU/Flm5JeBlJLkT1Y8SeRMDti5AEROY+TXvo6fXA
   rm6LwDro1vNxai1gSRuDvkHi+olUUgtO4bJ345fT3bq2nfcSFBb4kaYDx
   nogl7fcxERBQ6eahxtuxP99jt1pykt6wTdfExCfp2JL6ZulUq75Y/2viz
   GNzJhBAPzG+QuSF4qF5Gm9e8Mcy3fTQx71pHa7t1/PGZSvR4f6mXsQvjR
   2t1JYl3Bk2qGOriZTeoTtYyxlbF5ZewOd7rZ8tYqAmQC6Ds0+Xe/59ZoU
   A==;
X-CSE-ConnectionGUID: ZW/UWrB5SU2KcTlmXVjokg==
X-CSE-MsgGUID: fR97ONoxQqm+Gj4KGElTFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="74344617"
X-IronPort-AV: E=Sophos;i="6.21,250,1763452800"; 
   d="scan'208";a="74344617"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 23:55:04 -0800
X-CSE-ConnectionGUID: dkDbYmeLR1ia1hhA1QjupQ==
X-CSE-MsgGUID: AAwrW7wySqScv/htBuVDsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,250,1763452800"; 
   d="scan'208";a="238475022"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 23 Jan 2026 23:55:00 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjYTx-00000000V0U-0oPe;
	Sat, 24 Jan 2026 07:54:57 +0000
Date: Sat, 24 Jan 2026 15:54:10 +0800
From: kernel test robot <lkp@intel.com>
To: smadhavan@nvidia.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, ming.li@zohomail.com,
	rrichter@amd.com, Smita.KoralahalliChannabasappa@amd.com,
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, smadhavan@nvidia.com, vaslot@nvidia.com,
	vsethi@nvidia.com, sdonthineni@nvidia.com, vidyas@nvidia.com,
	mochs@nvidia.com, jsequeira@nvidia.com
Subject: Re: [PATCH v4 06/10] PCI: wire CXL reset prepare/cleanup
Message-ID: <202601241505.gxL2m9pU-lkp@intel.com>
References: <20260120222610.2227109-7-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120222610.2227109-7-smadhavan@nvidia.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.19-rc6]
[cannot apply to next-20260123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/smadhavan-nvidia-com/cxl-move-DVSEC-defines-to-cxl-pci-header/20260121-071852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260120222610.2227109-7-smadhavan%40nvidia.com
patch subject: [PATCH v4 06/10] PCI: wire CXL reset prepare/cleanup
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20260124/202601241505.gxL2m9pU-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260124/202601241505.gxL2m9pU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601241505.gxL2m9pU-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cxl/pci.c:1085:6: error: redefinition of 'cxl_is_type2_device'
    1085 | bool cxl_is_type2_device(struct pci_dev *pdev)
         |      ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/cxl/pci.c:11:
   include/linux/pci.h:1476:20: note: previous definition of 'cxl_is_type2_device' with type 'bool(struct pci_dev *)' {aka '_Bool(struct pci_dev *)'}
    1476 | static inline bool cxl_is_type2_device(struct pci_dev *dev)
         |                    ^~~~~~~~~~~~~~~~~~~
   drivers/cxl/pci.c: In function 'cxl_check_region_driver_bound':
   drivers/cxl/pci.c:1102:28: error: 'cxl_region_rwsem' undeclared (first use in this function); did you mean 'cxl_region_ref'?
    1102 |         guard(rwsem_read)(&cxl_region_rwsem);
         |                            ^~~~~~~~~~~~~~~~
         |                            cxl_region_ref
   drivers/cxl/pci.c:1102:28: note: each undeclared identifier is reported only once for each function it appears in
   drivers/cxl/pci.c:1103:41: error: 'struct cxl_region' has no member named 'driver'
    1103 |         if (cxld->region && cxld->region->driver)
         |                                         ^~
   drivers/cxl/pci.c: In function 'cxl_decoder_kill_region_iter':
   drivers/cxl/pci.c:1120:9: error: implicit declaration of function 'cxl_decoder_kill_region_locked'; did you mean 'cxl_decoder_kill_region_iter'? [-Wimplicit-function-declaration]
    1120 |         cxl_decoder_kill_region_locked(cxled);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         cxl_decoder_kill_region_iter
   drivers/cxl/pci.c: In function 'cxl_region_flush_device_caches':
   drivers/cxl/pci.c:1187:53: error: 'struct cxl_dev_state' has no member named 'pdev'; did you mean 'dev'?
    1187 |                 if (!target_cxlds || !target_cxlds->pdev)
         |                                                     ^~~~
         |                                                     dev
   drivers/cxl/pci.c:1190:35: error: 'struct cxl_dev_state' has no member named 'pdev'; did you mean 'dev'?
    1190 |                 if (target_cxlds->pdev != target_pdev)
         |                                   ^~~~
         |                                   dev
   drivers/cxl/pci.c: In function 'cxl_reset_prepare_memdev':
   drivers/cxl/pci.c:1231:21: error: 'cxl_region_rwsem' undeclared (first use in this function); did you mean 'cxl_region_ref'?
    1231 |         down_write(&cxl_region_rwsem);
         |                     ^~~~~~~~~~~~~~~~
         |                     cxl_region_ref
   In file included from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from arch/openrisc/include/asm/pgalloc.h:20,
                    from arch/openrisc/include/asm/io.h:18,
                    from include/linux/io.h:12,
                    from include/linux/io-64-nonatomic-lo-hi.h:5,
                    from drivers/cxl/pci.c:4:
   drivers/cxl/pci.c: In function 'cxl_reset_cleanup_memdev':
   drivers/cxl/pci.c:1265:35: error: 'cxl_region_rwsem' undeclared (first use in this function); did you mean 'cxl_region_ref'?
    1265 |         if (lockdep_is_held_type(&cxl_region_rwsem, -1))
         |                                   ^~~~~~~~~~~~~~~~
   include/linux/lockdep.h:253:61: note: in definition of macro 'lockdep_is_held_type'
     253 | #define lockdep_is_held_type(lock, r)   lock_is_held_type(&(lock)->dep_map, (r))
         |                                                             ^~~~
   drivers/cxl/pci.c: At top level:
>> drivers/cxl/pci.c:1278:5: error: redefinition of 'cxl_reset_prepare_device'
    1278 | int cxl_reset_prepare_device(struct pci_dev *pdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pci.h:1481:19: note: previous definition of 'cxl_reset_prepare_device' with type 'int(struct pci_dev *)'
    1481 | static inline int cxl_reset_prepare_device(struct pci_dev *pdev)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/cxl/pci.c:1303:6: error: redefinition of 'cxl_reset_cleanup_device'
    1303 | void cxl_reset_cleanup_device(struct pci_dev *pdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pci.h:1486:20: note: previous definition of 'cxl_reset_cleanup_device' with type 'void(struct pci_dev *)'
    1486 | static inline void cxl_reset_cleanup_device(struct pci_dev *pdev)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/cxl_reset_prepare_device +1278 drivers/cxl/pci.c

76e9ed09acad72 Srirangan Madhavan 2026-01-20  1268  
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1269  /**
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1270   * cxl_reset_prepare_device - Prepare CXL device for reset
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1271   * @pdev: PCI device being reset
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1272   *
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1273   * CXL-reset-specific preparation. Validates memory is offline, flushes
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1274   * device caches, and tears down regions.
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1275   *
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1276   * Returns: 0 on success, -EBUSY if memory online, negative on error
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1277   */
76e9ed09acad72 Srirangan Madhavan 2026-01-20 @1278  int cxl_reset_prepare_device(struct pci_dev *pdev)
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1279  {
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1280  	int rc;
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1281  
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1282  	rc = cxl_reset_prepare_memdev(pdev);
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1283  	if (rc) {
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1284  		if (rc == -EBUSY)
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1285  			dev_err(&pdev->dev,
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1286  				"Cannot reset: device has online memory or active regions\n");
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1287  		else
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1288  			dev_err(&pdev->dev,
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1289  				"Failed to prepare device for reset: %d\n", rc);
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1290  		return rc;
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1291  	}
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1292  
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1293  	return 0;
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1294  }
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1295  EXPORT_SYMBOL_NS_GPL(cxl_reset_prepare_device, "CXL");
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1296  
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1297  /**
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1298   * cxl_reset_cleanup_device - Cleanup after CXL reset
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1299   * @pdev: PCI device that was reset
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1300   *
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1301   * Releases region locks held during reset.
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1302   */
76e9ed09acad72 Srirangan Madhavan 2026-01-20 @1303  void cxl_reset_cleanup_device(struct pci_dev *pdev)
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1304  {
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1305  	cxl_reset_cleanup_memdev(pdev);
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1306  }
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1307  EXPORT_SYMBOL_NS_GPL(cxl_reset_cleanup_device, "CXL");
76e9ed09acad72 Srirangan Madhavan 2026-01-20  1308  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
