Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6883D8909;
	Thu, 14 May 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768586; cv=none; b=VZlOztjbkNVVhWvDFCWFXPJWf0mNAROwNt8JabWQDcI3OKQ5bu+LedcTXfCZS4I6YdOaaSf0CY4IxQfxjKfblPoWbIbZuuKaum+mnEIYeKZwCoMgEATxAVocSFuC39IncpT0sbWF53Sg473ngWReVN7eyton3boEXQwxjxpwBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768586; c=relaxed/simple;
	bh=1+cb2sStXOE2OW7LJ8lDA5+VJbnboBqGunLXZmnPBgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgPztxvrqEcmk/zc3swr4cHuloq7IsR2ey0nbDLg+979xJHO4xba3XDoi+m1ssBuD3SChmmBs3sl6jETgWC7d1laKkZySI7mz5Rh9lTGBLgc4UmiigwmNsXhDR4mSR5OFF1CMMh7QLGVDKLoFk3ezts221oI4/k0NPewc188YgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lI1Yhih7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lI1Yhih7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778768585; x=1810304585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1+cb2sStXOE2OW7LJ8lDA5+VJbnboBqGunLXZmnPBgo=;
  b=lI1Yhih7xhY0J50+y0WpMg1JB5vhOPfLdi65KNFsozWaOgtV4NHn8kxo
   /pQL9E/ikLObOCtZwROsGxcmyMMlvBYCjSHIvWV/k3eGYmpZkbM6z8Acy
   YNPHrwDm/RAMWQewQPoU/54EL0VXt3Py1XmXbvrmKbaJg3Wfk/bMMZ4Pc
   kjrCvy7Q5nWZMMKsP75P0VRKSFHQnHW9WEiud30eq4CvaiA0SjRE/eu5n
   tjAuzGg6V3NrNV/AGG8+fax51wazuE9Z0ZyxPdE8tY6hdG/Pw0xTt3MXd
   /fytuKNFfh9L8p80rU3i55pnc9SS8yq0B/TERKbvNe4iYWTJpICVZWFV0
   g==;
X-CSE-ConnectionGUID: bIOZ9Tw+Q7GbEsTprHoD5Q==
X-CSE-MsgGUID: gzeav3UCQD6WTML3CbnnFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79422775"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="79422775"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 07:23:04 -0700
X-CSE-ConnectionGUID: MoTmitk+SYGyMdDayYUivQ==
X-CSE-MsgGUID: j2Ra0cpgRtCqNzrKqlrxCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="238289913"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa008.jf.intel.com with ESMTP; 14 May 2026 07:22:59 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNWxk-000000008or-1YWQ;
	Thu, 14 May 2026 14:22:56 +0000
Date: Thu, 14 May 2026 16:22:22 +0200
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	vigneshr@ti.com, jingoohan1@gmail.com, thomas.petazzoni@bootlin.com,
	pali@kernel.org, ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	claudiu.beznea.uj@bp.renesas.com, mpillai@cadence.com
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org, s-vadapalli@ti.com,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v2 8/8] PCI: rzg3s-host: Add 100 ms delay after link
 training
Message-ID: <202605141646.YYkbS6Hg-lkp@intel.com>
References: <20260506152346.166056-9-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506152346.166056-9-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on a293ec25d59dd96309058c70df5a4dd0f889a1e4]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Add-pcie_wait_after_link_train-helper/20260514-132815
base:   a293ec25d59dd96309058c70df5a4dd0f889a1e4
patch link:    https://lore.kernel.org/r/20260506152346.166056-9-18255117159%40163.com
patch subject: [PATCH v2 8/8] PCI: rzg3s-host: Add 100 ms delay after link training
config: arm64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260514/202605141646.YYkbS6Hg-lkp@intel.com/config)
compiler: aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605141646.YYkbS6Hg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605141646.YYkbS6Hg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/pci-thunder-pem.c:16:
   drivers/pci/controller/../pci.h: In function 'pcie_wait_after_link_train':
>> drivers/pci/controller/../pci.h:73:17: error: implicit declaration of function 'msleep' [-Wimplicit-function-declaration]
      73 |                 msleep(PCIE_RESET_CONFIG_WAIT_MS);
         |                 ^~~~~~
--
   In file included from drivers/pci/controller/dwc/pcie-al.c:14:
   drivers/pci/controller/dwc/../../pci.h: In function 'pcie_wait_after_link_train':
>> drivers/pci/controller/dwc/../../pci.h:73:17: error: implicit declaration of function 'msleep' [-Wimplicit-function-declaration]
      73 |                 msleep(PCIE_RESET_CONFIG_WAIT_MS);
         |                 ^~~~~~


vim +/msleep +73 drivers/pci/controller/../pci.h

    62	
    63	/**
    64	 * pcie_wait_after_link_train - Wait 100 ms if link speed > 5 GT/s
    65	 * @max_link_speed: the maximum link speed (2 = 5.0 GT/s, 3 = 8.0 GT/s, ...)
    66	 *
    67	 * Must be called after Link training completes and before the first
    68	 * Configuration Request is sent.
    69	 */
    70	static inline void pcie_wait_after_link_train(int max_link_speed)
    71	{
    72		if (max_link_speed > 2)
  > 73			msleep(PCIE_RESET_CONFIG_WAIT_MS);
    74	}
    75	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
