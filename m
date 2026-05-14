Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363224CEEA;
	Thu, 14 May 2026 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778726970; cv=none; b=pDTCVMmhf90QtYBT9wRgNN2ZYmRGJfqpZiL42u6908PDOXYdKGKY/VADlpndb9Wdw1go24ZEvekMN1UtAtfkqijYU+9V1TLirhugeJAq+Df3LwAA0z3hpotT8DMuHWDq74iMXUaqiKH2B+UDnVvg6oaaIwt5pd8ROKS6h4ez6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778726970; c=relaxed/simple;
	bh=k0CIKpkiwdLSwTL1nBN8SsHdbHwx+9+NbeMDdU3KkdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+Tq3Q5DYdovUjP5DF8HZzGWlY22bs+8taHhbIrQQBIR/f+tAijuok1CsJeOg1QotR+j2Y/z559+KBiMFmXB0ro+TeIrtDlw3NI56p6IIPCJJGsVCMl0dV8YqKiTKerZOGODHHgg3Zo959NHU0mbdXc3gXiXstggBiIBDPQtiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2ce3ciL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2ce3ciL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778726968; x=1810262968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k0CIKpkiwdLSwTL1nBN8SsHdbHwx+9+NbeMDdU3KkdI=;
  b=n2ce3ciLeYbzvE85iMzAMTekCtXQ1gEa0UVG/pmIwI3jBfdkU0GDUwMQ
   /Etkt7drKsEQ9VGyBJ1is9lvubG4GvLYoIQWjOd4KVC6UGcccn7eMKvp0
   lDmJrDqllOxL9oNlHnQ2VzhrwY/7ATbNeMIF2fQ16W1fUBDWmIZQcNqWZ
   sKEMJkq0kvAXO6CgpxrXVyVaOfi2ZzYjts6E+KJAAXH8nIaWpcNGRWy5V
   Ki13cw+lebPpHregISRLHzVy7u632uhVoYea8FH/J9Z2zSpAFcJS9i22W
   Z95N3cc49UnBSsoI/s56UXEYcBQ0kJntMe6+fCvEdIBYahQMbg8/+3Qcy
   Q==;
X-CSE-ConnectionGUID: 9ew85r9zTcGPlgwqNRHC4A==
X-CSE-MsgGUID: 6Grbjm4KSfqhuIpzhjIgBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79618299"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79618299"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 19:49:26 -0700
X-CSE-ConnectionGUID: ZIrULUKFR32/EfWmCtls1g==
X-CSE-MsgGUID: g4dK7gGxTcuz6mDdjIL7Mw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 May 2026 19:49:23 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNM8X-000000005hP-08s4;
	Thu, 14 May 2026 02:49:21 +0000
Date: Thu, 14 May 2026 10:48:46 +0800
From: kernel test robot <lkp@intel.com>
To: Pawel Laszczak via B4 Relay <devnull+pawell.cadence.com@kernel.org>,
	Peter Chen <peter.chen@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Pawel Laszczak <pawell@cadence.com>
Subject: Re: [PATCH v3] usb: cdnsp: Add support for device-only configuration
Message-ID: <202605141023.18vWXyw3-lkp@intel.com>
References: <20260508-no_drd_config-v3-1-0614f5044721@cadence.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-no_drd_config-v3-1-0614f5044721@cadence.com>

Hi Pawel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 17c7841d09ee7d33557fd075562d9289b6018c90]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawel-Laszczak-via-B4-Relay/usb-cdnsp-Add-support-for-device-only-configuration/20260513-191545
base:   17c7841d09ee7d33557fd075562d9289b6018c90
patch link:    https://lore.kernel.org/r/20260508-no_drd_config-v3-1-0614f5044721%40cadence.com
patch subject: [PATCH v3] usb: cdnsp: Add support for device-only configuration
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260514/202605141023.18vWXyw3-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605141023.18vWXyw3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605141023.18vWXyw3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/cdns3/drd.c:187:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     187 |         if (cdns->no_drd)
         |             ^~~~~~~~~~~~
   drivers/usb/cdns3/drd.c:209:9: note: uninitialized use occurs here
     209 |         return ret;
         |                ^~~
   drivers/usb/cdns3/drd.c:187:2: note: remove the 'if' if its condition is always false
     187 |         if (cdns->no_drd)
         |         ^~~~~~~~~~~~~~~~~
     188 |                 goto phy_set;
         |                 ~~~~~~~~~~~~
   drivers/usb/cdns3/drd.c:185:9: note: initialize the variable 'ret' to silence this warning
     185 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +187 drivers/usb/cdns3/drd.c

   175	
   176	/**
   177	 * cdns_drd_host_on - start host.
   178	 * @cdns: Pointer to controller context structure.
   179	 *
   180	 * Returns 0 on success otherwise negative errno.
   181	 */
   182	int cdns_drd_host_on(struct cdns *cdns)
   183	{
   184		u32 val, ready_bit;
   185		int ret;
   186	
 > 187		if (cdns->no_drd)
   188			goto phy_set;
   189	
   190		/* Enable host mode. */
   191		writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
   192		       &cdns->otg_regs->cmd);
   193	
   194		if (cdns->version == CDNSP_CONTROLLER_V2)
   195			ready_bit = OTGSTS_CDNSP_XHCI_READY;
   196		else
   197			ready_bit = OTGSTS_CDNS3_XHCI_READY;
   198	
   199		dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
   200		ret = readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
   201						val & ready_bit, 1, 100000);
   202	
   203		if (ret)
   204			dev_err(cdns->dev, "timeout waiting for xhci_ready\n");
   205	
   206	phy_set:
   207		phy_set_mode(cdns->usb2_phy, PHY_MODE_USB_HOST);
   208		phy_set_mode(cdns->usb3_phy, PHY_MODE_USB_HOST);
   209		return ret;
   210	}
   211	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
