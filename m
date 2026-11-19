Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074708;
	b=3LNvfd2UPHKfy7BGFHsPZkAm3LGb5pI9tmG93Vbf0/U+cuqcYK7QMLzVi5+CGF+3uVEv
	 UvDhP52shLw34YPEPOSpyfnGBkXxKNmHgUjusoBgPoEhOQSJ4HgEo7YZ0oIOSWQ76Fm6w
	 mPK57oyDM0HHwq/NizPE86jDWgbAuUpuiMLo0B1TlH+wbg2TJ/9FT7CYtrn/dw8d2I6lz
	 PthtTPOzibtGqrQDZU6ItlFeKesNOcMolsa5gyRfdpM0ecse067WWbiqyz7zYONsNCxEE
	 7gkGsAoXG4bNyW8eL3oHjOFX6/5HxMneiHbIe+i7IfjQ1x/sgCBN2998SG4QaxbsGkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074708;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/xMcofbYLH/BQGqdyQHY3s09vTq6s+sJcSXrp+UZcQQ=;
	b=3d1rQSxh7DzUB78KuWZxM18y0+qvsx2/osaB8NIfIw4XyMDD0g5WFjCr7ronUbJsP3Wq
	 uXQCMJa+Mq+/GC7/lmhAGIkHYWjmaNOMPIGjwBrjijtwjiusgiRWc1tpukYCeG9ssfCeB
	 9N9uhc1J1VRjDmcyhvP5FCZagO0keEVxDqRzPs4G48Xqj64F/+afxJnxiViG5pf1g22xE
	 YKIFCa1msQCAMcp3y5t4Hw023tj4hibixLIyOX9indUMttFe6Da6vctyLeMHtplsg4B+Z
	 Eb55smWFuKudK+qhsY96NicTHMyivYEz17EJ+4wmBjFTqUFI3OJfX0bj2E2jeGHRMYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V5F6EWtP;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263D6606A320;
	Thu, 19 Nov 2026 07:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 263D6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V5F6EWtP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795074709; x=1826610709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+vBK1UvG33M73tQvAAVwvyLux0vIdvn8UJxqBDjdbtc=;
  b=V5F6EWtPBg1N9y6Cl6cNdGzVWpYmXL85BpTbToszECb7I4qUOzb1EQJa
   yS7rqg9kmEv6RUDKEGNIoKXmT4kOTRMRyV3xoM5IAdHopg80ShLH+jEPo
   OysV6afiwJkYNfRCmAkl0EHrfsrMyKOEAiN3j4LZ5glCTbnPGxZraWaXa
   vXRMRqAlZd0zfqb+ZuTL6luztbFD3iZBWob8lit4q7gRN4IpGXWKWLJ1O
   Im4q9aJiGVlmCzzG3uSEXs/ASuWnR/E5zTqEl5oUnbk2dR93IoD9WC3Ee
   8ZyfJGWePCR4XhEgsu6CryBd3sefCJ28260mOWlPuofmSIum/X8m6+DxP
   A==;
X-CSE-ConnectionGUID: wK8+UVghRraqfPWSp4BYVA==
X-CSE-MsgGUID: 0vkofEAtQWaUr0cXLT4Abg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3833635"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3833635"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 23:51:48 -0800
X-CSE-ConnectionGUID: RDOcz9zFR+u9DyrXHiCCvA==
X-CSE-MsgGUID: xSAgjB7xTLWP9PsKVyyFew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10358887"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Nov 2026 23:51:44 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTwvm-00000001FLu-0FqS;
	Thu, 19 Nov 2026 07:51:42 +0000
Date: Thu, 19 Nov 2026 15:50:55 +0800
From: kernel test robot <lkp@intel.com>
To: Chengwen Feng <fengchengwen@huawei.com>, alex@shazbot.org, jgg@ziepe.ca,
	helgaas@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, wathsala.vithanage@arm.com,
	wei.huang2@amd.com, zhipingz@meta.com, wangzhou1@hisilicon.com,
	wangyushan12@huawei.com, liuyonglong@huawei.com,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v21 09/13] vfio/pci: Add basic NO-ST TPH VFIO device
 feature support
Message-ID: <202611191515.xWHTgH9X-lkp@intel.com>
References: <20261118091238.45992-10-fengchengwen@huawei.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118091238.45992-10-fengchengwen@huawei.com>

Hi Chengwen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on awilliam-vfio/next]
[also build test WARNING on pci/next pci/for-linus linus/master v7.4-rc3 next-20261116]
[cannot apply to awilliam-vfio/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengwen-Feng/PCI-TPH-Fix-pcie_tph_get_st_table_loc-field-extraction/20261118-171226
base:   https://github.com/awilliam/linux-vfio.git next
patch link:    https://lore.kernel.org/r/20261118091238.45992-10-fengchengwen%40huawei.com
patch subject: [PATCH v21 09/13] vfio/pci: Add basic NO-ST TPH VFIO device feature support
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20261119/202611191515.xWHTgH9X-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261119/202611191515.xWHTgH9X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611191515.xWHTgH9X-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/vfio/pci/vfio_pci_config.c: In function 'vfio_tph_vcap_rewrite':
>> drivers/vfio/pci/vfio_pci_config.c:1130:25: warning: unused variable 'pdev' [-Wunused-variable]
    1130 |         struct pci_dev *pdev = vdev->pdev;
         |                         ^~~~


vim +/pdev +1130 drivers/vfio/pci/vfio_pci_config.c

  1126	
  1127	static void vfio_tph_vcap_rewrite(struct vfio_pci_core_device *vdev, int pos)
  1128	{
  1129		__le32 *vptr = (__le32 *)&vdev->vconfig[pos + PCI_TPH_CAP];
> 1130		struct pci_dev *pdev = vdev->pdev;
  1131		u32 val = le32_to_cpu(*vptr);
  1132	
  1133		if (!pcie_ext_tph_supported(pdev)) {
  1134			/* Remove extended TPH if root-port doesn't support */
  1135			val &= ~PCI_TPH_CAP_EXT_TPH;
  1136		}
  1137	
  1138		if (vdev->tph_policy == VFIO_PCI_TPH_POLICY_NO_ST) {
  1139			/*
  1140			 * NO-ST policy: mask IV/DS mode, ST location and ST size fields.
  1141			 * Userspace only sees NO-ST capability.
  1142			 */
  1143			val &= ~(PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS |
  1144				 PCI_TPH_CAP_LOC_MASK | PCI_TPH_CAP_ST_MASK);
  1145		}
  1146	
  1147		*vptr = cpu_to_le32(val);
  1148	
  1149		/* Cache the final virtualized TPH capability value */
  1150		vdev->tph_vcap = val;
  1151	}
  1152	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
