Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4642264A9;
	Wed, 24 Jun 2026 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316135; cv=none; b=VAvPTZV2ozh5HzRwMTgN3oWedniOYEi7kDRAATjqNyd384np8PCUXcYAwidz4au3U0dBBU+61GA/x0Mx+d+Tgo/PmseFKjjPgledQe3P4FypU0E/0ukE4fdXx6Cm32DE1aI0/TagwqTP1IIvV44/Xkwf/Ex/MsdTjw5iuq9DnxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316135; c=relaxed/simple;
	bh=RYwF0cU7ZzumNc56lNIIWvjCJUBZP8YDlpYopFdStqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVQVvVVkhYAbPG1KxFeA+qbdgaTiVKgjVtkqctpvFTtMNKOz5dRJJenduJBDlDnBD/8UM4t8lCDTM3APJ63gZmhRKTFCgH5U4WrtgxtecOZtRR3AapHiKO3jJXDU9pXd6q5HpW11+mFsri88x1z0qMmvLYo8SZePojbxMj7qNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KaXIsTav; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaXIsTav"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782316134; x=1813852134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RYwF0cU7ZzumNc56lNIIWvjCJUBZP8YDlpYopFdStqQ=;
  b=KaXIsTavLbrakU5j3zjrXv9Y7QS/Ww64mK8RU+qLgqUliVjGvttZGayC
   THz4TPHoUh+AS7l8n/wOBnZvTOqCfaz6x5QpaIohT/ua43EDrKN5HoY80
   GWZlSytfq2OhJFoXfAL3NPxhJ4NiNxqSBCy0hUV2NlaWnHl0d33mVwI3G
   g/kn6486NRa8KULY9O1qPZ+4sO7PDnTi32U4pIUnUFlvakCgJIIUclAYM
   Q80WXPf9IpHo9TbFdnokMw6KCtZOu0GFvkUK7j/JBzTQz2aBZKUJQKzyA
   6dW23DLLigkG3Mm5Owr4HmS5Z1M2I9AxB8HSqqhmvcRcigiEHKAyWk2Jx
   w==;
X-CSE-ConnectionGUID: CCniC7wlS66iQ7QtQZGXbw==
X-CSE-MsgGUID: dlcO7pQJTIK4pHrhIpGgeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93442790"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="93442790"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 08:48:53 -0700
X-CSE-ConnectionGUID: 766+8Q7CQLu6ca2D8TkAzg==
X-CSE-MsgGUID: 3ovOslP9T16JEshrv/preQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="251878537"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 24 Jun 2026 08:48:51 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcPqK-000000003S9-3ilo;
	Wed, 24 Jun 2026 15:48:48 +0000
Date: Wed, 24 Jun 2026 23:48:02 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mani@kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH v2] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Message-ID: <202606242330.Ab9bKFmk-lkp@intel.com>
References: <20260624-aspm-v2-1-800a4151ba3a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-aspm-v2-1-800a4151ba3a@oss.qualcomm.com>

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 840ef6c78e6a2f694b578ecb9063241c992aaa9e]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Chaitanya-Chundru/PCI-ASPM-Mask-ASPM-states-based-on-Devicetree-properties/20260624-181628
base:   840ef6c78e6a2f694b578ecb9063241c992aaa9e
patch link:    https://lore.kernel.org/r/20260624-aspm-v2-1-800a4151ba3a%40oss.qualcomm.com
patch subject: [PATCH v2] PCI/ASPM: Mask ASPM states based on Devicetree properties
config: x86_64-buildonly-randconfig-006-20260624 (https://download.01.org/0day-ci/archive/20260624/202606242330.Ab9bKFmk-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260624/202606242330.Ab9bKFmk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606242330.Ab9bKFmk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pcie/aspm.c:30:13: warning: 'pcie_config_aspm_l1ss' declared 'static' but never defined [-Wunused-function]
      30 | static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state);
         |             ^~~~~~~~~~~~~~~~~~~~~


vim +30 drivers/pci/pcie/aspm.c

    29	
  > 30	static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state);
    31	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
