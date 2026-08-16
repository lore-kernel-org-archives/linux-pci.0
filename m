Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A24B048A
	for <linux-pci@vger.kernel.org>; Sun, 16 Aug 2026 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838544; cv=none; b=o8hIeeobXW8ueuVxV1oI2Hh36j2ybf8jjMph4ko2lUAK6zQz17XiKWc6p3Q0IP4QZWs6tuUmi7MlEi8b8gKwT0ZU9Lx+gucCanSYwO8KDTUxYnHB8+eJk86x8Bfpdqf7/RCYhGVgVlQZrSMEBc9rc75tIYMVCMkhRbF9+RwNvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838544; c=relaxed/simple;
	bh=YEaVPp8SpD9ru4mQaTdMAlb7zLr+Hv4moNE1UHqbJds=;
	h=Date:From:To:Cc:Subject:Message-ID; b=totCaIUG7RBNBH4Tc8uoCztnIpk/7Rc7dTogFXp4QSX0C4b1rEh1x54QNQ3bQ6OcJDeHqOfGs/kITb5uNs20nj4aW26tI2XtfwB+hibXv/8lSkFSLG6CSWtbTNHuxNj0RxlgSZRaxUzE68lnLWBa+gOk0+oOuehwAjTgs/J0NM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEuYOV4B; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEuYOV4B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786838543; x=1818374543;
  h=date:from:to:cc:subject:message-id;
  bh=YEaVPp8SpD9ru4mQaTdMAlb7zLr+Hv4moNE1UHqbJds=;
  b=CEuYOV4BWnQmWMqPA7SnMPic5YDLT5zAe0d2kpSXCgsmTBIwAJ0rJmGU
   /Ak7doxup179+9GfiaqGlDryp0xhYGIgrP+EGXbo/mRTGUJyNenFlYikL
   bKROVq1ngegXdo4HKzlGvMweHNhDHTDU5gKHOdGo9SMcTtMOeXSAXbNhy
   rYl3BJTWo2ItEKmldBhe1hDYUz4Yh2JyQYCSfpyL1i0ogwAH86z+Y4S0O
   L7J6Iwt2cRvI8rLq2svuk+Br2fGiuPtW4sqf29dk6UA51/4Ddc+g2JHwX
   psx/szZ7dLEQHczjXNUDXLS9gmKxcauQa8zHaX5innCmyw6vTw6Qr9xP0
   w==;
X-CSE-ConnectionGUID: GZZzxBQ2TXS1+9FZm3Aljg==
X-CSE-MsgGUID: hlyXaMDJSHeegPXBDbG8+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="91040263"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="91040263"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 17:02:23 -0700
X-CSE-ConnectionGUID: oikXsPGBR3mTQyVWsFxRog==
X-CSE-MsgGUID: 5houKVxHS3C5fm3GLSBF6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="266553216"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 15 Aug 2026 17:02:21 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvOKR-00000000cYG-02D0;
	Sun, 16 Aug 2026 00:02:19 +0000
Date: Sun, 16 Aug 2026 08:02:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 03ffab4b0227353164147d7872e96d664d548259
Message-ID: <202608160804.0few7xko-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 03ffab4b0227353164147d7872e96d664d548259  Merge branch 'pci/misc'

elapsed time: 772m

configs tested: 15
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha           allnoconfig    gcc-16.1.0
alpha          allyesconfig    gcc-16.1.0
alpha             defconfig    gcc-16.1.0
arc            allmodconfig    gcc-16.1.0
arc            allyesconfig    gcc-16.1.0
arm        ixp4xx_defconfig    gcc-16.1.0
csky           allmodconfig    gcc-16.1.0
i386           allmodconfig    gcc-14
loongarch         defconfig    clang-24
nios2          allmodconfig    gcc-11.5.0
nios2           allnoconfig    gcc-11.5.0
parisc         allmodconfig    gcc-16.1.0
parisc         allyesconfig    gcc-16.1.0
parisc            defconfig    gcc-16.1.0
sh                defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
