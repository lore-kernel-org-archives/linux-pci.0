Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787531E0E14;
	Thu, 10 Sep 2026 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999168; cv=none; b=Ysi7Lg5IEiJzCY5mSyrfEqm88p6eLJI6cnZF1KKQ4boB2fxghSeQzgZQAdcMqlMiT0kkGLIN+kz59xlkKze0RCJMVQ8orLsbyYsUOd/p3otGbVNHNmbGPTpwLLy6I0AA0rX4CIOBR5hIQxjzrb8kpVGz3Ip2Vel+LoHwar+kUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999168; c=relaxed/simple;
	bh=J1jJnaeyf7LLhRqA+aeobhaA5FN1rbTKGY9M/HtxP4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEtqAjiwyCwOLzXZK2+0d9IxSXrXZxOKjKxsIj2xlzbJCHX+KxpujKe1pD262g0MeJrLK4Gi4GWoAOA5pmjcP6QIdpFcS4QKZYLWsO0f8UxWqI95bAC2twptcu52uih1J9+jttJzS2ID7JGjY1CkO/AKiD0hrXdjxJ3rcIevbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHG6J6Bf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHG6J6Bf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788999167; x=1820535167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J1jJnaeyf7LLhRqA+aeobhaA5FN1rbTKGY9M/HtxP4k=;
  b=nHG6J6BfXPcIowaA912QKVzXyc8TXWD5eQ586HWUjnHphsZYh8PCWqw0
   I97TkvfCifUE6vWq/BnxLiG4lHO55H0id9pqgOlkJ5VpP+4E2s4J52M69
   tmeyP+lTD0MHaipmzpGSYJp8BAoND6aGjHrosPNldOKGNeiHoaAXXqgbp
   glCoNTFnzStw0JLgPr/2O7lFiNPxdBvldrOzMIg8VuEWzb8uk6TRhyuhh
   BI2iZf+/7T4VspPSwEX6G/NxYmQk9IXi2npP2/57aioCVCZOD1Y7hqmrq
   1MNBIwBfmY+qi9XNlLPulikTFDiugSGB70uQb4lLZombOsbloUUqxiHqe
   g==;
X-CSE-ConnectionGUID: DtJjLdW/QtieSh1jFtP1sg==
X-CSE-MsgGUID: 6e2B8osBSWiB6VLXITkSKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88384806"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="88384806"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 17:12:46 -0700
X-CSE-ConnectionGUID: 57YLa0rXQiKYLTcF3IhQXQ==
X-CSE-MsgGUID: Mhufsv5iQ4+dLQjYqL4qAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="276707916"
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 09 Sep 2026 17:12:42 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4SPA-0000000018G-0Anx;
	Thu, 10 Sep 2026 00:12:40 +0000
Date: Thu, 10 Sep 2026 08:11:57 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Rodrigues Alves <breno3011alves@gmail.com>,
	torvalds@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, arnd@arndb.de,
	linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: Re: [PATCH v5] Kconfig: fix typos in core makefiles and purge
 defective DVB debug (v5)
Message-ID: <202609100824.ndDVSLWu-lkp@intel.com>
References: <20260905003005.118245-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905003005.118245-1-breno3011alves@gmail.com>

Hi Breno,

kernel test robot noticed the following build errors:

[auto build test ERROR on lee-leds/for-leds-next]
[also build test ERROR on broonie-regulator/for-next linus/master v7.3-rc2 next-20260909]
[cannot apply to linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Rodrigues-Alves/Kconfig-fix-typos-in-core-makefiles-and-purge-defective-DVB-debug-v5/20260904-213005
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20260905003005.118245-1-breno3011alves%40gmail.com
patch subject: [PATCH v5] Kconfig: fix typos in core makefiles and purge defective DVB debug (v5)
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260910/202609100824.ndDVSLWu-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260910/202609100824.ndDVSLWu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609100824.ndDVSLWu-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/media/dvb-core/dvb_net.c:76:35: error: 'TS_SZ' undeclared here (not in a function)
      76 | static unsigned char ule_hist[100*TS_SZ] = { 0 };
         |                                   ^~~~~
>> drivers/media/dvb-core/dvb_net.c:76:22: warning: 'ule_hist' defined but not used [-Wunused-variable]
      76 | static unsigned char ule_hist[100*TS_SZ] = { 0 };
         |                      ^~~~~~~~


vim +/TS_SZ +76 drivers/media/dvb-core/dvb_net.c

^1da177e4c3f41 drivers/media/dvb/dvb-core/dvb_net.c Linus Torvalds        2005-04-16  70  
e9f8b7ccd92d83 drivers/media/dvb-core/dvb_net.c     Breno Rodrigues Alves 2026-09-04  71  #ifdef CONFIG_DVB_ULE_DEBUG
b93a25e120d5a4 drivers/media/dvb-core/dvb_net.c     Mauro Carvalho Chehab 2017-12-11  72  /*
ba711e1cee7553 drivers/media/dvb-core/dvb_net.c     Mauro Carvalho Chehab 2017-12-11  73   * The code inside DVB_ULE_DEBUG keeps a history of the
b93a25e120d5a4 drivers/media/dvb-core/dvb_net.c     Mauro Carvalho Chehab 2017-12-11  74   * last 100 TS cells processed.
b93a25e120d5a4 drivers/media/dvb-core/dvb_net.c     Mauro Carvalho Chehab 2017-12-11  75   */
b93a25e120d5a4 drivers/media/dvb-core/dvb_net.c     Mauro Carvalho Chehab 2017-12-11 @76  static unsigned char ule_hist[100*TS_SZ] = { 0 };
b93a25e120d5a4 drivers/media/dvb-core/dvb_net.c     Mauro Carvalho Chehab 2017-12-11  77  static unsigned char *ule_where = ule_hist, ule_dump;
b93a25e120d5a4 drivers/media/dvb-core/dvb_net.c     Mauro Carvalho Chehab 2017-12-11  78  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
