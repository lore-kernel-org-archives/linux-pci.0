Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1758C3ACA51;
	Mon, 30 Mar 2026 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914062; cv=none; b=GzKnAIC5Ga1bBxVaPnv50xwzIN9wh5vJmpm3yitAHsJYTTlYOunIf1zASjxPyf4Ahb16RDlfOjgAWUWbK4b0dmUYJIoNUNulI9E/rpK49bNoQv0YQRor0GpLVyPweKFedpmNbI9nFkukr7r6aNuMecvGh0Lc/+45xmyHiip5zSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914062; c=relaxed/simple;
	bh=/7bWj8LSjbjOOQbncVOiQyndkujrzPgYDKjh3MdDTFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCzRkI/aJRRsgWpMBf4f1RZfrYhiBNYqW+/HOOmIpx7YGNJb7mN3g2BSqbpNZAYODfRsydCDJsyiQMtgs4DxMutMsCIYGuXEQvAd8JZCpUCsHVlDMPJytxDNVdB7HK60P86/Yhrl8uNDUQvoN50xFTZOLl/jCvwP8FgqpbHxtes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ch9jykEi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ch9jykEi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774914060; x=1806450060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/7bWj8LSjbjOOQbncVOiQyndkujrzPgYDKjh3MdDTFo=;
  b=Ch9jykEiqdnkVIT2Z0tYUk8w7udTv+CnMy8IKE/Jx0AN4aIld3KAI7C9
   tF7O/hTgpJo1bFlUYgNXu288aRqdnt3LE1nQY2IEoXh3hpLQ4oNuj+Iqj
   Ti1C9k0QMZmdm5duuSX+1yJCzUhcEn86TDlcP/MCIPppZOzh2xin2ugPs
   c5RNvGyjxFoNaqTxW5zR8v4l8sGS3lRK99AINW5A9LgsUUn/2rGJs+L13
   nphurOL7qji2Tr1DfICdH9EtUM5ar2/BBCzd0yNGkL+aO+088OlHRYL/A
   bnG+WMC2uBNinfIuwW31gv9B0fQDQVfH4w5tYc6DRhnfBPQwxWHLCXvCy
   Q==;
X-CSE-ConnectionGUID: YHtgwdfuTCunG078VBU2VA==
X-CSE-MsgGUID: ERiYoVgqQ46S4kf3zyT7Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93500739"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="93500739"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:41:00 -0700
X-CSE-ConnectionGUID: CBFG7EfbQBiV8V1pOgxBPQ==
X-CSE-MsgGUID: q4vw4/sZSIerHKFhAUZP2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="231000505"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 30 Mar 2026 16:40:58 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7ME3-000000001s5-1yZH;
	Mon, 30 Mar 2026 23:40:55 +0000
Date: Tue, 31 Mar 2026 07:39:59 +0800
From: kernel test robot <lkp@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	bhelgaas@google.com, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie:Support Product level reset.
Message-ID: <202603310744.5WIVh3e6-lkp@intel.com>
References: <20260330063842.1121545-1-chandrashekar.devegowda@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330063842.1121545-1-chandrashekar.devegowda@intel.com>

Hi Chandrashekar,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on next-20260327]
[cannot apply to bluetooth/master linus/master v7.0-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chandrashekar-Devegowda/Bluetooth-btintel_pcie-Support-Product-level-reset/20260330-190125
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20260330063842.1121545-1-chandrashekar.devegowda%40intel.com
patch subject: [PATCH v1] Bluetooth: btintel_pcie:Support Product level reset.
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260331/202603310744.5WIVh3e6-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603310744.5WIVh3e6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603310744.5WIVh3e6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/bluetooth/btintel_pcie.c: In function 'btintel_pcie_acpi_reset_method':
>> drivers/bluetooth/btintel_pcie.c:2307:14: error: implicit declaration of function 'acpi_has_method'; did you mean 'acpi_has_watchdog'? [-Wimplicit-function-declaration]
    2307 |         if (!acpi_has_method(handle, "_PRR")) {
         |              ^~~~~~~~~~~~~~~
         |              acpi_has_watchdog


vim +2307 drivers/bluetooth/btintel_pcie.c

  2280	
  2281	static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
  2282	{
  2283		union acpi_object *obj, argv4;
  2284		acpi_handle handle;
  2285		int ret;
  2286		struct pldr_mode {
  2287			u16	cmd_type;
  2288			u16	cmd_payload;
  2289		} __packed;
  2290	
  2291		/* set 1 for _PRR mode
  2292		 * Product Reset (PLDR Abort flow)
  2293		 */
  2294		static const struct pldr_mode mode = {
  2295			.cmd_type = 1,
  2296			.cmd_payload = BTINTEL_PCIE_DSM_PLDR_MODE_EN_PROD_RESET |
  2297				       BTINTEL_PCIE_DSM_PLDR_MODE_EN_WIFI_FLR,
  2298		};
  2299		struct hci_dev *hdev = data->hdev;
  2300	
  2301		handle = ACPI_HANDLE(GET_HCIDEV_DEV(data->hdev));
  2302		if (!handle) {
  2303			bt_dev_dbg(data->hdev, "No support for bluetooth device in ACPI firmware");
  2304			return -EACCES;
  2305		}
  2306	
> 2307		if (!acpi_has_method(handle, "_PRR")) {
  2308			bt_dev_dbg(data->hdev, "No support for _PRR ACPI method, falling back to FLR");
  2309			btintel_pcie_reset(data->hdev);
  2310			return -ENODEV;
  2311		}
  2312	
  2313		argv4.buffer.type = ACPI_TYPE_BUFFER;
  2314		argv4.buffer.length = sizeof(mode);
  2315		argv4.buffer.pointer = (void *)&mode;
  2316	
  2317		obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
  2318					BTINTEL_PCIE_DSM_DYNAMIC_PLDR, &argv4);
  2319		if (!obj) {
  2320			bt_dev_err(data->hdev, "Failed to call dsm to set reset method");
  2321			return -EIO;
  2322		}
  2323		ACPI_FREE(obj);
  2324	
  2325		pci_dev_lock(data->pdev);
  2326		pci_save_state(data->pdev);
  2327		ret = btintel_acpi_reset_method(hdev);
  2328		if (ret)
  2329			bt_dev_err(data->hdev, "ACPI _PRR reset failed (%d),PLDR incomplete",
  2330				   ret);
  2331		pci_restore_state(data->pdev);
  2332		pci_dev_unlock(data->pdev);
  2333		return ret;
  2334	}
  2335	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
