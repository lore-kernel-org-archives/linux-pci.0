Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280671;
	b=NhPfNF0eQZTd+sFm5aybzG/FRk0RYJntF+K6Gj3Vy5wNsz5s29NjQmnuJ8NwgXqXQpad
	 x/ixNl9MHrP0M8QhxFspvoS8ZsY1CxjrU+7+G2YCKNseYBzUWq/BML+rfF/kYFgzXBs2c
	 JzgUjx8X8GDwDQCvOqq+5xKtOyz1S+hS9jOMX4CxP9anVSaojFU1cS34nD7umJJ4+uErf
	 LCSpK29xax6VviQRTtlDK5NtMMgksBRWAZVZMzsweqLi4MvE0yTqOYHTaRq9dJTFBl+fk
	 6DfFfaYSAjmYpMn+iXay2NlD7rt7/pScljd/SEmEktN27xnDgyv3fK1t8MrT5QYhYuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280671;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=b+AFuhWnPDJSLYhPZ4qjpkT+CV2kwG8ni2hQRfb7t5c=;
	b=nbOcJE78CH7mSOynfPKQVoKOgtpevwa9PuLxs5dFCVbP7jtG3ynp3oEbn2d8+dVXryHC
	 NEswD/ELKIwBedSA152ms9U+g5uqj5medbDvdeQSZ6vgya1RV9hYDKz62N/Pkxtv1rj0/
	 PTCRbpMOWuUmCnibOpHHLvfc+FZKOOg8Fa6ERq6J9aFpn30fbg2JfFq2Q7iLF3xVkQGQ7
	 GqncZulvEhNbBiqb4uuKu4DGqwgoHZ/gumXlHtN4zS+NsHe8yCW/ejb/oYYk8NcNt8CSO
	 N2cMEvGMRzyyZ8JDFVM0XP/MJ+omt0XFyp6Y9fYLkowRmnLx1DWRbCUoMc1R+VZStew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ICrif33P;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A9606A321;
	Thu, 29 Oct 2026 13:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C0A9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ICrif33P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793280670; x=1824816670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zbPNXzmKH5aiAeKH/1F04rnmfk563h7HnAZF0WYRyrA=;
  b=ICrif33PAkFdKQhDpW7b0nvjVyoca7qh1NCgdBw3WJE8wcaYy14ZjlSQ
   5VhkdDnGtKRKqu+JGhhsCrK1b2a9j+9NgCSf9roGWpLqy9eB7JuNA33wL
   C5n5C0PSxKmVrvEjvqX1fFYq4iMVIh79IdWy65Ywy+4eIbgGF9cMJFs88
   ARaeSWCdBwy6Ok4xQNv/WjSyUuSsgBiTPHDh6oHFT2P3Oe1TfUmaUC2x0
   zvrMaVVST4f0vCNv0wrhO/uOKze7C8/L3r+5rB5wFtCNYBs+E+yMHCq1i
   5uRzLWYBvXlxmbgIpYeYV+ZJSjj/2vvTCX4B+XznrD/TM/qFmf0wMl1HE
   Q==;
X-CSE-ConnectionGUID: TWDiercORcaZmkk7YwIQ6Q==
X-CSE-MsgGUID: 9huVO9KVSNWr7rd/HvbIOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1906435"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1906435"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:31:10 -0700
X-CSE-ConnectionGUID: ZVqDH6SwSAi+mVyeV+cHmw==
X-CSE-MsgGUID: r8hmop+ZR1uxXaDTAZ6hKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5035807"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 29 Oct 2026 06:31:08 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xMQDg-00000000aAi-3BfQ;
	Thu, 29 Oct 2026 13:31:04 +0000
Date: Thu, 29 Oct 2026 21:30:15 +0800
From: kernel test robot <lkp@intel.com>
To: wuqianhai@loongson.cn, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, wuqianhai <wuqianhai@loongson.cn>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	tzimmermann@suse.de, javierm@redhat.com,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] PCI/VGA: Fix boot device detection after framebuffer
 relocation
Message-ID: <202610292159.Ls5pkJAS-lkp@intel.com>
References: <20261028094634.766723-1-wuqianhai@loongson.cn>
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
In-Reply-To: <20261028094634.766723-1-wuqianhai@loongson.cn>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v7.3 next-20261028]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wuqianhai-loongson-cn/PCI-VGA-Fix-boot-device-detection-after-framebuffer-relocation/20261028-174634
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20261028094634.766723-1-wuqianhai%40loongson.cn
patch subject: [PATCH] PCI/VGA: Fix boot device detection after framebuffer relocation
config: microblaze-defconfig (https://download.01.org/0day-ci/archive/20261029/202610292159.Ls5pkJAS-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261029/202610292159.Ls5pkJAS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610292159.Ls5pkJAS-lkp@intel.com/

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/pci/vgaarb.o: in function `vga_arb_device_init':
>> drivers/pci/vgaarb.c:1536:(.init.text+0x10): undefined reference to `screen_info_apply_fixups'


vim +1536 drivers/pci/vgaarb.c

  1524	
  1525	static int __init vga_arb_device_init(void)
  1526	{
  1527		int rc;
  1528		struct pci_dev *pdev;
  1529	
  1530		/*
  1531		 * PCI resource assignment may have relocated the firmware
  1532		 * framebuffer BAR. Update screen_info's lfb_base so that
  1533		 * vga_is_firmware_default() can match it against the boot
  1534		 * device's relocated resource.
  1535		 */
> 1536		screen_info_apply_fixups();

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
