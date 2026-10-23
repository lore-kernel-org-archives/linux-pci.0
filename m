Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792719580;
	b=pORreFYrELH32zhMmkKpqpbZrjcQTPFoRsSGadpup6imeZ82ZU3k/4D24A/2NGSqIAay
	 RnwAkfQFexHOeQ0PeB2Lo/nnOax1AR4XRxgGlJgaTnU6yKh5uLHXp6Ko8+4IqXOnaP9/y
	 zlrN+QUG2MCMZgP5q3840EhuIwZb9vlJPI86p75IJmUC+cJYMwvSbs1/PQPDCn2mppNPt
	 96HE3/Qs7OScKUG7KtkvTXGRWPm1C8T+aIDOTc8DraDKUwU6cDW7q/G94XoGtLRJZupBz
	 poP6HTf1EAeDd6KgyjUg1ziTHAAADwncP+3OsZ18DK3/UlmYDLTYA2yO4iNKPnD2z0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792719580;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=zlUgj7MhOA7NiXRah7QpaWYmnmT0MHWnM7+9ThgmOB0=;
	b=n1nvNVc6cKYTGNoY0z8LanRDGs1eBjzBpTpexlkO6pF+m8RQWmvZcEKOtQnqzBVShgcZ
	 dM8Tv10lsAuvhygJOQsxekEX3jbCqLgw8FgpTV4qDcMSzHMRKZe89EPSJO66xbvBaT7km
	 ZHk/aouhYjrQIIimD15Pv6w5PSnjX1jq9GMsycTdP9H3pzgmX3RBDlkDhoK60o9CI/vLf
	 c0/RQLmdxrmkMR1FEmOzaLyIeTnrjja+OjIJZANr7hGsiOqb00JSPAQXm/PbEMNZq3tji
	 5hO0V3Jl6v4DwzgaGlrWdiaQtuYCZJT5y8hZJA51wV7zWOcW/3tQbmMUSRn2ugJDlFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ds+QoCs4;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6D606A319;
	Fri, 23 Oct 2026 01:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBE6D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ds+QoCs4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792719579; x=1824255579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ItD34oWASUxo5/QR3v4k5gW4vxzz9C22A8XfHQIstRk=;
  b=ds+QoCs4vUg78tcPovimgi75kvA8DRJi2HYLyfyrpOvHNW9dwkh6RxQ7
   Da5vSGVw1HZxS7Hlj4mRR0rB1KO2H6vwuTrGAmeDv2mTkW3z8wBqCVKJA
   AeFPh/oIUKXcV7wjogDwIhPl8wt1aPkBwtDLZmhjNA5vNf0cbMfPZr7AW
   3Ewl9MgjMIW63pkypoh1CA6cJOdrzJmSmIWTOLdC/ZFVSNShcSJHkpEcb
   N4LhJphNMcK3aC+NdpSEMedTk86zTuwC/w0YerN8a7l2+kbWzR+Yo/Tvp
   N+mFhjZuOsSUEDYy6G2xEvIYEj43hWbOHiOXZIhfyhL45UcCktNQ+vIFB
   g==;
X-CSE-ConnectionGUID: GbQcsfCzSvCpEzxkLu43Aw==
X-CSE-MsgGUID: PY/Xw37PQfK58VoCLpFpOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1585826"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1585826"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 18:39:38 -0700
X-CSE-ConnectionGUID: GY1h/MB/S96sbOwHJkbeEg==
X-CSE-MsgGUID: yXZ5EHVDTu+otsnBCugiVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3413194"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Oct 2026 18:39:36 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xK4Fo-00000000RyQ-3hQ1;
	Fri, 23 Oct 2026 01:39:32 +0000
Date: Fri, 23 Oct 2026 09:38:54 +0800
From: kernel test robot <lkp@intel.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, vidyas@nvidia.com,
	cassel@kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, mmaddireddy@nvidia.com
Subject: Re: [PATCH v2 3/3] PCI: tegra194: Notify Endpoint functions on
 PERST# assert
Message-ID: <202610230923.2lf3BsLs-lkp@intel.com>
References: <20261021061903.1269605-4-mmaddireddy@nvidia.com>
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
In-Reply-To: <20261021061903.1269605-4-mmaddireddy@nvidia.com>

Hi Manikanta,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v7.3 next-20261022]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manikanta-Maddireddy/PCI-dwc-Reuse-Endpoint-resources-after-fundamental-reset/20261021-114901
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20261021061903.1269605-4-mmaddireddy%40nvidia.com
patch subject: [PATCH v2 3/3] PCI: tegra194: Notify Endpoint functions on PERST# assert
config: xtensa-randconfig-1001-20261022 (https://download.01.org/0day-ci/archive/20261023/202610230923.2lf3BsLs-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 15.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261023/202610230923.2lf3BsLs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610230923.2lf3BsLs-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-tegra194.c: In function 'pex_ep_event_pex_rst_assert':
>> drivers/pci/controller/dwc/pcie-tegra194.c:1708:9: error: implicit declaration of function 'pci_epc_linkdown'; did you mean 'dw_pcie_ep_linkdown'? [-Wimplicit-function-declaration]
    1708 |         pci_epc_linkdown(pcie->pci.ep.epc);
         |         ^~~~~~~~~~~~~~~~
         |         dw_pcie_ep_linkdown


vim +1708 drivers/pci/controller/dwc/pcie-tegra194.c

  1688	
  1689	static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
  1690	{
  1691		u32 val;
  1692		int ret;
  1693	
  1694		if (pcie->ep_state == EP_STATE_DISABLED)
  1695			return;
  1696	
  1697		ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
  1698			((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
  1699			((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
  1700			((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
  1701			((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT) ||
  1702			((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_L2_IDLE),
  1703			LTSSM_DELAY_US, LTSSM_TIMEOUT_US);
  1704		if (ret)
  1705			dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", val, ret);
  1706	
  1707		/* Avoid the DBI register reinitialization in dw_pcie_ep_linkdown(). */
> 1708		pci_epc_linkdown(pcie->pci.ep.epc);
  1709	
  1710		/*
  1711		 * Deassert LTSSM state to stop the state toggling between
  1712		 * Polling and Detect.
  1713		 */
  1714		val = appl_readl(pcie, APPL_CTRL);
  1715		val &= ~APPL_CTRL_LTSSM_EN;
  1716		appl_writel(pcie, val, APPL_CTRL);
  1717	
  1718		reset_control_assert(pcie->core_rst);
  1719	
  1720		tegra_pcie_disable_phy(pcie);
  1721	
  1722		reset_control_assert(pcie->core_apb_rst);
  1723	
  1724		clk_disable_unprepare(pcie->core_clk);
  1725	
  1726		pm_runtime_put_sync(pcie->dev);
  1727	
  1728		if (pcie->enable_ext_refclk) {
  1729			ret = tegra_pcie_bpmp_set_pll_state(pcie, false);
  1730			if (ret)
  1731				dev_err(pcie->dev, "Failed to turn off UPHY: %d\n",
  1732					ret);
  1733		}
  1734	
  1735		ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
  1736		if (ret)
  1737			dev_err(pcie->dev, "Failed to disable controller: %d\n", ret);
  1738	
  1739		pcie->ep_state = EP_STATE_DISABLED;
  1740		dev_dbg(pcie->dev, "Uninitialization of endpoint is completed\n");
  1741	}
  1742	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
