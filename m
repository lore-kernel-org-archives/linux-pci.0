Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33896 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbbLEN01 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 5 Dec 2015 08:26:27 -0500
Date: Sat, 5 Dec 2015 21:27:46 +0800
From: kbuild test robot <lkp@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: Resizeable PCI BAR support
Message-ID: <201512052133.KDSznZOw%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
In-Reply-To: <5662C61F.50303@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christian,

[auto build test WARNING on pci/next]
[also build test WARNING on v4.4-rc3 next-20151203]

url:    https://github.com/0day-ci/linux/commits/Christian-K-nig/Resizeable-PCI-BAR-support/20151205-204542
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   lib/crc32.c:148: warning: No description found for parameter 'tab)[256]'
   lib/crc32.c:148: warning: Excess function parameter 'tab' description in 'crc32_le_generic'
   lib/crc32.c:293: warning: No description found for parameter 'tab)[256]'
   lib/crc32.c:293: warning: Excess function parameter 'tab' description in 'crc32_be_generic'
   lib/crc32.c:1: warning: no structured comments found
>> drivers/pci/pci.c:2735: warning: No description found for parameter 'pdev'
>> drivers/pci/pci.c:2735: warning: Excess function parameter 'dev' description in 'pci_rbar_get_sizes'
   drivers/pci/pci.c:2774: warning: No description found for parameter 'pdev'
>> drivers/pci/pci.c:2774: warning: Excess function parameter 'dev' description in 'pci_rbar_set_size'

vim +/pdev +2735 drivers/pci/pci.c

  2729	 * @bar: BAR to query
  2730	 *
  2731	 * Get the possible sizes of a resizeable BAR as bitmask defined in the spec
  2732	 * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizeable.
  2733	 */
  2734	u32 pci_rbar_get_sizes(struct pci_dev *pdev, int bar)
> 2735	{
  2736		int pos, nbars;
  2737		u32 ctrl, cap;
  2738		int i;
  2739	
  2740		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
  2741		if (!pos)
  2742			return 0x0;
  2743	
  2744		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  2745		nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
  2746	
  2747		for (i = 0; i < nbars; ++i, pos += 8) {
  2748			int bar_idx;
  2749	
  2750			pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  2751			bar_idx = (ctrl & PCI_REBAR_CTRL_BAR_IDX_MASK) >>
  2752					PCI_REBAR_CTRL_BAR_IDX_SHIFT;
  2753			if (bar_idx != bar)
  2754				continue;
  2755	
  2756			pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
  2757			return (cap & PCI_REBAR_CTRL_SIZES_MASK) >>
  2758				PCI_REBAR_CTRL_SIZES_SHIFT;
  2759		}
  2760	
  2761		return 0x0;
  2762	}
  2763	
  2764	/**
  2765	 * pci_rbar_set_size - set a new size for a BAR
  2766	 * @dev: PCI device
  2767	 * @bar: BAR to set size to
  2768	 * @size: new size as defined in the spec.
  2769	 *
  2770	 * Set the new size of a BAR as defined in the spec (0=1MB, 19=512GB).
  2771	 * Returns true if resizing was successful, false otherwise.
  2772	 */
  2773	bool pci_rbar_set_size(struct pci_dev *pdev, int bar, int size)
> 2774	{
  2775		int pos, nbars;
  2776		u32 ctrl;
  2777		int i;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--jRHKVT23PllUwdXP
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
QH9wS7DCqMilXNgrIfgPnE6LPnFWAAA=

--jRHKVT23PllUwdXP--
