Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4613D886;
	Thu, 20 Aug 2026 05:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787202606; cv=none; b=GyXGeobRCDv3AzboEqFzsyFI6UiiZb8ENV4MMeiDJZUfXJh137kx0pRzM2geDo76p1JZkynlyycLntQzz1gcV5duOKkpSISwzWXKUYm+LlLOlZZW+CtojwRs6QRX/Hzn+Fboc5ZyoyAsz7hUa3j9Raz0scCa4BkWctt10923vu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787202606; c=relaxed/simple;
	bh=3nLGpgBPdWwc8JpLxbQ4Z3gEuYcaV+RB4izohmoVF14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKOZB+uOneBMmjThcZ2ufOoGC7HnEruvpJvKjbOc9I4HTP1vyhjkiDrSTKmgWKwlZOoDPIFkcROWmGA8jAaApSno00Qk53EtJz9lCjV/lQZgMiR3GQsfzYv1ym30zgKSKG7WPggvsrRNyj1qiQwH6rdF/Am91VxTC0dHTg+aLBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3jr3Fz0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3jr3Fz0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787202603; x=1818738603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3nLGpgBPdWwc8JpLxbQ4Z3gEuYcaV+RB4izohmoVF14=;
  b=M3jr3Fz0mGEKw0Qr+O4110WChpxx/C80zKKtA2lOrNMJKZSv4k93muga
   jLRzqmGVxzhpLy7eczPTgD01fQcCykoysORo2FMppAhMDHDwyDwaTT2/V
   s1X+eMKnDt08J2LcdjUBNsxE7W3XDB5Dqln988PZePtVR/d3FOTXtEfrH
   07JloKz/pbJjCDdO0MGr426IUCKUIAhweSe04PGqwP8y9KTRyCHX7Z2Rz
   kO/wp48YDw4Q+eMVqgKxgZM/qB84/aGluCFXogO5KMaG5MlYiVxO0HSZF
   FkHEAMa4zJ8JBPHbZ4yni1QQtw+P7gtP/QNE8W3ljXZhVkPXMV2CbiTAF
   Q==;
X-CSE-ConnectionGUID: cHpRoufwT6y+4t+xoqLOiQ==
X-CSE-MsgGUID: tEEVfRDwRiurnDMwJnsHqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98321826"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="98321826"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 22:10:03 -0700
X-CSE-ConnectionGUID: 94I9o2DLSeWCqmq+GedBpQ==
X-CSE-MsgGUID: HLqbnT5+TG2cC68lIlVXEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="271039019"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2026 22:09:59 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwv2K-00000000ht3-2foM;
	Thu, 20 Aug 2026 05:09:56 +0000
Date: Thu, 20 Aug 2026 13:09:44 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Add register dump support for PCIe Link Down
 events
Message-ID: <202608201351.dBcT51sv-lkp@intel.com>
References: <20260811-regdump-v1-1-f22db3fb37c2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-regdump-v1-1-f22db3fb37c2@oss.qualcomm.com>

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d55d5a8f3d852baab49dba910dcb04b6d8091b05]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Chaitanya-Chundru/PCI-qcom-Add-register-dump-support-for-PCIe-Link-Down-events/20260811-214223
base:   d55d5a8f3d852baab49dba910dcb04b6d8091b05
patch link:    https://lore.kernel.org/r/20260811-regdump-v1-1-f22db3fb37c2%40oss.qualcomm.com
patch subject: [PATCH] PCI: qcom: Add register dump support for PCIe Link Down events
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260820/202608201351.dBcT51sv-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608201351.dBcT51sv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608201351.dBcT51sv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-qcom.c:220:18: warning: 'qcom_pcie_ext_parf_dump_regs' defined but not used [-Wunused-const-variable=]
     220 | static const u32 qcom_pcie_ext_parf_dump_regs[] = {
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/qcom_pcie_ext_parf_dump_regs +220 drivers/pci/controller/dwc/pcie-qcom.c

   219	
 > 220	static const u32 qcom_pcie_ext_parf_dump_regs[] = {
   221		PARF_PM_STTS,
   222		PARF_PM_STTS_1,
   223		PARF_INT_ALL_STATUS,
   224		PARF_INT_ALL_2_STATUS,
   225		PARF_CLKREQ_OVERRIDE,
   226		PARF_L1SS_SLEEP_MODE_HANDLER_STATUS,
   227		PARF_L1SS_SLEEP_MODE_HANDLER_CFG,
   228		PARF_CORE_ERRORS,
   229		PARF_LINK_DOWN_AXI_ECAM_BLOCK_STATUS,
   230		PARF_STATUS,
   231		PARF_SYS_CTRL,
   232	};
   233	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
